unit headered;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, RXSpin, Buttons, PngBitBtn;

type
  TfHeader = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    cScrolling: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    cObjectSet: TComboBox;
	cStartAction: TComboBox;
	cStartX: TComboBox;
	cStartY: TComboBox;
	sePalEnemy: TRxSpinEdit;
	sePalLevel: TRxSpinEdit;
	seLength: TRxSpinEdit;
	cGraphicSet: TComboBox;
	cMusic: TComboBox;
	cbPipeEnds: TCheckBox;
	cTime: TComboBox;
	Label6: TLabel;
	lHeader: TLabel;
	sePtrObjects: TRxSpinEdit;
	sePtrEnemies: TRxSpinEdit;
    Button2: TButton;
    Label14: TLabel;
    PngBitBtn1: TPngBitBtn;
	procedure HeaderChanged(Sender: TObject);
    procedure lHeaderDblClick(Sender: TObject);
  private
	{ Private declarations }
  public
	{ Public declarations }
  end;

var
  fHeader: TfHeader;
  hdr: array[1..9] of Byte;


implementation

uses main, NESSMB3;

{$R *.dfm}


procedure TfHeader.HeaderChanged(Sender: TObject);
var
	I: Integer;
begin
	Label14.Caption :=
	IntToHex(object_set_pointers[cObjectSet.ItemIndex+1].ptr_min, 5)
	+ ' - ' +
	IntToHex(object_set_pointers[cObjectSet.ItemIndex+1].ptr_max, 5);
	if Tag > 0 then Exit;

	I := sePtrObjects.AsInteger - $10010 -
		object_set_pointers[cObjectSet.ItemIndex+1].ptr_type;
	hdr[2] := I div $100;
	hdr[1] := I and 255;

	I := sePtrEnemies.AsInteger - $10;
	hdr[4] := I div $100;
	hdr[3] := I and 255;

	hdr[5] := (cStartY.ItemIndex shl 5) + ((seLength.AsInteger-$F) div $10);

	hdr[6] := (cStartX.ItemIndex shl 5) +
		(sePalEnemy.AsInteger shl 3) + sePalLevel.AsInteger;

	hdr[7] := cScrolling.ItemIndex shl 4 + cObjectSet.ItemIndex;
	if not cbPipeEnds.Checked then hdr[7] := hdr[7] or 128;

	hdr[8] := cStartAction.ItemIndex shl 5 + cGraphicSet.ItemIndex;

	hdr[9] := cTime.ItemIndex shl 6 + cMusic.ItemIndex;

	lHeader.Caption := '';
	for I := 1 to 9 do
		lHeader.Caption := lHeader.Caption + IntToHex(hdr[I], 2) + ' ';
end;


procedure TfHeader.lHeaderDblClick(Sender: TObject);
begin
	ShowMessage('Hello!');
end;


end.
