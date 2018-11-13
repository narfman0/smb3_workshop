unit ptredit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxStrUtils, RXSpin, Buttons, PngBitBtn;

type
  TfPointer = class(TForm)
	GroupBox1: TGroupBox;
	ScrollBar1: TScrollBar;
	ScrollBar2: TScrollBar;
	Label1: TLabel;
	Label2: TLabel;
	Label3: TLabel;
	RxSpinEdit1: TRxSpinEdit;
	Label4: TLabel;
	Label5: TLabel;
	Label6: TLabel;
	cbExitAction: TComboBox;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Button2: TButton;
    PngBitBtn1: TPngBitBtn;
	procedure ScrollBar1Change(Sender: TObject);
	procedure ScrollBar2Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure RxSpinEdit1Change(Sender: TObject);
    procedure cbExitActionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
  private
	{ Private declarations }
  public
	{ Public declarations }
  end;

var
  fPointer: TfPointer;

const
	ptr3_vert_values: array [0..15] of Byte =
	(	$0,  $5,  $8,  $C,
		$10, $14, $17, $18,
		$0,  $5,  $8,  $C,
		$10, $14, $17, $18 );


implementation

uses main;


var
	PtrChanged: Boolean = False;


{$R *.dfm}


procedure TfPointer.ScrollBar1Change(Sender: TObject);
var
	S: String;
begin
	PtrChanged := True;
	S := IntToHex(ScrollBar1.Position,1);
	Label5.Caption := S + '0 - ' + S + 'F';
end;


procedure TfPointer.ScrollBar2Change(Sender: TObject);
var
	S: String;
begin
	PtrChanged := True;
	S := IntToHex(ptr3_vert_values[ScrollBar2.Position], 2);
	if ScrollBar2.Position > 7 then S := S + ' (Vert)';
	Label4.Caption := S;
end;


procedure TfPointer.ListBox1Click(Sender: TObject);
var
	S: String;
	I: Integer;
begin
	if Listbox1.ItemIndex < 0 then Exit;
	if Tag >= 0 then
	  if PtrChanged then
		if MessageDlg('Save changes to current pointer?',
			mtConfirmation, [mbYes, mbNo], 0) = mrYes then
				MainForm.SavePointer(Tag);
	S := Listbox1.Items[Listbox1.ItemIndex];
	S := Trim(ReplaceStr(S, 'Item #', ''));
	MainForm.SelectPointer(StrToInt(S));
	ScrollBar1Change(Self);
	ScrollBar2Change(Self);
	PtrChanged := False;
end;


procedure TfPointer.RxSpinEdit1Change(Sender: TObject);
begin
	PtrChanged := True;
end;


procedure TfPointer.cbExitActionChange(Sender: TObject);
begin
	PtrChanged := True;
end;


procedure TfPointer.FormShow(Sender: TObject);
begin
	PtrChanged := False;
end;


procedure TfPointer.Button2Click(Sender: TObject);
begin
	PtrChanged := False;
end;


procedure TfPointer.PngBitBtn1Click(Sender: TObject);
begin
	PtrChanged := False;
end;


end.
