unit main;

(*********************************************************
	SMB3 Workshop
	Version: Public Alpha
	Last modified: 2005-03-01

	(C) 2004, 2005, 2006, 2007 Joel Toivonen (hukka)
	hukkax@gmail.com
	http://hukka.furtopia.org/
 *********************************************************)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  StdCtrls, ComCtrls, ExtCtrls, Forms, Dialogs, Menus, Math, ImgList,
  Buttons, ToolWin, GR32, GR32_Image, GR32_RangeBars, BMSpinEdit, RXSpin,
  ShellApi, RxStrUtils, Placemnt, XPMan, madExceptVcl, pngimage, SpeedBar,
  M3IDEFS, NESSMB3, TSA, PngImageList, ActnList, clipbrd;

{$I CompileTime.Inc}

const
  Filter_M3L = 'M3L Levels|*.m3l|All Files|*.*';
  Filter_ROM = 'ROMs|*.nes;*.smc|All Files|*.*';
  Filter_IPS = 'IPS Patches|*.ips|All Files|*.*';

  COL_RECT_3BYTE = clBlack32;
  COL_RECT_4BYTE = clBlue32;
  COL_RECT_ENEMY = clRed32;
  COL_RECT_OUTER = clWhite32;

  APPCOMMAND_BROWSER_BACKWARD = 1;	// support backward/forward
  APPCOMMAND_BROWSER_FORWARD  = 2;	// navi buttons on modern mice

  DS_NONE  = 0;
  DS_HANDLE= 1;
  DS_ENEMY = 2;
  DS_3BYTE = 3;
  DS_4BYTE = 4;
  DS_INIT  = 9;

  LOC_ALL		= 0;
  LOC_TOP		= 1;
  LOC_TOP2  	= 2;
  LOC_BOTTOM	= 3;
  LOC_DBOTTOM	= 4;
  LOC_DBOTTOM2	= 5;

  MODE_EDIT_MAP		= 1;
  MODE_EDIT_LEVEL	= 0;
  MODE_EDIT_OBJDEF	= 2;

  SPECIALTILEROWS = 10;

  tsaobjset: array [0..11] of Byte =
	(0,2,3,1,9,12,8,5,{7,}10,11, 13,13);



