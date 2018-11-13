object fSelectLevel: TfSelectLevel
  Left = 744
  Top = 156
  Width = 311
  Height = 292
  Caption = 'Level/Offset Selector'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    303
    265)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 6
    Width = 28
    Height = 13
    Caption = 'World'
    Transparent = True
  end
  object Label2: TLabel
    Left = 104
    Top = 6
    Width = 26
    Height = 13
    Caption = 'Level'
    Transparent = True
  end
  object Label3: TLabel
    Left = 104
    Top = 163
    Width = 55
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Object data'
    Transparent = True
  end
  object Label4: TLabel
    Left = 8
    Top = 163
    Width = 56
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Enemy data'
    Transparent = True
  end
  object Label5: TLabel
    Left = 8
    Top = 209
    Width = 89
    Height = 24
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Object set:'
    Transparent = True
  end
  object ListBox1: TListBox
    Left = 8
    Top = 23
    Width = 89
    Height = 136
    Anchors = [akLeft, akTop, akBottom]
    ExtendedSelect = False
    ItemHeight = 13
    Items.Strings = (
      'World Maps'
      'World 1'
      'World 2'
      'World 3'
      'World 4'
      'World 5'
      'World 6'
      'World 7'
      'World 8'
      'Lost Levels')
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object ListBox2: TListBox
    Left = 104
    Top = 23
    Width = 190
    Height = 136
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox2Click
    OnDblClick = ListBox2DblClick
  end
  object bCancel: TButton
    Left = 222
    Top = 233
    Width = 75
    Height = 27
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object seOffset: TRxSpinEdit
    Left = 104
    Top = 180
    Width = 193
    Height = 21
    ButtonKind = bkStandard
    ValueType = vtHex
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
  end
  object seEnemy: TRxSpinEdit
    Left = 8
    Top = 180
    Width = 89
    Height = 21
    ButtonKind = bkStandard
    ValueType = vtHex
    Anchors = [akLeft, akBottom]
    TabOrder = 4
  end
  object cbObjectSet: TComboBox
    Left = 104
    Top = 206
    Width = 193
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 5
    Items.Strings = (
      '1 Plains'
      '2 Dungeon'
      '3 Hilly'
      '4 Sky'
      '5 Piranha Plant'
      '6 Water'
      '7 Mushroom'
      '8 Pipe'
      '9 Desert'
      'A Ship'
      'B Giant'
      'C Ice'
      'D Cloudy'
      'E Underground'
      'F Spade Bonus')
  end
  object bOK: TPngBitBtn
    Left = 132
    Top = 233
    Width = 80
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
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
  end
end
