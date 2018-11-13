(*
 * cool configuration dialog routines by hukka *
 *                                             *
 ***********************************************
 requires RxLib
*)

unit config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxSpin, ComCtrls, FileCtrl, Buttons, ExtDlgs, CheckLst,
  RxStrUtils, Mask, ToolEdit, Placemnt, ExtCtrls;


type TCtrlValType = (
	CTRL_VT_INTEGER,
	CTRL_VT_STRING,
	CTRL_VT_BOOLEAN
);

type TCtrlMode = (
	CTRL_NONE,
	CTRL_FALSE,
	CTRL_TRUE,
	CTRL_SECTION
);

type TCtrlType = (
	CTRL_spinedit,
	CTRL_trackbar,
	CTRL_edit,
	CTRL_checkbox,
	CTRL_diredit
);

type TConfigListItemExt = record
	Enabled:	boolean;
	Name: 	 	string;		// ControlName
	Caption: 	string;		// ControlCaption
	CtrlType:	TCtrlType;		// ControlType
	Min, Max,
	Default,
	Value: 		integer;
	Address:	integer;
	sDefault,
	sValue:		string;
	ValueType:	TCtrlValType;
end;

type TConfigListItem = record
	Name:		string;		// ConfigName
	Caption:	string;		// Caption
	Info:		string;		// Explanation/hint
	Checked:	TCtrlMode;	// Checked
	Extended:	TConfigListItemExt;
end;

(*
	- luo formi nimelt‰ TConfigForm
	- lis‰‰ seuraavat komponentit:
		TFormStorage
		TCheckListBox (ConfigList; mode:CustomDraw; assign OnDraw, OnClick events)
		TTrackBar (ConfigList_Trackbar; assign OnChange)
		TSpinEdit (ConfigList_SpinEdit; assign OnChange)
		TDirectoryEdit (rxlib)
		TLabel x 2 (ConfigList_ExtLabel, ConfigList_InfoLabel)
*)

type
  TConfigForm = class(TForm)
	ConfigList: TCheckListBox;
	ConfigList_TrackBar: TTrackBar;
	ConfigList_ExtLabel: TLabel;
	ConfigList_InfoLabel: TLabel;
	ConfigList_SpinEdit: TRxSpinEdit;
	Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;

	procedure ConfigListDrawItem(Control: TWinControl; Index: Integer;
	  Rect: TRect; State: TOwnerDrawState);
	procedure ConfigListClick(Sender: TObject);
	procedure ConfigListClickCheck(Sender: TObject);
	function FindKey(Key: string): integer;
	function ConfigGetInteger(Key: string; Def: integer): integer;
	function ConfigGetString(Key: string; Def: string): string;
	function ConfigGetBoolean(Key: string; Def: boolean): boolean;
    procedure ReadConfig;
    procedure StoreConfig;
    procedure ConfigList_SpinEditChange(Sender: TObject);
    procedure ConfigList_TrackBarChange(Sender: TObject);
    procedure ConfigList_DirEditChange(Sender: TObject);
  private
  public
    ConfigListItems: array of TConfigListItem;
  end;

var
  ConfigForm: TConfigForm;

implementation

uses main;

{$R *.dfm}


(* Customdraw routine for TCheckListBox by hukka
    - checkboxes can be individually enabled and disabled for
      items (Enabled property) *)
procedure TConfigForm.ConfigListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
	I: integer;
begin
    with (Control as TCheckListBox).Canvas do
    begin
		if odSelected in State then
        begin
			if not (Control as TCheckListBox).Header[Index] then
        	begin
        		Brush.Color:= clHighlight;
				Font.Color:= clHighlightText;
        	end;
        end
        else
        	Font.Color:= clBtntext;
		FillRect(Rect);
        if (Control as TCheckListBox).Header[Index] then
		begin
			Pen.Color := clBlack;
			PenPos := Point(Rect.Left, Rect.Bottom-1);
			LineTo(Rect.Right, Rect.Bottom-1);
		end;
		TextOut(Rect.Left+2, Rect.Top+2, (Control as TCheckListBox).Items[Index]);
		if not (Control as TCheckListBox).ItemEnabled[Index] then
		begin
			Brush.Color := clWindow;
			I := Rect.Left;
			Rect.Right := I;
			Rect.Left := 2;
			FillRect(Rect);
		end;
	end;
end;


(* search ConfigListItems array for item/subitem by name *)
function TConfigForm.FindKey(Key: string): integer;
var
	I: integer;
