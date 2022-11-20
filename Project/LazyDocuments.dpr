program LazyDocuments;

uses
  Vcl.Forms,
  Vcl.Dialogs,
  Main in '..\Units\Forms\Main.pas' {LazyDocumentsForm},
  Database.Manager in '..\Units\Classes\Database.Manager.pas',
  LogIn in '..\Units\Forms\LogIn.pas' {LogInForm},
  Utils.Format in '..\Units\Classes\Utils.Format.pas',
  Database.Query in '..\Units\Classes\Database.Query.pas',
  Database.Query.LogIn in '..\Units\Classes\Database.Query.LogIn.pas',
  Utils.Log in '..\Units\Classes\Utils.Log.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLazyDocumentsForm, LazyDocumentsForm);
  Application.Run;
end.