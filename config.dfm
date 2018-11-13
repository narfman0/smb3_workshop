object ConfigForm: TConfigForm
  Left = 248
  Top = 605
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Misc. Game Properties'
  ClientHeight = 247
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    463
    247)
  PixelsPerInch = 96
  TextHeight = 13
  object ConfigList_ExtLabel: TLabel
    Left = 264
    Top = 98
    Width = 93
    Height = 13
    Caption = 'ConfigList_ExtLabel'
  end
  object ConfigList_InfoLabel: TLabel
    Left = 256
    Top = 10
    Width = 201
    Height = 73
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'ConfigList_InfoLabel'
    Layout = tlCenter
    WordWrap = True
  end
  object Label1: TLabel
    Left = 360
    Top = 98
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Bevel1: TBevel
    Left = 256
    Top = 88
    Width = 201
    Height = 9
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 256
    Top = 203
    Width = 201
    Height = 7
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 256
    Top = 184
    Width = 60
    Height = 13
    Caption = 'ROM offset: '
  end
  object Button1: TButton
    Left = 297
    Top = 214
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object ConfigList: TCheckListBox
    Left = 8
    Top = 8
    Width = 241
    Height = 230
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Style = lbOwnerDrawFixed
    TabOrder = 1
    OnClick = ConfigListClick
    OnDrawItem = ConfigListDrawItem
  end
  object ConfigList_Trackbar: TTrackBar
    Left = 256
    Top = 120
    Width = 201
    Height = 33
    TabOrder = 2
    OnChange = ConfigList_TrackbarChange
  end
  object ConfigList_SpinEdit: TRxSpinEdit
    Left = 400
    Top = 95
    Width = 49
    Height = 21
    ButtonKind = bkStandard
    EditorEnabled = False
    ValueType = vtHex
    TabOrder = 3
    OnChange = ConfigList_SpinEditChange
  end
  object Button2: TButton
    Left = 379
    Top = 214
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
