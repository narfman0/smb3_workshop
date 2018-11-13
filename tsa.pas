unit tsa;

interface

uses gr32, GR32_Image, types;

(*
  koosta kuva rom-grafiikoista: (toista joka levelsetille)
	- lataa tsa-taulukko levelsetille
	- lataa raaka grafiikka romista taulukkoon (pix=0..3)
	- selvitä paletti + värien vastaavuudet
	- plottaa kuvaan
*)

var
	tsaOffsets: array [0..$e+8] of Integer = (
		$1e010, $2a010, $20010, $22010, $0, $24010, $0, $24010,	$28010, $2e010,
		$26010, $22010, $26010, $1a010,
	$18010,$18010,$18010,$18010,$18010,$18010,$18010,$18010,$18010	// map
);
	graphicsOffsets: array[0..$e+8] of Integer = ($42010, $44010, $5b010, $43010,
		$0, $56010, $0, $56010, $4c010, $4D010, $5b810, $46010, $43010, $47010,
	$45010,$45010,$45010,$45010,$45010,$45010,$45010,$45010,$45010	// map
);
	commonOffsets:   array[0..$e+8] of Integer = ($58010, $58010, $58010, $58010,
		$58010, $58010, $58010, $58010, $58010, $5c010, $58010, $58010, $58010, $58010,
	$45810,$45810,$45810,$45810,$45810,$45810,$45810,$45810,$45810	// map
);


type
  METATABLE = record 		// holds a table that has nes gfx
	numberOfTiles: Integer;	// explicity written as 0-3
	metaTable: array of Byte;
  end;

  GFXTILE = array[0..63] of Byte;

  NESPal4 = array[0..3] of Byte;


procedure SaveMetaTable(var metaTemp: METATABLE; tiles, offset: Integer);
procedure SetPalettes(pal: Integer);
procedure BlitTile(tileNumber: Integer; var metaPTable: METATABLE;
	buffer: TBitmap32; X, Y: Integer; levelPal: Integer = -1; PixelSize: Integer = 1);
procedure BlitBlock(b: TBitmap32; tile, xx, yy: Integer);
function  NES_GetPixel(tileNumber: Integer; var metaPTable: METATABLE; X, Y: Integer): Byte;
procedure NES_SetPixel(tileNumber: Integer; var metaPTable: METATABLE; X, Y: Integer; P: Byte);
procedure LoadPatternTable(objectSet: Integer);
procedure LoadTSAData(objectSet: Integer);
procedure BuildPatternTables;
procedure SelectTile(x, y: Integer);


var
//	rompix: array[0..255] of array[0..127] of Byte;
	patternTableMT, commonTableMT: METATABLE;
//	gamePalette: array[0..3] of PALDATA;
	tsaData: array [0..1023] of Byte;
	objectNumber: array [0..3] of Byte;
	paletteData: array[0..7, 0..15] of Byte;
	PALDATA: array[0..5, 0..3] of Byte;
	selectedTile, selectedBlock,
	levelPalette, currentPalette: Integer;


implementation

uses main, levelsel;


procedure SetBit(var B: Byte; Bit: Byte);
begin
	B := B or (1 shl Bit);
end;

procedure ClrBit(var B: Byte; Bit: Byte);
begin
	B := B and not (1 shl Bit);
end;

function GetBit(B: Byte; Bit: Byte): Boolean;
begin
	Result := B and (1 shl Bit) > 0;
end;


procedure BlitTile(tileNumber: Integer; var metaPTable: METATABLE;
	buffer: TBitmap32; X, Y: Integer; levelPal: Integer = -1; PixelSize: Integer = 1);
var
	xx, yy, i, pixel: Integer;
begin
	if levelPal < 0 then levelPal := 0; //levelPalette;
	tileNumber := tileNumber * 64;
	i := 63;
	for yy := 0 to 7 do
	for xx := 0 to 7 do
	begin
		pixel := metaPTable.metaTable[tileNumber+i];
		pixel := paletteData[levelPal][pixel+(currentPalette*4)];
		if PixelSize < 2 then
			buffer.SetPixelTS(X+xx, Y+7-yy, MainForm.NESpal[pixel])
		else
			buffer.FillRectS(Bounds(X+(xx*PixelSize), Y+((7-yy)*PixelSize),
				PixelSize, PixelSize), MainForm.NESpal[pixel]);
		Dec(i);
	end;
end;


procedure NES_SetPixel(tileNumber: Integer; var metaPTable: METATABLE;
		X, Y: Integer; P: Byte);
