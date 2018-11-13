unit paletted;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32_Image, GR32, ExtCtrls, Buttons, FileUtils;

type
  TfPalette = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    cbColorSet: TComboBox;
    pbColorSet: TPaintBox32;
    pbPalette: TPaintBox32;
    Label3: TLabel;
    cbObjectSet: TComboBox;
    Button1: TButton;
    Label1: TLabel;
    Button3: TButton;
    SpeedButton1: TSpeedButton;
    procedure cbColorSetChange(Sender: TObject);
	procedure FormShow(Sender: TObject);
	procedure DrawPalette;
    procedure pbPaletteMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbColorSetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
	Selcolor: Integer;
  end;

var
  fPalette: TfPalette;

implementation

uses main, gfxeditor;

{$R *.dfm}



procedure TfPalette.cbColorSetChange(Sender: TObject);
var
	x, i: Integer;
begin
	i := paletteaddr+1+((cbObjectSet.ItemIndex-1)*$C0)+(cbColorSet.ItemIndex*16);
	for x := 0 to 15 do
		pbColorSet.Buffer.FillRect(x*16, 0, (x+1)*16, 16, MainForm.NESpal[Ord(ROMdata[i+x])]);
	pbColorSet.Flush;
end;


procedure TfPalette.DrawPalette;
var
	x, y: Integer;
begin
	for y := 0 to 3 do
	  for x := 0 to 15 do
		pbPalette.Buffer.FillRect(x*16, y*16, (x+1)*16, (y+1)*16, MainForm.NESpal[y*16+x]);
	x := Selcolor mod 16 * 16;
	y := Selcolor div 16 * 16;
	pbPalette.Buffer.FrameRectTS(x, y, x+16, y+16, clWhite32);
	pbPalette.Buffer.FrameRectTS(x+1, y+1, x+15, y+15, clBlack32);
	pbPalette.Flush;
end;


procedure TfPalette.FormShow(Sender: TObject);
begin
	DrawPalette;
	cbColorSetChange(Self);
end;


procedure TfPalette.pbPaletteMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	Selcolor := (x div 16) + (y div 16 * 16);
	DrawPalette;
end;


procedure TfPalette.pbColorSetMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	x := x div 16;
	y := paletteaddr+1+((cbObjectSet.ItemIndex-1)*$C0)+(cbColorSet.ItemIndex*16) + x;
	if Button = mbLeft then
	begin
		ROMdata[y] := Chr(Selcolor);
		cbColorSetChange(Self);
	end else
	if Button = mbRight then
	begin
		Selcolor := ord(ROMdata[y]);
		DrawPalette;
	end;
end;


procedure TfPalette.Button3Click(Sender: TObject);
begin
	with MainForm do
	begin
		if fGfxEdit.Showing then
		begin
			fGfxEdit.Button1Click(Self);
			SaveROMGraphics;
		end;
		LevelModified := True;
		GetPalette;
		miROMgfxClick(Self);
	end;
end;


procedure TfPalette.Button1Click(Sender: TObject);
begin
	Button3Click(Self);
	Close;
end;


procedure TfPalette.Button2Click(Sender: TObject);
begin
	Close;
end;


procedure TfPalette.FormCreate(Sender: TObject);
begin
	Selcolor := 0;
end;


procedure TfPalette.SpeedButton1Click(Sender: TObject);
var
	x, i: Integer;
	F: string;
begin
	if not MainForm.OpenDialog.Execute then Exit;
	F := FileToString(MainForm.OpenDialog.FileName);
	i := paletteaddr+1+((cbObjectSet.ItemIndex-1)*$C0)+(cbColorSet.ItemIndex*16);
	for x := 0 to 15 do
		ROMdata[i+x] := F[i+x];
	cbColorSetChange(Self);
end;


end.
