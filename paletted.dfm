object fPalette: TfPalette
  Left = 816
  Top = 131
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Palette Editor'
  ClientHeight = 221
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 6
    Top = 104
    Width = 269
    Height = 81
  end
  object Bevel2: TBevel
    Left = 6
    Top = 24
    Width = 269
    Height = 57
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 57
    Height = 13
    Caption = 'NES palette'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 67
    Height = 13
    Caption = 'Colorset editor'
  end
  object SpeedButton1: TSpeedButton
    Left = 8
    Top = 192
    Width = 70
    Height = 25
    Hint = 'Load colorset from another ROM...'
    Caption = 'Load...'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FF078DBE
      078DBE078DBE078DBE078DBE078DBE078DBE078DBE078DBE078DBE078DBE078D
      BE078DBEFF00FFFF00FF078DBE25A1D172C7E785D7FA66CDF965CDF965CDF965
      CDF965CDF865CDF965CDF866CEF939ADD8078DBEFF00FFFF00FF078DBE4CBCE7
      39A8D1A0E2FB6FD4FA6FD4F96ED4FA6FD4F96FD4FA6FD4FA6FD4FA6ED4F93EB1
      D984D7EB078DBEFF00FF078DBE72D6FA078DBEAEEAFC79DCFB79DCFB79DCFB79
      DCFB79DCFB7ADCFB79DCFA79DCFA44B5D9AEF1F9078DBEFF00FF078DBE79DDFB
      1899C79ADFF392E7FB84E4FB83E4FC83E4FC84E4FC83E4FC83E4FB84E5FC48B9
      DAB3F4F9078DBEFF00FF078DBE82E3FC43B7DC65C3E0ACF0FD8DEBFC8DEBFC8D
      EBFD8DEBFD8DEBFC8DEBFD0C85184CBBDAB6F7F96DCAE0078DBE078DBE8AEAFC
      77DCF3229CC6FDFFFFC8F7FEC9F7FEC9F7FEC9F7FEC8F7FE0C85183CBC5D0C85
      18DEF9FBD6F6F9078DBE078DBE93F0FE93F0FD1697C5078DBE078DBE078DBE07
      8DBE078DBE0C851852D97F62ED9741C4650C8518078DBE078DBE078DBE9BF5FE
      9AF6FE9AF6FE9BF5FD9BF6FE9AF6FE9BF5FE0C851846CE6C59E48858E18861EB
      9440C1650C8518FF00FF078DBEFEFEFEA0FBFFA0FBFEA0FBFEA1FAFEA1FBFE0C
      85180C85180C85180C851856E18447CD6E0C85180C85180C8518FF00FF078DBE
      FEFEFEA5FEFFA5FEFFA5FEFF078CB643B7DC43B7DC43B7DC0C85184EDD7936BA
      540C8518FF00FFFF00FFFF00FFFF00FF078DBE078DBE078DBE078DBEFF00FFFF
      00FFFF00FFFF00FF0C851840D0650C8518FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C85182AB7432DBA490C85
      18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FF0C851821B5380C8518FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF0C85180C85180C85180C8518FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C85180C85180C
      85180C8518FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton1Click
  end
  object cbColorSet: TComboBox
    Left = 132
    Top = 32
    Width = 137
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbColorSetChange
    Items.Strings = (
      'Level colorset 0'
      'Level colorset 1'
      'Level colorset 2'
      'Level colorset 3'
      'Level colorset 4'
      'Level colorset 5'
      'Level colorset 6'
      'Level colorset 7')
  end
  object pbColorSet: TPaintBox32
    Left = 12
    Top = 57
    Width = 256
    Height = 16
    TabOrder = 1
    OnMouseDown = pbColorSetMouseDown
  end
  object pbPalette: TPaintBox32
    Left = 12
    Top = 112
    Width = 256
    Height = 64
    TabOrder = 2
    OnMouseDown = pbPaletteMouseDown
  end
  object cbObjectSet: TComboBox
    Left = 12
    Top = 32
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 3
    Text = 'Object set 1'
    OnChange = cbColorSetChange
    Items.Strings = (
      'World maps'
      'Object set 1'
      'Object set 2'
      'Object set 3'
      'Object set 4'
      'Object set 5'
      'Object set 6'
      'Object set 7'
      'Object set 8'
      'Object set 9'
      'Object set A'
      'Object set B'
      'Object set C'
      'Object set D'
      'Object set E'
      'Object set F')
  end
  object Button1: TButton
    Left = 116
    Top = 192
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 198
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 5
    OnClick = Button3Click
  end
end
