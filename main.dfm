object MainForm: TMainForm
  Left = 243
  Top = 107
  Width = 537
  Height = 402
  HorzScrollBar.ButtonSize = 8
  HorzScrollBar.Increment = 1
  HorzScrollBar.Visible = False
  ActiveControl = Pb
  Caption = 'SMB3 Workshop'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCanResize = FormCanResize
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelInfo: TPanel
    Left = 0
    Top = 299
    Width = 527
    Height = 55
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      527
      55)
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 37
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 5
      Top = 21
      Width = 37
      Height = 13
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 5
      Top = 37
      Width = 37
      Height = 13
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 266
      Top = 4
      Width = 29
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Bank'
    end
    object Label5: TLabel
      Left = 327
      Top = 4
      Width = 28
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Type'
    end
    object Label6: TLabel
      Left = 428
      Top = 4
      Width = 38
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Length'
    end
    object sObjectSet: TBMSpinEdit
      Left = 265
      Top = 20
      Width = 55
      Height = 30
      Cursor = crArrow
      Anchors = [akRight, akBottom]
      AutoSelect = False
      EditorEnabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = sObjectTypeChange
      Increment = 1.000000000000000000
      MaxValue = 7.000000000000000000
      GuageBeginColor = clMaroon
      Precision = 0
      TrackBarOrientation = trVertical
    end
    object sObjectType: TBMSpinEdit
      Left = 326
      Top = 20
      Width = 97
      Height = 30
      Cursor = crArrow
      Anchors = [akRight, akBottom]
      AutoSelect = False
      Ctl3D = True
      EditorEnabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnChange = sObjectTypeChange
      Increment = 1.000000000000000000
      MaxValue = 255.000000000000000000
      GuageBeginColor = clNavy
      GuageEndColor = clBlue
      TrackBarWidth = 256
      Precision = 0
      TrackBarOrientation = trVertical
    end
    object sObjectLength: TBMSpinEdit
      Left = 427
      Top = 20
      Width = 97
      Height = 30
      Cursor = crArrow
      Anchors = [akRight, akBottom]
      AutoSelect = False
      EditorEnabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = sObjectTypeChange
      Increment = 1.000000000000000000
      MaxValue = 255.000000000000000000
      GuageBeginColor = clGreen
      GuageEndColor = clLime
      TrackBarWidth = 256
      Precision = 0
      TrackBarOrientation = trVertical
    end
    object bEditPointer: TButton
      Left = 429
      Top = 22
      Width = 93
      Height = 26
      Anchors = [akRight, akBottom]
      Caption = 'Edit Pointer'
      TabOrder = 3
      Visible = False
      OnClick = bEditPointerClick
    end
  end
  object PanelGfx: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 279
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Image1: TImage
      Left = 56
      Top = 56
      Width = 16
      Height = 16
      AutoSize = True
      Picture.Data = {
        07544269746D617036050000424D360500000000000036040000280000001000
        0000100000000100080000000000000100000000000000000000000100000001
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000FFFFFF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF00004040
        40007D7D7D007D7DFF007DFF7D007DFFFF00FF7D7D00FF7DFF00FFFF7D000000
        0000000000000000000000000000000000000002020202020202020202020202
        0200000202020202020202020202020202000002000000000202020000000002
        0200000200010100020202000101000202000002000101000200020001010002
        0200000200010100000100000101000202000002000101000101010001010002
        0200000200010101010001010101000202000002000101010002000101010002
        0200000200010100020202000101000202000002000100020202020200010002
        0200000200000202020202020200000202000002020202020202020202020202
        0200000202020202020202020202020202000000000000000000000000000000
        0000}
    end
    object Pb: TPaintBox32
      Left = 225
      Top = 29
      Width = 286
      Height = 234
      Align = alClient
      Options = [pboWantArrowKeys, pboAutoFocus]
      TabOrder = 0
      TabStop = True
      OnDblClick = PbDblClick
      OnMouseDown = PbMouseDown
      OnMouseMove = PbMouseMove
      OnMouseUp = PbMouseUp
      OnMouseWheel = PbMouseWheel
      OnResize = PbResize
    end
    object LogMemo: TMemo
      Left = 1
      Top = 29
      Width = 224
      Height = 234
      Align = alLeft
      BorderStyle = bsNone
      Ctl3D = False
      Lines.Strings = (
        'SMB3 Workshop Debug Log')
      ParentCtl3D = False
      ScrollBars = ssVertical
      TabOrder = 1
      Visible = False
    end
    object TileGfx: TImage32
      Left = 8
      Top = 72
      Width = 144
      Height = 136
      Bitmap.DrawMode = dmCustom
      Bitmap.ResamplerClassName = 'TNearestResampler'
      BitmapAlign = baTopLeft
      Scale = 1.000000000000000000
      ScaleMode = smNormal
      TabOrder = 2
      Visible = False
    end
    object ObjdefPanel: TPanel
      Left = 240
      Top = 104
      Width = 233
      Height = 161
      TabOrder = 3
      DesignSize = (
        233
        161)
      object FillButton: TButton
        Left = 142
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Fill'
        TabOrder = 0
        OnClick = FillButtonClick
      end
      object PasteButton: TButton
        Left = 142
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Paste'
        TabOrder = 1
        OnClick = PasteButtonClick
      end
      object ListBox: TListBox
        Tag = -1
        Left = 9
        Top = 8
        Width = 120
        Height = 145
        Anchors = [akLeft, akTop, akBottom]
        Color = clSilver
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 16
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        OnClick = ListBoxClick
      end
      object SpinEdit: TRxSpinEdit
        Left = 136
        Top = 8
        Width = 89
        Height = 22
        ButtonKind = bkStandard
        ValueType = vtHex
        Color = clSilver
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnChange = SpinEditChange
      end
      object SetButton: TButton
        Left = 142
        Top = 104
        Width = 75
        Height = 25
        Caption = 'Set'
        TabOrder = 4
        OnClick = SetButtonClick
      end
    end
    object sbY: TRangeBar
      Left = 511
      Top = 29
      Width = 15
      Height = 234
      Align = alRight
      Color = clBtnShadow
      Backgnd = bgSolid
      HandleColor = 13386871
      Increment = 1
      Kind = sbVertical
      Visible = False
      ShowHandleGrip = False
      OnChange = sbYChange
    end
    object sbX: TRangeBar
      Left = 1
      Top = 263
      Width = 525
      Height = 15
      Align = alBottom
      Color = clBtnShadow
      Backgnd = bgSolid
      HandleColor = 13386871
      Increment = 1
      Visible = False
      ShowHandleGrip = True
      OnChange = sbXChange
    end
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 525
      Height = 28
      AutoSize = True
      BorderWidth = 1
      Caption = 'ToolBar'
      Customizable = True
      EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
      EdgeOuter = esNone
      Flat = True
      HideClippedButtons = True
      Images = ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Wrapable = False
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = OpenROM
      end
      object ToolButton4: TToolButton
        Left = 23
        Top = 0
        Action = ReloadLevel
      end
      object ToolButton23: TToolButton
        Left = 46
        Top = 0
        Width = 8
        Caption = 'ToolButton23'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object ToolButton2: TToolButton
        Left = 54
        Top = 0
        Action = SaveROM
      end
      object ToolButton3: TToolButton
        Left = 77
        Top = 0
        Action = SaveROMAs
      end
      object ToolButton5: TToolButton
        Left = 100
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 17
        Style = tbsSeparator
      end
      object ToolButton6: TToolButton
        Left = 108
        Top = 0
        Action = GotoNextArea
      end
      object ToolButton7: TToolButton
        Left = 131
        Top = 0
        Action = SelectLevel
      end
      object ToolButton8: TToolButton
        Left = 154
        Top = 0
        Width = 8
        Caption = 'ToolButton8'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object ToolButton9: TToolButton
        Left = 162
        Top = 0
        Action = EditHeader
      end
      object ToolButton10: TToolButton
        Left = 185
        Top = 0
        Action = EditPointers
      end
      object ToolButton12: TToolButton
        Left = 208
        Top = 0
        Action = EditPalette
      end
      object ToolButton11: TToolButton
        Left = 231
        Top = 0
        Action = EditGraphics
      end
      object ToolButton13: TToolButton
        Left = 254
        Top = 0
        Action = EditMisc
      end
      object ToolButton14: TToolButton
        Left = 277
        Top = 0
        Width = 8
        Caption = 'ToolButton14'
        ImageIndex = 0
        Style = tbsSeparator
      end
      object btnAdd3byte: TToolButton
        Left = 285
        Top = 0
        Action = ObjAdd3Byte
      end
      object btnAdd4byte: TToolButton
        Left = 308
        Top = 0
        Action = ObjAdd4Byte
      end
      object btnAddEnemy: TToolButton
        Left = 331
        Top = 0
        Action = ObjAddEnemy
      end
      object ToolButton18: TToolButton
        Left = 354
        Top = 0
        Action = ObjDelete
      end
      object ToolButton19: TToolButton
        Left = 377
        Top = 0
        Width = 8
        Caption = 'ToolButton19'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object ToolButton20: TToolButton
        Left = 385
        Top = 0
        Action = ViewZoom50
      end
      object ToolButton21: TToolButton
        Left = 408
        Top = 0
        Action = ViewZoom100
      end
      object ToolButton22: TToolButton
        Left = 431
        Top = 0
        Action = ViewZoom200
      end
    end
  end
  object RomGfx: TImage32
    Left = 16
    Top = 80
    Width = 160
    Height = 177
    Bitmap.DrawMode = dmCustom
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Color = clAqua
    ParentColor = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 3
    Visible = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 279
    Width = 527
    Height = 20
    Align = alBottom
    AutoSize = True
    BevelOuter = bvLowered
    TabOrder = 2
    object InfoLabel: TLabel
      Left = 1
      Top = 1
      Width = 462
      Height = 18
      Align = alClient
      Caption = 'Welcome to SMB3 Workshop'
      Layout = tlCenter
      OnDblClick = InfoLabelDblClick
    end
    object lByteData: TLabel
      Left = 463
      Top = 1
      Width = 63
      Height = 18
      Hint = 'Object bytedata / level size'
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Bytedata   '
      Layout = tlCenter
    end
  end
  object FloorGfx: TImage32
    Left = 40
    Top = 80
    Width = 128
    Height = 16
    Bitmap.DrawMode = dmCustom
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Color = clWhite
    ParentColor = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 4
    Visible = False
  end
  object MainMenu: TMainMenu
    Images = ImageList
    Left = 392
    Top = 64
    object mROM: TMenuItem
      Caption = 'File'
      SubMenuImages = ImageList
      object miLoadROM: TMenuItem
        Action = OpenROM
      end
      object miLoadLevel: TMenuItem
        Action = OpenM3L
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object miSaveROM: TMenuItem
        Action = SaveROM
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miSaveLevelAs: TMenuItem
        Action = SaveM3L
      end
      object Savetolocation1: TMenuItem
        Action = SaveToLocation
      end
      object miSaveROMAs: TMenuItem
        Action = SaveROMAs
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object ApplyIPSPatch1: TMenuItem
        Action = ApplyIPS
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object miROMtype: TMenuItem
        Tag = 224418
        Caption = 'ROM Preset'
        ImageIndex = 14
        object miROMDefault: TMenuItem
          AutoCheck = True
          Caption = 'Default'
          Checked = True
          Default = True
          GroupIndex = 2
          RadioItem = True
          OnClick = miROMDefaultClick
        end
      end
      object N7: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object miClose: TMenuItem
        Action = ExitProgram
        GroupIndex = 2
      end
    end
    object Mode1: TMenuItem
      Caption = 'Edit'
      object miEdLevel: TMenuItem
        Action = EditLevel
        RadioItem = True
      end
      object miEdObjdefs: TMenuItem
        Action = EditObjDefs
        RadioItem = True
      end
      object miEdPalette: TMenuItem
        Action = EditPalette
        GroupIndex = 1
      end
      object miEditGraphics: TMenuItem
        Action = EditGraphics
        GroupIndex = 1
      end
      object miEdTSA: TMenuItem
        AutoCheck = True
        Caption = 'TSA Definitions'
        Enabled = False
        GroupIndex = 1
        RadioItem = True
        Visible = False
      end
      object miMisc: TMenuItem
        Action = EditMisc
        GroupIndex = 1
      end
      object N18: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object miFreeform: TMenuItem
        AutoCheck = True
        Caption = 'Freeform Mode'
        Checked = True
        GroupIndex = 1
        Hint = 'Freeform mode allows adding and deleting objects'
      end
      object miLimitsize: TMenuItem
        AutoCheck = True
        Caption = 'Limit Size'
        GroupIndex = 1
        Hint = 'Limit data size to avoid overwriting next levels'
      end
    end
    object mLevel: TMenuItem
      Caption = 'Level'
      object miNextarea: TMenuItem
        Action = GotoNextArea
      end
      object miLevel: TMenuItem
        Action = SelectLevel
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Reload1: TMenuItem
        Action = ReloadLevel
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miLevelHeader: TMenuItem
        Action = EditHeader
      end
      object Pointers1: TMenuItem
        Action = EditPointers
        GroupIndex = 1
      end
    end
    object mEdit: TMenuItem
      Caption = 'Object'
      object miCloneObject: TMenuItem
        Action = ObjClone
        GroupIndex = 1
      end
      object N17: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object Add3byteobject1: TMenuItem
        Tag = 3
        Action = ObjAdd3Byte
        GroupIndex = 1
      end
      object Add4byteobject1: TMenuItem
        Tag = 4
        Action = ObjAdd4Byte
        GroupIndex = 1
      end
      object miAddenemy1: TMenuItem
        Tag = 2
        Action = ObjAddEnemy
        GroupIndex = 1
      end
      object N10: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object Deleteobjectenemy1: TMenuItem
        Tag = 1
        Action = ObjDelete
        GroupIndex = 1
      end
      object Clear1: TMenuItem
        Caption = 'Delete All'
        GroupIndex = 1
        ImageIndex = 16
        object miDelAll3: TMenuItem
          Caption = '3-Byte Objects'
          ImageIndex = 0
          OnClick = miDelAll3Click
        end
        object miDelAll4: TMenuItem
          Caption = '4-Byte Objects'
          ImageIndex = 1
          OnClick = miDelAll4Click
        end
        object miDelAllE: TMenuItem
          Caption = 'Enemies'
          ImageIndex = 2
          OnClick = miDelAllEClick
        end
      end
    end
    object mView: TMenuItem
      Caption = 'View'
      object miViewHandles: TMenuItem
        AutoCheck = True
        Caption = 'Handles'
        ShortCut = 116
        Visible = False
        OnClick = miView3boClick
      end
      object miViewGrid: TMenuItem
        AutoCheck = True
        Caption = 'Gridlines'
        ShortCut = 117
        OnClick = miViewGridClick
      end
      object miViewFloor: TMenuItem
        AutoCheck = True
        Caption = 'Background && Floor'
        Checked = True
        OnClick = miViewFloorClick
      end
      object miViewToolbar: TMenuItem
        AutoCheck = True
        Caption = 'Toolbar'
        Checked = True
        OnClick = miViewToolbarClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miZoom: TMenuItem
        Caption = 'Zoom'
        ImageIndex = 18
        object miZoom50: TMenuItem
          Tag = 8
          Action = ViewZoom50
          RadioItem = True
        end
        object miZoom100: TMenuItem
          Tag = 16
          Action = ViewZoom100
          Default = True
          RadioItem = True
        end
        object miZoom200: TMenuItem
          Tag = 32
          Action = ViewZoom200
          RadioItem = True
        end
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object miROMgfx: TMenuItem
        AutoCheck = True
        Caption = 'Use ROM Graphics'
        Checked = True
        Hint = 
          'Render levels using graphics from the ROM (incomplete - no enemi' +
          'es)'
        ShortCut = 119
        OnClick = miROMgfxClick
      end
      object miPaletteFile: TMenuItem
        Caption = 'Palette'
        Hint = 'Select a palette for ROM graphics'
        ImageIndex = 6
        OnClick = miPaletteFileClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object More1: TMenuItem
        Caption = 'More'
        object miViewTrans: TMenuItem
          AutoCheck = True
          Caption = 'Transparency'
          Checked = True
          ShortCut = 118
          OnClick = miViewTransClick
        end
        object miViewActiveObjTop: TMenuItem
          AutoCheck = True
          Caption = 'Selected Object in Front'
          OnClick = miView3boClick
        end
        object miFloorinfront: TMenuItem
          AutoCheck = True
          Caption = 'Floor in Front'
          OnClick = miFloorinfrontClick
        end
        object N9: TMenuItem
          Caption = '-'
        end
        object miView3bo: TMenuItem
          AutoCheck = True
          Caption = '3-Byte Objects'
          Checked = True
          ImageIndex = 0
          OnClick = miView3boClick
        end
        object miView4bo: TMenuItem
          AutoCheck = True
          Caption = '4-Byte Objects'
          Checked = True
          ImageIndex = 1
          OnClick = miView3boClick
        end
        object miViewEnemies: TMenuItem
          AutoCheck = True
          Caption = 'Enemies'
          Checked = True
          ImageIndex = 2
          OnClick = miView3boClick
        end
      end
    end
    object Debug1: TMenuItem
      Caption = 'Debug'
      Visible = False
      object LoadObjDefs1: TMenuItem
        Caption = 'Load ROM Objdefs'
        OnClick = LoadObjDefs1Click
      end
      object LoadObjdefs2: TMenuItem
        Caption = 'Load Objdefs'
        OnClick = LoadObjdefs2Click
      end
      object SaveObjDefs1: TMenuItem
        Caption = 'Save Objdefs'
        OnClick = SaveObjDefs1Click
      end
      object N8: TMenuItem
        Caption = '-'
        Visible = False
      end
      object miDebug: TMenuItem
        AutoCheck = True
        Caption = 'Debug Mode'
        Visible = False
      end
      object miDebuglog: TMenuItem
        AutoCheck = True
        Caption = 'Debug Log'
        Hint = 'View debug messages'
        Visible = False
        OnClick = miDebuglogClick
      end
    end
    object mHelp: TMenuItem
      Caption = 'Help'
      object Enemycompatibility1: TMenuItem
        Caption = 'Enemy Compatibility'
        Hint = 'enemies.html'
        ImageIndex = 2
        ShortCut = 112
        OnClick = roubleshooting1Click
      end
      object roubleshooting1: TMenuItem
        Caption = 'Troubleshooting'
        Hint = 'errors.html'
        ImageIndex = 3
        ShortCut = 8304
        OnClick = roubleshooting1Click
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object Enemycompatibility2: TMenuItem
        Caption = 'Program Website'
        Hint = 'http://hukka.furtopia.org/projects/m3ed/'
        ImageIndex = 13
        OnClick = Enemycompatibility2Click
      end
      object ProgramWebsite1: TMenuItem
        Caption = 'Make a Donation!'
        Hint = 'http://hukka.furtopia.org/donate/'
        ImageIndex = 0
        OnClick = Enemycompatibility2Click
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Caption = 'About...'
        Hint = 'About this program'
        ImageIndex = 14
        OnClick = miAboutClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'NES ROMs|*.nes;*.smc|M3I Levels|*.m3l|All Files|*.*'
    Title = 'Open SMB3 ROM...'
    Left = 328
    Top = 64
  end
  object SaveDialog: TSaveDialog
    Filter = 'NES ROM|*.nes|M3L Levels|*.m3l|All Files|*.*'
    Left = 360
    Top = 64
  end
  object ImageList: TPngImageList
    BlendColor = clFuchsia
    PngImages = <
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B11
          00000B11017F645F910000016C4944415478DA63640082FF4008038C0C8C160C
          0C1C79406624032A58CEC0F0631250ED0924B5400835005963795A08439CBF13
          83BCB418C3ADABE719D6AC5CC2D0B6E92186416806702E03695E37A58AC1CDC6
          8881F9ED1520BEC6C0F4ED1558D7B9079F193216DC02D32043FE337C8F821B00
          0420DB8FEF59D0C26023F19181E9D343863F12E60CFFF8E4C106CC9B318121C3
          490AACD9ACE12C54CB0F4B2071026A00C7B2086FBBC839AD790C6CB7568135FD
          30C861607DB49B81F9DD4D069684030C7F16388055C6CDBACEB0ECD84B9857A2
          6006FC3FBB6E2283A6F00F06B6FBDB21E6030DE0B83005CC463600CD158C7003
          BE5C5803B7119F01303E560360CE1F380328F202A581088F4698A6DF72AE6017
          DD78F68DC1B6F51CC3EBA936F8A211929040AED061B906F646DDBAFBF0E43B25
          4E0D9E9010A91129212127E555132B1802C46F3130FD78879293F02665F4CC14
          6525CE50E523CFA021C505F642DB96873067E3CE4CE466670061920820EF6D5A
          C90000000049454E44AE426082}
        Name = 'PngImage0'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B11
          00000B11017F645F91000001824944415478DA63646060B06060E0C801D2D10C
          640046A0E625735AB3A323BC1DC9D10F36E0FF970B6BC8D24C3D030E2FEB6030
          D45221DB80250C640620DC05A71A8C187EAA85C15DC1F4ED1503E38FF70CAC8F
          76C315FE02CAFFE31283CB337D7AC8C0F2E224C4803F0B1CC0127F24CC19FEF1
          C9C31532BFBB896208BA3CD8226403B0811BCFBE32B46D79C4B0ECD84B862A3F
          79860023610623053E542F7CDFD70AB6C9ACE12CC3B9079FC10A936C25181444
          39E10AEBD6DD6768DBF410C8FAC7303D419DC1555B082C0F8F4690732F1F5ACB
          3061D753B06D2010642AC2D014A8C8A021C58DE11A23055E8655D95A1003BE1D
          9B06F617C785296085E71E7C423128CA4A9C61519A2686B76E3CFB8608035028
          B3DD5A85E27F9041190B6E83BD0532A4C04D1AC5FF206FA10462C5AABB0C0936
          127027231B64D6700ECC0645397A202E01864134280CAC933AC0B6A12B8281B8
          59D7C1DE2AF6946408379704AB011AC060F1EDD8BCE3B03098B1EF1943CEA25B
          58A30C04D69E7ECD103EF52ADC3500F87EBB3F99ED75370000000049454E44AE
          426082}
        Name = 'PngImage1'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B11
          00000B11017F645F91000001364944415478DA6364A01030FE67F88F29C8C0E8
          03A436A309FB02D56EC16B00B2C6FF0B1D5015C61FC06A10DC00745B63ACC419
          16A76B82D975EBEE33346F7C88D535585DF07F4D180363C82A86338DA60CC60A
          DC60DB6162045D00D6E40864BEBA0AD300D6CC20A6CD7076FF160693FAD3A82E
          0062B8D3613632283A3230DAD5C3C301EC82438D0C0CF7F7339C7DF0156608D8
          209001FFCF341A0335F2227C083420B6621A3C0C62675E6758DC910536000660
          06810D400F71A2D300D065A82E80DABCE4D84BAC1A6AFD15189A8A13A15EF90C
          74C1594418800D71F44371265600B4E4ECFE4D60CDE03000C5028E9447088063
          026B3A38333B93C1585D0245755DEF3C5062C248CEB8D301B64003462D023001
          F13FB8175072143643A02E80F34131078B85E9404E0652664118024A54485186
          0D000058F7A1E2EB1971090000000049454E44AE426082}
        Name = 'PngImage2'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C000002AF4944415478DAA5936948545114C7FFF7CDBCD95EDAB4
          B9A46398363993B49961A4442B125A0A62D886841646411B511FA25090822888
          C88AA2D010CAFA906D96044994A4994AB42264B984B6D3CC9BF7DEBDEFDDDEB4
          40412B5DB8DCDFF9707E977BCEB984738EFF5944DA1503AE0356D501913A6155
          9CA04487262A80A08189149A5D033799986CD82860683E77EC90631005FFBF09
          ACA640908BBDDE988A3953FDF157EE3D7EFBD70283A8A36067950B32924A5664
          A4E2D0F50EA3F941573E71ED8A4EE40CB2A839077E2AB06A50ACEA7429CA7262
          D57CBF3F2F2509BBAFB5A3B1F9F11A22E94749DCC16459A3C693400FCB7171A9
          EF7B01872A062DA1528F2F72EFB6DC346756B41B5B1BDAD170A36BA76067E590
          CC67F9AA260D64CC1819557FE1F92D366859E460D25B2AE8504828C590B48AAC
          CCD882F5B3A62121C28AF2C6369CBFD6BDDF22A89B982B043829887BB3B7BC6C
          45DA0E511471A0FA4E93F85E9AAD723ACFE1D18F17667B3D4513274314551C68
          6AC1B9FADE33C4D09633A74C99E3AB20B26CC2F8A4F1C33B0EAF5BEA38DD7A9B
          1FA9BDDB3FD63B74D8DABC34577AD438048C57A8696D475D5D5F83CED442EE52
          3E6AB6204C09E032055125D32DD4AA556D583DB3342F351DA7EE3762526C3C92
          233C78C75FE2D2C3FB385B3BD8493FB01CB8582F17180CB3B086D9522E3290D1
          C59950159E9D32D37E79FBB205C42D46E0A3124088BCC3CDEE47A8AB7EDFADBF
          D1E75B9C7A97D9CBF0EC8170F30CEF7094B0241B9C11BB658476A9A82C7AEE94
          D84428F880CEFE5E5CAC915F077BB01092DC1ABEED5BD20FA3ECCD5FFC192815
          3626E52AFB72F322F1622080AB277920F8D4566048F255DD21E39702DFA2C22F
          C48411B638D6E65F3938E659835B7BD532A494B8E46A6A26FF56909AB3FC2B72
          58046B251945B7B01EFB0E2A287B746708D4F607C1FF7EE74FDBAE6191399823
          450000000049454E44AE426082}
        Name = 'PngImage3'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D4948445200000010000000100803000000282D0F
          530000000774494D45000000000000000973942E000000097048597300000AEF
          00000AEF017D768A4800000300504C544500000000FFFFFFFFFF40C240FF4000
          81818161C240FFC281A18100008181FFA140005C5B0000FF40C2FFA1FFFF00A1
          008120000061FFFF20008100FFA12000A1A181C2C2FF202040404040202000C2
          C281616140616181FFC2FF8181FF4040FF2020FFFFA181FF8181FF6181A1A1FF
          6161FF6181FFFF4081FF2040FF0000FF4040FF614081A1FFA181FFC2A1FFA1C2
          FF4061FFFFFF81C2FF8140FF4081FF81C2FFFFFFFF00FFFF4020FF4000FF0061
          FF4020FF008161FFC2A181A1FF81A1C281FFC24081C281FFC20020A1FFFF6100
          FFA1FFFF00FF0081FF00610000A1409100965B00B0000000DDDDDDB4B4B40000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000A0B0F0FF33FFDEE9AC94000000664944415478DA63
          6440038C0C4C28FC7F4001E1D770AEE85B90C03F8FDD0C0C7F199819185C7730
          8105804C86BF60EA2F9280F179200D15006B3766008A4005C0F6183200451820
          02C6304BCE32A0686138CB8C6228908F6ACB5984B5E80EC3703ABAE7D000001F
          6037115C0D602D0000000049454E44AE426082}
        Name = 'PngImage4'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C000003194944415478DA6D936D48535118C79F73DDDDE6D4BB4A
          54FC32AAE975132C4449B4955E41287C43AD61469F1214548A30843429BF644A
          202506A54541AF425A34502287C2104A06E6CB2294252E1D689873BAF7DD9E73
          53B0F2C0E59C7BEE797ECFFFF93FE792506C2C30D1D1F09E61A0233515F6E1EC
          76BBC1E7F3314AA5F29A56ABBDEC70386E0502813B32990C62626240A7D34144
          44046C6C6C00D90BB0BEBE4EFC7EFF0DA3D1D85C595919D1D3D3E31E1E1E2E57
          ABD51FB2B2B240A552D104B0B9B9F93F202A14028FC7D359515171A5A6A68661
          59165001B4B6B6CECECFCF17190C067B349EDF13D0AED32955C1600706376030
          78BD5E4926953D3A3A0AA86400E53722C08D25B9B6B6B6BC24C471E958EC4113
          CBDA3B3332EACF14145CACAEAE069AB9ABAB0B42A888E77909B2B0B00058DA77
          511497B1CC1F2B2B2BAF885855F5C59B9292F2786CCCE1C8CD3D5C555E0E1A8D
          4692D8DFDF0F6B6B6B90909020CD72B95CDAA7AA505D787575F53511EBEB3D1F
          535395E640004EE8F5C027250183E56016A023180C4AEBC5C545585A5A02A7D3
          09168B6519411750D567F24BA399702627673C54AB3DC9252591A70541CA120E
          8725107DE8A06D43F95276ABD52A9A4CA637083F476618A6492F97B74F04835F
          EF09C24C515D5DC5B1B434D84087FF1D1446BDA1B0A1A121C0D6DE26A3004779
          00CB0100FF4D9EBF6ACBCFAFBD643466C6C6C5495D2084FC05A1E528140A69BF
          AFAFCF4706511D063FC902387F5FAB6D799A933396171F3F545E56A6A2996817
          76075315D4CCA9A929309BCD26F20C3F84014E21E0DDA45AFD604010EA7FB26C
          635E7A7AE77183413291FAB1BB84C9C949181919798BDF6AC95D4A0660D50036
          5C3EB76666B6CEF33C131908BCCC1784B33B2DA5C1F45FB0D96C303E3EFE02F7
          6AF15F7191B63FEAE428B49705E81619E6D36C61216CCA6487F673DC607676F6
          113C281DB2DBED303D3DFD0883EB10E8A540D2FC07A040AB34786C0E67D1565C
          0CBEA82808F9FD271313134D7ABD3E9ADE83B9B9B96EF4A409BDD8A27E488096
          6D83A8D78AEDF5B7D25208701CBD45F4B581E3B83697CBD58B99AFE3BB971ABB
          03F80D59E6834A1F7992610000000049454E44AE426082}
        Name = 'PngImage5'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C000003864944415478DA65936D6C536514C7FFCFBD775DBBB1AD
          ED6DB7B14E1C94F0A21BE30399A0BCCA02922C6642D85C212C266A42212C0273
          31C419E503C2C8505EFC803126580741120D2FA6CC902909A681ADDD8B6642A0
          355BD717BAF5767DB96DEFEDBDF5614B0CC64F27E749CEEFF99FF33F871C2A02
          942C0002301C909380B40A9EA60D3A7DE1DB862AED7ABE82359514A50AE44436
          F3E42146BD619C56805B5A204F9E07280A746A1E2D35ABAAEDEBB6D634D4AE33
          A3B486814623424C7078345D093994C0E8AD7B70FE3CD905153DFF026405F5E5
          2F9A4FBFD1B1BDB176B309B7E547108211EC2936E0CFE9353831F11E625C152A
          F9248E994EE22F8743B97225F0CE1C202BA261F986D57DADA76CD62A4B0C17C7
          EEE3436E0CE9681807233C7692DD38EAB523BDA40E8505327ACB8EA1AED8854F
          EC9E61B29F83B9FA65EBCDF65E7B4365F1432093C2DD480CBD131EDA57126D5A
          2B6CB54B30131171796A33A26A19ECD67E987809673F1D14C807A5855D6F1EDD
          F9F96BED4F21859250FC7A709C1E6C6909F2520EDA3276BEC7123A5CAF1FF9B8
          089DF5050A5770B1C7354BCE6E593BD67CB8B1D6B2E62A18C988603F01312E46
          65FD42AA861666D274C00A1E3B9F20F6F528AA45196ACB3218DB2CF8B2CB1521
          3F1EDE37B3B5FD1563F4F73320EA02709655A8A8B38095A99FD9EC9CAF32C9E1
          BEDD8915AEC033B33052AE43C991A5707CE573911B9D7B85A68F9AF492F71ED8
          321E4CB911244D8BE31140A251A60A5805FE012F82173C886754681B79F87222
          9C7DE103C4D1B669D276BEA39AC8C3783A19C594FB6F2C7AB519BC290E0813F3
          90674A340A12B36914B02A845800E70EB947277CE96DE4C44AFEDABB3FF4EC12
          7CBFC2FDCDF5A8261A73BC646BB52D6FDD6142C04D15E42824432132B080209E
          08E2D2F1C1F4F02F420BC7E226E95E8826EBC6A5371461FAB1361E6B29D621B7
          A26DCFC0B2B736F1088DCC03645A4C7F4ECC8670FD5B0F067F0A1F1753E80643
          E7DB5D051D43B0CF6CC25D4329C6D52C76AFEDECECB36E58C4214001A007C2A9
          9809F9E1BC3484F13BE12FE8AA1C49A640B77E1E00965A6D32023A0D552BA279
          63E7FEAB2B9B57176072885E581EBE711F06BEF760EAC1CC292AE86331032999
          A097F43C8037D0485F72320C15F53543AF776D5BACC48218F9CD8B3FFA7D42CA
          2F76B004DF656837296ACCFF00463DDD2D1550D5B9F87EA1B9E84C9E304C3298
          BA4DA4FC6744C3B8F3B28A8CF45FC03F1E8C978491BF5D570000000049454E44
          AE426082}
        Name = 'PngImage6'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C000002A04944415478DA85936B4853611CC69F63DB6C53896D65
          9BB745296A856069220506599644F9C54B1F4A140C298A22A2A03E08220B24E9
          821342C22023C392B41C4D8729A63949F3BAE9A6F3329DB7B9B9A553B7B3D3AB
          0E2A7476E0F7E93CFC9EFFFB3FE7A51886014551F8DFC34B0B3813182A7826F6
          E7076A7AC794E656F36D479FD5406D27F0CB084A801713EE5CA48DFB620465D9
          679305B1E2A3A8D735405652239FAF305EF528E0A68A632451E246B148C0531B
          46102CE12252C00287C5058FEB0365BDC1DE27559FF62C48129EDF735C5413B9
          2F0403434658D98B90EC7581C77282E3E38BFE8A85C9E9F786DCED8EC0E6C449
          2A032FF12FF873B8181D316399EB8250C48153B3FC6BB478A8144EA6D6B320E8
          013B31E562CD95F4C1A4479D4F41BB6C304FAD82B56B276CF533DD36E59C94A4
          7A3D0A2232752F542507725618E0B9B21155634558A274601C4ED066861E2B1C
          BEC62CD1F22D05C2E49EFBAAD230A91FDF1B4DA340CF14F02EFFD6CCA4F71BDA
          2F5E2436558F77DBDB2D0524DAB249E07DA2335D511CFAF6C8215FD469812E0B
          F0A5B0DCFAFD43E66380D6834D85C0C1102DF484817F05D16DF12F0BF62B2F9F
          DBCD950F003F1780E657DF1C0AD92919B0F2952474041BC18BB048B0FC111C56
          491EDE14B5E4E70407D49258E73C1128F4A8CA8B7D4DD3A61A1256BB5BED84B5
          46D71A1B8288167E5AAA5051911F1E534722EDB380E6870595778EC9ED766D39
          096ADCED5602F3F7BED60509B93D0DB54F0E9EEC98DD81E6096058EF44D58D44
          95C9D44846C7A01BB3BB159B0429D7DB3AA40571D1D5A46384083EDFCDD28E6B
          CB8ADC63AFB5CF11E8ADFEB68D09329A54D95991B17DB3143EC98A8DEAD63CB2
          7174BB05D30487A75BBA2E088BBAD73C31F4B17F7579CE49BBCC640BAE2EF28E
          7C444C1256B6BBE6BF013F77458DEDB145CB0000000049454E44AE426082}
        Name = 'PngImage7'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000002C744558744372656174696F6E2054696D6500746F203134206B6573
          E420323030372031373A31343A3036202B30323030AF4520E10000000774494D
          45000000000000000973942E000000097048597300000B1100000B11017F645F
          91000002084944415478DAA592DF4B536118C7BFC73BA9F0C28B2ED6BA28D990
          8C2E64571589913F983F208818783123A2E842886E0AA2BFC0EEA46B6F0D3594
          816E5ADA4609425D7495986D6B6A2EA6DBE9CCB39DF757CF7915D924A7D003E7
          BCCF7978BE9FE779DEF31838C6DA7ADF77B45D3B3BAB1460DB025FBEE6FDB189
          EB2BB76EC77DEE691C27F6373568B1825A761C19B02C0ED3E27E7B97CD2766DA
          BD35017DA18FCA2E0BD7EDA46AD1F6FEC5E172993D515244A464C1A5B91EA326
          E06AD79CA2C4C8A768778FFBEDB66D1672AF94124125399617EED606549A2BDE
          C9A5E7497C4E29A9639FE361C31879840EF2672B729FD333FEF835560E014000
          10001500B800E56B6DC585966658852D24DEC68E6A6294A0E1C3410DB833F400
          0D8DA720791E926521F836F945AAC474D2AF5411EF26D32080F14FC0BD978350
          D221F11F70BE03E15890B2047AED67016323DF8E06849F75410A46E212D657B7
          B038B57AD2BBDD030C3C0D50DB1299EF39C4A79308DE7F018FEF32C07F43B01F
          507C0DD2C9D248166D94C046D244EC4D4AEF870684865AB0BE66E2C3741ADD83
          0FE1F50728515257391226C19D0C14235F16B1992CD07DEC8969A4A806DCE83B
          4F6DA7D13970135EDF15A0EE3455A3E5E5267879830059B0521E9BA96D24223F
          0FC40723E848E8123C173D30EACE50B45E0324DF854342C72ED078592C453355
          E22AC009AD4ABCFF83FECFFE02F1302F617057BBED0000000049454E44AE4260
          82}
        Name = 'PngImage8'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000473424954080808087C0864880000001974455874536F6674776172
          65007777772E696E6B73636170652E6F72679BEE3C1A0000023D4944415478DA
          9D935F4853511CC7BFF79E73B6F647254645AD97C08751F4D64B942F3DF560A0
          0F3DF620480641F590935EA27A58B48208EC0F4BB1BF209422CC94C1EC9F390A
          D2FEB828A720688D1ACEDA72DE8DBB7B4FBF3B6A312BD17E97730E5CCEF7F3FB
          7B142925FE66756DA2D734D03572410F631953FE05D8755CE86E67B591CB674F
          3E0BEAC1FF029C3BD6C5AFF604B499E4A4154D1345A3AF1CD02AF46B27FAB901
          1D772397F2CFDF3C1E378BD84B90F93F00BBFD629C8EDAF24F6B31A857FC61DB
          A77C1C1BED3E0C8DF5157BA33753D2C01E824C5400AC70CF3477726113608CD1
          52C138C31AE140223B0C063BBC8EED98987D2D433DC19C512C3612245A01387B
          E80E8FA71E810B1516880B06CE055D31014931991C5EE73664B25F71F9DE29ED
          BB96F18F9CD7DBCB8040CB6DFE2A19F909E0A50818E3505595BC28908602D390
          D8E0AC854DBA100A07B4E4DCF4F532E07473078F266E2067A64BCB500AA87178
          5065F7A0C6B61E55621D160B393069C326B70F03B16E6D6AE6DD70197070BF9F
          F78D5F84840166B36AA040654AA950D61DCBBBCF5307AF6B2B069FDE5F4C67BE
          744B132D1500DD2C5007E85348AC5A27D0FFA1BD94C28ECDFBC08B2E0C90582B
          E4DAACFC7F17B155A41C7697FB9737DAA98DD23C507FC41579DF819D5B1A909E
          9F9343B1070BA6693450071E2E6DA325762F99A5D95254461E6F275FEA63F1D8
          67BA6ACDC0D48A47B9A9F1287F323AA84D7F4C8C52BEF524CEACEA2DACADF6E8
          DF16D2B7487C98C4C6AA1E138DF70B127692308465EC075F403F60A310CA2F00
          00000049454E44AE426082}
        Name = 'PngImage9'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B12
          00000B1201D2DD7EFC000001694944415478DA85933D4EC3401085672552720B
          28101520248480020A1A380048D8A1204A101448BE852D71026828E000390010
          4265A70339768214890681208640887FD95D27C1ACC764ABD9DD37DF7ADE9349
          144573802F2351676A0803104274F1869E9324204B3304EC3C1F020923705FBA
          70317DC2EE37E95D3909905A25200180EBF4E07CE6946B8600E9E900CC4E1D7C
          C783DAEC250A901F4A607E5BE0B73D3016AF05C0E33E983D7B34E08B3ED2F6C1
          581A015014E54855D54A1F3045356772B308E6A7C535C6722503F0EA426DFE0A
          B55CB68BFC0B02C7077D4504B4D87C76FC5C6E326935401897AC99D0ADFFFE0F
          2078F37E9BC37E3383D0951B1FE367CC037DF5260DA8B3F928DD58C047C89B05
          9A54AC4901B088068DD4D0094DD38EF3F78538EA0F0A58AB2200212231C6FCDD
          5E9C020A4022CA04509FF4F5DBBF802D7D17AC6E83BB3C7058046C5725B03A0D
          7E9002209EA5009886017845051BC8DF564EEE31CD0F186E4A428FB21B110000
          000049454E44AE426082}
        Name = 'PngImage10'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B4744000000000000F943BB7F000000097048597300000DD700
          000DD70142289B780000000774494D45000000000000000973942E000000A549
          44415478DA6364A01030D2CC0093D42567809431947BF6CCEC1813520DF8DF9C
          E90466D74EDFC700348071901B80E667304036000DC0C304D980FF3D792E0CBF
          FFFD070BFEFEFB1F45C7FFFF100C92AB9B8970118A010DE98E0C0F5F7F032BFC
          0734088818BEFDFACFF01768D81F10FF1F0383920427C3D4E547B01A80E18520
          0F5330BD6EC769C25EC01588E7EF7F061B40762C506C00D1D188C500CA9232B1
          80620300486577112F125DDB0000000049454E44AE426082}
        Name = 'PngImage11'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B4744000000000000F943BB7F000000097048597300000DD700
          000DD70142289B780000000774494D45000000000000000973942E0000007049
          44415478DA6364A010308E1A4045034C52979C0152C644EA3B7B66768C09BA01
          FF7BF25C187EFFFB0F16FCFDF73F8A8EFFFF2118245737731F03D000460C031A
          D21D191EBEFE0656F80F681010317CFBF59FE12FD0B03F20FE3F060625094E86
          A9CB8F603580322F0C7C2C8C6003004EB23711482851F60000000049454E44AE
          426082}
        Name = 'PngImage12'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B11
          00000B11017F645F91000000824944415478DA636460601004620120E667200D
          7C04E20F8C4042918181E31E899AA1E08712C80003A001E7197E7C810B7367A4
          337C5DB09418030CB11A40BC21780C20CE105AB980A230603A798DE19FBD19B1
          B180690036DBFFA0798F8583877C2F800C2368003643905D419401F8BC43960B
          4832009FF3B17981E2CC44517606004E1E70B5B3067A9C0000000049454E44AE
          426082}
        Name = 'PngImage13'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C000003664944415478DA4D92794C545714C6BF3B5C86A153C641
          3282065116F7150860B5D66A35D154DCA231A8111762498A56A2E81FADC59A6E
          A0AD264D2D62144D6A9418A3488BB6519168DC9016D48A416551A4E3C038308E
          65DEBCF7EEED790C1A6F72DE7296DF39EF3B8FD5C54443C40CC6D3D616F474F7
          80330609404A691F9691D170DCE57297B6B44C090302865F214B8BB42367681C
          2AA98619006D500C027A00AE671DF0F578C182907599A7CB0FD5DCBC29577EBB
          673EBD57092A4EB54560555C1CC04CA86A6B7D0D88862A34F8BC5E389FB4C348
          8C4C88FD2DF3C6E58F3BEA6F63F6BC15879B74B19EDCC88B8BC564BB1D7EC970
          FE6D80A229100CE8767BD0E574D946AF98F368DAB1D30EBDA309D91F2D785CF9
          A07DECC298E8C08CA848F8C0C04D3C08B8ED7040B53BA0E87E68424291129D6D
          AD99EF977C5691F8C94E06BD133FAF5CA796945F9DB62531A9B647D7A152310F
          E1B8E07C0AD6342EF1BA3A296198DFDBABEA5287A26A02561E955C9C15614DF8
          90BEB5170F2BCB51BDEF926760B8C5ABC2C4F450CEAC96D09013D5F517D9C9A9
          495D4B8FCE8E42523CF0DF0048A1933E3AA09B0161A375D0734837A88E622630
          7223AC0BCD67EF2327F74F274B0392678C7CE7C4B65DC9231D0BC601AF224033
          52A108161B877102D03D5C0334377EDFFF17BED8D7D85EFF426C65E9E4FF9B6C
          3167BF6EDC34242B7DB5DD64E6A4A66E54B020C058AA59C0E3D451BADB258BAA
          DC173DC01A0A3C63E994D340F1144AA621F3776F882F9EFAA99FC3DB8B605B3A
          5CA5D50EC2F63C9FBAA7EE793179BE24137DC395D2C56F4C47202159EA075B33
          AE8DCE0933C31B00ACF4FF91A6082890661B3ECF6F7FF9DDA5C65194FE6FFF68
          607F505FA38F4A6386470DD89B523677B36DB2A3AF81D2D0081E6945C85012D8
          2470E5F07DB9A8F072C10BC81FDE002AFBBF5323C09029F177D32A368E671605
          AD6567505854F77278B445167C3DCBF6EEBCB9F0543763FEB25FAE5EF3BC9AFE
          0670EEB54C8C254FD8B5E4566CDE7BBC7A4B090A8E3C7A5827B0660409953290
          9D2ADC313375CCDAC5F826EBA06FC7B93BE349B6B63E4059BF1AE1169E3F3D6F
          E28F676BDBC4CE1A774527904BCB734DA4D83F6404FAE9FB0D23727D1ECEB34F
          3EC825550EF401B6F76BAD9A58FC75932CAED5708FE4FBCA08869219806632F2
          2101C8EE35637973801509C81A23E77FD4BE6AEB2C0888190000000049454E44
          AE426082}
        Name = 'PngImage16'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C000001C44944415478DABD92CB2B44511CC77F487291E68E7B85
          C90CFE021BA52C4429CF85678A2C58C802C54A36F2663576926736281B855858
          7A8E67B9C3CC65664416B29B71CD3D0FE7DE74892152CED99ECFE77BCEF7FCC2
          28A5F09715F6EF829AB932BBAAA2C7E5C6D59E5F0BAA674BED89BCD88A10028F
          CFD7B5D6B635F86341D54C890E67D86C107852C025CB707DE5EDFE91A072BAD8
          2E9A0406A70161FB5CBAD060083EABD186A065B3211F239C3E5E383FF11EAE98
          D2E084D634964CD996182CBB3D18A92876BBD7A1E882968D861C84F0A2993325
          DD3DDCB7CF562ED935B87CB2E815B6B25C0A4EE9D28077FA0E15BDC4E6F5FA02
          963C65135253A222A3C0219D68073A58D316D164EEB46AC91483D3E9822BB757
          8777FB8F14E31B9B566AA309A201731C0FC96212F89F02707B7F0711E111208A
          02D070804B4987095271CCDEC01B6C7C63DD42054730F19BE379B024A7002118
          824405766BB870BAC1E3F65176236E7FF058F958B051222B8B238849781E52AD
          16404CE29264F0C83E8A3478E8E413FC69900AC7F274892024808A54F0CA373A
          7C307C1A120E3989B9FDD91C26C41F548288BD39D63172FAFCDD8C841CA4ACAE
          4C8E25E3C3D1B36FE12F05BF592F295C195A0BA58B2F0000000049454E44AE42
          6082}
        Name = 'PngImage17'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000473424954080808087C0864880000001974455874536F6674776172
          65007777772E696E6B73636170652E6F72679BEE3C1A0000030D4944415478DA
          6D934B48546114C7CF7D7CD33C737414664C534A7CF5D004B50229C2162184A6
          A0E8A2889A4C6D51BB422A6C910B575299BA48C4512BA26C1582154961339284
          3506A6A4A3E6736674661C67EEAB7327AFCCC20B87FBDD7BBEF3FBCEF99FF351
          922481F2E45B6DC92A9669020A4EF182686668DA43513011E6843674BF7574D4
          70517B6FE3AB8D520005565B29C3D0BDB999896C46AA8958E2F400E85BF16EC2
          A8733EF0EBCF2A32A55A84F4175CB359D1D58E61C60800695984A547CB8B8F68
          638D1A60F15893410D3A350B062D010DA161D91B8416DBC826021D06ADAA7023
          1022181A17019CACEBEFCCCDB05CD6A8096D1F774188E381B08C70709F31585C
          7040579865A6189A021AEDE58749F1F4B124FA56EB50184B8B8F004E5CEFF361
          B09EE3454914C5203AEE637A3D688759966ECE4A31653694E769138C5A60192A
          527245E30087FB622300AC5F2484118E66A4768F39A7CF61AD4558EB54946097
          B0AA67AD37CF8244D1901CAF85CABB3240DCD18037C7C73465A725BD9A59585D
          9C9A5DF22040DC0E665986FE58599C5D5075269DF8B7F88836158D6F7804EC55
          00060CF0C12E0FFABAF075D114A3091186FEDF32AC62712DA0C695460184F083
          6CC74851F61EED0A1AB70B9BC543E7764A18682E6364B4FCFDCE312B760E8CB9
          0441CCC54DDEE8A87B3667A23FB095F269746278670E7030107081995E0A00C1
          2CEB5B06E5D31B30F84954293A8AA2A60B73D27AFE2EBBF36716D68AF0B72A02
          385EDB2BBC7E5846A3FA806AC3D4FC3AB4F4D9E5A1F9C9F3A20CB223A04EAD22
          0F4CB186B815F7BA2488223FD256AD52E640E86A2CA187BEB9A492C2544AC07F
          1E7F1886BFCF4B438EE9E0923B80578462655DB025548C6E0FB83782CF3F3FAE
          AA523210D392E342932EF794D9A44FB596E6E91270A47D410EE4B679031CAAEE
          87709807BD86C08BC1F14DBC18F99899531151C2317DF4F569F50D5C57E02DEC
          D86F892139E916BD09A78F661858F76D816BD123387ECC8531FDABF6F61A5BA4
          A3DB806EB9D74894B605935B7A5E45987A51920E613762F16E2CA33E5F4261E1
          0EEEFBAD88FB0FBBD29CE1BBCCA7630000000049454E44AE426082}
        Name = 'PngImage18'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B31
          00000B3101ED4C7E05000002454944415478DA95924B4C13511486FF3BD3E950
          4A4DB194D25790451185DA1823F1016181C68536D185848D893B4358CA4EA9A1
          7B3626C68D468D51231B63860DDA2E04139492106CA371442212AD8A7D3FD269
          CB8C774A65415A8927F973937BCEFFE5DC730F51A0A05E4CDE0E9EA3C7515991
          7D0C435096CAD068393FBD0B5D1D199C566B483D806ACE6CA484F62E07ACBD9D
          28D1B262A2007176B992D7F21AAF0AA90950CD525E12862F1C81799F05CFC522
          7EFE2EC164E4606DD520BA104674E54705520F30E1EC71FAFA4E7622BC5AC04A
          AC84663D8BB6160E4D4D2C0C3C20DC9A01CB6BFDF5004AF7F901885F24B08C0C
          97438B768B161C4B2AD51A2A31BC8EC540A4F60C6E3E98539CA7FB115E4AC0BD
          5F87831D3C783A44D548A8CA54E9581681A9377500F76715FB603FBEAD6570FC
          901E26030BDA354CD57C9AEAEBF7045E3D0BA1DE139E703A6ED8D277025D7616
          FA0682067A6FA6E2AA35F7A6E6918CE76BCC20383431295E09E98C7B8503673C
          B0353360AAADEBAB90B5D50D3C7CFC1A86963D3B7E2138A42E8E10B75EC6A3F9
          4614E5327A077AD0E16AAB407225191FDF7EC2BB85CFE01BF91D7B40CD4A6953
          209204F1FD0AEEAE1F43ABFB923F13CFFACC36630550A09B282BA8B189AAB958
          16486913D10FCB08A43DC85947916359EFD8C82901FF08A2042F6E99E9DF4423
          8B7891398CB4F33A8A486FB5484B68D436139A95A7CF2A8468F12BB284995437
          92F66B283279EF768BBB01E6EE8C2AAE9880972937928E714824BB6DFE0BD8F5
          09E34F7382CD33863C23FBA9F906FE23FE00993906A7EEE06912000000004945
          4E44AE426082}
        Name = 'PngImage19'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B22
          00000B220109E14FA2000002474944415478DA7D924D4C134114C7FFB3DBDDA5
          2D25103E4ABF440E4522ADC4A8C40F9003F1649BE8CD8B8957C3C5443DA935F4
          E6C18BD17850A3C6E8818B31DB0B5A0F82090A2404DB68AC8588448BD67ED0D2
          A6DBD65D67D772A87499E4657767DEEF37B36F1E51A0406FDCBCFBDA471F8764
          450E300C4155AAC2C073413A377FF1FC5848CD217A0215CE2737C49E7E276C43
          7DA8D0B472A684D8F492B6CE0B06BF2A69285061A92889674E1F40E76E2B5EC4
          CAF8F9BB82F6560EB62E0312731124E2EB9A444F30E1F2B802C3C7FA10592921
          9EAAA0CDCCA2BB834373330B8B008877A6C00A7C504FA00C9C1A45ECAB049691
          E176F2E8B1F2E058A2651B68C4226B5808471BD7E0D6E319C575620491C50CBC
          7B8CD8DB2B40A045544142A34A2397DA4478F29D8EE0D1B4E2181BC1F7D53C8E
          EC33A3DDC2829E1AEDB5F51C8D6F3F3278F37C1EBA35E08C5CC03A7C14FD0E16
          E62682263ADF4983ABE53C9C9C45365DDC5E0325E4F3DD4B5EB82CB12DC73DBE
          83B0B731606A4737D724AB2B493C79F616968E96FA5B506162348969DB393C9D
          35A12C573134EA41AFBB5B93142A323EBFFF820F73CB104C427D1FA8300C8248
          2409B18F713C583B8C2EEF597F3EBD2976DA5B35418976A2AC607B276A30CB8B
          A4F207894F4B08E70651B08DA3C0B2419A781D3B0C22874E4E503840E8DD24A2
          0B7899DF8F9CEB2ACAC8F9B776A903D43DFF132884F0F8155DC4D4C600B28E2B
          2833C586F096808E7FEF847ECDDC1F57DC2911AF36BCC83AAF41229BBA7043C1
          FA8D5DBEDBCB1ED13E78094546DE116EF40B7F01ABD801A733FB08D200000000
          49454E44AE426082}
        Name = 'PngImage20'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300000B31
          00000B3101ED4C7E05000002594944415478DA7D935F4853511CC7BF6777FFEF
          A4D93237E730899965362292FE687B88E8A17B217BEA71F42A54443D55930C7A
          287CC8885E8AECA1178924EE48CCF5A03E1829884C0AC690526A19CEE9CCF4EE
          AE9DCE994EB6DA3CF0E31C7EE7F7FDFCFE9C7B090545B9D5D33B22B1EDA8FA5B
          0DEA7404193503CB0E6B17F38D5F0E9C0AF118520EC0C58BB30B4A5D632D5C2D
          0DD058583AB98EE8C854EE5EB45B640E290BB8D7FD965E6C3F82AA3DD578134D
          637E4183C36E806BB71EF18F11C4633F729092009EDDB9D7A9B49E6C4064661D
          B184864A5180739701369B800A13A03C1E84D92E769504743F794F9BCEFB11FD
          A242D065E1AD35A2AEDA08834072D17A66D1C81C26C2D3A567D0F362947ACEB4
          21329944F33E0B0ED49B606243E442C22CC32C95F88570DF07946B81BA4FB7E1
          DBD7151C3F24C2512180550DC7E67D8AD9ECF72486FBC7CB02EEB3ED4675EB09
          34BA0588660233735431336CC63CEF1BC3EA9AF6FF0CE8C005E9D1FC55E84D15
          CAFEB33ED454EAA063FE6BB28C5028B415D779F735767A1CC5AFC0C5C4A85716
          5D01BC1CB3229DCDA0C57F10F55E273C840D906EC412767ED83B5CFC1D7031BB
          5188AA22FA29866773C7E06EB9240FBD7AA0E4331702F8922469630639317B5A
          A2FD41FCF314C2291F565D1D48DBCCF295805FC90BFF5D1C44B203ED77D83948
          D8DBC4A727F06EE530529E5BA096B58D12598EED01A1739410237E4E4F6270B9
          094BEE9BA0A226E77F165992E9B62D8C3EEDA0DE8482A1E5662CD5DE46D6AA6E
          898BB21554C201ACF11C85B72005FB55A5C6771D9A2874317167A9720B2BE199
          95909203FC05035A09BB3BFCDAEE0000000049454E44AE426082}
        Name = 'PngImage21'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300001EC1
          00001EC101C36954530000016F4944415478DA63FCFFFF3F0331E07960A03D90
          3A006233AAAB337C888961D0D4D5656424C6009866E1E666865F57AE30FCBA75
          8B61AF8C0C435872326103165F2CCAE3B8653971FFFEFD0C5D7676603190016D
          B76F33F42E5982DF00A066B0CD6FF6C932282A2A323C78F08021EED327B05CD2
          FAF50C1B2F5CC06D004CB392BE36C3ABF5420C7FFEFC6178FAF4294343430383
          03D03020F0051AB005AB01C89A6F33BC65F0DEF39061DF5B3B8683070F322C5B
          B60C6480EF86F3E7B730323232601880AEF9FD83AB6071A6BF0F19F6877C04DB
          0CD20C8E0D740348D18C6100A99A510CB87F69B9FDA717A70F7C71235E33DC80
          7B1797816DFEFBF30D0313131BC346E1634469463620EFCFF79713653443184E
          6D88639052F763D826B201A6B909A8B91E573A811AB0F2FF9FEFCF1840063CB9
          BE86A134632148AE1B88B702351FC4974AC1069CDF91FFDFD06322C3AD13FD30
          CD85408D13188800600380F47F7F0303B046203E4FC8566C065004000171EA11
          E1862B500000000049454E44AE426082}
        Name = 'PngImage22'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300001EC1
          00001EC101C3695453000002414944415478DA6334C9EC3EF9EDC50F330608F8
          CF8000C86C14F01F2AC7C127B69F5133B0F94FAABF19F333E10286FF20E17F40
          F41FAA0AC8F80FA6192034540C04443F7433ACDA7391016C406B6932F3C28D16
          10038804014EFB197A662E6360D40A6CFEDB5894C07483CD176800F12688BF59
          CD3071EE4A8801B5F9F14C11F6B2C45B0F04D337DD6498B26035C480CA9C58A6
          487B1986478F1E11A55951519161D2BA6B0C3397AC8318509619CD14EFAA4892
          0BFA575D6198B36203C480E2B408A6240F1586FBF7EF13A5594E4E8EA177E515
          86856B36430CC84B0A634AF75123C905AD8BCE312CDBB00D6CC0BFECB810C6B3
          B7DF3070BC3BC570E7DC6EEC3A18A1FE37F060F8CAADC3A022CDC7B06ACB4E88
          01E9D1818C176F3C657872A89FC1C9C98141535393819595158E999898187EFE
          FCC970E9D225869D3B77328899E73128C80833ACDBB107624052B81FE3955BCF
          189E1F9BCC505E56C2B06EDD3A8657AF5E31E4E7E733FCF8F103AC194483F082
          058B18444CB318E4A4841836EDD90F36E07F42882FC395DB4F195E9D98CAD0D8
          58CF50535303766E6E6E2E8A66107BE3A6CD0C22C6190C52E2420CDB0F1E8218
          10E5EFC970EFD14B86A7C7A63214E4E732CC9F3F9F414C4C8CC1C4C404453388
          3E72F4188390611A83B8A800C31E209B51D3B7364F4C88BFC7C6CC98F5CCE62E
          86D898687082FAF3E70F033737378617AE5FBFC1A06C9FCBF0E6C523866B4FDF
          31309AA42EE1F9FAF2561A3B2B63BBE8A7636C0C8CCC0CB00CFB1F4B8E66048A
          BDE2B5F8FE97918D919D4FEA2800C8FF14C7159B363E0000000049454E44AE42
          6082}
        Name = 'PngImage22'
        Background = clWindow
      end
      item
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000774494D45000000000000000973942E000000097048597300001EC1
          00001EC101C36954530000027D4944415478DA8D936F48536114C69FF7CAD458
          592C9DB552D2ECCF444C71591F8A4A0816614B902CA769869AD5B628332B2544
          442821A2ACA4D5A6D9488BE19FA846236DB4615992C37439EBC368A643FC1098
          1B4D6FDEDD728DCDE881C3399C7B9FDFFBBC1F5E222AB9F2E6C7983315AC6878
          F5F7EC23FAF7B7D0307E17116654BB0B25A941D963DDC0EC2CE8B9F2749AEDDE
          DD8C77A66928632468D5F7C303A8397B3468FDA12804C76E0047108D7FE9E7A8
          0D2EEB207A959F51D7A00189CFA89EA93A9D4F6D37DE9C375BCC1F70BBEF13EE
          BFECC683F82888CB2FF841DA138EE0DADD161650A9C8A376F5DCC2A2B8449F1F
          A747CC58515E0B43722C365DACF1D96B8579B8A17EC402CE9FCCA576F736F8C4
          674E61CC0B256859978386662D0B282B9152E2BE3B7E091612934013930DE5C3
          361670A6E820B5B7FF5EC004C6D2626C4C4CF24BD0189585C6C79D2C405E7080
          DAFF51FD5FA7FF91726526346D4F3D80D9138733C97BEB044227DF62A4EF4560
          07615B4C921853DC04C4AD0A43EB131D0B289666907E8B1D5F0D579196B61342
          A1101C0E67BE288A82CBE582D96C864EA7037F8B1C6B562F87F6B99E051464ED
          2303C3A3F866BA8E7365A5D06AB570381C502814703A9D1E33D39952AB9B10BE
          F938A2053C74E8BB3C003A3F331D03563B1C3DF5A8AABA848A8A0A4F5C994CE6
          6366E6F68E4E84A71C8320928767AF0C2C205BB2075F6CE3B09BEA714A21834A
          A5029FCF874824F23133FDB5D1045E7211222396413F3713617AA59CCF5B5AB7
          2D3585F3AEF3327273A4B0D96C70BBDDE072B97E57181AB260ED0E1926C66C18
          B44F82880A9B174F8D0F178570486DC477533048D0FC83A503BC6832B7732CD9
          3A3D4382494898C0F80B8C113FC74A64FEC80000000049454E44AE426082}
        Name = 'PngImage23'
        Background = clWindow
      end>
    Left = 264
    Top = 64
    Bitmap = {}
  end
  object XPManifest: TXPManifest
    Left = 232
    Top = 64
  end
  object FormStorage1: TFormStorage
    UseRegistry = True
    StoredProps.Strings = (
      'miViewTrans.Checked'
      'miViewHandles.Checked'
      'miViewGrid.Checked'
      'miViewFloor.Checked'
      'miViewEnemies.Checked'
      'miViewActiveObjTop.Checked'
      'miView4bo.Checked'
      'miView3bo.Checked'
      'miFreeform.Checked'
      'miFloorinfront.Checked'
      'miROMgfx.Checked'
      'miLimitsize.Checked'
      'miViewToolbar.Checked')
    StoredValues = <>
    Left = 296
    Top = 64
  end
  object ActionList1: TActionList
    Images = ImageList
    Left = 424
    Top = 64
    object OpenROM: TAction
      Category = 'File'
      Caption = 'Open ROM...'
      Hint = 'Open NES or SNES SMB3 ROM'
      ImageIndex = 8
      OnExecute = OpenROMExecute
    end
    object OpenM3L: TAction
      Category = 'File'
      Caption = 'Open M3L...'
      Hint = 'Open a M3L level file'
      ImageIndex = 13
      OnExecute = OpenM3LExecute
    end
    object SaveROM: TAction
      Category = 'File'
      Caption = 'Save ROM'
      Hint = 'Save current ROM'
      ImageIndex = 21
      OnExecute = SaveROMExecute
    end
    object SaveROMAs: TAction
      Category = 'File'
      Caption = 'Save ROM As...'
      Hint = 'Save ROM using another file name'
      ImageIndex = 22
      OnExecute = SaveROMAsExecute
    end
    object SaveM3L: TAction
      Category = 'File'
      Caption = 'Save M3L...'
      Hint = 'Save M3L level file'
      ImageIndex = 13
      OnExecute = SaveM3LExecute
    end
    object SaveToLocation: TAction
      Category = 'File'
      Caption = 'Save Level To...'
      Hint = 'Save current level to a custom ROM location'
      ImageIndex = 4
      OnExecute = SaveToLocationExecute
    end
    object ApplyIPS: TAction
      Category = 'File'
      Caption = 'Apply IPS Patch...'
      Hint = 'Apply an IPS patch to current ROM'
      ImageIndex = 15
      OnExecute = ApplyIPSExecute
    end
    object ExitProgram: TAction
      Category = 'File'
      Caption = 'Exit'
      Hint = 'Close SMB3 Workshop'
      OnExecute = ExitProgramExecute
    end
    object GotoNextArea: TAction
      Category = 'Level'
      Caption = 'Goto Next Area'
      Hint = 'Goto next area pointed from level'
      ImageIndex = 9
      OnExecute = GotoNextAreaExecute
    end
    object SelectLevel: TAction
      Category = 'Level'
      Caption = 'Select Level...'
      Hint = 'Select a level for editing'
      ImageIndex = 13
      ShortCut = 115
      OnExecute = SelectLevelExecute
    end
    object ReloadLevel: TAction
      Category = 'Level'
      Caption = 'Reload Level'
      Hint = 'Reload current level'
      ImageIndex = 16
      OnExecute = ReloadLevelExecute
    end
    object EditHeader: TAction
      Category = 'Level'
      Caption = 'Edit Header'
      Hint = 'Edit level header'
      ImageIndex = 10
      ShortCut = 114
      OnExecute = EditHeaderExecute
    end
    object EditPointers: TAction
      Category = 'Level'
      Caption = 'Edit Pointers'
      Hint = 'Edit pointers used in level'
      ImageIndex = 4
      ShortCut = 8306
      OnExecute = EditPointersExecute
    end
    object EditLevel: TAction
      Category = 'Edit'
      Caption = 'Edit Level'
      Hint = 'Edit level'
      ImageIndex = 13
      OnExecute = EditLevelExecute
    end
    object EditObjDefs: TAction
      Category = 'Edit'
      Caption = 'Edit Obj.Defs'
      Hint = 'Edit Object Definitions'
      ImageIndex = 1
      OnExecute = EditObjDefsExecute
    end
    object EditPalette: TAction
      Category = 'Edit'
      Caption = 'Edit Palette'
      Hint = 'Edit palette'
      ImageIndex = 6
      OnExecute = EditPaletteExecute
    end
    object EditGraphics: TAction
      Category = 'Edit'
      Caption = 'Edit Graphics'
      Hint = 'Edit graphics'
      ImageIndex = 20
      OnExecute = EditGraphicsExecute
    end
    object EditMisc: TAction
      Category = 'Edit'
      Caption = 'Edit Miscellaneous'
      Hint = 'Edit game properties'
      ImageIndex = 3
      OnExecute = EditMiscExecute
    end
    object ObjAdd3Byte: TAction
      Tag = 3
      Category = 'Object'
      Caption = 'Add 3-Byte Object'
      Hint = 'Add a 3-byte object'
      ImageIndex = 0
      OnExecute = ObjAddEnemyExecute
    end
    object ObjAdd4Byte: TAction
      Tag = 4
      Category = 'Object'
      Caption = 'Add 4-Byte Object'
      Hint = 'Add a 4-byte object'
      ImageIndex = 1
      OnExecute = ObjAddEnemyExecute
    end
    object ObjAddEnemy: TAction
      Tag = 2
      Category = 'Object'
      Caption = 'Add Enemy'
      Hint = 'Add an enemy'
      ImageIndex = 2
      OnExecute = ObjAddEnemyExecute
    end
    object ObjClone: TAction
      Category = 'Object'
      Caption = 'Clone Object/Enemy'
      Hint = 'Clone object/enemy'
      ImageIndex = 11
      OnExecute = ObjCloneExecute
    end
    object ObjDelete: TAction
      Category = 'Object'
      Caption = 'Delete Object/Enemy'
      Hint = 'Remove selected object/enemy'
      ImageIndex = 12
      OnExecute = ObjDeleteExecute
    end
    object ViewZoom50: TAction
      Tag = 8
      Category = 'View'
      Caption = 'Zoom To 50%'
      Hint = 'Zoom view to 50%'
      ImageIndex = 17
      OnExecute = ViewZoom100Execute
    end
    object ViewZoom100: TAction
      Tag = 16
      Category = 'View'
      Caption = 'Zoom To 100%'
      Hint = 'Zoom view to 100%'
      ImageIndex = 18
      OnExecute = ViewZoom100Execute
    end
    object ViewZoom200: TAction
      Tag = 32
      Category = 'View'
      Caption = 'Zoom To 200%'
      Hint = 'Zoom view to 200%'
      ImageIndex = 19
      OnExecute = ViewZoom100Execute
    end
  end
end
