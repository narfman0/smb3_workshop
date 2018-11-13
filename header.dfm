object fHeader: TfHeader
  Left = 185
  Top = 269
  Width = 434
  Height = 257
  Caption = 'Edit level header'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    424
    228)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 6
    Top = 8
    Width = 410
    Height = 182
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
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
        object ComboBox3: TComboBox
          Left = 16
          Top = 88
          Width = 153
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'ComboBox3'
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
        object ComboBox4: TComboBox
          Left = 16
          Top = 88
          Width = 153
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'ComboBox4'
        end
        object ComboBox5: TComboBox
          Left = 104
          Top = 16
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            '1'
            '7'
            '8'
            'D')
        end
        object ComboBox6: TComboBox
          Left = 104
          Top = 40
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
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
    object TabSheet2: TTabSheet
      Caption = 'Visual'
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 105
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
          Top = 60
          Width = 70
          Height = 13
          Caption = 'Enemy palette:'
        end
      end
      object GroupBox4: TGroupBox
        Left = 208
        Top = 8
        Width = 185
        Height = 105
        Caption = 'GroupBox4'
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 28
          Width = 57
          Height = 13
          Caption = 'Graphic set:'
        end
        object Label4: TLabel
          Left = 16
          Top = 60
          Width = 31
          Height = 13
          Caption = 'Music:'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Miscellaneous'
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 105
        Caption = 'GroupBox5'
        TabOrder = 0
        object Label5: TLabel
          Left = 16
          Top = 22
          Width = 36
          Height = 13
          Caption = 'Length:'
        end
        object Label6: TLabel
          Left = 16
          Top = 54
          Width = 26
          Height = 13
          Caption = 'Time:'
        end
        object ComboBox2: TComboBox
          Left = 16
          Top = 72
          Width = 153
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'ComboBox2'
        end
      end
      object GroupBox6: TGroupBox
        Left = 208
        Top = 8
        Width = 185
        Height = 105
        Caption = 'GroupBox6'
        TabOrder = 1
        object Label7: TLabel
          Left = 16
          Top = 22
          Width = 43
          Height = 13
          Caption = 'Scrolling:'
        end
        object CheckBox1: TCheckBox
          Left = 16
          Top = 78
          Width = 153
          Height = 17
          Caption = 'Entering pipe ends level'
          TabOrder = 0
        end
        object ComboBox1: TComboBox
          Left = 16
          Top = 40
          Width = 153
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          Text = 'ComboBox1'
        end
      end
    end
  end
  object Button1: TButton
    Left = 341
    Top = 197
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
