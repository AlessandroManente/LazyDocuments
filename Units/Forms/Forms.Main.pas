unit Forms.Main;

interface

uses
  Database.Manager,
  Database.Query.User,
  Utils.Log,

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
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionPCAggiungiExecute(Sender: TObject);
    procedure ActionPCCercaExecute(Sender: TObject);
    procedure ActionPCImpostazioniExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIUser: IQueryUser;
    FUserID: Integer;
    procedure SetTSCerca;
    procedure SetTSAggiungi;
    procedure SetTSImpostazioni;
    procedure LoadData;
    procedure SetIUser(const Value: IQueryUser);
    procedure SetUserID(const Value: Integer);
  protected
    property IUser: IQueryUser read FIUser write SetIUser;
    property UserID: Integer read FUserID write SetUserID;
  public
    procedure SetupDaUtente(Utente: Integer);
  end;

var
  LazyDocumentsForm: TLazyDocumentsForm;

implementation

{$R *.dfm}

procedure TLazyDocumentsForm.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TLazyDocumentsForm.FormCreate(Sender: TObject);
begin
  inherited;
  FIUser := GetIQueryUser;
end;

procedure TLazyDocumentsForm.SetIUser(const Value: IQueryUser);
begin
  FIUser := Value;
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

procedure TLazyDocumentsForm.SetUserID(const Value: Integer);
begin
  FUserID := Value;
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

procedure TLazyDocumentsForm.FormShow(Sender: TObject);
begin
  inherited;
  LoadData;
end;

procedure TLazyDocumentsForm.LoadData;
const
  MName = 'LoadData';
var
  Msg: String;
begin
  if not IUser.GetUtenteCorrente(FUserID) then
    begin
      Msg := 'Utente corrente non trovato.' + sLineBreak +
        'Il programma si chiuderà premendo OK. Riprovare l''accesso';
      ShowMessage(Msg);
      Logger.AddLog(Self.ClassName, MName, Msg);
      Close;
    end
  else if UserID <= 0 then
    begin
      Msg := 'Utente corrente non valido.' + sLineBreak +
        'Il programma si chiuderà premendo OK. Riprovare l''accesso';
      ShowMessage(Msg);
      Logger.AddLog(Self.ClassName, MName, Msg);
      Close;
    end
  else
    begin

    end;
end;

end.
