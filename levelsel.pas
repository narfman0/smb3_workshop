unit levelsel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxStrUtils, BMSpinEdit, RXSpin, NESSMB3, Buttons,
  PngBitBtn;

type
  TfSelectLevel = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    bCancel: TButton;
    Label3: TLabel;
    seOffset: TRxSpinEdit;
    Label4: TLabel;
    seEnemy: TRxSpinEdit;
    cbObjectSet: TComboBox;
    Label5: TLabel;
    bOK: TPngBitBtn;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSelectLevel: TfSelectLevel;

implementation

uses main;

{$R *.dfm}


procedure TfSelectLevel.ListBox1Click(Sender: TObject);
var
	S: String;
    I: Integer;
begin
	if ListBox1.ItemIndex < 0 then ListBox1.ItemIndex := 0;
	ListBox2.Items.BeginUpdate;
	ListBox2.Items.Clear;

	for I := 1 to 298 do
	begin
		if level_array[I].game_world = ListBox1.ItemIndex then
		begin
			S := level_array[I].name;
			if S <> '' then ListBox2.Items.Add(S);
		end;
	end;
	if ListBox1.ItemIndex = MainForm.World then
	begin
		if MainForm.World > 0 then
			ListBox2.ItemIndex := MainForm.Level - 1
		else
			ListBox2.ItemIndex := MainForm.Level - 2;
	end;
	ListBox2.Items.EndUpdate;
	ListBox2Click(Self);
end;


procedure TfSelectLevel.ListBox2Click(Sender: TObject);
var
	E: Boolean;
	W, L, los, lin: Integer;
begin
	E := ListBox2.ItemIndex >= 0;
//	bOK.Enabled := E;
//	seEnemy.Enabled := E;
//	seOffset.Enabled := E;
	if not E then Exit;

	W := fSelectLevel.ListBox1.ItemIndex;
	L := fSelectLevel.ListBox2.ItemIndex + 1;
	if W = 0 then lin := L
		else lin := WORLD_INDEXES[W] + L;
	los := MainForm.convert_object_sets(level_array[lin].real_obj_set);
	L := level_array[lin].rom_level_offset;
	if W > 0 then Dec(L, 9);
	seOffset.Value  := L;
	if W > 0 then
		L := level_array[lin].enemy_offset
	else L := 0;
	if L > 0 then Dec(L);
	seEnemy.Value := L;
	if Listbox1.ItemIndex < 1 then Exit;
	cbObjectSet.ItemIndex := level_array[
		WORLD_INDEXES[ListBox1.ItemIndex]+ListBox2.ItemIndex+1].real_obj_set - 1;
end;


procedure TfSelectLevel.ListBox2DblClick(Sender: TObject);
begin
	if bOK.Enabled then bOK.Click;
end;


end.
