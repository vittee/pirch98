program pirch98;

{%ToDo 'pirch98.todo'}

uses
  Windows,
  Forms,
  Main in 'Main.pas' {MainForm},
  Utils in 'Utils.pas';

{$R *.res}
{$R bitmaps.RES}

begin
  Application.Initialize;
  Application.Title := 'PIRCH98';
  Application.HelpFile := 'pirch98.hlp';
  Application.CreateForm(TMainForm, MainForm);
  // TODO: TIrcMediaPlayer
  // TODO: TUrlCatcher
  // TODO: TIdentServerForm
  
  if MainForm.ShowTips then
  begin
    MainForm.HelpTipsClick(nil);
  end;

  // TODO: GetLastError
  
  PostMessage(MainForm.Handle, $801, 0, 0);
  Application.ProcessMessages;
  Application.Run;
end.
