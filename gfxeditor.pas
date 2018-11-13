unit gfxeditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32_Image, GR32, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  PngSpeedButton, PngBitBtn;

type
  TfGfxEdit = class(TForm)
	pbPalette: TPaintBox32;
	pb: TPaintBox32;
	pbROM: TPaintBox32;
	Bevel1: TBevel;
	bDraw: TPngSpeedButton;
	bFill: TPngSpeedButton;
	Bevel2: TBevel;
	pbPreview: TPaintBox32;
	UpDown1: TUpDown;
	UpDown2: TUpDown;
	CheckBox1: TCheckBox;
	Bevel4: TBevel;
	Label1: TLabel;
	Label2: TLabel;
	bPick: TPngSpeedButton;
	SpeedButton1: TPngSpeedButton;
	SpeedButton2: TPngSpeedButton;
    PngBitBtn1: TPngBitBtn;
	procedure GotTile(Id: Byte);
	procedure Blit_Tile(T, X, Y: Integer; Bitmap: TBitmap32);
	procedure UpdatePaletteView;
	procedure UpdateView(UpdateMainform: Boolean = True);
    procedure FormShow(Sender: TObject);
    procedure pbMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbROMMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure pbPaletteMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bPickClick(Sender: TObject);
    procedure pbMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGfxEdit: TfGfxEdit;
  Currtile: Integer = 0;
  colBg: Byte = 1;
  colFg: Byte = 0;


implementation

uses main, TSA, levelsel;

{$R *.dfm}



procedure FloodFill_Tile(metaPTable: METATABLE; Pos: TPoint; MaxHeight: Integer; FillColor: TColor32);
var
	X, Y: Integer;
	ReplaceColor: TColor32;
	Stack: array of TPoint;

	procedure PutInStack(X, Y: Integer);
	begin
		SetLength(Stack, Length(Stack)+1);
		Stack[Length(Stack)-1] := Point(X, Y);
	end;

	procedure GetFromStack(var X, Y: Integer);
	begin
		X := Stack[Length(Stack)-1].X;
		Y := Stack[Length(Stack)-1].Y;
		SetLength(Stack, Length(Stack)-1);
	end;

begin
	X := Pos.X;
	Y := Pos.Y;
	ReplaceColor := NES_GetPixel(currTile, metaPTable, X, Y);
	if ReplaceColor = FillColor then Exit;
	PutInStack(X, Y);
	while Length(Stack) > 0 do
	begin
		GetFromStack(X, Y);
		while (X > 0) and (NES_GetPixel(currTile, metaPTable, X-1, Y) = ReplaceColor) do
			Dec(X);
		while (X < 8) and (NES_GetPixel(currTile, metaPTable, X, Y) = ReplaceColor) do
		begin
			if Y > 0 then
				if NES_GetPixel(currTile, metaPTable, X, Y-1) = ReplaceColor then
					PutInStack(X, Y-1);
			if Y+1 < MaxHeight then
				if NES_GetPixel(currTile, metaPTable, X, Y+1) = ReplaceColor then
					PutInStack(X, Y+1);
			NES_SetPixel(currTile, metaPTable, X, Y, FillColor);
			Inc(X);
		end;
	end;
end;


procedure TfGfxEdit.Blit_Tile(T, X, Y: Integer; Bitmap: TBitmap32);
begin
	if T < 128 then
		TSA.BlitTile(T, patternTableMT, Bitmap, X*17, Y*17, UpDown1.Position, 2)
	else
		TSA.BlitTile(T-128, commonTableMT, Bitmap, X*17, Y*17, UpDown1.Position, 2);
end;


procedure TfGfxEdit.UpdatePaletteView;
var
	X: Integer;
begin
	pbPalette.Buffer.Clear(Color32(Color));
	for X := 0 to 3 do
		pbPalette.Buffer.FillRectS(Bounds(X*32, 4, 32, pbPalette.Height-7),
			MainForm.NESpal[paletteData[UpDown1.Position][UpDown2.Position*4+X]]);
	pbPalette.Buffer.FillRectS(Bounds(colFg*32, 1, 32, 2), clBlack32);
	pbPalette.Buffer.FillRectS(Bounds(colBg*32, pbPalette.Height-2, 32, 2), clBlack32);
	pbPalette.Flush;
end;


