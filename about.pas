unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvExStdCtrls, JvMemo, Buttons, PngBitBtn;

type
  TfAbout = class(TForm)
    Logo: TImage;
    Label1: TLabel;
    JvMemo1: TJvMemo;
    PngBitBtn1: TPngBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

implementation

{$R *.dfm}

procedure TfAbout.FormShow(Sender: TObject);
begin
	Logo.Picture.Icon.Assign(Application.Icon);
	JvMemo1.WordWrap := True;
end;

end.
