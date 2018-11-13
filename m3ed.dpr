program m3ed;

uses
  madExcept,
  Forms,
  main in 'main.pas' {MainForm},
  levelsel in 'levelsel.pas' {fSelectLevel},
  drawobjs in 'drawobjs.pas',
  tsa in 'tsa.pas',
  about in 'about.pas' {fAbout},
  headered in 'headered.pas' {fHeader},
  ptredit in 'ptredit.pas' {fPointer},
  paletted in 'paletted.pas' {fPalette},
  config in 'config.pas' {ConfigForm},
  mapptr in 'mapptr.pas' {fMapPointer},
  gfxeditor in 'gfxeditor.pas' {fGfxEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfSelectLevel, fSelectLevel);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfHeader, fHeader);
  Application.CreateForm(TfPointer, fPointer);
  Application.CreateForm(TfPalette, fPalette);
  Application.CreateForm(TConfigForm, ConfigForm);
  Application.CreateForm(TfMapPointer, fMapPointer);
  Application.CreateForm(TfGfxEdit, fGfxEdit);
  Application.Run;
end.
