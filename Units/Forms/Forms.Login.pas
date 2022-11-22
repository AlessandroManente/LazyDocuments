unit Forms.Login;

interface

uses
  Database.Query.User,
  Utils.Log,

  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ActnList,
  Vcl.ComCtrls,

  Data.DB,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TLogInForm = class(TForm)
    LTitle: TLabel;
    PBottom: TPanel;
    PLeft: TPanel;
    PRight: TPanel;
    PCentral: TPanel;
    PTop: TPanel;
    LPassword: TLabel;
    EUsername: TEdit;
    LUsername: TLabel;
    EPassword: TEdit;
    PDatiAccedi: TPanel;
    PCentralDown: TPanel;
    CBRicordami: TCheckBox;
    PCheck: TPanel;
    PBtns: TPanel;
    SBAccedi: TSpeedButton;
    SBEsci: TSpeedButton;
    ActionList: TActionList;
    ActionEsci: TAction;
    ActionAccedi: TAction;
    PBase: TPanel;
    PC: TPageControl;
    TSAccedi: TTabSheet;
    TSCrea: TTabSheet;
    PCentralCrea: TPanel;
    PDatiCrea: TPanel;
    LPasswordCrea1: TLabel;
    LUsernameCrea: TLabel;
    EUsernameCrea: TEdit;
    EPasswordCrea1: TEdit;
    PCentralDownCrea: TPanel;
    PCheckCrea: TPanel;
    CBRicordamiCrea: TCheckBox;
    PBtnsCrea: TPanel;
    SBCrea: TSpeedButton;
    SBEsciCrea: TSpeedButton;
    EPasswordCrea2: TEdit;
    LPasswordCrea2: TLabel;
    ActionCrea: TAction;
    LOpAccedi: TLabel;
    LOpCrea: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ActionAccediExecute(Sender: TObject);
    procedure ActionCreaExecute(Sender: TObject);
    procedure ActionEsciExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FIUser: IQueryUser;
    procedure CaricaDatiUtenteAccedi;
    procedure SetIUser(const Value: IQueryUser);
  protected
    property IUser: IQueryUser read FIUser write SetIUser;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure ImpostaLogin;
  end;

const
  tcm_AdjustRect = 4904;

var
  LogInForm: TLogInForm;

function EffettuaLogin: Boolean;

implementation

function EffettuaLogin: Boolean;
var
  LI: TLogInForm;
begin
  LI := TLogInForm.Create(nil);
  try
    LI.ImpostaLogin;
    Result := LI.ShowModal > 0;
  finally
    LI.Free;
  end;
end;

{ TLogInForm }

{$R *.dfm}

procedure TLogInForm.FormCreate(Sender: TObject);
begin
  inherited;
  FIUser := GetIQueryUser;
  IUser.EliminaUtenteCorrente;
end;

procedure TLogInForm.ActionAccediExecute(Sender: TObject);
const
  MName = 'ActionAccediExecute';
var
  UserID: Integer;
  Msg: String;
  OK: Boolean;
begin
  OK := False;
  if EUsername.Text = '' then
    Msg := 'Inserisci un username'
  else if EPassword.Text = '' then
    Msg := 'Inserisci una password'
  else if not IUser.GetDatiUtenteDaUserPass(EUsername.Text, EPassword.Text, UserID) then
    Msg := 'Impossibile trovare utente'
  else if UserID = 0 then
    Msg := 'Utente corrente non esiste o la password inserita non è corretta'
  else
    begin
      OK := True;
      IUser.CreaLogInEvent(UserID, CBRicordami.Checked);
      IUser.ImpostaUtenteCorrente(UserID);
      Msg := 'Utente trovato e impostato come utente corrente';
    end;
  Logger.AddLog(Self.ClassName, MName, Msg);
  if not OK then
    ShowMessage(Msg)
  else
    ModalResult := UserID;
end;

procedure TLogInForm.ActionCreaExecute(Sender: TObject);
const
  MName = 'ActionCreaExecute';
var
  UserID: Integer;
  Msg: String;
  OK: Boolean;
begin
  OK := False;
  if EUsernameCrea.Text = '' then
    Msg := 'Inserisci un username'
  else if EPasswordCrea1.Text = '' then
    Msg := 'Inserisci una password'
  else if EPasswordCrea2.Text = '' then
    Msg := 'Inserisci la password di conferma'
  else if EPasswordCrea1.Text <> EPasswordCrea2.Text then
    Msg := 'Le due password inserite non coincidono'
  else if not IUser.CreaUtente(EUsernameCrea.Text, EPasswordCrea1.Text, UserID) then
    Msg := 'Impossibile creare l''utente'
  else if UserID = -1 then
    Msg := 'Utente non creato'
  else
    begin
      IUser.CreaLogInEvent(UserID, CBRicordamiCrea.Checked);
      IUser.ImpostaUtenteCorrente(UserID);
      Msg := 'Utente creato correttamente';
    end;
  Logger.AddLog(Self.ClassName, MName, Msg);
  if not OK then
    ShowMessage(Msg)
  else
    ModalResult := UserID;
end;

procedure TLogInForm.ActionEsciExecute(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TLogInForm.CaricaDatiUtenteAccedi;
const
  MName = 'CaricaDatiUtenteAccedi';
var
  UserID: Integer;
  Username, Password: String;
  Msg: String;
begin
  if not  IUser.UtenteUltimoEvento(UserID) then
    Msg := 'Impossibile ottenere dati su ultimi eventi di login'
  else if (UserID > 0) and IUser.GetDatiUtenteDaID(UserID, Username, Password) then
    begin
      EUsername.Text := Username;
      EPassword.Text := Password;
      CBRicordami.Checked := True;
      Msg := 'Dati utente ultimo evento caricati';
    end;
  Logger.AddLog(Self.ClassName, MName, Msg);
end;

procedure TLogInForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TLogInForm.FormResize(Sender: TObject);
begin
  //
end;

procedure TLogInForm.ImpostaLogin;
begin
  if not IUser.UtentiPresenti then
    PC.ActivePage := TSCrea
  else
    begin
      PC.ActivePage := TSAccedi;
      CaricaDatiUtenteAccedi;
    end;
end;

procedure TLogInForm.SetIUser(const Value: IQueryUser);
begin
  FIUser := Value;
end;

end.
