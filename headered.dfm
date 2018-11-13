object fHeader: TfHeader
  Left = 200
  Top = 358
  BorderStyle = bsSingle
  Caption = 'Level Header Editor'
  ClientHeight = 212
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    425
    212)
  PixelsPerInch = 96
  TextHeight = 13
  object lHeader: TLabel
    Left = 9
    Top = 186
    Width = 56
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'lHeader'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    OnDblClick = lHeaderDblClick
  end
  object PageControl1: TPageControl
    Left = 6
    Top = 8
    Width = 411
    Height = 166
    ActivePage = TabSheet2
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Visual'
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 169
        Height = 121
        Caption = 'Palettes'
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 28
          Width = 64
          Height = 13
          Caption = 'Level palette:'
        end
        object Label2: TLabel
          Left = 16
          Top = 92
          Width = 70
          Height = 13
          Caption = 'Enemy palette:'
        end
        object sePalEnemy: TRxSpinEdit
          Left = 96
          Top = 88
          Width = 57
          Height = 21
          ButtonKind = bkStandard
          MaxValue = 3.000000000000000000
          MaxLength = 1
          TabOrder = 0
          OnChange = HeaderChanged
        end
        object sePalLevel: TRxSpinEdit
          Left = 96
          Top = 24
          Width = 57
          Height = 21
          ButtonKind = bkStandard
          MaxValue = 7.000000000000000000
          MaxLength = 1
          TabOrder = 1
          OnChange = HeaderChanged
        end
      end
      object GroupBox4: TGroupBox
        Left = 192
        Top = 8
        Width = 201
        Height = 121
        Caption = 'Misc'
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 20
          Width = 57
          Height = 13
          Caption = 'Graphic set:'
        end
        object Label4: TLabel
          Left = 16
          Top = 68
          Width = 31
          Height = 13
          Caption = 'Music:'
        end
        object cGraphicSet: TComboBox
          Left = 16
          Top = 40
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = HeaderChanged
          Items.Strings = (
            'Mario graphics (1)'
            'Plain'
            'Fortress'
            'Underground (1)'
            'Sky'
            'Pipe/Water (1, Piranha Plant)'
            'Pipe/Water (2, Water)'
            'Mushroom house (1)'
            'Pipe/Water (3, Pipe)'
            'Desert'
            'Ship'
            'Giant'
            'Ice'
            'Clouds'
            'Underground (2)'
            'Spade bonus room'
            'Spade bonus'
            'Mushroom house (2)'
            'Pipe/Water (4)'
            'Hills'
            'Plain 2'
            'Tank'
            'Castle'
            'Mario graphics (2)'
            'Animated graphics (1)'
            'Animated graphics (2)'
            'Animated graphics (3)'
            'Animated graphics (4)'
            'Animated graphics (P-Switch)'
            'Game font/Course Clear graphics'
            'Animated graphics (5)'
            'Animated graphics (6)')
        end
        object cMusic: TComboBox
          Left = 16
          Top = 88
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = HeaderChanged
          Items.Strings = (
            'Plain level'
            'Underground'
            'Water level'
            'Fortress'
            'Boss'
            'Ship'
            'Battle'
            'P-Switch/Mushroom house (1)'
            'Hilly level'
            'Castle room'
            'Clouds/Sky'
            'P-Switch/Mushroom house (2)'
            'No music'
            'P-Switch/Mushroom house (1)'
            'No music'
            'World 7 map')
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Next area/Start'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 121
        Caption = 'Pointer for next area of level'
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
          Left = 88
          Top = 64
          Width = 58
          Height = 13
          Caption = 'Offset range'
        end
        object cObjectSet: TComboBox
          Left = 16
          Top = 88
          Width = 153
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = HeaderChanged
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
        end
        object sePtrObjects: TRxSpinEdit
          Left = 88
          Top = 16
          Width = 81
          Height = 21
          ButtonKind = bkStandard
          ValueType = vtHex
          TabOrder = 1
          OnChange = HeaderChanged
        end
        object sePtrEnemies: TRxSpinEdit
          Left = 88
          Top = 40
          Width = 81
          Height = 21
          ButtonKind = bkStandard
          ValueType = vtHex
          TabOrder = 2
          OnChange = HeaderChanged
        end
      end
      object GroupBox2: TGroupBox
        Left = 208
        Top = 8
        Width = 185
        Height = 121
        Caption = 'Level start'
        TabOrder = 1
        object Label11: TLabel
          Left = 16
          Top = 20
          Width = 50
          Height = 13
          Caption = 'Horizontal:'
        end
        object Label12: TLabel
          Left = 16
          Top = 44
          Width = 38
          Height = 13
          Caption = 'Vertical:'
        end
        object Label13: TLabel
          Left = 16
          Top = 68
          Width = 33
          Height = 13
          Caption = 'Action:'
        end
        object cStartAction: TComboBox
          Left = 16
          Top = 88
          Width = 153
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = HeaderChanged
          Items.Strings = (
            'None'
            'Sliding'
            'Coming up of pipe (upwards)'
            'Coming up of pipe (downwards)'
            'Coming up of pipe (leftwards)'
            'Coming up of pipe (rightwards)'
            'Running and climbing up ship'
            'Ship autoscrolling')
        end
        object cStartX: TComboBox
          Left = 112
          Top = 16
          Width = 57
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = HeaderChanged
          Items.Strings = (
            '01'
            '07'
            '08'
            '0D')
        end
        object cStartY: TComboBox
          Left = 112
          Top = 40
          Width = 57
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          OnChange = HeaderChanged
          Items.Strings = (
            '01'
            '05'
            '08'
            '0C'
            '10'
            '14'
            '17'
            '18')
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Miscellaneous'
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 169
        Height = 121
        Caption = 'Misc 2'
        TabOrder = 0
        object Label5: TLabel
          Left = 16
          Top = 28
          Width = 61
          Height = 13
          Caption = 'Level length:'
        end
        object seLength: TRxSpinEdit
          Left = 96
          Top = 24
          Width = 57
          Height = 21
          ButtonKind = bkStandard
          EditorEnabled = False
          Increment = 16.000000000000000000
          MaxValue = 255.000000000000000000
          MinValue = 15.000000000000000000
          ValueType = vtHex
          Value = 15.000000000000000000
          TabOrder = 0
          OnChange = HeaderChanged
        end
        object cbPipeEnds: TCheckBox
          Left = 16
          Top = 88
          Width = 145
          Height = 17
          Caption = 'Entering pipe ends level'
          TabOrder = 1
          OnClick = HeaderChanged
        end
      end
      object GroupBox6: TGroupBox
        Left = 192
        Top = 8
        Width = 201
        Height = 121
        Caption = 'Misc 3'
        TabOrder = 1
        object Label7: TLabel
          Left = 16
          Top = 20
          Width = 66
          Height = 13
          Caption = 'Scrolling type:'
        end
        object Label6: TLabel
          Left = 16
          Top = 68
          Width = 26
          Height = 13
          Caption = 'Time:'
        end
        object cScrolling: TComboBox
          Left = 16
          Top = 40
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = HeaderChanged
          Items.Strings = (
            'Horiz., scrolls up when flying'
            'Horizontal scrolling (1)'
            'Free scrolling'
            'Horizontal scrolling (2)'
            'Vertical only (1)'
            'Horizontal scrolling (3)'
            'Vertical only (2)'
            'Horizontal scrolling (4)')
        end
        object cTime: TComboBox
          Left = 16
          Top = 88
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = HeaderChanged
          Items.Strings = (
            '300'
            '400'
            '200'
            'Unlimited')
        end
      end
    end
  end
  object Button2: TButton
    Left = 342
    Top = 180
    Width = 75
    Height = 27
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object PngBitBtn1: TPngBitBtn
    Left = 258
    Top = 180
    Width = 75
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
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