procedure TfGfxEdit.UpdateView(UpdateMainform: Boolean = True);
var
	J, X, Y: Integer;
begin
	pbROM.Buffer.Clear(clGray32);
	currentPalette := UpDown2.Position;
	J := 0;
	for Y := 0 to 15 do
		for X := 0 to 15 do
		begin
			Blit_Tile(J, X, Y, pbROM.Buffer);
			Inc(J);
		end;
	pbROM.Buffer.FrameRectS(Bounds((currTile mod 16)*17,
		(currTile div 16)*17, 17, 17), clRed32);
	pbROM.Buffer.FrameRectS(Bounds((currTile mod 16)*17-1,
		(currTile div 16)*17-1, 19, 19), clYellow32);
	pbROM.Flush;

	Blit_Tile(Currtile, 0, 0, pbPreview.Buffer);

	pbPreview.Flush;
	J := 16;
	for Y := 0 to 7 do
		for X := 0 to 7 do
		begin
			pb.Buffer.FillRectS(Bounds(X*J, Y*J, J, J),
				pbPreview.Buffer.PixelS[X*2, Y*2]);
		end;
	pb.Flush;

	Label1.Caption := IntToStr(UpDown1.Position);
	Label2.Caption := IntToStr(UpDown2.Position);
end;


procedure TfGfxEdit.FormShow(Sender: TObject);
begin
	UpdateView;
	UpdatePaletteView;
end;


procedure TfGfxEdit.pbMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
	B, tsaTile: Integer;
begin
	if Button = mbRight then B := colBg else B := colFg;
	if bDraw.Down then
	begin
		Pb.Tag := B;
		SetCapture(Pb.Handle);
		PbMouseMove(Sender, Shift, X, Y);
	end
	else
	if bFill.Down then
	begin
		X := X div 16;
		Y := Y div 16;
		if currTile < 128 then
			FloodFill_Tile(patternTableMT, Point(X,Y), 8, B)
		else
			FloodFill_Tile(commonTableMT,  Point(X,Y), 8, B);
		UpdateView;
		if Checkbox1.Checked then MainForm.ROMGraphicsChanged;
	end;
end;


procedure TfGfxEdit.pbROMMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	if Button = mbLeft then
	begin
		X := X div 17;
		Y := Y div 17;
		currTile := Y * 16 + X;
		UpdateView;
	end;
end;


procedure TfGfxEdit.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
	UpdateView;
	UpdatePaletteView;
end;


procedure TfGfxEdit.pbPaletteMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	Y := X div 32;
	if Button = mbLeft then colFg := Y else colBg := Y;
	UpdatePaletteView;
end;


procedure TfGfxEdit.Button1Click(Sender: TObject);
begin
	MainForm.ROMGraphicsChanged;
end;


procedure TfGfxEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	case Key of
		VK_LEFT:	Dec(currTile);
		VK_RIGHT:	Inc(currTile);
		VK_UP:		Dec(currTile, 16);
		VK_DOWN:	Inc(currTile, 16);
	end;
	if currTile < 0 then   Inc(currTile, 256)
	else
	if currTile > 255 then Dec(currTile, 256);
	UpdateView;
end;


procedure TfGfxEdit.bPickClick(Sender: TObject);
begin
	bPick.Down := True;
	AskTile.Want := True;
	MainForm.pb.Cursor := crCross;
end;


procedure TfGfxEdit.GotTile(Id: Byte);
begin
	bPick.Down := False;
	AskTile.Want := False;
	currTile := Id;
	UpdateView;
end;


procedure TfGfxEdit.pbMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	ReleaseCapture;
	pb.Tag := -1;
end;


procedure TfGfxEdit.pbMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
	if Pb.Tag < 0 then Exit;
	if (X < 0) or (Y < 0) then Exit;
	X := X div 16;
	Y := Y div 16;
	if (X > 7) or (Y > 7) then Exit;
	if currTile < 128 then
		NES_SetPixel(currTile,     patternTableMT, X, Y, pb.Tag)
	else
		NES_SetPixel(currTile-128, commonTableMT,  X, Y, pb.Tag);
	UpdateView;
	if Checkbox1.Checked then MainForm.ROMGraphicsChanged;
end;


procedure TfGfxEdit.PngBitBtn1Click(Sender: TObject);
begin
	MainForm.ROMGraphicsChanged;
end;


end.

