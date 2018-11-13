unit mapptr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXSpin;

type
  TfMapPointer = class(TForm)
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    sePtrObjects: TRxSpinEdit;
    sePtrEnemies: TRxSpinEdit;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMapPointer: TfMapPointer;

implementation

{$R *.dfm}

end.
