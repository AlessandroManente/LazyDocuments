unit Forms.Main;

interface

uses
  Database.Manager,
  Forms.Login,

  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.CategoryButtons,
  Vcl.Buttons,
  Vcl.Grids,
  Vcl.DBGrids,

  Data.DB,

  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TLazyDocumentsForm = class(TForm)
    SplitView: TSplitView;
    PageCon: TPageControl;
    ActList: TActionList;
    BtnImpostazioni: TSpeedButton;
    BtnAggiungi: TSpeedButton;
    BtnCerca: TSpeedButton;
    TSCerca: TTabSheet;
    TSAggiungi: TTabSheet;
    TSImpostazioni: TTabSheet;
    ActionPCCerca: TAction;
    ActionPCAggiungi: TAction;
    ActionPCImpostazioni: TAction;
    PCercaBase: TPanel;
    PAggiungiBase: TPanel;
    PImpostazioniBase: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ActionPCAggiungiExecute(Sender: TObject);
    procedure ActionPCCercaExecute(Sender: TObject);
    procedure ActionPCImpostazioniExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SetupDaUtente(Utente: Integer);
    procedure SetTSCerca;
    procedure SetTSAggiungi;
    procedure SetTSImpostazioni;
  protected
    procedure ExecQueryCerca(SQL: String);
  public
  end;

var
  LazyDocumentsForm: TLazyDocumentsForm;

implementation

{$R *.dfm}

procedure TLazyDocumentsForm.FormCreate(Sender: TObject);
begin
  inherited;
  SetTSCerca;
end;

procedure TLazyDocumentsForm.SetTSAggiungi;
begin
  PageCon.ActivePage := TSAggiungi;
end;

procedure TLazyDocumentsForm.SetTSCerca;
begin
  PageCon.ActivePage := TSCerca;
end;

procedure TLazyDocumentsForm.SetTSImpostazioni;
begin
  PageCon.ActivePage := TSImpostazioni;
end;

procedure TLazyDocumentsForm.SetupDaUtente(Utente: Integer);
begin
  //
end;

procedure TLazyDocumentsForm.ActionPCAggiungiExecute(Sender: TObject);
begin
  SetTSAggiungi;
end;

procedure TLazyDocumentsForm.ActionPCCercaExecute(Sender: TObject);
begin
  SetTSCerca;
end;

procedure TLazyDocumentsForm.ActionPCImpostazioniExecute(Sender: TObject);
begin
  SetTSImpostazioni;
end;

procedure TLazyDocumentsForm.ExecQueryCerca(SQL: String);
begin
  //
end;

procedure TLazyDocumentsForm.FormShow(Sender: TObject);
var
  Utente: Integer;
begin
  inherited;
  Application.ProcessMessages;
  Utente := EffettuaLogin;
  if Utente > 0 then
    SetupDaUtente(Utente)
  else
    Close;
end;

end.