begin
	metaPTable.metaTable[(tileNumber*64)+(63-((7-Y)*8)+(7-X))-7] := P;
end;

function NES_GetPixel(tileNumber: Integer; var metaPTable: METATABLE;
		X, Y: Integer): Byte;
begin
	Result := metaPTable.metaTable[(tileNumber*64)+(63-((7-Y)*8)+(7-X))-7];
end;



procedure BlitBlock(b: TBitmap32; tile, xx, yy: Integer);
var
	i: Integer;
	tsaTile: Byte;
	x, y: array[0..3] of Integer;
begin
	x[0] := xx;
	y[0] := yy;
	x[1] := xx;
	y[2] := yy;
	x[2] := xx + 8;
	x[3] := xx + 8;
	y[1] := yy + 8;
	y[3] := yy + 8;
	currentPalette := tile div $40;
	for i := 0 to 3 do
	begin
		tsaTile := tsaData[(i * $100) + tile];
		if tsaTile < 128 then
			BlitTile(tsaTile, patternTableMT, b, x[i], y[i])
		else
			BlitTile(tsaTile - 128, commonTableMT, b, x[i], y[i]);
	end;
	if b = MainForm.FloorGfx.Buffer then
		floortile[xx div 16] := tile;
end;



procedure SetPalettes(pal: Integer);
var
	I: Integer;
begin
	for I := 0 to 15 do
		PALDATA[I div 4][I mod 4] :=
			paletteData[pal][I];
end;


{
 Pattern Table 1 (256x2x8) @ $1000
 Pattern Table 0 (256x2x8) @ $0000

 Character   Colors      Contents of Pattern Table
 ...*....    00010000    00010000 $10  +-> 00000000 $00
 ..O.O...    00202000    00000000 $00  |   00101000 $28
 .#...#..    03000300    01000100 $44  |   01000100 $44
 O.....O.    20000020    00000000 $00  |   10000010 $82
 *******. -> 11111110 -> 11111110 $FE  |   00000000 $00
 O.....O.    20000020    00000000 $00  |   10000010 $82
 #.....#.    30000030    10000010 $82  |   10000010 $82
 ........    00000000    00000000 $00  |   00000000 $00
}


procedure SaveMetaTable(var metaTemp: METATABLE; tiles, offset: Integer);
var
	Pix, tmpA, tmpB: Byte;
	i, j, z, baseOffset, tileOffset: Integer;
begin
	tileOffset := 0;
	for i := 0 to tiles-1 do
	begin
		baseOffset := offset + (i * 16);
		for j := 0 to 7 do
		begin
			tmpA := 0;
			tmpB := 0;
			for z := 0 to 7 do
			begin
				Pix := metaTemp.metaTable[tileOffset+7-z];
				if GetBit(Pix, 0) then SetBit(tmpA, 7-z);
				if GetBit(Pix, 1) then SetBit(tmpB, 7-z);
			end;
			Inc(tileOffset, 8);
			MainForm.ROM_PutByte(tmpA, baseOffset + j);
			MainForm.ROM_PutByte(tmpB, baseOffset + j + 8);
		end;
	end;
end;


function CreateMetaTable(tiles, offset: Integer): METATABLE;
var
	tmpA, tmpB: Byte;
	metaTemp: METATABLE;
	i, j, baseOffset, tileOffset: Integer;
	tileBuffer: array[0..$1000] of Byte;
begin
	tileOffset := 0;
	SetLength(metaTemp.metaTable, tiles * 64);
	metaTemp.numberOfTiles := tiles;
	MainForm.ROM_Seek(offset);
	for i := 0 to $1000 do
		tileBuffer[i] := MainForm.ROM_GetByte;
	for i := 0 to tiles-1 do
	begin
		baseOffset := i * 16;
		for j := 0 to 7 do
		begin
			tmpA := tileBuffer[baseOffset + j];
			tmpB := tileBuffer[baseOffset + j + 8];
			metaTemp.metaTable[tileOffset]   :=  (tmpA and $01) or ((tmpB and $01) shl 1);
			metaTemp.metaTable[tileOffset+1] := ((tmpA and $02) shr 1) +  (tmpB and $02);
			metaTemp.metaTable[tileOffset+2] := ((tmpA and $04) shr 2) + ((tmpB and $04) shr 1);
			metaTemp.metaTable[tileOffset+3] := ((tmpA and $08) shr 3) + ((tmpB and $08) shr 2);
			metaTemp.metaTable[tileOffset+4] := ((tmpA and $10) shr 4) + ((tmpB and $10) shr 3);
			metaTemp.metaTable[tileOffset+5] := ((tmpA and $20) shr 5) + ((tmpB and $20) shr 4);
			metaTemp.metaTable[tileOffset+6] := ((tmpA and $40) shr 6) + ((tmpB and $40) shr 5);
			metaTemp.metaTable[tileOffset+7] := ((tmpA and $80) shr 7) + ((tmpB and $80) shr 6);
			Inc(tileOffset, 8);
		end;
	end;
	Result := metaTemp;
