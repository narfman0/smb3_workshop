object fAbout: TfAbout
  Left = 624
  Top = 175
  AlphaBlendValue = 200
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'About SMB3 Workshop'
  ClientHeight = 297
  ClientWidth = 474
  Color = clBtnFace
  TransparentColorValue = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    474
    297)
  PixelsPerInch = 96
  TextHeight = 13
  object Logo: TImage
    Left = 2
    Top = 256
    Width = 32
    Height = 32
    Proportional = True
    Stretch = True
  end
  object Label1: TLabel
    Left = 43
    Top = 259
    Width = 84
    Height = 13
    Caption = 'SMB3 Workshop '
    Layout = tlCenter
  end
  object JvMemo1: TJvMemo
    Left = 0
    Top = 0
    Width = 474
    Height = 249
    Cursor = crArrow
    AutoSize = False
    MaxLines = 0
    HideCaret = True
    Align = alTop
    Lines.Strings = (
      
        'This program is not endorsed or supported by Nintendo, and the a' +
        'uthor is not affiliated with any other corporate entity.'
      
        'The program is Freeware and provided "as is". The author cannot ' +
        'be held liable for damages of any kind arising from its use or p' +
        'resence.'
      ''
      
        'Portions of code and data files adapted from the source code of ' +
        'Mario3 Improvement, '#169' Lincolnsoft (http://www.lincolnsoft.com/).'
      ''
      
        'ROM graphics/TSA code adapted from SMB3 Level Object TSA Editor,' +
        ' '#169' DahrkDaiz (DahrkDaiz@hotmail.com).'
      ''
      
        'Special thanks to DahrkDaiz and Spinzig for data collecting and ' +
        'testing, and to all others who have helped test and document thi' +
        'ngs.'
      ''
      
        'This program was made using Delphi 7 and uses the following thir' +
        'd-party components:'
      ' - Graphics32 by Alex A. Denisov; http://graphics32.org/'
      ' - TBMSpinEdit by Boian Mitov'
      ' - madExcept by Mathias Rauen; http://www.madshi.net/'
      
        ' - RxLib (D7 port) by Fedor Kozhevnikov, Igor Pavluk, Serge Koro' +
        'lev, (Oleg Fyodorov)'
      ''
      
        'Please consider donating to help motivate me to keep working on ' +
        'this thing!'
      ''
      'Program website: http://hukka.furtopia.org/projects/m3ed/'
      'Author website: http://hukka.furtopia.org'
      'Author email: hukkax@gmail.com')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
    WordWrap = False
  end
  object PngBitBtn1: TPngBitBtn
    Left = 390
    Top = 265
    Width = 80
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
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
