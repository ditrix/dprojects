program Mdiapp;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Scripts in 'Scripts.pas',
  fixDBF in 'fixDBF.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