end;


procedure LoadTSAData(objectSet: Integer);
var
	I: Integer;
begin
	MainForm.ROM_Seek(tsaOffsets[objectSet]);
	for I := 0 to 1023 do
		tsaData[I] := MainForm.ROM_GetByte;
end;


procedure LoadPatternTable(objectSet: Integer);
var
	x, y, paletteOffset: Integer;
begin
	if objectSet = $e then
	begin
		y := MainForm.Level - 2;
		patternTableMT := CreateMetaTable(128, graphicsOffsets[$e+y]);
		commonTableMT  := CreateMetaTable(128, commonOffsets[$e+y]);
		if y = 2 then y := 0 else
			if y > 7 then y := 2;
		paletteOffset  := mappaletteaddr + (y * 16);
	end
	else
	begin
		patternTableMT := CreateMetaTable(128, graphicsOffsets[objectSet]);
		commonTableMT  := CreateMetaTable(128, commonOffsets[objectSet]);
		paletteOffset  := paletteaddr + (objectSet * $C0);
	end;
	//mainform.sObjectType.Value := objectSet;
	MainForm.ROM_Seek(paletteOffset);
	for x := 0 to 7 do
	  for y := 0 to 15 do
		palettedata[x, y] := MainForm.ROM_GetByte;

{
	y := header[8] and 31;
	if y = 20 then y := 1;
	if y = 19 then y := 3;
	y := y and 15;
}
	if objectSet <> $e then
	begin
		y := fSelectLevel.cbObjectSet.ItemIndex+1;
		if y = $E then y := 3;
		y := paletteaddr + 1 + ((y-1) * $C0);
		y := y + ((header[6] and 7) * 16);
		for x := 0 to 15 do
			palettedata[0, x] := Ord(ROMdata[y+x]);
	end; {else
	begin
		y := paletteaddr + 1;
		y := y + ((mainform.level-2) * 16);
//{
		for x := 0 to 7 do
		  for y := 0 to 15 do
			palettedata[x, y] := MainForm.ROM_GetByte;
	end; }
	if MainForm.World = 0 then
		levelPalette := MainForm.Level-2
	else
		levelPalette := header[6] and 7;
end;


procedure BuildPatternTables;
begin
	selectedBlock := 0; //MainForm.RxSpinEdit1.AsInteger;
	currentPalette := objectNumber[selectedBlock] div $40;
{
	for i := 0 to 127 do
	begin
		BlitTile(i, patternTableMT, gamePalette[currentPalette], MainForm.pb,
        (i mod 16) * 8, (i div 16) * 8 );
		BlitTile(i, commonTableMT,  gamePalette[currentPalette], MainForm.pb,
        (i mod 16) * 8, ((i div 16) * 8) + 64);
	end;
}
end;


procedure SelectTile(x, y: Integer);
var
	blockRange, tileReplace: Integer;
begin
	if (x > 5) and (x < 261) and (y > 5) and (y < 261) then
	begin
		Dec(x, 5);
		Dec(y, 5);
		selectedTile := ((y div 16) * 16) + (x div 16);
//		DrawPatternTables();
//		DrawSelectedTile();
		Exit;
	end;
	if (x > 266) and (x < 330) and (y > 5) and (y < 69) then
	begin
		Dec(x, 266);
		Dec(y, 5);
		blockRange := ((y div 32) * 2) + (x div 32);
		Dec(x, (blockRange mod 2) * 32);
		Dec(y, (blockRange div 2) * 32);
		tsaData[objectNumber[blockRange] + ($100 * (((x div 16) * 2) + (y div 16)))] := selectedTile;
		blockRange := selectedBlock;
		tileReplace := currentPalette;
		for x := 0 to 3 do
		begin
			selectedBlock := x;
			currentPalette := objectNumber[selectedBlock] div $40;
            // blitblock
		end;
		currentPalette := tileReplace;
		selectedBlock := blockRange;
//		drawTSABlock();
//		drawSelected();
	end;
end;


end.