begin
	// Return positive index if normal item,
    // negative index if "child"/"subitem"/"Extended" item.
    // CASE SENSITIVE!
    Result := 0;
	for I := 1 to ConfigList.Items.Count do
    begin
       if ConfigListItems[I].Name = Key then
	   begin
       		Result := I;
            Exit;
       end;
       if ConfigListItems[I].Extended.Enabled then
       	if ConfigListItems[I].Extended.Name = Key then
       	begin
       		Result := 0-I;
            Exit;
       	end;
    end;
end;


function TConfigForm.ConfigGetInteger(Key: string; Def: integer): integer;
var
	I: integer;
begin
	Result := Def;
    I := FindKey(Key);
    if I = 0 then Exit;
    if I < 0 then I := -I;
    Result := ConfigListItems[I].Extended.Value;
end;


function TConfigForm.ConfigGetString(Key: string; Def: string): string;
var
	I: integer;
begin
	Result := Def;
    I := FindKey(Key);
    if I = 0 then Exit;
    if I < 0 then I := -I;
    Result := ConfigListItems[I].Extended.sValue;
end;


function TConfigForm.ConfigGetBoolean(Key: string; Def: boolean): boolean;
var
	I: integer;
begin
	Result := Def;
    I := FindKey(Key);
    if I = 0 then Exit;
    if I < 0 then		// subitem
    begin
    	I := -I;
    	Result := ConfigListItems[I].Extended.Value > 0;
	end
    else
    begin
		Result := ConfigListItems[I].Checked = CTRL_TRUE;
    end;
end;


(* read config file and init components, then fill in values from registry *)
procedure TConfigForm.ReadConfig;
var
	Sl: TStringList;
    L,I: integer;
    S,W: string;
    Ti: TConfigListItem;
    B,IsHdr: boolean;
