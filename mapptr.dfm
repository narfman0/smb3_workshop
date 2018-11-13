object fMapPointer: TfMapPointer
  Left = 538
  Top = 147
  BorderStyle = bsSingle
  Caption = 'Map pointer properties'
  ClientHeight = 239
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 285
    Height = 185
    TabOrder = 0
    object Label8: TLabel
      Left = 16
      Top = 20
      Width = 39
      Height = 13
      Caption = 'Objects:'
    end
    object Label9: TLabel
      Left = 16
      Top = 44
      Width = 43
      Height = 13
      Caption = 'Enemies:'
    end
    object Label10: TLabel
      Left = 16
      Top = 68
      Width = 51
      Height = 13
      Caption = 'Object set:'
    end
    object Label14: TLabel
      Left = 176
      Top = 20
      Width = 58
      Height = 13
      Caption = 'Offset range'
    end
    object Label1: TLabel
      Left = 176
      Top = 44
      Width = 58
      Height = 13
      Caption = 'Offset range'
    end
    object sePtrObjects: TRxSpinEdit
      Left = 88
      Top = 16
      Width = 81
      Height = 21
      ButtonKind = bkStandard
      ValueType = vtHex
      TabOrder = 0
    end
    object sePtrEnemies: TRxSpinEdit
      Left = 88
      Top = 40
      Width = 81
      Height = 21
      ButtonKind = bkStandard
      ValueType = vtHex
      TabOrder = 1
    end
    object ListBox1: TListBox
      Left = 88
      Top = 72
      Width = 177
      Height = 97
      ItemHeight = 13
      Items.Strings = (
        '0 - World Map'
        '1 - Plain'
        '2 - Fortress'
        '3 - Hills'
        '4 - Sky'
        '5 - Piranha Plant'
        '6 - Water'
        '7 - Mushroom'
        '8 - Pipe'
        '9 - Desert'
        'A - Ship'
        'B - Giant'
        'C - Ice'
        'D - Clouds'
        'E - Underground'
        'F - Spade Bonus')
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 133
    Top = 204
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 221
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