type
  TObjDrag = record
	Dragging:	Boolean;
	osX, osY,
	xsl, ysl,
	X, Y:		Integer;
  end;

  TObjSize = record
	Left,  Right,
	Top,   Bottom,
	Width, Height,
	HandleX, HandleY:	Integer;
  end;

  TEnemySize = record
	Left,  Right,
	Top,   Bottom,
	HandleX:	Integer;
  end;

  TObjectInfo = record
	Index:		Integer;
	SubIndex:	Integer;
	x, y,
	w, h,
	x2, y2:		Integer;
	Obj:		^ObjectDef;
	objtype:	Integer;
	R:			TRect;
	Drag:		TObjDrag;
  end;

  TEnemyInfo = record
	Index:		Integer;
	x, y,
	w, h,
	x2, y2:		Integer;
	R:			TRect;
	Drag:		TObjDrag;
  end;

  TAskTile = record
	Want:		Boolean;
	X, Y:		Integer;
	Corner:		Byte;
	Tile:		Byte;
  end;

  TWMAppCommand = packed record
	msg: Cardinal;
	wnd: HWND;
	keystate: Word;
	deviceAndCommand: Word;
	result: longint;
  end;

  TPaintBox32 = class(Gr32_Image.TPaintBox32)
  private
    Procedure CreateParams( Var params: TCreateParams ); override;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  end;

  TMainForm = class(TForm)
	MainMenu: TMainMenu;
	mROM: TMenuItem;
    mEdit: TMenuItem;
    mHelp: TMenuItem;
	miLoadROM: TMenuItem;
    miSaveROM: TMenuItem;
	miSaveROMAs: TMenuItem;
	miSaveLevelAs: TMenuItem;
	miEdPalette: TMenuItem;
    miLevel: TMenuItem;
	miAbout: TMenuItem;
	PanelInfo: TPanel;
	Label1: TLabel;
    Label2: TLabel;
	Label3: TLabel;
    mLevel: TMenuItem;
    N3: TMenuItem;
	miLevelHeader: TMenuItem;
	OpenDialog: TOpenDialog;
	SaveDialog: TSaveDialog;
	N2: TMenuItem;
    miLoadLevel: TMenuItem;
	Reload1: TMenuItem;
	ImageList: TPNGImageList;
    PanelGfx: TPanel;
    Pb: TPaintBox32;
    mView: TMenuItem;
    miZoom: TMenuItem;
	miZoom100: TMenuItem;
	miZoom200: TMenuItem;
    LogMemo: TMemo;
	N4: TMenuItem;
	miDebuglog: TMenuItem;
    miView3bo: TMenuItem;
    miView4bo: TMenuItem;
	miViewEnemies: TMenuItem;
	Image1: TImage;
	TileGfx: TImage32;
	miZoom50: TMenuItem;
	N7: TMenuItem;
    miClose: TMenuItem;
	miViewHandles: TMenuItem;
    miViewTrans: TMenuItem;
	N9: TMenuItem;
	miViewActiveObjTop: TMenuItem;
	sObjectSet: TBMSpinEdit;
	sObjectType: TBMSpinEdit;
	Label4: TLabel;
    Label5: TLabel;
    miROMgfx: TMenuItem;
	miEdObjdefs: TMenuItem;
	miEdLevel: TMenuItem;
	miEdTSA: TMenuItem;
	RomGfx: TImage32;
    Debug1: TMenuItem;
	N8: TMenuItem;
	LoadObjDefs1: TMenuItem;
	SaveObjDefs1: TMenuItem;
    LoadObjdefs2: TMenuItem;
    N11: TMenuItem;
	miROMtype: TMenuItem;
	miROMDefault: TMenuItem;
	Label6: TLabel;
	sObjectLength: TBMSpinEdit;
	Panel2: TPanel;
	InfoLabel: TLabel;
    lByteData: TLabel;
    XPManifest: TXPManifest;
	miViewFloor: TMenuItem;
	FloorGfx: TImage32;
	miFloorinfront: TMenuItem;
	miViewGrid: TMenuItem;
    N13: TMenuItem;
    miFreeform: TMenuItem;
    Add3byteobject1: TMenuItem;
	Add4byteobject1: TMenuItem;
	miAddenemy1: TMenuItem;
    Deleteobjectenemy1: TMenuItem;
    Savetolocation1: TMenuItem;
    FormStorage1: TFormStorage;
    miDebug: TMenuItem;
    Clear1: TMenuItem;
    miDelAll3: TMenuItem;
	miDelAllE: TMenuItem;
    miDelAll4: TMenuItem;
	bEditPointer: TButton;
    miLimitsize: TMenuItem;
	miPaletteFile: TMenuItem;
    miMisc: TMenuItem;
    miViewToolbar: TMenuItem;
    ObjdefPanel: TPanel;
    FillButton: TButton;
    PasteButton: TButton;
    ListBox: TListBox;
    SpinEdit: TRxSpinEdit;
    SetButton: TButton;
	sbY: TRangeBar;
    sbX: TRangeBar;
    Mode1: TMenuItem;
    N10: TMenuItem;
    N17: TMenuItem;
    miCloneObject: TMenuItem;
    N18: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    roubleshooting1: TMenuItem;
    Enemycompatibility1: TMenuItem;
    Enemycompatibility2: TMenuItem;
	N19: TMenuItem;
	miNextarea: TMenuItem;
    N1: TMenuItem;
    Pointers1: TMenuItem;
    miEditGraphics: TMenuItem;
    N20: TMenuItem;
    ApplyIPSPatch1: TMenuItem;
    ToolBar: TToolBar;
    ActionList1: TActionList;
    OpenROM: TAction;
    OpenM3L: TAction;
    SaveROM: TAction;
    SaveM3L: TAction;
    SaveROMAs: TAction;
    SaveToLocation: TAction;
    ApplyIPS: TAction;
    ExitProgram: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    GotoNextArea: TAction;
    SelectLevel: TAction;
    ReloadLevel: TAction;
    EditHeader: TAction;
    EditPointers: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    EditLevel: TAction;
    EditObjDefs: TAction;
    EditPalette: TAction;
    EditGraphics: TAction;
    EditMisc: TAction;
    ToolButton12: TToolButton;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ObjAdd3Byte: TAction;
    ObjAdd4Byte: TAction;
    ObjAddEnemy: TAction;
    ObjClone: TAction;
    ObjDelete: TAction;
    ViewZoom50: TAction;
    ViewZoom100: TAction;
    ViewZoom200: TAction;
    btnAdd3byte: TToolButton;
    btnAdd4byte: TToolButton;
    btnAddEnemy: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    More1: TMenuItem;
    N5: TMenuItem;
    ToolButton8: TToolButton;
    ToolButton23: TToolButton;
    ProgramWebsite1: TMenuItem;
	procedure FormShow(Sender: TObject);
	procedure LoadMap;
	procedure LoadLevel(os_level, os_enemy: Integer);
	procedure SaveLevel(ToM3L: Boolean = False);
	procedure SaveMap;
	procedure DrawLevel;
	procedure Draw_Sprite(var Box: TPaintbox32; id, x, y: Integer);
	procedure Draw_Handle(id, x, y: Integer);
	procedure miDebuglogClick(Sender: TObject);
	procedure PbKeyDown(Sender: TObject; var Key: Word;
	  Shift: TShiftState);
	procedure miView3boClick(Sender: TObject);
	procedure Move_Object(X, Y: Integer; Limit: Boolean = True);
	procedure Move_Enemy(X, Y: Integer);
	procedure PbResize(Sender: TObject);
	procedure InitVariables;
	procedure Log(S: string; B: Boolean = True);
	procedure ModeChanged(FullRepaint: Boolean = True);
	procedure miAboutClick(Sender: TObject);
	procedure PbMouseWheel(Sender: TObject; Shift: TShiftState;
	  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
	procedure FormCanResize(Sender: TObject; var NewWidth,
	  NewHeight: Integer; var Resize: Boolean);
	procedure LoadGfx;
	procedure DrawFloor;
	procedure sbXChange(Sender: TObject);
	procedure sbYChange(Sender: TObject);
	procedure miViewTransClick(Sender: TObject);
	procedure miViewBackgroundClick(Sender: TObject);
	function  GetEnemyAt(x, y: Integer): TEnemyInfo;
	function  GetObjectAt(x, y: Integer): TObjectInfo;
	function  GetGroundlevel(x, y, x2: Integer; want3:Boolean=True; all:Boolean=True): Integer;
	function  isBlockplatform(d, o: Integer): Boolean;
	//procedure GetObjectDimensions(var O: TObjectInfo);
	procedure Draw_ROMTile(tile, x, y: Integer);
	procedure Draw_FloorTile(tile, x, y: Integer);
	procedure ClearLevel(what, romloc: Integer);
	//procedure StringToFile(Filename: string; var S: string);
	procedure TellObjectInfo;
	procedure PbMouseDown(Sender: TObject; Button: TMouseButton;
	  Shift: TShiftState; X, Y: Integer);
	procedure PbMouseUp(Sender: TObject; Button: TMouseButton;
	  Shift: TShiftState; X, Y: Integer);
	procedure PbMouseMove(Sender: TObject; Shift: TShiftState; X,
	  Y: Integer);
	procedure sObjectTypeChange(Sender: TObject);
	function ROM_Seek(Pos: Integer): Integer;
	function ROM_GetByte(Pos: Integer = -1): Byte;
	function  Get_Ending_Index(obs: Integer): Integer;
	procedure ROM_PutByte(B: Byte; Pos: Integer = -1);
	procedure miROMgfxClick(Sender: TObject);
	procedure DrawFrame(x1, y1, x2, y2: Integer; S: String = '');
	procedure LoadRomObjDefs(ToROM: Boolean = True);
	procedure SaveRomObjDefs;
	procedure LoadObjDefs1Click(Sender: TObject);
	procedure SaveObjDefs1Click(Sender: TObject);
	procedure LoadObjdefs2Click(Sender: TObject);
	procedure miROMDefaultClick(Sender: TObject);
	procedure ShowHint(Sender: TObject);
	procedure Info(S: String; Stay: Boolean = False);
	procedure Change_Enemy_Type(T: Integer);
	procedure Change_Object_Type(B, T, L: Integer; Sender: TObject);
	procedure miViewFloorClick(Sender: TObject);
    procedure miFloorinfrontClick(Sender: TObject);
	procedure miViewGridClick(Sender: TObject);
	procedure GetBgTileSolidColor;
	procedure InfoLabelClick(Sender: TObject);
	procedure AddEnemy(x, y: Integer);
	procedure AddObject_3byte(x, y: Integer);
	procedure AddObject_4byte(x, y: Integer);
	procedure UpdateLevelInfo;
	function  Convert_Object_Sets(obs: Integer): Integer;
	procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
	procedure Debug(S: string = '');
	procedure InfoLabelDblClick(Sender: TObject);
	procedure miDelAll3Click(Sender: TObject);
	procedure miDelAllEClick(Sender: TObject);
	procedure miDelAll4Click(Sender: TObject);
	procedure bEditPointerClick(Sender: TObject);
	procedure GetPalette;
	procedure AdjustScrollbars;
	procedure PbDblClick(Sender: TObject);
	//function  FileToString(Filename: string; Maxlen: integer): string;
	procedure DrawMap;
	procedure DrawGridlines;
	procedure DrawObjDef;
	procedure CustomMenuitemClick(Sender: TObject);
	procedure miPaletteFileClick(Sender: TObject);
	procedure Error(S: string);
	function  GetConfigFile(Filename: string): string;
    procedure SpinEditChange(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure FillButtonClick(Sender: TObject);
    procedure SetButtonClick(Sender: TObject);
    procedure roubleshooting1Click(Sender: TObject);
    procedure Enemycompatibility2Click(Sender: TObject);
	procedure SelectPointer(i: Integer);
	procedure SavePointer(i: Integer);
	procedure EnterPointerDialog;
	procedure ROMGraphicsChanged(Tile: Integer = -1);
	procedure SaveROMGraphics;
    procedure EditPaletteExecute(Sender: TObject);
    procedure EditObjDefsExecute(Sender: TObject);
    procedure EditLevelExecute(Sender: TObject);
    procedure ObjCloneExecute(Sender: TObject);
    procedure ObjAddEnemyExecute(Sender: TObject);
    procedure ObjDeleteExecute(Sender: TObject);
    procedure ExitProgramExecute(Sender: TObject);
    procedure SelectLevelExecute(Sender: TObject);
    procedure OpenROMExecute(Sender: TObject);
    procedure OpenM3LExecute(Sender: TObject);
    procedure miViewToolbarClick(Sender: TObject);
    procedure ApplyIPSExecute(Sender: TObject);
    procedure EditGraphicsExecute(Sender: TObject);
    procedure EditPointersExecute(Sender: TObject);
    procedure GotoNextAreaExecute(Sender: TObject);
    procedure ReloadLevelExecute(Sender: TObject);
    procedure SaveROMExecute(Sender: TObject);
    procedure ViewZoom100Execute(Sender: TObject);
    procedure SaveROMAsExecute(Sender: TObject);
    procedure SaveM3LExecute(Sender: TObject);
    procedure SaveToLocationExecute(Sender: TObject);
    procedure EditHeaderExecute(Sender: TObject);
    procedure EditMiscExecute(Sender: TObject);
  protected
	TransColor: TColor32;
  private
	procedure WMSyscommand(var msg: TWmSysCommand); message WM_SYSCOMMAND;
	procedure WMAppcommand(var msg: TWmAppCommand); message WM_APPCOMMAND;
  public
	World, Level: byte;
	NESpal: array[0..63] of TColor32;
	ROM_gfx: Boolean;
	procedure PC_ColorMask(F: TColor32; var B: TColor32; M: TColor32);
	procedure PC_NoColorMask(F: TColor32; var B: TColor32; M: TColor32);
  end;


var
  MainForm: TMainForm;
  WORLD_INDEXES: array [1..9] of Integer = (9,33,56,94,124,162,198,246,281);
  leveltile: array of array of Byte;
  floortile: array[0..12] of Byte;
  ROMdata: String;
  ROM_EOF: Boolean = False;
  ROM_pos: Integer = 0;
  BgTileIsSolidColor: Boolean = False;
  LevelModified: Boolean = False;
  GraphicsModified: Boolean = False;
  Starting: Boolean = True;
  level_array: array [1..NUM_SMB3_LEVELS] of Mario3Level;
  plains_level: array [0..12, 0..247] of ObjectDef;
  ff_number_of_level_sections,
  ff_object_flag, ff_oldobject_flag: Integer;
  shadowblock: array[1..6] of Integer;
  map_sections: Integer;
  map_sprites:     array [0..9, 0..4] of Byte;
  map_ptr_vert:    array [0..65664] of Byte;
  map_ptr_hriz:    array [0..65664] of Byte;
  map_ptr_enemies: array [0..2, 0..65664] of Byte;
  map_ptr_levels:  array [0..2, 0..65664] of Byte;
    tbyte_array: array [0..2, 0..21848] of Byte;	//temp reusable storage for 3-byte objects
    fbyte_array: array [0..3, 0..16386] of Byte;	//temp reusable storage for 4-byte objects
    enemy_array: array [0..2, 0..21848] of Byte;	//temp reusable storage for enemies
  object_numbers_3: array [0..21848] of Word;
  object_numbers_4: array [0..16386] of Word;
  level_bytes, orig_level_bytes,		// Stores the amount of bytes each level uses
  level_index_number: Word;
  object_ordering: array [0..21848] of Word; //Object ordering table
  objbytes: array[0..21848] of Byte;
  tbyte_objs, fbyte_objs, enemy_objs,
  number_of_level_sections, the_first_object,
  enemy_bytes, orig_enemy_bytes, pointer_offset, num_ptrs: Integer;
  level_offset, header_offset, enemy_offset: Cardinal;
  level_object_set, real_level_object_set: Byte;	 //stores the number of the tile set each level uses
  level_table_string: String; //actual level data will be stored in this string
  header: array[1..9] of Byte;
  vertical_flag: Boolean;
  x_screen_loc, y_screen_loc: Integer;
  bgcol: TColor32;
  DataDir: string;
  pbW, pbH: Integer;
  Loading: boolean;
  Zoomsize: integer;
  zzzx,zzzy: Integer;
  color_Sky, color_BgTile, color_Sky_orig, color_FillSky: TColor32;
  //objlist_3, objlist_4: array[0..255] of Byte;
  ground_level : Integer = 26;
  drawingstate: Integer;
  blitting_object: Integer = -1;
  SelObject: TObjectInfo;
  SelEnemy:  TEnemyInfo;
  ObjectSize: array[0..38234] of TObjSize;
  ObjectSizes: array[1..11, 0..255] of TObjSize;
  EnemySize: array[0..236] of TEnemySize;
  init_objectsizes: Boolean = False;
  objectsizeinit_prev: Integer = -1;
  mbdown: (MB_LEFT, MB_RIGHT, MB_MIDDLE, MB_NONE);
  ROM_OffsetBy: Integer = 0;
  ROMfilename: string;
  mode: Integer = MODE_EDIT_LEVEL;
  SelObjTile: Integer = 0;
  ROMdir: string = '';
  paletteaddr: Integer = $36CA2;
  mappaletteaddr: Integer = $36BE2;
  StatusText: string;
  enemymode: Boolean = False;
  WaitingToAddObj: Integer = 0;
  levellimit_x, levellimit_y: Integer;
  enemyhandle_x, enemyhandle_x2, enemyhandle_y: array[0..236] of Shortint;
  Debug_Text: String = '';
  maparray: array [0..9, 0..7296] of Byte;
  mapptr_level, mapptr_enemy, mapptr_objectset: Integer;
  DblClicked, ROMloaded, SMAS: Boolean;
  palettefile: String;
  cloneobjarray: array [0..4] of Byte;
  sbw, sbh: Integer;
  AskTile: TAskTile;


implementation

{$R *.dfm}


uses drawobjs, levelsel, about, headered, ptredit, paletted, config, gfxeditor,
	fileutils;


//  Add scrollbars to graphics container
procedure TPaintBox32.CreateParams(var params: TCreateParams);
begin
	inherited;
	params.Style := params.Style or WS_HSCROLL or WS_VSCROLL;
end;

// Respond to scrolling events
procedure TPaintBox32.WMHScroll(var Msg: TWMHScroll);
var
	Jmp: Integer;
begin
	inherited;
	Jmp := 0;
	case Msg.ScrollCode of
		SB_RIGHT, SB_LINERIGHT: Jmp :=  1;
		SB_LEFT,  SB_LINELEFT:  Jmp := -1;
		SB_PAGELEFT:   Jmp := -MainForm.sbX.Window;
		SB_PAGERIGHT:  Jmp :=  MainForm.sbX.Window;
		SB_THUMBTRACK: MainForm.sbX.Position := Msg.Pos;
	end;
	if Jmp <> 0 then
		MainForm.sbX.Position := MainForm.sbX.Position + Jmp;
end;

procedure TPaintBox32.WMVScroll(var Msg: TWMVScroll);
var
	Jmp: Integer;
begin
	inherited;
	Jmp := 0;
	case Msg.ScrollCode of
		SB_RIGHT, SB_LINERIGHT: Jmp :=  1;
		SB_LEFT,  SB_LINELEFT:  Jmp := -1;
		SB_PAGELEFT:   Jmp := -MainForm.sbY.Window;
		SB_PAGERIGHT:  Jmp :=  MainForm.sbY.Window;
		SB_THUMBTRACK: MainForm.sbY.Position := Msg.Pos;
	end;
	if Jmp <> 0 then
		MainForm.sbY.Position := MainForm.sbY.Position + Jmp;
end;

procedure TMainForm.Error(S: string);
begin
	MessageDlg(S, mtError, [mbOK], 0);
end;

procedure TMainForm.Log(S: string; B: Boolean = True);
begin
	if LogMemo.Visible then
		if B = True then
			LogMemo.Lines.Add(S);
end;

procedure TMainForm.Debug(S: string = '');
begin
	if not miDebug.Checked then Exit;
	if S = '' then
	begin
		Log(Debug_Text);
		Debug_Text := '';
	end
	else
		Debug_Text := Debug_Text + S;
end;


(*
 *  Trap window maximize event in order to make sure the
 *  window gets fully maximized
 *)
procedure TMainForm.WMSyscommand(var msg: TWmSysCommand);
begin
	case (msg.cmdtype and $FFF0) of
	SC_RESTORE:
		OnCanResize := FormCanResize;
	SC_MAXIMIZE:
		begin
			OnCanResize := nil;
			y_screen_loc := 0;
		end;
	end;
	inherited;
end;

(*
 *  Trap browser backward/forward buttons on posh mice/keyboards
 *)
procedure TMainForm.WMAppcommand(var msg: TWmAppCommand);
begin
	case (msg.deviceAndCommand and not $F000) of
	APPCOMMAND_BROWSER_BACKWARD:
		if not vertical_flag then
			MainForm.sbX.Position := MainForm.sbX.Position - MainForm.sbX.Window
		else
			MainForm.sbY.Position := MainForm.sbY.Position + MainForm.sbY.Window;
	APPCOMMAND_BROWSER_FORWARD:
		if not vertical_flag then
			MainForm.sbX.Position := MainForm.sbX.Position + MainForm.sbX.Window
		else
			MainForm.sbY.Position := MainForm.sbY.Position - MainForm.sbY.Window;
	end;
	inherited;
end;


procedure TMainForm.ShowHint(Sender: TObject);
var
	S: String;
begin
	S := Application.Hint;
	if S = '' then S := StatusText
		else S := ReplaceStr(S, '$rom', ROMfilename);
	Infolabel.Caption := ' ' + ReplaceStr(S, #13#10, ' ');
end;


procedure TMainForm.Info(S: String; Stay: Boolean = False);
begin
	S := ReplaceStr(S, '&', '&&');
	S := ReplaceStr(S, '$rom', ROMfilename);
	S := ReplaceStr(S, 'MSG_CRASH',   'Crashes game');
	S := ReplaceStr(S, 'MSG_NOTHING', 'Nothing');
	S := ReplaceStr(S, 'MSG_POINTER', 'Pointer');

	Infolabel.Caption := ' ' + S;
	if Stay then StatusText := S;
end;


function TMainForm.GetConfigFile(Filename: string): string;
label
	GotName;
var
	F: string;
begin
	if ROMdir <> '' then
	begin
		F := DataDir + ROMdir + Filename;
		if FileExists(F) then goto GotName;
	end;
	F := DataDir + Filename;
	if FileExists(F) then goto GotName;
	F := ExtractFilePath(Application.ExeName) + Filename;
	if FileExists(F) then goto GotName;
	F := Filename;
GotName:
	Result := F;
end;


function EnemyWidth(I: Integer): Integer;
begin
	Result := plains_level[enemybank, enemy_array[0, I]].bmp_width;
end;

function EnemyHeight(I: Integer): Integer;
begin
	Result := plains_level[enemybank, enemy_array[0, I]].bmp_height;
end;

procedure GetEnemySize(i: Integer);
var
	hx: Integer;
begin
	hx := enemyhandle_x2[enemy_array[0, i]];
	EnemySize[i].HandleX := hx;
	EnemySize[i].Left    := enemy_array[1, i] + enemyhandle_x[enemy_array[0, i]] - hx;
	EnemySize[i].Top     := enemy_array[2, i] + enemyhandle_y[enemy_array[0, i]];
	EnemySize[i].Right   := EnemySize[i].Left + EnemyWidth(i)  - 1;
	EnemySize[i].Bottom  := EnemySize[i].Top  + EnemyHeight(i) - 1;
end;


procedure SelectObjectAt(x, y: Integer; mb: TMouseButton; SelectNone: Boolean = False);
var
	ss: TShiftState;
begin
	if x > levellimit_x then Exit;
	if y > levellimit_y then Exit;
	if SelectNone then ss := [ssShift] else ss := [];
	with MainForm do begin
		PbMouseDown(Pb, mb, ss, x*Zoomsize, y*Zoomsize);
		PbMouseUp(Pb,   mb, ss, x*Zoomsize, y*Zoomsize);
	end;
end;


function TMainForm.Convert_Object_Sets(obs: Integer): Integer;
begin
  Result := 1;
  case obs of
	0,1,7,15: Result := 1;
	14:		Result := 11; // Underground
	2:		Result := 4;
	3, 114:	Result := 2;
	4:		Result := 3;
	5, 11:	Result := 9;
	6, 8:	Result := 8;
	9:		Result := 7;
	10:		Result := 5;
	12:		Result := 10;
	13:		Result := 6;
	16:		Result := 0;
  end;
end;


function TMainForm.Get_Ending_Index(obs: Integer): Integer;
begin
  Result := 0;
  case obs of
	0,1,7,15: Result := 0;
	14:		Result := 0; // Underground
	2:		Result := 0;
	3, 114:	Result := 0;
	4:		Result := 1;
	5, 11:	Result := 2;
	6, 8:	Result := 3;
	9:		Result := 2;
	10:		Result := 0;
	$C:		Result := 1;
	13:		Result := 0;
	16:		Result := 0;
  end;
end;


procedure UpdateEditValue(Sender: TBMSpinEdit);
var
	S: String;
begin
	if Sender.Value >= 100 then S := ''
	else
	if Sender.Value >= 10  then S := ' '
	else
	S := '  ';
	S := S + '(' + IntToHex(Trunc(Sender.Value) , 2) + ')';
	Sender.ValueUnit := S;
end;


{$include file.pas}
{$include drawing.pas}


procedure TMainForm.DrawGridlines;
var
	Linecolor: TColor32;
	o: Integer;
begin
	if not miViewGrid.Checked then Exit;
	Linecolor := Color32(0, 0, 0, 90);
	for o := 1 to levellimit_y do
		Pb.Buffer.HorzLineTS(0, o * Zoomsize, Pb.Width-sbw-1,  Linecolor);
	for o := 1 to Pb.Width-sbw  div Zoomsize do
		Pb.Buffer.VertLineTS(o * Zoomsize, 0, Pb.Height-sbh-1, Linecolor);
end;


procedure TMainForm.LoadGfx;
var
	S: String;
	Y, X, J: Integer;
begin
	if palettefile = '' then palettefile := 'Default.pal';
	S := GetConfigFile(palettefile);
	if FileExists(S) then
	begin
		S := FileToString(S, -1);
		J := $19; // 1st color pos
		for Y := 0 to 63 do
		begin
			NESpal[Y] := Color32(Ord(S[J]), Ord(S[J+1]), Ord(S[J+2]));
			Inc(J, 4);
		end;
    end;
	if ROMloaded then
	 if not SMAS then
	 begin
		if World > 0 then
			J := tsaobjset[level_object_set-1]
		else
			J := $e;
		TSA.LoadTSAData(J);
		TSA.LoadPatternTable(J);
		TSA.BuildPatternTables;
	 end
	 else
		ROM_gfx := False;
	case mode of
	  MODE_EDIT_LEVEL, MODE_EDIT_MAP:
	  begin
		if ROM_gfx then
		begin
			shadowblock[1] := 192+2;
			shadowblock[2] := 192+5;
			shadowblock[3] := 192+3;
			shadowblock[4] := 192+4;
			shadowblock[5] := 192+0;
			J := 0;
			for y := 0 to 3 do
			  for x := 0 to 63 do
			  begin
				TSA.BlitBlock(Pointer(TileGfx.Bitmap), J, x*16, y*16);
				Inc(J);
			  end;
			TileGfx.Flush;
		end
		else
		begin
			shadowblock[1] := 340;
			shadowblock[2] := 341;
			shadowblock[3] := 342;
			shadowblock[4] := 343;
			shadowblock[5] := 344;
			TileGfx.Bitmap.LoadFromFile(GetConfigFile('gfx.png'));
		end;
	  end;
	  MODE_EDIT_OBJDEF:
	  begin
		J := 0;
		for y := 0 to 15 do
		  for x := 0 to 15 do
		  begin
			TSA.BlitBlock(Pointer(RomGfx.Buffer), J, x * 16, y * 16);
			Inc(J);
		  end;
		RomGfx.Flush;
		TileGfx.Bitmap.LoadFromFile(GetConfigFile('gfx.png'));
	  end;
	end;

	if miViewTrans.Checked then
		TileGfx.Bitmap.OnPixelCombine := PC_ColorMask
	else
		TileGfx.Bitmap.OnPixelCombine := PC_NoColorMask;
end;


procedure TMainForm.InitVariables;
var
	T: TStrings;
	S, Z: String;
	Y, D, F, J: Integer;
function GetConfigInteger(Name: string; Default: Integer): Integer;
begin
	if T.Values[Name] = '' then Result := Default
		else Result := StrToInt(T.Values[Name]);
end;
begin
	Zoomsize := 16;
	{
	Loads graphics
	}
	RomGfx.Width  := 256;
	RomGfx.Height := 256;
	LoadGfx;

	(* read ROM preset info *)
	T := TStringList.Create;
	T.LoadFromFile(GetConfigFile('rom.ini'));
	paletteaddr := GetConfigInteger('levelpalettes', paletteaddr);
	mappaletteaddr := GetConfigInteger('mappalettes', mappaletteaddr);
	palettefile := T.Values['palettefile'];

	S := T.Values['offsets.tsa'];
	if S <> '' then
		for D := 0 to $E+8 do
			tsaOffsets[D] := StrToInt(ExtractWord(D+1, S, [',']));

	S := T.Values['offsets.graphics'];
	if S <> '' then
		for D := 0 to $E+8 do
			graphicsOffsets[D] := StrToInt(ExtractWord(D+1, S, [',']));

	S := T.Values['offsets.common'];
	if S <> '' then
		for D := 0 to $E+8 do
			commonOffsets[D] := StrToInt(ExtractWord(D+1, S, [',']));

	{
	Loads level offsets in ROM and other similar data from levels.dat
	}
	T.LoadFromFile(GetConfigFile('levels.dat'));
	for Y := 1 to T.Count do
	begin
		S := T.Strings[Y-1];
//		S := Trim(Copy(S, 1, Pos(';', S)-1));
		with level_array[Y] do
		begin
			game_world       := StrToInt(ExtractWord(1, S, [',']));
			level_in_world   := StrToInt(ExtractWord(2, S, [',']));
			rom_level_offset := StrToInt(ExtractWord(3, S, [',']));
			enemy_offset     := StrToInt(ExtractWord(4, S, [',']));
			real_obj_set     := StrToInt(ExtractWord(5, S, [',']));
			name             := ExtractWord(6, S, [',']);
            if (level_in_world = 1) and (game_world > 0) then
				WORLD_INDEXES[game_world] := Y-1;
		end;
	end;
	{
	Loads object definitions from data.dat
	}
	F := 0;
	D := 0;
	T.LoadFromFile(GetConfigFile('data.dat'));
	for Y := 1 to T.Count-1 do
	begin
		S := T.Strings[Y];
		if S = '' then
		begin
			Inc(D);
			F := 0;
			Continue;
		end;
		with plains_level[D, F] do
		begin
			obj_domain := StrToInt(ExtractWord(1, S, [',']));
			min_value  := StrToInt(ExtractWord(2, S, [',']));
			max_value  := StrToInt(ExtractWord(3, S, [',']));
			bmp_width  := StrToInt(ExtractWord(4, S, [',']));
			bmp_height := StrToInt(ExtractWord(5, S, [',']));
			Z := Copy(S, Pos('<', S)+1, Length(S));
			Z := Copy(Z, 1, Pos('>', Z)-1);
			S := Copy(S, Pos('>', S)+1, Length(S));
			J := 1;
			while ExtractWord(J, Z, [',']) <> '' do
			begin
				SetLength(obj_design, J);
				SetLength(obj_design_2, J);
				obj_design[J-1] := StrToInt(ExtractWord(J, Z, [',']));
				obj_design_2[J-1] := 0;
				SetLength(rom_obj_design, J);
				//SetLength(rom_obj_design_2, J);
				rom_obj_design[J-1] := obj_design[J-1];
				obj_design_length := J;
				Inc(J);
			end;
			orientation := StrToInt(ExtractWord(1, S, [',']));
			ends        := StrToInt(ExtractWord(2, S, [',']));
			obj_flag    := StrToInt(ExtractWord(3, S, [',']));
			S := ExtractWord(4, S, [',']);
			if D = enemybank then
			 if F <= 236 then
			 begin
				Z := '';
				if Pos('|', S) > 0 then
				begin
					Z := Copy(S, Pos('|', S)+1, Length(S)) + ' ';
					S := Copy(S, 1, Pos('|', S)-1);
				end;
				Z := Z + '0 0 0 ';
				enemyhandle_x[F] := StrToInt(ExtractWord(1, Z, [' ']));
				enemyhandle_y[F] := StrToInt(ExtractWord(2, Z, [' ']));
				enemyhandle_x2[F]:= StrToInt(ExtractWord(3, Z, [' ']));
			 end;
			obj_descript := ReplaceStr(S, ';;', ',');
		end;
		Inc(F);
	end;
	T.Free;
end;


procedure TMainForm.GetPalette;
var
	i: Integer;
begin
	if not ROMloaded then Exit;
	if SMAS then Exit;
	i := header[8] and 31;
	if i = 20 then i := 1;
	i := i and 15;
	i := paletteaddr + 1 + ((i-1) * $C0);
	i := i + ((header[6] and 7) * 16);
	color_Sky := NESpal[Ord(ROMdata[i])];
{
	if level_object_set = OBJSET_WATERPIPE then
		for i := 0 to tbyte_objs - 1 do
			if tbyte_array[2][i] = $C then	// black bg for pipe levels
			begin
				color_Sky := clBlack32;
				Break;
			end;
}
	if level_object_set = OBJSET_UNDERGROUND then
	begin
		color_Sky := clBlack32;
		for i := 0 to tbyte_objs - 1 do
			if tbyte_array[2][i] = $D then	// blue bg for ug levels
			if (tbyte_array[0][i] div 32) = 2 then
			begin
				color_Sky := NESpal[$3C];
				Break;
			end;
	end;
	color_Sky_orig := color_Sky;
end;


procedure TMainForm.UpdateLevelInfo;
begin
	Label1.Caption := Format('3-byte objects: %d', [tbyte_objs]);
	Label2.Caption := Format('4-byte objects: %d', [fbyte_objs]);
	Label3.Caption := Format('Enemies:  %d', [enemy_objs]);
	Caption := 'SMB3 Workshop ' +
		FormatDateTime('yyyy-mm-dd', CompileTime);
	// Format('SMB3 Workshop - Level %d-%d', [World, Level]);
	if miLimitsize.Checked then
	  lByteData.Hint := 'Free object bytes: ' + IntToStr(orig_level_bytes - level_bytes)
	+ '   Free enemy bytes: ' + IntToStr(orig_enemy_bytes - enemy_bytes)
	else
	  lByteData.Hint := 'Object bytedata / level size';
end;


function TMainForm.isBlockplatform(d, o: Integer): Boolean;
begin
	Result := False;
	if d <> 1 then Exit;
	if (o >= $10) and (o <= $17) then Result := True;
end;


function TMainForm.GetEnemyAt(x, y: Integer): TEnemyInfo;
var
	tx, ty, l, tx2, ty2: Integer;
begin
	Result.Index := -1;
	for l := 0 to (enemy_objs - 1) do
	begin
		tx  := EnemySize[l].Left;
		ty  := EnemySize[l].Top;
		tx2 := tx + EnemyWidth(l)  - 1;
		ty2 := ty + EnemyHeight(l) - 1;
		if ty  > y then Continue;
		if ty2 < y then Continue;
		if tx  > x then Continue;
		if tx2 < x then Continue;
		Result.Index := l;
	end;
end;


function GetObjectIndex(bytes, subindex: Integer): Integer;
var
	l: Integer;
	b: array[3..4] of Integer;
begin
	b[3] := 0; b[4] := 0;
	for l := 0 to (tbyte_objs + fbyte_objs - 1) do
	begin
		Inc(b[objbytes[l]]);
		if b[bytes] > subindex then Break;
	end;
	Result := l;
end;


function TMainForm.GetObjectAt(x, y: Integer): TObjectInfo;
var
	tx, ty, m, g, l, tx2, ty2, obj: Integer;
begin
	Result.Index := -1;
	Result.SubIndex := -1;
	Result.Obj := nil;
	m := 0; g := 0;
	for l := 0 to (tbyte_objs + fbyte_objs - 1) do
	begin
		if objbytes[l] = 3 then
		begin
			if (tbyte_array[2,m] < 16) then
				obj := tbyte_array[2,m] + ((tbyte_array[0,m] div 32) * 31)
			else
				obj := ((tbyte_array[2,m] div 16) + (((tbyte_array[0,m] div 32) * 31) + 16)) - 1;
			Inc(m);
		end
		else
		begin	// 4 byte
			obj := ((fbyte_array[2,g] div 16) + (((fbyte_array[0,g] div 32) * 31) + 16)) - 1;
			Inc(g);
		end;
		tx  := ObjectSize[l].Left;
		ty  := ObjectSize[l].Top;
		tx2 := ObjectSize[l].Right;
		ty2 := ObjectSize[l].Bottom;
		if ty  > y then Continue;
		if ty2 < y then Continue;
		if tx  > x then Continue;
		if tx2 < x then Continue;
		Result.Index := l;
		if objbytes[l] = 3 then Result.SubIndex := m - 1
			else Result.SubIndex := g - 1;
		Result.Obj := @plains_level[level_object_set, obj];
		Result.objtype := obj;
	end;
end;


function TMainForm.GetGroundlevel(x, y, x2: Integer; want3:Boolean=True; all:Boolean=True): Integer;
label valmis;
var
	r, tx, ty, m, l, tx2, obj, d: Integer;
begin
	m := -1; x2 := x + x2;
	Result := 26; r := Result + 1;
	if all then d := (tbyte_objs+fbyte_objs-1) else d := blitting_object-1;
	if d < 0 then Exit;

	for l := 0 to d do
	begin
		if objbytes[l] = 3 then
		begin
			Inc(m);
			if not want3 then Continue;
			if tbyte_array[2,m] > 15 then
			begin
				obj := ((tbyte_array[2,m] div 16) + (((tbyte_array[0,m] div 32) * 31) + 16)) - 1;
				if isBlockPlatform(level_object_set, obj) then Continue;
			end
			else
				obj := tbyte_array[2,m] + ((tbyte_array[0,m] div 32) * 31);
			if plains_level[level_object_set, obj].orientation in [PYRAMID, PYRAMID2] then Continue;
		end;
		tx  := ObjectSize[l].Left;
		ty  := ObjectSize[l].Top;
		tx2 := ObjectSize[l].Right;
		if ty <= y then Continue;
		if tx > x2 then Continue;
		if tx2 < x then Continue;
		Dec(ty);
		if ty < Result then
		begin
			Result := ty;
			r := ty + 1;
		end;
	end;
{
	for l := Min(x,levellimit_x) to Min(x2, levellimit_x) do
	for r := Min(y,levellimit_y) to levellimit_y do
		if leveltile[l,r] in [83,85,87,74,75,76,88] then
		begin
			Result := r-1;
			goto valmis;
		end;
}
valmis:
	Result := r-1;
	if blitting_object < 0 then Exit;
	ObjectSize[blitting_object].Bottom := r;
	ObjectSize[blitting_object].Height := r - ObjectSize[blitting_object].Top;
	if blitting_object = SelObject.Index then
	begin
		SelObject.y2 := r;
		SelObject.h := ObjectSize[SelObject.Index].Height;
	end;
end;


{$include object.pas}


(* TODO: get rid of sbX/sbY TRangebars altogether *)
procedure TMainForm.AdjustScrollbars;
var
	ScrInfo: TScrollInfo;
    pbw, pbh: Integer;
begin
	pbw := pb.Width  - sbw;
	pbh := pb.Height - sbh;
	sbX.OnChange := nil;
	sbY.OnChange := nil;
	sbX.Position := x_screen_loc;
	sbY.Position := y_screen_loc;

	if vertical_flag then
		sbX.Window := 0
	else
		sbX.Window := (pb.Width - sbw) div Zoomsize;
	sbY.Window := pbh div Zoomsize;
	if vertical_flag then
		sbY.Range := Max( (((header[5] and 15)+1)*$10)-(pbh div Zoomsize), 0) + (pbh div Zoomsize)
	else
		sbY.Range := Max(levellimit_y+1-(pbh div Zoomsize), 0) + (pbh div Zoomsize);
	sbX.Range := Max( levellimit_x - (sbw div Zoomsize), 0) + (sbw  div Zoomsize);
	sbX.Repaint;
	sbY.Repaint;
	sbX.OnChange := sbXChange;
	sbY.OnChange := sbYChange;

	ScrInfo.cbSize := Sizeof(scrInfo);
	ScrInfo.fMask := SIF_PAGE or SIF_POS or SIF_RANGE or SIF_DISABLENOSCROLL;
	ScrInfo.nMin := 0;
	ScrInfo.nPage := sbX.Window;
    ScrInfo.nMax := sbX.Range-1;
    ScrInfo.nPos := x_screen_loc;
    SetScrollInfo(pb.Handle, SB_HORZ, ScrInfo, True);

	ScrInfo.nPage := sbY.Window;
    ScrInfo.nMax := sbY.Range-1;
    ScrInfo.nPos := y_screen_loc;
    SetScrollInfo(pb.Handle, SB_VERT, ScrInfo, True);
end;


procedure TMainForm.TellObjectInfo;
label TellNone;
var
	a, domain, o: Integer;
	S: String;
begin
	if enemymode then
	begin
		if (SelEnemy.Index < 0) then goto TellNone;
		Info(Format('%.3d  X:%.3d  Y:%.3d  %s',
		[SelEnemy.Index,
		 SelEnemy.x + EnemySize[SelEnemy.Index].HandleX, SelEnemy.y,
		 plains_level[enemybank,enemy_array[0,SelEnemy.Index]].obj_descript]),
		 True);
	end else
	begin
		if (SelObject.Index < 0) then goto TellNone;
		if (SelObject.obj = nil) then goto TellNone;
		{if mode = MODE_EDIT_MAP then
		Info(Format('%.3d  X:%.3d  Y:%.3d  %s',
		[maparray[SelObject.y,SelObject.x],
		SelObject.x + ObjectSize[SelObject.Index].HandleX,
		SelObject.y + ObjectSize[SelObject.Index].HandleY,
		SelObject.Obj.obj_descript]), True)
		else}
		Info(Format('%.3d  X:%.3d  Y:%.3d  %s',
		[SelObject.Index,
		SelObject.x + ObjectSize[SelObject.Index].HandleX,
		SelObject.y + ObjectSize[SelObject.Index].HandleY,
		SelObject.Obj.obj_descript]), True);
	end;
	// display raw object bytedatas
	S := '';
	if enemymode then
	begin
		a := SelEnemy.Index;
		for o := 0 to 2 do
			S := S + IntToHex(enemy_array[o,a],2) + ' ';
	end
	else
	begin
	  a := SelObject.SubIndex;
	  //if SelObject.Obj.obj_flag = THREE_BYTE then
	  if objbytes[SelObject.Index] = 3 then
	  begin
		domain := tbyte_array[0, a] div 32;
		for o := 0 to 2 do
			S := S + IntToHex(tbyte_array[o,a],2) + ' ';
	  end else
	  begin
		domain := fbyte_array[0, a] div 32;
		for o := 0 to 3 do
			S := S + IntToHex(fbyte_array[o,a],2) + ' ';
	  end;
	end;
	lByteData.Caption := S + ' ';
	Exit;
TellNone:
	S := IntToHex(level_bytes,3) + ' (' + IntToStr(level_bytes) + ')';
	lByteData.Caption := S;
end;


procedure TMainForm.FormShow(Sender: TObject);
var
	S: string;
	R: TSearchRec;
	M: TMenuItem;
	NonClientMetrics: TNonClientMetrics;
begin
	sbw := GetSystemMetrics(SM_CXVSCROLL);
	sbh := GetSystemMetrics(SM_CYHSCROLL);
	if Starting then	// initialize stuff in the beginning
	begin
	Pb.OnKeyDown := PbKeyDown;
	Application.Title := 'SMB3 Workshop';
	Caption := DateTimeToStr(CompileTime);
		(* get default Windows font *)
		NonClientMetrics.cbSize := sizeof(NonClientMetrics);
		if SystemParametersInfo(
			SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
		begin
			Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
			fSelectLevel.Font.Handle := Font.Handle;
			ConfigForm.Font.Handle := Font.Handle;
			fAbout.Font.Handle := Font.Handle;
			fHeader.Font.Handle := Font.Handle;
			fPointer.Font.Handle := Font.Handle;
			fPalette.Font.Handle := Font.Handle;
			fGfxEdit.Font.Handle := Font.Handle;
		end;

		StatusText := InfoLabel.Caption;
		InfoLabel.Hint := InfoLabel.Caption;
		Application.OnHint := ShowHint;

		(* search for subfolders *)
		DataDir := ExtractFilePath(Application.ExeName) + 'data\';
		if FindFirst(DataDir + '*', faDirectory, R) = 0 then
		begin
			repeat
				if (R.Attr and faDirectory) <> 0 then
				begin
					if Copy(R.Name, 1, 1) = '.' then Continue;
					M := TMenuItem.Create(Self);
					M.Caption := R.Name;
					M.RadioItem := True;
					M.AutoCheck := True;
					M.OnClick := miROMDefaultClick;
					miROMType.Insert(1, M);
				end;
			until FindNext(R) <> 0;
			FindClose(R);
		end;

		(* search for subfolders *)
		if FindFirst(DataDir+'*.pal', faAnyFile, R) = 0 then
		begin
			repeat
				if R.Attr <> faDirectory then
				begin
					if Copy(R.Name, 1, 1) = '.' then Continue;
					M := TMenuItem.Create(Self);
					M.Caption := R.Name;
					M.RadioItem := True;
					M.AutoCheck := True;
					M.OnClick := miPaletteFileClick;
					miPaletteFile.Add(M);
				end;
			until FindNext(R) <> 0;
			FindClose(R);
		end;

		FloorGfx.Top := -999;

		S := 'SMB3-USA.nes';
		zzzx := Width - (pb.Width - sbw);
		zzzy := Height - (pb.Height - sbh);
		World := 1;
		Level := 1;
		Starting := False;
		if FileExists(S) then
		begin
			ROMloaded := True;
			SMAS := UpperCase(ExtractFileExt(S)) = '.SMC';
			ROMdata := FileToString(S, -1);
			ROMfilename := S;
			InitVariables;
			LoadLevelEasy(1, 1);
		end else
		begin
			ROMloaded := False;
			ROMfilename := '';
			OpenROMExecute(Self);
			if ROMfilename = '' then Close
				else SelectLevelExecute(Self);
		end;
	end;
end;


procedure TMainForm.miDebuglogClick(Sender: TObject);
begin
	LogMemo.Visible := miDebuglog.Checked;
end;


procedure TMainForm.PbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if mode = MODE_EDIT_OBJDEF then
	begin
	  case Key of
		VK_UP:
			sObjectType.Value := sObjectType.Value + 1;
		VK_DOWN:
			sObjectType.Value := sObjectType.Value - 1;
		VK_RIGHT:
			Inc(SelObjTile);
		VK_LEFT:
			Dec(SelObjTile);
	  end;
	  DrawLevel;
	  Exit;
	end
	else
	if mode = MODE_EDIT_MAP then
	case Key of
		VK_RETURN:
		begin
			bEditPointerClick(Self);
		end;
		VK_ADD:
		begin
			Inc(maparray[SelObject.y][SelObject.x]);
			if maparray[SelObject.y][SelObject.x] > 236 then
				maparray[SelObject.y][SelObject.x] := 0;
			DrawLevel;
		end;
		VK_SUBTRACT:
		begin
			if maparray[SelObject.y][SelObject.x] < 1 then
				maparray[SelObject.y][SelObject.x] := 236 else
			Dec(maparray[SelObject.y][SelObject.x]);
			DrawLevel;
		end;
	end
	else
	if mode = MODE_EDIT_LEVEL then
	case Key of
		VK_ESCAPE:
			if WaitingToAddObj > 0 then
			begin
				WaitingToAddObj := 0;
				Pb.Cursor := crDefault;
				Info('Canceled.');
			end;

		VK_LEFT:
			if x_screen_loc > 0 then Dec(x_screen_loc);
		VK_RIGHT:
			if x_screen_loc < (sbX.Range - sbX.Window) then Inc(x_screen_loc);
		VK_UP:
			if y_screen_loc > 0 then Dec(y_screen_loc);
		VK_DOWN:
			if y_screen_loc < (sbY.Range - sbY.Window) then Inc(y_screen_loc);
		Ord('G'):
			LoadGfx;
		Ord('R'):
			InitVariables;

		VK_ADD:
		  if Shift = [] then
			sObjectType.Value := sObjectType.Value + 1
		  else
			sObjectLength.Value := sObjectLength.Value + 1;
		VK_SUBTRACT:
		  if Shift = [] then
			sObjectType.Value := sObjectType.Value - 1
		  else
			sObjectLength.Value := sObjectLength.Value - 1;
		VK_DIVIDE:
			begin
				if sObjectType.Value = $0 then sObjectType.Value := $F0
				else sObjectType.Value := sObjectType.Value - $10;
			end;
		VK_MULTIPLY:
			begin
				sObjectType.Value := sObjectType.Value + $10;
				if sObjectType.Value = $FF then sObjectType.Value := 0;
			end;
		VK_RETURN:
			if bEditPointer.Visible then bEditPointerClick(Self);

		VK_DELETE:
			ObjDeleteExecute(Self);
		VK_INSERT:
			if Shift = [] then
				ObjAddEnemyExecute(btnAdd3Byte)
			else
			if Shift = [ssAlt] then
				ObjAddEnemyExecute(btnAdd4Byte)
			else
				ObjAddEnemyExecute(btnAddEnemy);
	end;

	DrawLevel;
end;


procedure TMainForm.miView3boClick(Sender: TObject);
begin
	DrawLevel;
end;


procedure TMainForm.PbResize(Sender: TObject);
begin
	if Starting then Exit;
	if x_screen_loc + ((Pb.Width - sbw)  div Zoomsize) > levellimit_x then
		x_screen_loc := Max(levellimit_x - ((Pb.Width-sbw)  div Zoomsize), 0);
	if y_screen_loc + ((Pb.Height - sbh) div Zoomsize) > (levellimit_y+1) then
		y_screen_loc := Max(levellimit_y+1 - ((Pb.Height-sbh) div Zoomsize), 0);
	DrawLevel;
end;


procedure TMainForm.miAboutClick(Sender: TObject);
begin
	fAbout.Label1.Caption := 'SMB3 Workshop - built ' +
		DateTimeToStr(CompileTime) +  #10#13 +
		'© 2004-2007 Joel Toivonen (hukka)';
	fAbout.ShowModal;
end;


procedure TMainForm.PbMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
 if mode = MODE_EDIT_OBJDEF then
 begin
	if WheelDelta < 0 then WheelDelta := -1;
	if WheelDelta > 0 then WheelDelta :=  1;
	sObjectType.Value := sObjectType.Value + WheelDelta;
	Handled := True;
	Exit;
 end;

 if mode = MODE_EDIT_LEVEL then
 case mbdown of

 MB_NONE:
  begin
	if Shift = [ssShift] then
	begin
		if WheelDelta < 0 then
			if x_screen_loc < (sbX.Range - sbX.Window) then Inc(x_screen_loc);
		if WheelDelta > 0 then
			if x_screen_loc > 0 then Dec(x_screen_loc);
		DrawLevel;
	end
	else
	if Shift = [] then
	begin
		if WheelDelta < 0 then
			if y_screen_loc < (sbY.Range - sbY.Window) then Inc(y_screen_loc);
		if WheelDelta > 0 then
			if y_screen_loc > 0 then Dec(y_screen_loc);
		DrawLevel;
	end
	{else
	if Shift = [ssAlt] then
	begin
		if WheelDelta > 0 then
			Inc(Zoomsize)
		else
			Dec(Zoomsize);
		DrawLevel;
	end}
	else
	if Shift = [ssCtrl] then
	begin
		if WheelDelta > 0 then
			sObjectType.Value := sObjectType.Value + 1
		else
			sObjectType.Value := sObjectType.Value - 1;
	end;

  end;

 MB_LEFT:
  begin
	if SelObject.Obj = nil then Exit;
  end;

 MB_RIGHT:
  begin
  end;

  end; // case

 Handled := True;
end;


procedure TMainForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
	if Zoomsize < 1 then Exit;
	NewWidth  := NewWidth  - ((NewWidth  - zzzx) mod Zoomsize);
	NewHeight := NewHeight - ((NewHeight - zzzy) mod Zoomsize);
end;


procedure TMainForm.sbXChange(Sender: TObject);
begin
	x_screen_loc := Trunc(sbX.Position);
	DrawLevel;
end;


procedure TMainForm.sbYChange(Sender: TObject);
begin
	y_screen_loc := Trunc(sbY.Position);
	DrawLevel;
end;


procedure TMainForm.miViewTransClick(Sender: TObject);
begin
	LoadGfx;
	DrawLevel;
end;


procedure TMainForm.miViewBackgroundClick(Sender: TObject);
var
	i, b: Integer;
begin
{
	if miViewBackground.Checked then
	begin
}
		i := paletteaddr + 1 + (((header[8] and 31)-1) * $C0);
		b := Ord(ROMdata[i + ((header[6] and 7) * 16)]);
		// InfoLabel.caption := inttostr(i) + ', ' + inttostr(b) + ', ' + inttostr(header[6] and 15);
    	color_Sky := NESpal[b];
{
	end
	else color_Sky := Color32(200, 190, 250);
}
	DrawLevel;
end;


procedure TMainForm.PbMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
	xx, yy, n, i: Integer;
begin
	if AskTile.Want then
	begin
		AskTile.X := X div Zoomsize;
		AskTile.Y := Y div Zoomsize;
		X := X - (AskTile.X * Zoomsize);
		Y := Y - (AskTile.Y * Zoomsize);
		xx := 0;
		if X >= (zoomsize div 2) then xx := 2;
		if Y >= (zoomsize div 2) then Inc(xx);
		AskTile.Corner := xx;
		DrawLevel;
		fGfxEdit.GotTile(AskTile.Tile);
		pb.Cursor := crDefault;
		Exit;
	end;

	if WaitingToAddObj > 0 then
	begin
		SelEnemy.Index := -1;
		SelObject.Obj := nil;
		SelObject.Index := -1;
		objectsizeinit_prev := -1;
		xx := X div Zoomsize + x_screen_loc;
		yy := Y div Zoomsize + y_screen_loc;
		if mode = MODE_EDIT_LEVEL then
		 case WaitingToAddObj of
			2: AddEnemy(xx, yy);
			3: AddObject_3Byte(xx, yy);
			4: AddObject_4Byte(xx, yy);
		 end;
		WaitingToAddObj := 0;
		UpdateLevelInfo;
		Init_ObjectSizes := True;
		Pb.Cursor := crDefault;
		DrawLevel;
		if WaitingToAddObj = 2 then Button := mbRight
			else Button := mbLeft;
	end
	else
	if drawingstate <> DS_NONE then Exit;

	if Button = mbMiddle then
	begin
		SelectLevelExecute(Self);
		Exit;
	end;


 case mode of
  MODE_EDIT_MAP:
  begin
	xx := X div Zoomsize + x_screen_loc;
	yy := Y div Zoomsize + y_screen_loc;
	case Button of
	 mbLeft:
	 begin
		SelObject.Drag.Dragging := False;
		if DblClicked then
		begin
			DblClicked := False;
			Exit;
		end;
		for i := 0 to num_ptrs-1 do
		  if (map_ptr_hriz[i] = xx) and (((map_ptr_vert[i] div 16) - 2) = yy) then
		  begin
			sObjectType.Value := i;
			SelObject.Index := i;
			SelObject.Drag.Dragging := True;
			SelObject.Drag.X := xx;
			SelObject.Drag.Y := yy;
			Break;
		  end;
	 end;
	 mbRight:
	 begin
		if xx <  levellimit_x then SelObject.x := xx;
		if yy <= levellimit_y then SelObject.y := yy;
	 end;
    end;
	DrawLevel;
  end;
  MODE_EDIT_LEVEL:
  begin
	if Button = mbLeft then
	begin
		SelObject.Obj := nil;
		SelObject.Index := -1;
		objectsizeinit_prev := -1;
		xx := X div Zoomsize + x_screen_loc;
		yy := Y div Zoomsize + y_screen_loc;
		SelObject.R.Left   := 9999;
		SelObject.R.Right  := 0;
		SelObject.R.Top    := 9999;
		SelObject.R.Bottom := 0;
		if not (ssShift in Shift) then
			SelObject := GetObjectAt(xx, yy);
		enemymode := False;
		DrawLevel;
		mbdown := MB_LEFT;
		SelObject.Drag.Dragging := True;
		SelObject.Drag.X := xx;
		SelObject.Drag.Y := yy;
		SelObject.Drag.osX := xx - SelObject.x;
		SelObject.Drag.osY := yy - SelObject.y;
		SelObject.Drag.xsl := x_screen_loc;
		SelObject.Drag.ysl := y_screen_loc;

		// handle objects that extend to sky (blue poles)
		if SelObject.Obj <> nil then
		 if SelObject.Obj.orientation = EXT_SKY then
		 begin
			SelObject.Drag.osX := xx - SelObject.x;
			SelObject.Drag.osY := yy - SelObject.y;
			//SelObject.Drag.Y := 0;
		 end;

		sObjectType.Enabled := SelObject.Obj <> nil;
		sObjectSet.Enabled  := SelObject.Obj <> nil;
		sObjectLength.Enabled  := SelObject.Obj <> nil;

		Label1.Font.Color := clWindowText;
		Label2.Font.Color := clWindowText;
		Label3.Font.Color := clWindowText;

		if SelObject.Obj <> nil then
		begin
			sObjectType.OnChange := nil;
			sObjectSet.OnChange  := nil;
			sObjectLength.OnChange := nil;
			if objbytes[SelObject.Index] = 3 then
			begin
				sObjectSet.Value  := tbyte_array[0,SelObject.SubIndex] div 32;
				bEditPointer.Visible := sObjectSet.Value = 7;
				sObjectLength.Enabled := False;
				sObjectLength.Value := 0;
				sObjectType.Value := tbyte_array[2, SelObject.SubIndex];
				Label1.Font.Color := clBlue;
			end
			else
			begin
				sObjectSet.Value  := fbyte_array[0,SelObject.SubIndex] div 32;
				sObjectType.Value := fbyte_array[2, SelObject.SubIndex];
				sObjectLength.Value := fbyte_array[3, SelObject.SubIndex];
				sObjectLength.Enabled := True;
				Label2.Font.Color := clBlue;
			end;
			//plains_level[level_object_set, SelObject.objtype{Trunc(sObjectType.Value)}].obj_domain;

			UpdateEditValue(sObjectType);
			UpdateEditValue(sObjectLength);
			sObjectType.OnChange := sObjectTypeChange;
			sObjectSet.OnChange  := sObjectTypeChange;
			sObjectLength.OnChange  := sObjectTypeChange;
		end
		else
		begin
			bEditPointer.Visible := False;
			Info('Editing $rom', True);
			//lByteData.Caption := IntToHex(level_offset, 6) + '  ';
			TellObjectInfo;
		end;

	end		// button = mbLeft
	else

	if Button = mbRight then
	begin
		bEditPointer.Visible := False;
		objectsizeinit_prev := -1;
		xx := X div Zoomsize + x_screen_loc;
		yy := Y div Zoomsize + y_screen_loc;
		SelEnemy.R.Left   := 9999;
		SelEnemy.R.Right  := 0;
		SelEnemy.R.Top    := 9999;
		SelEnemy.R.Bottom := 0;
		SelEnemy := GetEnemyAt(xx, yy);
		enemymode := True;
		DrawLevel;
		if SelEnemy.Index < 0 then
		begin
			Label1.Font.Color := clWindowText;
			Label2.Font.Color := clWindowText;
			Label3.Font.Color := clWindowText;
			Info('Editing $rom', True);
			lByteData.Caption := IntToHex(level_offset, 6) + '  ';
			Exit;
		end;
		mbdown := MB_RIGHT;
		SelEnemy.Drag.Dragging := True;
		SelEnemy.Drag.X := xx;
		SelEnemy.Drag.Y := yy;
		SelEnemy.Drag.osX := xx - SelEnemy.x;
		SelEnemy.Drag.osY := yy - SelEnemy.y;
		SelEnemy.Drag.xsl := x_screen_loc;
		SelEnemy.Drag.ysl := y_screen_loc;

		sObjectType.Enabled := True;
		sObjectSet.Enabled  := False;
		sObjectLength.Enabled  := False;

		Label1.Font.Color := clWindowText;
		Label2.Font.Color := clWindowText;
		Label3.Font.Color := clWindowText;

		sObjectType.OnChange := nil;
		sObjectType.MaxValue := 255; //236;
		sObjectType.Value := enemy_array[0, SelEnemy.Index];
		UpdateEditValue(sObjectType);
		sObjectType.OnChange := sObjectTypeChange;
	end;

  end;
  MODE_EDIT_OBJDEF:
  begin
	xx := (X div 16);
	yy := (Y div 16) - 1;
	if xx >= 19 then	// ROM object area
	begin
		xx := xx - 19;
		if xx >= plains_level[level_object_set,Trunc(sObjectType.Value)].bmp_width then Exit;
		if yy >= 0 then
			if yy < plains_level[level_object_set,Trunc(sObjectType.Value)].bmp_height
			then
			begin
				i := yy * plains_level[level_object_set,Trunc(sObjectType.Value)].bmp_width + xx;
				if i >= Length(plains_level[level_object_set,Trunc(sObjectType.Value)].obj_design)
					then Exit;
				if Button = mbLeft then
				begin
					if SelObjTile < 256 then
						plains_level[level_object_set,
						Trunc(sObjectType.Value)].rom_obj_design[i] := SelObjTile
					else
					begin
						if (SelObjTile-256) < 48 then
						plains_level[level_object_set,
						Trunc(sObjectType.Value)].obj_design_2[i] := SelObjTile - 256
						else
						begin
							n := SelObjTile - 256 - 48 + 38;
							if n > 120 then Inc(n, 121-98+13) else
							if n > 97  then Inc(n, 121-98);
							plains_level[level_object_set,
							 Trunc(sObjectType.Value)].obj_design_2[i] := n + 64;
						end;
					end;
				end else
				begin
					if Button = mbRight then
						SelObjTile := plains_level[level_object_set,
						Trunc(sObjectType.Value)].rom_obj_design[i]
					else
						SelObjTile := plains_level[level_object_set,
						Trunc(sObjectType.Value)].obj_design_2[i] + 256;
				end;
				DrawLevel;
			end;

	end else
	if ((xx-1) < 16) and (yy < (16+SPECIALTILEROWS)) then
	begin
		Dec(xx);
		if xx < 0 then Exit;
		if yy < 0 then Exit;
		SelObjTile := (yy * 16) + xx;
		DrawLevel;
	end;

  end;
 end;
end;


procedure TMainForm.PbMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	SelObject.Drag.Dragging := False;
	SelEnemy.Drag.Dragging := False;
	mbdown := MB_NONE;
end;


procedure TMainForm.PbMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
	X := X div Zoomsize + x_screen_loc;
	Y := Y div Zoomsize + y_screen_loc;
	case mode of
	MODE_EDIT_LEVEL:
	begin
		//if not vertical_flag then
		//Label7.Caption := IntToStr(leveltile[X,Y]);
		if SelObject.Drag.Dragging then Move_Object(X, Y)
		else
		if SelEnemy.Drag.Dragging  then Move_Enemy(X, Y);
	end;
	MODE_EDIT_MAP:
	begin
		if not SelObject.Drag.Dragging then Exit;
		if (X = SelObject.Drag.X) and
			(Y = SelObject.Drag.Y) then Exit;
		if X >= 0 then if X < levellimit_x then
		 map_ptr_hriz[SelObject.Index] := X;
		if Y >= 0 then if Y <= levellimit_Y then
		 map_ptr_vert[SelObject.Index] :=
			(map_ptr_vert[SelObject.Index] mod 16) + ((y + 2) * 16);
		levelmodified := True;
		SelObject.Drag.X := X;
		SelObject.Drag.Y := Y;
		DrawLevel;
	end;
	end;
end;
                   

procedure TMainForm.sObjectTypeChange(Sender: TObject);
begin
	if mode <> MODE_EDIT_LEVEL then
	begin
		ListBox.Tag := -1;
		DrawLevel;
		UpdateEditValue(Sender as TBMSpinEdit);
		Exit;
	end;
	if enemymode then
		Change_Enemy_Type(Trunc(sObjectType.Value))
	else
		Change_Object_Type(Trunc(sObjectSet.Value), Trunc(sObjectType.Value),
			Trunc(sObjectLength.Value), Sender);
	UpdateEditValue(Sender as TBMSpinEdit);
	levelmodified := True;
end;


procedure TMainForm.miROMgfxClick(Sender: TObject);
begin
	if not ROMloaded then Exit;
	if Sender <> ListBox then
		if mode = MODE_EDIT_OBJDEF then
		begin
			miROMGfx.Checked := ROM_gfx;
			Exit;
		end;
	if SMAS then Exit;
	ROM_gfx := miROMGfx.Checked;
	if ROM_gfx then
	begin
		LoadRomObjDefs(False);
		LoadGfx;
		//color_Sky := color_BgTile;
	end
	else
	begin
		InitVariables;
		LoadRomObjDefs(True);
		//color_Sky := color_Sky_orig;
	end;
	DrawLevel;
end;


procedure TMainForm.ModeChanged(FullRepaint: Boolean = True);
begin
	sbX.Enabled := mode <> MODE_EDIT_OBJDEF;
	sbY.Enabled := mode <> MODE_EDIT_OBJDEF;
	with bEditPointer do
	begin
		Visible := mode in [MODE_EDIT_OBJDEF, MODE_EDIT_MAP];
		case mode of
			MODE_EDIT_LEVEL:
				Caption := 'Edit Pointer';
			MODE_EDIT_MAP:
				Caption := 'Edit Level';
			MODE_EDIT_OBJDEF:
				Caption := 'Save Objdefs';
		end;
	end;
	ObjDefPanel.Visible   := mode = MODE_EDIT_OBJDEF;
	sObjectLength.Visible := mode = MODE_EDIT_LEVEL;
	Label6.Visible      := mode = MODE_EDIT_LEVEL;
	SaveM3L.Enabled := mode = MODE_EDIT_LEVEL;
	miFreeform.Enabled  := mode = MODE_EDIT_LEVEL;
	ObjAdd3Byte.Enabled := mode = MODE_EDIT_LEVEL;
	ObjAdd4Byte.Enabled := mode = MODE_EDIT_LEVEL;
	ObjAddEnemy.Enabled := mode = MODE_EDIT_LEVEL;
	ObjDelete.Enabled   := mode = MODE_EDIT_LEVEL;
	ViewZoom50.Enabled  := mode <> MODE_EDIT_OBJDEF;
	ViewZoom100.Enabled := mode <> MODE_EDIT_OBJDEF;
	ViewZoom200.Enabled := mode <> MODE_EDIT_OBJDEF;
	Clear1.Enabled := mode = MODE_EDIT_LEVEL;
	miLevelHeader.Enabled := (mode = MODE_EDIT_LEVEL) and (not SMAS);
	if mode <> MODE_EDIT_OBJDEF then sObjectType.PopupMenu := nil;
	SaveROM.Enabled := ROMloaded;
	SaveROMAs.Enabled := ROMloaded;
	miROMtype.Enabled := ROMloaded;
	miPaletteFile.Enabled := (ROMloaded) and (not SMAS);
	if FullRepaint then LoadGfx;
	case mode of
		MODE_EDIT_MAP: sObjectType.MaxValue := num_ptrs-1;
		MODE_EDIT_OBJDEF: sObjectType.MaxValue := 247;
		MODE_EDIT_LEVEL: sObjectType.MaxValue := 255;
	end;
	if mode = MODE_EDIT_LEVEL then
		SelectObjectAt(0, 0, mbLeft);
	if FullRepaint then DrawLevel;
end;


procedure TMainForm.CustomMenuitemClick(Sender: TObject);
var
	T: Integer;
begin
	if not (Sender is TMenuItem) then Exit;
	T := (Sender as TComponent).Tag;
	case mode of
	 MODE_EDIT_OBJDEF:
	 begin
		sObjectType.Value := T;
	 end;
	end;
end;


procedure TMainForm.LoadObjDefs1Click(Sender: TObject);
begin
	LoadRomObjDefs(True);
	DrawLevel;
end;


procedure TMainForm.SaveObjDefs1Click(Sender: TObject);
begin
	SaveRomObjDefs;
end;


procedure TMainForm.LoadObjdefs2Click(Sender: TObject);
begin
	LoadRomObjDefs(False);
	DrawLevel;
end;


procedure TMainForm.miROMDefaultClick(Sender: TObject);
var
	S: String;
begin
	if not ROMloaded then Exit;
	S := (Sender as TMenuItem).Caption;
	S := ReplaceStr(S, '&', '');
	if S = 'Default' then S := ''
		else S := S + '\';
	ROMdir := S;
	InitVariables;
	if mode = MODE_EDIT_MAP then
	begin
		SelObject.x := 0;
		SelObject.y := 0;
		LoadMap;
	end
	else
		LoadLevelEasy(1, 1);
end;


procedure TMainForm.miViewFloorClick(Sender: TObject);
begin
	DrawLevel;
end;


procedure TMainForm.miFloorinfrontClick(Sender: TObject);
begin
	DrawLevel;
end;


procedure TMainForm.miViewGridClick(Sender: TObject);
begin
	DrawLevel;
end;


procedure TMainForm.InfoLabelClick(Sender: TObject);
begin
{
	S := 'Bg tile is solid color: ';
	if BgTileIsSolidColor then S := S + 'TRUE' else S := S + 'FALSE';
	infolabel.caption := S + '   color_Sky = ' + IntToStr(color_Sky);
	InfoLabel.Caption := Format('Level bytes: %d   Sections: %d (Original) + %d (Freeform)',
		[level_bytes, number_of_level_sections, ff_number_of_level_sections]);
}
end;


procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
	if not levelmodified then CanClose := True else
	CanClose :=
	 MessageDlg('Exit without saving?',
	 mtWarning, [mbYes, mbNo], 0) = mrYes;
end;




procedure TMainForm.InfoLabelDblClick(Sender: TObject);
var
	i: Integer;
begin
	if not miDebug.Checked then Exit;
	Log('--- ' + IntToStr(ff_number_of_level_sections-1));
	for i := 0 to ff_number_of_level_sections - 1 do
	begin
		if the_first_object = 3 then
		begin
			if (i mod 2) = 0 then
				Log(IntToStr(i) + ': 3-BYTE: ' + IntToStr(object_ordering[i]))
			else // if (i mod 2) = 1 then
				Log(IntToStr(i) + ': 4-BYTE: ' + IntToStr(object_ordering[i]));
		end
		else
		if the_first_object = 4 then
		begin
			if (i mod 2) = 1 then
				Log(IntToStr(i) + ': 3-BYTE: ' + IntToStr(object_ordering[i]))
			else // if (i mod 2) = 0 then
				Log(IntToStr(i) + ': 4-BYTE: ' + IntToStr(object_ordering[i]));
		end;
	end;
end;


procedure TMainForm.miDelAll3Click(Sender: TObject);
var
	o: Integer;
begin
	for o := tbyte_objs - 1 downto 0 do
		Delete_Object(3, o);
	SelectObjectAt(0, 0, mbLeft);
	DrawLevel;
end;


procedure TMainForm.miDelAll4Click(Sender: TObject);
var
	o: Integer;
begin
	for o := fbyte_objs - 1 downto 0 do
		Delete_Object(4, o);
	SelectObjectAt(0, 0, mbLeft);
	DrawLevel;
end;


procedure TMainForm.miDelAllEClick(Sender: TObject);
var
	e: Integer;
begin
	for e := enemy_objs - 1 downto 0 do
		Delete_Enemy(e);
	SelectObjectAt(0, 0, mbRight);
	DrawLevel;
end;


procedure TMainForm.bEditPointerClick(Sender: TObject);
begin
  case mode of
	MODE_EDIT_LEVEL:
		EnterPointerDialog;
	MODE_EDIT_MAP:
	begin
		if level = 10 then Exit;
		if (mapptr_enemy > 0) and (mapptr_level > 0) then
		begin
			fSelectLevel.ListBox1.ItemIndex := level - 1;
			fSelectLevel.cbObjectSet.ItemIndex := mapptr_objectset-1;
			LoadLevel(mapptr_level+9, mapptr_enemy+1);
		end;
	end;
	MODE_EDIT_OBJDEF:
	begin
		SaveRomObjDefs;
	end;
  end;
end;


procedure TMainForm.PbDblClick(Sender: TObject);
var
	o: Integer;
begin
	mbdown := MB_NONE;
	SelObject.Drag.Dragging := False;
	DblClicked := True;
	if mode <> MODE_EDIT_MAP then Exit;
	o := Trunc(sObjectType.Value);
	with fSelectLevel do
	begin
		if (mapptr_enemy = 0) or (mapptr_level = 0) then Exit;
		ListBox1.ItemIndex := level - 1;
		ListBox1Click(Self);
		ListBox2.ItemIndex := -1;
		cbObjectSet.ItemIndex := mapptr_objectset-1;
		seEnemy.Value := mapptr_enemy;
		seOffset.Value := mapptr_level;
		if ShowModal = mrOK then
		begin
			levelmodified := True;
			mapptr_enemy := seEnemy.AsInteger + 1;
			mapptr_level := seOffset.AsInteger;
			mapptr_objectset := cbObjectSet.ItemIndex;
			map_ptr_vert[o] := ((map_ptr_vert[o] div 16) * 16) + mapptr_objectset+1;
			if mapptr_enemy > $FFFF then
				Dec(mapptr_enemy, ((mapptr_enemy div $10000) * $10000));
			Dec(mapptr_enemy, $11);
			map_ptr_enemies[0][o] := (mapptr_enemy mod $100);
			map_ptr_enemies[1][o] := (mapptr_enemy div $100);
			Dec(mapptr_level, object_set_pointers[mapptr_objectset+2].ptr_type);
			Dec(mapptr_level, $10010);
			if mapptr_level > $FFFF then
				Dec(mapptr_level, ((mapptr_level div $10000) * $10000));
			map_ptr_levels[0][o] := (mapptr_level mod $100);
			map_ptr_levels[1][o] := (mapptr_level div $100);
			DrawLevel;
		end;
	end;
end;



procedure TMainForm.miPaletteFileClick(Sender: TObject);
begin
	if not (Sender is TMenuItem) then Exit;
	palettefile := ReplaceStr((Sender as TMenuItem).Caption, '&', '');
	LoadGfx;
	GetPalette;
	DrawLevel;
end;


procedure TMainForm.SpinEditChange(Sender: TObject);
begin
	if ListBox.ItemIndex >= 0 then
	begin
		ListBox.Tag := ListBox.ItemIndex;
		plains_level[level_object_set, Trunc(sObjectType.Value)].
			rom_obj_design[ListBox.ItemIndex] := SpinEdit.AsInteger;
		DrawLevel;
	end;
end;


procedure TMainForm.PasteButtonClick(Sender: TObject);
var
	S: String;
	I: Integer;
begin
	S := Clipboard.AsText;
	if S = '' then Exit;
	S := Trim(ReplaceStr(S, '0x', '$'));
	if Pos('$', S) > 1 then S := Copy(S, Pos('$', S), Length(S));
	S := ExtractWord(1, S, [' ']);
	if not TryStrToInt(S, I) then Exit;
	if ListBox.ItemIndex < 0 then ListBox.ItemIndex := 0;
	SpinEdit.Value := I;
	if ListBox.ItemIndex < ListBox.Items.Count then
		ListBox.ItemIndex := ListBox.ItemIndex + 1;
	ListBoxClick(Self);
end;


procedure TMainForm.ListBoxClick(Sender: TObject);
begin
	ListBox.Tag := ListBox.ItemIndex;
	SpinEdit.Value := plains_level[level_object_set, Trunc(sObjectType.Value)].
		rom_obj_design[ListBox.ItemIndex];
end;


procedure TMainForm.FillButtonClick(Sender: TObject);
var
	Y, I: Integer;
begin
	if ListBox.ItemIndex < 0 then Exit;
	if ListBox.ItemIndex >= (ListBox.Items.Count-1) then Exit;
	I := plains_level[level_object_set, Trunc(sObjectType.Value)].
		rom_obj_design[ListBox.ItemIndex];
	for Y := ListBox.ItemIndex + 1 to ListBox.Items.Count - 1 do
		plains_level[level_object_set, Trunc(sObjectType.Value)].
			rom_obj_design[Y] := I + Y;
	DrawLevel;
end;


procedure TMainForm.SetButtonClick(Sender: TObject);
var
	I: Integer;
begin
	if SelObjTile > 255 then Exit;
	if ListBox.ItemIndex < 0 then Exit;
	if ListBox.ItemIndex >= ListBox.Items.Count then Exit;
	I := plains_level[level_object_set, Trunc(sObjectType.Value)].
		rom_obj_design[ListBox.ItemIndex];
	if I < 255 then
		plains_level[level_object_set, Trunc(sObjectType.Value)].
			rom_obj_design[ListBox.ItemIndex] := SelObjTile
	else
		ROMdata[plains_level[level_object_set, Trunc(sObjectType.Value)].
			rom_obj_design[ListBox.ItemIndex]+1] := Chr(SelObjTile);
	DrawLevel;
end;


procedure TMainForm.roubleshooting1Click(Sender: TObject);
var
	S: String;
begin
	S := ExtractFilePath(Application.ExeName) + 'docs\' +
		(Sender as TMenuItem).Hint;
	if FileExists(S) then
		ShellExecute(HWND_DESKTOP, 'open', PChar(S), nil, nil,  SW_SHOWNORMAL);
end;


procedure TMainForm.Enemycompatibility2Click(Sender: TObject);
begin
	ShellExecute(HWND_DESKTOP, 'open', PChar((Sender as TMenuItem).Hint),
		nil, nil,  SW_SHOWNORMAL);
end;



procedure TMainForm.SelectPointer(i: Integer);
var
	x, y: Integer;
begin
	with fPointer do
	begin
		Tag := i;
		ScrollBar1.Position := tbyte_array[0][i] mod 16;
		ScrollBar2.Position := tbyte_array[1][i] div 16;
		cbExitAction.ItemIndex := tbyte_array[1][i] mod 16;
		RxSpinEdit1.Value := ((tbyte_array[2][i] mod 16) * 16) + (tbyte_array[2][i] div 16);
		if vertical_flag then
		begin
			x := tbyte_array[1][i] {and $F} mod 16;
			y := (((tbyte_array[1][i] {and 240}) {shr 4} div 16) * 15) + (tbyte_array[0][i]{ - $E0} mod 32);
		end
		else
		begin
			x := tbyte_array[1][i];
			y := tbyte_array[0][i] {- $E0} mod 32;
			if x < x_screen_loc then begin x_screen_loc := x; x := 0; end;
			if x >= (x_screen_loc + sbX.Window) then x_screen_loc := x - sbX.Window + 1;
		end;
		if y < y_screen_loc then begin y_screen_loc := y; y := 0; end;
		if y >= (y_screen_loc + sbY.Window) then y_screen_loc := y - sbY.Window + 1;
		if x>= x_screen_loc then Dec(x, x_screen_loc);
		if y>= y_screen_loc then Dec(y, y_screen_loc);
		SelectObjectAt(x, y, mbLeft);
	end;
end;


procedure TMainForm.SavePointer(i: Integer);
begin
	if i >= 0 then
	with fPointer do
	begin
		tbyte_array[1][i] := (ScrollBar2.Position * 16) + cbExitAction.ItemIndex;
		levelmodified := True;
		if vertical_flag then
			Move_Object(ScrollBar1.Position+cbExitAction.ItemIndex, (ScrollBar2.Position*15), False)
		else
			Move_Object((ScrollBar2.Position*16)+cbExitAction.ItemIndex, ScrollBar1.Position, False);
		Change_Object_Type(7, ((RxSpinEdit1.AsInteger mod 16) * 16) +
			(RxSpinEdit1.AsInteger div 16), 1, {Sender}Self);
		if not vertical_flag then
			SelectObjectAt(tbyte_array[1][i] - x_screen_loc,
			tbyte_array[0][i] - $E0 - y_screen_loc, mbLeft);
	end;
end;


procedure TMainForm.EnterPointerDialog;
var
	i: Integer;
begin
	with fPointer do
	begin
		Tag := -1;
		if sObjectSet.Value = 7 then
			if SelObject.SubIndex >= 0 then
				Tag := SelObject.SubIndex;
		Listbox1.Items.Clear;
		for i := 0 to tbyte_objs - 1 do
		begin
			if (tbyte_array[0,i] div 32) = 7 then
			begin
				Listbox1.Items.Add('Item #' + inttostr(i));
				if i = Tag then Listbox1.ItemIndex := Listbox1.Items.Count - 1;
			end;
		end;
		if Listbox1.ItemIndex < 0 then
			if Listbox1.Items.Count >= 0 then
				Listbox1.ItemIndex := 0;
		ListBox1Click(Self);
		ShowModal;
		if ModalResult = mrOK then SavePointer(Tag);
		x_screen_loc := 0;
		y_screen_loc := 0;
		AdjustScrollbars;
		SelectObjectAt(0, 0, mbLeft, True);
	end;
end;


procedure TMainForm.ROMGraphicsChanged(Tile: Integer = -1);
var
	J, X, Y: Integer;
begin
	J := 0;
	if Tile < 0 then
	begin
		for y := 0 to 3 do
		for x := 0 to 63 do
		begin
			TSA.BlitBlock(Pointer(TileGfx.Bitmap), J, x*16, y*16);
			Inc(J);
		end;
	end;
	TileGfx.Flush;
	DrawLevel;
	LevelModified := True;
	GraphicsModified := True;
end;


procedure TMainForm.EditPaletteExecute(Sender: TObject);
begin
	if not ROMloaded then Exit;
	if SMAS then Exit;
	with fPalette do
	begin
		if World = 0 then
		begin
			cbColorSet.ItemIndex  := level-2;
			cbObjectSet.ItemIndex := 0;
		end else
		begin
			cbColorSet.ItemIndex  := header[6] and 7;
			cbObjectSet.ItemIndex := fSelectLevel.cbObjectSet.ItemIndex + 1; //header[8] and 15;
		end;
		Show;
		if Sender = miLevel then FormShow(Self);
	end;
end;


procedure TMainForm.EditObjDefsExecute(Sender: TObject);
var
	P: TPopupMenu;
	L, I, N: Integer;
begin
	if AskTile.Want then Exit;
	if not ROMloaded then Exit;
	if SMAS then Exit;
	miEdLevel.Checked := False;
	miEdObjdefs.Checked := True;
	ListBox.ControlStyle := ListBox.ControlStyle + [csOpaque];
	Zoomsize := 16;
	mode := MODE_EDIT_OBJDEF;
	sObjectType.Enabled := True;
	sObjectSet.Enabled := False;
	sObjectLength.Enabled := False;

	Label1.Caption := 'Object definition editor';
	Label2.Caption := '';
	Label1.Font.Color := clWindowText;
	Label2.Font.Color := clWindowText;
	Label3.Font.Color := clWindowText;

	ModeChanged(False);
	ModeChanged(False);
	{
	if MessageDlg('Would you also like to:'#10#13 +
	 '* Debug -> Load ROM Objdefs'#10#13 + '* View -> Disable transparency ?',
	 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
	}
	begin
		if miROMgfx.Checked then
		begin
			miROMgfx.Checked := False;
			miROMgfxClick(ListBox);
		end;
		LoadObjDefs1Click(Self);
		miViewTrans.Checked := False;
		miViewTransClick(Self);
	end;
	P := TPopupMenu.Create(Self);
	N := 0;
	for I := 0 to 15 do
	begin
		P.Items.Add(TMenuItem.Create(Self));
		P.Items[I].Caption := IntToHex(I*$10,2) + ' - ' + IntToHex(I*$10+$F,2);
		for L := 0 to 15 do
		begin
			P.Items[I].Add(TMenuItem.Create(Self));
			with P.Items[I].Items[L] do
			begin
				Caption := IntToHex(N, 2) + ' ' + plains_level[level_object_set][N].obj_descript;
				Tag := N;
				OnClick := CustomMenuitemClick;
				Inc(N);
				if N > 247 then
				begin
					sObjectType.PopupMenu := P;
					Exit;
				end;
			end;
		end;
	end;
end;


procedure TMainForm.EditLevelExecute(Sender: TObject);
begin
	if AskTile.Want then Exit;
	miEdObjdefs.Checked := False;
	miEdLevel.Checked := True;
	if World > 0 then
		mode := MODE_EDIT_LEVEL
	else mode := MODE_EDIT_MAP;
	ModeChanged;
	UpdateLevelInfo;
end;


procedure TMainForm.ObjCloneExecute(Sender: TObject);
var
	i: Integer;
begin
	if AskTile.Want then Exit;
	cloneobjarray[0] := 0;
	if enemymode then
	begin
		if SelEnemy.Index < 0 then Exit;
		cloneobjarray[0] := 1;
		for i := 1 to 3 do
			cloneobjarray[i] := enemy_array[i-1][SelEnemy.Index];
		ObjAddEnemyExecute(miAddenemy1);
	end
	else
	begin
		if SelObject.Index < 0 then Exit;
		i := objbytes[SelObject.Index];
		cloneobjarray[0] := i;
		case i of
		3:
		begin
			for i := 2 to 3 do
				cloneobjarray[i] := tbyte_array[i-1][SelObject.SubIndex];
			cloneobjarray[1] := tbyte_array[0,SelObject.SubIndex] div 32;
			ObjAddEnemyExecute(Add3byteobject1);
		end;
		4:
		begin
			for i := 2 to 4 do
				cloneobjarray[i] := fbyte_array[i-1][SelObject.SubIndex];
			cloneobjarray[1] := fbyte_array[0,SelObject.SubIndex] div 32;
			ObjAddEnemyExecute(Add4byteobject1);
		end;
		end;
	end;
end;


// actually adds EITHER 3-byte, 4-byte object or Enemy
procedure TMainForm.ObjAddEnemyExecute(Sender: TObject);
const
	InfoStr: array[1..4] of String =
	('',
	'Click on level to add an enemy...',
	'Click on level to add a 3-byte object...',
	'Click on level to add a 4-byte object...');
	ERROR_BOUNDARY = 'level data would overrun boundaries.';
var
	I: Integer;
begin
	if AskTile.Want then Exit;
	if not miFreeform.Checked then Exit;
	I := (Sender as TComponent).Tag;
	if not (I in [2, 3, 4]) then Exit;
	if miLimitsize.Checked then
	begin
	  if I in [3,4] then
		 if level_bytes + I > orig_level_bytes then
		 begin
			//ShowMessage('Cannot add object: level size would exceed limit.');
			Application.MessageBox('Cannot add object: ' + ERROR_BOUNDARY,
			  'Cannot add object', MB_OK + MB_ICONSTOP + MB_TOPMOST);
			Exit;
		 end;
	  if I = 2 then
		 if enemy_bytes + 3 > orig_enemy_bytes then
		 begin
			//ShowMessage('Cannot add enemy: level size would exceed limit.');
			Application.MessageBox('Cannot add enemy: ' + ERROR_BOUNDARY,
			  'Cannot add enemy', MB_OK + MB_ICONSTOP + MB_TOPMOST);
			Exit;
		 end;
	end;
	Pb.Cursor := crCross;
	Info(InfoStr[I] + ' (ESC to cancel)', True);
	ActiveControl := Pb;
	WaitingToAddObj := I;
end;


procedure TMainForm.ObjDeleteExecute(Sender: TObject);
begin
	if AskTile.Want then Exit;
	if enemymode then
	begin
		if SelEnemy.Index < 0 then Exit;
		Delete_Enemy(SelEnemy.Index);
		SelEnemy.Index := -1;
		Info('Enemy deleted.');
	end
	else begin
		if SelObject.Index < 0 then Exit;
		Delete_Object(objbytes[SelObject.Index], SelObject.SubIndex);
		SelObject.Index := -1;
		Info('Object deleted.');
	end;
	SelectObjectAt(0, 0, mbLeft);
	UpdateLevelInfo;
	DrawLevel;
end;


procedure TMainForm.ExitProgramExecute(Sender: TObject);
begin
	Close;
end;


procedure TMainForm.SelectLevelExecute(Sender: TObject);
begin
	if AskTile.Want then Exit;
	if not ROMloaded then
	begin
		OpenM3LExecute(Self);
		Exit;
	end;
	if not (mode in [MODE_EDIT_LEVEL, MODE_EDIT_MAP]) then Exit;
	if levelmodified then
	 if MessageDlg('Discard changes and select another level?',
	  mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;

	fSelectLevel.ListBox1.ItemIndex := World;
	fSelectLevel.ListBox1Click(Self);
	if fSelectLevel.ShowModal <> mrOK then Exit;
	if fSelectLevel.ListBox1.ItemIndex = 0 then
	begin
		SelObject.x := 0;
		SelObject.y := 0;
		mode := MODE_EDIT_MAP;
		level := fSelectLevel.ListBox2.ItemIndex + 2;
		World := 0;
		LoadMap;
	end
	else
	begin
		mode := MODE_EDIT_LEVEL;
		LoadLevel(fSelectLevel.seOffset.AsInteger+9,
			fSelectLevel.seEnemy.AsInteger+1);
	end;
end;


procedure TMainForm.OpenROMExecute(Sender: TObject);
var
	T: TStrings;
	Y: Integer;
begin
	if AskTile.Want then Exit;
	if levelmodified then
	 if MessageDlg('Discard changes and load another ROM?',
	  mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;

	OpenDialog.Title := 'Open SMB3 ROM...';
	OpenDialog.Filter := Filter_ROM;
	if not OpenDialog.Execute then Exit;
	ROMfilename := OpenDialog.Filename;

	T := TStringList.Create;
	T.LoadFromFile(GetConfigFile('m3ed.ini'));
	ROMdir := T.Values[ExtractFilename(ROMfilename)];
	if ROMdir = '' then ROMdir := 'Default';
	for Y := 0 to miROMtype.Count-1 do
		if ReplaceStr(miROMtype.Items[Y].Caption, '&', '') = ROMdir then
			begin
				miROMtype.Items[Y].Checked := True;
				Break;
			end;
	ROMdir := ROMdir + '\';
	if ROMdir = 'Default\' then ROMdir := '';
	T.Free;

	ROMloaded := True;
	ROMdata := FileToString(ROMfilename, -1);
	SMAS := UpperCase(ExtractFileExt(ROMfilename)) = '.SMC';
	if SMAS then
		MessageDlg('SMAS support is currently incomplete and untested.',
	 	mtWarning, [mbOK], 0);

	InitVariables;
	LoadLevelEasy(World, Level);
	Info('Load: opened $rom for editing.');
end;


procedure TMainForm.OpenM3LExecute(Sender: TObject);
begin
	if levelmodified then
	 if MessageDlg('Discard changes and load another level?',
	  mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;
	OpenDialog.Filter := Filter_M3L;
	OpenDialog.Title := 'Open M3L level file...';
	if not OpenDialog.Execute then Exit;
	if not FileExists(OpenDialog.Filename) then Exit;
	ROMloaded := False;
	if miROMGfx.Checked then
	begin
		InitVariables;
		LoadRomObjDefs(True);
		LoadGfx;
	end;
	ROM_gfx := False;
	ROMfilename := OpenDialog.Filename;
	ROMdata := FileToString(ROMfilename, -1);
	LoadLevel(-1, -1);
end;


procedure TMainForm.miViewToolbarClick(Sender: TObject);
begin
	Toolbar.Visible := not Toolbar.Visible;
end;


procedure TMainForm.ApplyIPSExecute(Sender: TObject);
var
	S, S2: String;
	Total, RP, L, P, B1, B2: Integer;
	EOF: Boolean;
begin
	if levelmodified then
	 if MessageDlg('Apply patch without saving changes?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;
	OpenDialog.Title := 'Open IPS Patch...';
	OpenDialog.Filter := Filter_IPS;
	if not OpenDialog.Execute then Exit;
	S := OpenDialog.Filename;
	S2 := Copy(S, 1, Length(S) - 4) + '.txt';
	S := FileToString(OpenDialog.Filename);
	EOF := False;
	P := 1;
	L := 0;
	Total := 0;
	if FileUtils.GetString(S, P, 5) <> 'PATCH' then
	begin
		ShowMessage('Invalid patch file.');
		Exit;
	end;
	if FileExists(S2) then
	begin
		S2 := FileToString(S2);
		ShowMessage(S2);
	end;
	while not EOF do
	begin
		RP := GetVal24R(S, P);
		L  := GetVal16R(S, P);	// length
		if L = 0 then		// RLE
		begin
			B1 := GetVal8(S, P);
			B2 := GetVal8(S, P);
			for L := 1 to B1 do
				ROMdata[RP+L] := Chr(B2);
			Inc(Total, B1);
		end
		else
		begin			// Normal
			for B1 := 1 to L do
				ROMdata[RP+B1] := Chr(GetVal8(S, P));
			Inc(Total, L);
		end;
		if P >= (Length(S)-3) then EOF := True;
	end;
	InitVariables;
	LoadLevelEasy(World, Level);
	levelmodified := True;
	Info(Format('Patched a total of %d bytes from IPS.', [Total]));
end;


procedure TMainForm.EditGraphicsExecute(Sender: TObject);
begin
	fGfxEdit.Show;
end;


procedure TMainForm.EditPointersExecute(Sender: TObject);
begin
	if mode = MODE_EDIT_LEVEL then EnterPointerDialog;
end;


procedure TMainForm.GotoNextAreaExecute(Sender: TObject);
var
	oL, oE, c: Integer;
begin
	if AskTile.Want then Exit;
	if levelmodified then
	 if MessageDlg('Discard changes and load next area?',
	  mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;

	c := header[7] and 15 - 1;
	oL := header[2] * $100 + header[1] +
		object_set_pointers[(header[7] mod 16)+1].ptr_type + $10010;
	if (oL < object_set_pointers[c+2].ptr_min)
		or (oL > object_set_pointers[c+2].ptr_max)
	then Exit;
	oE := header[4] * $100 + header[3] + $10;
	fSelectLevel.cbObjectSet.ItemIndex := c;
	oL := oL + 9;
	oE := oE + 1;
	for c := 1 to 298 do
	begin
		if (level_array[c].rom_level_offset = oL) and
        (level_array[c].enemy_offset = oE) then
		begin
			with fSelectLevel do
			begin
				ListBox1.ItemIndex := level_array[c].game_world;
				ListBox1Click(Self);
				ListBox2.ItemIndex := level_array[c].level_in_world - 1;
				ListBox2Click(Self);
			end;
			Break;
		end;
	end;
	LoadLevel(oL, oE);
end;


procedure TMainForm.ReloadLevelExecute(Sender: TObject);
begin
	if levelmodified then
	 if MessageDlg('Discard changes and reload level?',
	 mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;
	if mode = MODE_EDIT_MAP then
	begin
		SelObject.x := 0;
		SelObject.y := 0;
		//level := fSelectLevel.ListBox2.ItemIndex + 2;
		//World := 0;
		LoadMap;
	end
	else
	begin
		if ROMloaded then
			LoadLevel(level_offset, enemy_offset)
		else
			LoadLevel(-1, -1);
	end;
end;


procedure TMainForm.SaveROMExecute(Sender: TObject);
begin
	if not ROMloaded then Exit;
	SaveDialog.Filter := Filter_ROM;
	SaveDialog.DefaultExt := 'nes';
	if ROMfilename <> '' then SaveLevel
		else SaveROMAsExecute(Self);
end;


procedure TMainForm.ViewZoom100Execute(Sender: TObject);
begin
	Zoomsize := (Sender as TComponent).Tag;
	Width := Width + 1;
	DrawLevel;
end;


procedure TMainForm.SaveROMAsExecute(Sender: TObject);
begin
	if not ROMloaded then Exit;
	SaveDialog.Filter := Filter_ROM;
	SaveDialog.DefaultExt := 'nes';
	if SaveDialog.Execute then
	begin
		ROMfilename := SaveDialog.Filename;
		SaveLevel;
	end;
end;


procedure TMainForm.SaveM3LExecute(Sender: TObject);
var
	ofn: String;
begin
	ofn := ROMfilename;
	SaveDialog.Filter := Filter_M3L;
	SaveDialog.DefaultExt := 'm3l';
	if not SaveDialog.Execute then Exit;
	ROMfilename := SaveDialog.Filename;
	SaveLevel(True);
	if ROMloaded then ROMfilename := ofn;
end;


procedure TMainForm.SaveToLocationExecute(Sender: TObject);
begin
	SaveDialog.Filter := Filter_ROM;
	SaveDialog.DefaultExt := 'nes';
	if SaveDialog.Execute then
	begin
		fSelectLevel.ListBox1.ItemIndex := World;
		fSelectLevel.ListBox1Click(Self);
		if fSelectLevel.ShowModal <> mrOK then Exit;
		if fSelectLevel.ListBox1.ItemIndex = 0 then
		begin
			if mode <> MODE_EDIT_MAP then Exit;
		end
		else
			if mode = MODE_EDIT_MAP then Exit;
		ROMfilename := SaveDialog.Filename;
		ROMdata := FileToString(ROMfilename, -1);
		if fSelectLevel.ListBox1.ItemIndex = 0 then
		begin
			level := fSelectLevel.ListBox2.ItemIndex + 2;
			World := 0;
			SaveMap;
		end
		else
		begin
			mode := MODE_EDIT_LEVEL;
			header_offset := fSelectLevel.seOffset.AsInteger;
			level_offset := header_offset + 9;
			enemy_offset := fSelectLevel.seEnemy.AsInteger + 1;
			SaveLevel;
		end;
	end;
end;


procedure TMainForm.EditHeaderExecute(Sender: TObject);
var
	I: Integer;
begin
  with fHeader do
  begin
	Tag := 1;

	lHeader.Caption := '';
	for I := 1 to 9 do
	begin
		hdr[I] := header[I];
		lHeader.Caption := lHeader.Caption + IntToHex(header[I], 2) + ' ';
	end;
// Next area/Start
	sePtrObjects.Value := header[2] * $100 + header[1]
	+ object_set_pointers[(header[7] mod 16)+1].ptr_type + $10010;
	sePtrEnemies.Value := header[4] * $100 + header[3] + $10;

	cObjectSet.ItemIndex := header[7] and 15;
	cStartX.ItemIndex := header[6] shr 5 and 3;
	cStartY.ItemIndex := header[5] shr 5 and 7;
	cStartAction.ItemIndex := header[8] shr 5 and 7;

// Visual
	sePalLevel.Value := header[6] and 7;
	sePalEnemy.Value := header[6] shr 3 and 3;
	cGraphicSet.ItemIndex := header[8] and 31{15};
	cMusic.ItemIndex := header[9] and 15;

// Miscellaneous
	seLength.Value := (header[5] and 15) * $10 + $F;
	cbPipeEnds.Checked := (header[7] and 128) = 0;
	cScrolling.ItemIndex := header[7] shr 4 and 7;
	cTime.ItemIndex := (header[9] shr 6) and 3;

	Tag := 0;
	if ShowModal = mrOK then
	begin
		LevelModified := True;
		for I := 1 to 9 do
			header[I] := hdr[I];
		//InitVariables;
		GetPalette;
		LoadGfx;
		DrawLevel;
	end;
  end;
end;


procedure TMainForm.EditMiscExecute(Sender: TObject);
begin
	with ConfigForm do
	begin
		ConfigList.Items.Clear;
		ReadConfig;
		ConfigList.ItemIndex := 1;
		ConfigListClick(Self);
		ShowModal;
		if ModalResult = mrOK then
		begin
			StoreConfig;
			LevelModified := True;
		end;
	end;
end;


end.