begin
	Sl := TStringList.Create;

	S := MainForm.GetConfigFile('config.ini');
	if not FileExists(S) then
	begin
		MainForm.Error('Cannot initialize -- config.ini not found!');
		Exit;
	end;
	Sl.LoadFromFile(S);

    I := 0;			// number of configlistitems to create
    for L := 0 to Sl.Count-1 do
    begin
    	S := Sl.Strings[L];
        if S <> '' then if S[1] in ['!', '['] then Inc(I);
	end;
	SetLength(ConfigListItems, I);
    if I < 1 then Exit;
    I := 0;
	ConfigList.Items.Clear;

    for L := 0 to Sl.Count-1 do
    begin
    	IsHdr := False;
    	S := Sl.Strings[L];
        if S = '' 		then Continue;	// skip empty lines
        if S[1] = ';'	then Continue;	// skip comments

        if S[1] = '[' then
        begin
        	IsHdr := True;
        	S := Copy(S, 2, Length(S)-2);
            S := '! ' + S;
        end;

		if S[1] = '!' then	// create new, give name
        begin
        	(* add previously made item *)
			if Ti.Name <> '' then
			begin
            	(* try to get Checked from config *)
				if Ti.Checked in [CTRL_TRUE, CTRL_FALSE] then
				begin
					B := False;
					B := Ti.Checked = CTRL_TRUE;
					{B := StrToBool(FormStorage.ReadString(
						Ti.Name, BoolToStr(B,True))); }
					if B then Ti.Checked := CTRL_TRUE else Ti.Checked := CTRL_FALSE;
				end;
				(* try to get additional values from config *)
				if Ti.Extended.Enabled then
				begin
					case Ti.Extended.Valuetype of
						  CTRL_VT_INTEGER:
						  begin
							Ti.Extended.Value := Ord(ROMdata[Ti.Extended.Address+1]);
								{FormStorage.ReadInteger(
								Ti.Extended.Name, Ti.Extended.Default);}
						  end;
						  CTRL_VT_STRING:
						  begin
							Ti.Extended.sValue := '';{FormStorage.ReadString(
								Ti.Extended.Name, Ti.Extended.sDefault);}
						  end;
					end;
                end;
				ConfigList.Items.Add(Ti.Caption);
				ConfigListItems[I] := Ti;
                if Ti.Checked = CTRL_NONE then
					ConfigList.ItemEnabled[ConfigList.Count-1] := False else
                if Ti.Checked = CTRL_SECTION then
                	ConfigList.Header[ConfigList.Count-1] := True else
				ConfigList.Checked[ConfigList.Count-1] := Ti.Checked = CTRL_TRUE;
			end;

            (* start a new item *)
        	Inc(I);
            if S = '! ' then Break;
            Ti.Extended.Enabled := False;
            Ti.Extended.Caption := 'Value:';
            Ti.Extended.Name := '';
            Ti.Name := '';
            Ti.Caption := '';
            Ti.Info := '';

			if IsHdr then
			begin
                W := Copy(S, 3, Length(S));
            	Ti.Checked := CTRL_SECTION;
				Ti.Caption := W;
				Ti.Name    := W;
    			IsHdr := False;
				Continue;
			end;

			W := ExtractWord(2, S, [' ']);
            if W <> '' then
            begin
				Ti.Name := W;
                Ti.Extended.Name := W;
            end;
        	W := UpperCase(ExtractWord(3, S, [' ']));
			Ti.Checked := CTRL_NONE;
            if W <> '' then
            begin
            	if W = 'TRUE'  then Ti.Checked := CTRL_TRUE;
            	if W = 'FALSE' then Ti.Checked := CTRL_FALSE;
            end;
            Continue;
        end;

        (* get first word of line *)
        W := LowerCase(ExtractWord(1, S, [' ']));

        if W = 'caption' then
        begin
            Ti.Caption := Copy(S, 9, Length(S));
            Continue;
        end;

        if W = 'info' then
		begin
            Ti.Info := Copy(S, 6, Length(S));
            Continue;
		end;

        if W = '+name' then
        begin
        	Ti.Extended.Name := ExtractWord(2, S, [' ']);
        	Continue;
        end;

        if W = '+caption' then
        begin
        	Ti.Extended.Caption := ExtractWord(2, S, [' ']);
        	Continue;
        end;

        if W = '+type' then
        begin
			Ti.Extended.Enabled := True;
        	W := LowerCase(ExtractWord(2, S, [' ']));
			if W = 'spinedit' then Ti.Extended.CtrlType := CTRL_spinedit;
			if W = 'trackbar' then Ti.Extended.CtrlType := CTRL_trackbar;
			if W = 'edit'     then Ti.Extended.CtrlType := CTRL_edit;
			if W = 'diredit'  then Ti.Extended.CtrlType := CTRL_diredit;
			if W = 'checkbox' then Ti.Extended.CtrlType := CTRL_checkbox;
			case Ti.Extended.CtrlType of
             CTRL_spinedit, CTRL_trackbar:
             begin
				Ti.Extended.Valuetype := CTRL_VT_INTEGER;
				W := ExtractWord(3, S, [' ']);
				if W <> '' then
				begin
					Ti.Extended.Address := 0;
					if W[1] = '#' then
					begin
						Ti.Extended.Address := StrToInt(Copy(W, 2, Length(W)));
						Ti.Extended.Default := Ord(ROMdata[StrToInt(Copy(W,2,Length(W)))+1])
					end
					else
						Ti.Extended.Default := StrToInt(W);
				end;
				Ti.Extended.Value := Ti.Extended.Default;
            	W := ExtractWord(4, S, [' ']);
            	if W <> '' then Ti.Extended.Min := StrToInt(W);
            	W := ExtractWord(5, S, [' ']);
            	if W <> '' then Ti.Extended.Max := StrToInt(W);
             end;
             CTRL_edit, CTRL_diredit:
             begin
             	Ti.Extended.Valuetype := CTRL_VT_STRING;
                W := ExtractWord(3, S, [' ']);
                W := Copy(S, Pos(W, S), Length(S));
				Ti.Extended.sDefault := W;
				Ti.Extended.sValue := W;
             end;
			end;
        	Continue;
        end;

    end;

    Sl.Free;
end;


(* take care of storing values when choosing a new item *)
procedure TConfigForm.ConfigListClick(Sender: TObject);
var
	I: integer;
