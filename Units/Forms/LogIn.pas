unit LogIn;

interface

uses
  Database.Manager,
  Utils.Format,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  System.Actions,
  Vcl.ActnList,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.ComCtrls;

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
    Query: TFDQuery;
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
    FOldTabProc: TWndMethod;
    procedure TabWndProc(var Msg: TMessage);
    function UtentiPresenti: Integer;
    procedure CaricaDatiUtenteAccedi;
    function UtenteUltimoEvento: Integer;
    function CreaUtente(Username, Password: String): Integer;
    function GetDatiUtenteDaUserPass(Username, Password: String): Integer;
    function GetUtente(Username: String): Integer;
    function GetDatiUtenteDaID(UserID: Integer; var Username, Password: String): Boolean;
    procedure CreaLogInEvent(UserID: Integer; RememberMe: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
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
  Query.Connection := DatabaseManager.Connection;
  FOldTabProc := PC.WindowProc;
  PC.WindowProc := TabWndProc;
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
      UserID := GetDatiUtenteDaUserPass(EUsername.Text, EPassword.Text);
      if UserID > 0 then
        begin
          CreaLogInEvent(UserID, CBRicordami.Checked);
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
      UserID := CreaUtente(EUsernameCrea.Text, EPasswordCrea1.Text);
      if UserID > -1 then
        begin
          CreaLogInEvent(UserID, CBRicordamiCrea.Checked);
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
  UserID := UtenteUltimoEvento;
  if (UserID > 0) and GetDatiUtenteDaID(UserID, Username, Password) then
    begin
      EUsername.Text := Username;
      EPassword.Text := Password;
      CBRicordami.Checked := True;
    end;
end;

procedure TLogInForm.CreaLogInEvent(UserID: Integer; RememberMe: Boolean);
begin
  try
    Query.ExecSQL
      ('INSERT INTO LOGIN_EVENT (USER_ID, DATE, REMEMBER_ME) VALUES (:USER_ID, :DATE, :REMEMBER_ME)',
      [UserID, TLazyFormat.FormatDateTimeSQLite(Now), RememberMe]);
  except
    //
  end;
end;

procedure TLogInForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //
end;

function TLogInForm.CreaUtente(Username, Password: String): Integer;
begin
  Result := -1;
  try
    if Query.ExecSQL('INSERT INTO USER (USERNAME, PASSWORD) VALUES (:USERNAME, :PASSWORD)',
      [Username, Password]) > 0 then
      Result := GetUtente(Username);
  except
    Result := -1;
  end;
end;

function TLogInForm.GetDatiUtenteDaUserPass(Username, Password: String): Integer;
begin
  Result := -1;
  try
    Query.Open('SELECT ID FROM USER WHERE USERNAME = :USERNAME AND PASSWORD = :PASSWORD',
      [Username, Password]);
    if Query.RowsAffected > 0 then
      Result := Query.FieldByName('ID').AsInteger;
  except
    Result := -1;
  end;
end;

procedure TLogInForm.FormResize(Sender: TObject);
begin
  //
end;

function TLogInForm.GetDatiUtenteDaID(UserID: Integer; var Username, Password: String): Boolean;
begin
  Result := False;
  try
    Query.Open('SELECT USERNAME, PASSWORD FROM USER WHERE ID = :ID', [UserID]);
    if Query.RowsAffected > 0 then
      begin
        Result := True;
        Username := Query.FieldByName('USERNAME').AsString;
        Password := Query.FieldByName('PASSWORD').AsString;
      end;
  except
    Result := False;
  end;
end;

function TLogInForm.GetUtente(Username: String): Integer;
begin
  Result := -1;
  try
    Query.Open('SELECT ID FROM USER WHERE USERNAME = :USERNAME', [Username]);
    if Query.RowsAffected > 0 then
      Result := Query.FieldByName('ID').AsInteger;
  except
    Result := -1;
  end;
end;

procedure TLogInForm.ImpostaLogin;
begin
  if UtentiPresenti > 0 then
    begin
      PC.ActivePage := TSAccedi;
      CaricaDatiUtenteAccedi;
    end
  else
    PC.ActivePage := TSCrea;
end;

procedure TLogInForm.TabWndProc(var Msg: TMessage);
begin
  FOldTabProc(Msg);
  if Msg.Msg = tcm_AdjustRect then
    begin
      case PC.TabPosition of
        tpTop:
          begin
            PRect(Msg.LParam)^.Left := 0;
            PRect(Msg.LParam)^.Right := PC.ClientWidth;
            Dec(PRect(Msg.LParam)^.Top, 4);
            PRect(Msg.LParam)^.Bottom := PC.ClientHeight;
          end;
      end;
    end;
end;

function TLogInForm.UtenteUltimoEvento: Integer;
begin
  Result := 0;
  try
    Query.Open('SELECT USER_ID, REMEMBER_ME FROM LOGIN_EVENT ORDER BY ID DESC LIMIT 1', []);
    if (Query.RowsAffected > 0) and (Query.FieldByName('REMEMBER_ME').AsInteger = 1) then
      Result := Query.FieldByName('USER_ID').AsInteger;
  except
    Result := 0;
  end;
end;

function TLogInForm.UtentiPresenti: Integer;
begin
  Result := 0;
  try
    Query.Open('SELECT COUNT(*) AS NR_UTENTI FROM USER', []);
    if Query.RowsAffected > 0 then
      Result := Query.FieldByName('NR_UTENTI').AsInteger;
  except
    Result := 0;
  end;
end;

end.