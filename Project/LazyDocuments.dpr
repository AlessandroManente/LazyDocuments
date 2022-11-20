program LazyDocuments;

uses
  Vcl.Forms,
  Vcl.Dialogs,
  Forms.Main in '..\Units\Forms\Forms.Main.pas' {LazyDocumentsForm},
  Database.Manager in '..\Units\Classes\Database.Manager.pas',
  Forms.Login in '..\Units\Forms\Forms.Login.pas' {LogInForm},
  Utils.Format in '..\Units\Classes\Utils.Format.pas',
  Database.Query in '..\Units\Classes\Database.Query.pas',
  Database.Query.User in '..\Units\Classes\Database.Query.User.pas',
  Utils.Log in '..\Units\Classes\Utils.Log.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLazyDocumentsForm, LazyDocumentsForm);
  Application.Run;
end.
