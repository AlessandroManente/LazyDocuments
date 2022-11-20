unit Forms.Login;

interface

uses
  Database.Query.User,

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
  public
    procedure ImpostaLogin;
  end;

const
  tcm_AdjustRect = 4904;

var
  LogInForm: TLogInForm;

function EffettuaLogin: Integer;

implementation

function EffettuaLogin: Integer;
var
  LI: TLogInForm;
begin
  LI := TLogInForm.Create(nil);
  try
    LI.ImpostaLogin;
    Result := LI.ShowModal;
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
end;

procedure TLogInForm.ActionAccediExecute(Sender: TObject);
var
  UserID: Integer;
begin
  if EUsername.Text = '' then
    ShowMessage('Inserisci un username')
  else if EPassword.Text = '' then
    ShowMessage('Inserisci una password')
  else
    begin
      UserID := IUser.GetDatiUtenteDaUserPass(EUsername.Text, EPassword.Text);
      if UserID > 0 then
        begin
          IUser.CreaLogInEvent(UserID, CBRicordami.Checked);
          ModalResult := UserID;
        end
    end;
end;

procedure TLogInForm.ActionCreaExecute(Sender: TObject);
var
  UserID: Integer;
begin
  if EUsernameCrea.Text = '' then
    ShowMessage('Inserisci un username')
  else if EPasswordCrea1.Text = '' then
    ShowMessage('Inserisci una password')
  else if EPasswordCrea2.Text = '' then
    ShowMessage('Inserisci la password di conferma')
  else if EPasswordCrea1.Text <> EPasswordCrea2.Text then
    ShowMessage('Le due password inserite non coincidono')
  else
    begin
      UserID := IUser.CreaUtente(EUsernameCrea.Text, EPasswordCrea1.Text);
      if UserID > -1 then
        begin
          IUser.CreaLogInEvent(UserID, CBRicordamiCrea.Checked);
          ModalResult := UserID;
        end;
    end
end;

procedure TLogInForm.ActionEsciExecute(Sender: TObject);
begin
  ModalResult := -1;
end;

procedure TLogInForm.CaricaDatiUtenteAccedi;
var
  UserID: Integer;
  Username, Password: String;
begin
  UserID := IUser.UtenteUltimoEvento;
  if (UserID > 0) and IUser.GetDatiUtenteDaID(UserID, Username, Password) then
    begin
      EUsername.Text := Username;
      EPassword.Text := Password;
      CBRicordami.Checked := True;
    end;
end;

procedure TLogInForm.FormResize(Sender: TObject);
begin
  //
end;

procedure TLogInForm.ImpostaLogin;
begin
  if IUser.UtentiPresenti > 0 then
    begin
      PC.ActivePage := TSAccedi;
      CaricaDatiUtenteAccedi;
    end
  else
    PC.ActivePage := TSCrea;
end;

procedure TLogInForm.SetIUser(const Value: IQueryUser);
begin
  FIUser := Value;
end;

end.