begin
	(* put new value back *)
    if ConfigList.Tag > 0 then
    begin
    	I := ConfigList.Tag;
		case ConfigListItems[I].Extended.CtrlType of
			CTRL_spinedit:
				ConfigListItems[I].Extended.Value := ConfigList_SpinEdit.AsInteger;
			CTRL_trackbar:
				ConfigListItems[I].Extended.Value := ConfigList_TrackBar.Position;
			//CTRL_edit:
			CTRL_diredit:
				//ConfigListItems[I].Extended.sValue := ConfigList_DirEdit.Text;
			//CTRL_checkbox:
		end;
	end;

	(* display values and widgets *)
	I := ConfigList.ItemIndex+1;
	ConfigList_InfoLabel.Caption := ConfigListItems[I].Info;
	ConfigList.Hint := ConfigList_InfoLabel.Caption;
	ConfigList.Tag := 0;

	ConfigList_SpinEdit.Visible := False;
	ConfigList_TrackBar.Visible := False;
	//ConfigList_DirEdit.Visible  := False;

	if ConfigListItems[I].Extended.Enabled then
	begin
		ConfigList.Tag := I;
		ConfigList_ExtLabel.Visible := True;
		ConfigList_ExtLabel.Caption := ConfigListItems[I].Extended.Caption + ' ';
		case ConfigListItems[I].Extended.CtrlType of
			CTRL_spinedit:
			  with ConfigList_SpinEdit do
			  begin
				MinValue := ConfigListItems[I].Extended.Min;
				MaxValue := ConfigListItems[I].Extended.Max;
				Value := ConfigListItems[I].Extended.Value;
				Visible := True;
			  end;
			CTRL_trackbar:
			  with ConfigList_TrackBar do
			  begin
				Min := ConfigListItems[I].Extended.Min;
				Max := ConfigListItems[I].Extended.Max;
				Position := ConfigListItems[I].Extended.Value;
				Frequency := (Max - Min) div 10;
				Visible := True;
			  end;
			//CTRL_edit:
			CTRL_diredit:
			  {with ConfigList_DirEdit do
			  begin
				Text := ConfigListItems[I].Extended.sValue;
				InitialDir := Text;
				Visible := True;
			  end;}
			//CTRL_checkbox:
		end;
		Label2.Visible := ConfigListItems[I].Extended.Address > 0;
		Label2.Caption := 'ROM offset: $' + IntToHex(ConfigListItems[I].Extended.Address, 3);
	end
	else
	begin
		Label2.Visible := False;
		ConfigList_ExtLabel.Visible := False;
	end;
	Label1.Visible := ConfigList_SpinEdit.Visible;
end;


function Bool_Str(B: Boolean): string;
begin
	if B then Result := 'True'
	else Result := 'False';
end;


(* stores all values *)
procedure TConfigForm.StoreConfig;
var
	I: integer;
begin
	for I := 1 to ConfigList.Items.Count do
    begin
		if ConfigListItems[I].Checked in [CTRL_TRUE, CTRL_FALSE] then
		begin
			{FormStorage.WriteString(
				ConfigListItems[I].Name,
				Bool_Str(ConfigListItems[I].Checked = CTRL_TRUE) ); }
		end;
		if ConfigListItems[I].Extended.Enabled then
		begin
			case ConfigListItems[I].Extended.ValueType of
			 CTRL_VT_INTEGER:
				ROMdata[ConfigListItems[I].Extended.Address+1] :=
					Chr(ConfigListItems[I].Extended.Value);
				{FormStorage.WriteInteger(
					ConfigListItems[I].Extended.Name,
					ConfigListItems[I].Extended.Value );}
			 CTRL_VT_STRING:
			 begin
				{FormStorage.WriteString(
					ConfigListItems[I].Extended.Name,
					ConfigListItems[I].Extended.sValue );}
			 end;
			end;
		end;
	end;
end;


(* change Checked value of item *)
procedure TConfigForm.ConfigListClickCheck(Sender: TObject);
var
	I: integer;
begin
    I := ConfigList.ItemIndex+1;
    if ConfigListItems[I].Checked in [CTRL_TRUE, CTRL_FALSE] then
    begin
    	if ConfigList.Checked[I-1] then
        	ConfigListItems[I].Checked := CTRL_TRUE
        else
        	ConfigListItems[I].Checked := CTRL_FALSE;
    end;
end;


procedure TConfigForm.ConfigList_SpinEditChange(Sender: TObject);
begin
	ConfigList_SpinEdit.Hint :=
		ConfigList_ExtLabel.Caption +
		IntToStr(ConfigList_SpinEdit.AsInteger);
	Label1.Caption := IntToStr(ConfigList_SpinEdit.AsInteger);
end;

procedure TConfigForm.ConfigList_TrackBarChange(Sender: TObject);
begin
	ConfigList_TrackBar.Hint :=
    	ConfigList_ExtLabel.Caption +
		IntToStr(ConfigList_TrackBar.Position);
end;

procedure TConfigForm.ConfigList_DirEditChange(Sender: TObject);
var
	S: string;
begin
	(* add backslash to end of string if necessary *)
{
	S := ''ConfigList_DirEdit.Text;
	S := ReplaceStr(S, '/', '\');
	if S <> '' then
		if S[Length(S)] <> '\' then S := S + '\';
	ConfigList_DirEdit.Text := S;
	ConfigList_DirEdit.Hint :=
		ConfigList_ExtLabel.Caption + S;
}
end;


end.

