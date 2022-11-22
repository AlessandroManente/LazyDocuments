unit Database.Query.User;

interface

uses
  Database.Manager,
  Utils.Format,
  Utils.Log,

  System.SysUtils,
  System.Classes,
  System.SyncObjs,
  System.Generics.Collections,

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
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  IQueryUser = interface
    ['{B661793F-9AF7-46DA-A220-F047D5C100F0}']
    function CreaLogInEvent(UserID: Integer; RememberMe: Boolean): Boolean;
    function CreaUtente(Username, Password: String; var UserID: Integer): Boolean;
    function GetDatiUtenteDaID(UserID: Integer; var Username, Password: String): Boolean;
    function GetDatiUtenteDaUserPass(Username, Password: String; var UserID:
        Integer): Boolean;
    function GetUtente(Username: String; var UserID: Integer): Boolean;
    function UtentiPresenti: Boolean;
    function UtenteUltimoEvento(var UserID: Integer): Boolean;
    function ImpostaUtenteCorrente(UserID: Integer): Boolean;
    function GetUtenteCorrente(var UserID: Integer): Boolean;
    function EliminaUtenteCorrente: Boolean;
  end;

function GetIQueryUser: IQueryUser;

implementation

type
  TQueryUser = class(TInterfacedObject, IQueryUser)
  private
    FQuery: TFDQuery;
    procedure SetQuery(const Value: TFDQuery);
  protected
    property Query: TFDQuery read FQuery write SetQuery;
  public
    constructor Create; overload;
    destructor Destroy; override;
    function CreaLogInEvent(UserID: Integer; RememberMe: Boolean): Boolean;
    function CreaUtente(Username, Password: String; var UserID: Integer): Boolean;
    function GetDatiUtenteDaID(UserID: Integer; var Username, Password: String): Boolean;
    function GetDatiUtenteDaUserPass(Username, Password: String; var UserID:
        Integer): Boolean;
    function GetUtente(Username: String; var UserID: Integer): Boolean;
    function UtentiPresenti: Boolean;
    function UtenteUltimoEvento(var UserID: Integer): Boolean;
    function ImpostaUtenteCorrente(UserID: Integer): Boolean;
    function GetUtenteCorrente(var UserID: Integer): Boolean;
    function EliminaUtenteCorrente: Boolean;
  end;

function GetIQueryUser: IQueryUser;
begin
  Result := TQueryUser.Create;
end;

{ TQueryUser }

constructor TQueryUser.Create;
begin
  inherited;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DatabaseManager.Connection;
end;

destructor TQueryUser.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TQueryUser.EliminaUtenteCorrente: Boolean;
const
  MName = 'EliminaUtenteCorrente';
begin
  try
    Result := Query.ExecSQL('DELETE FROM CURRENT_USER', []) > 0;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.CreaLogInEvent(UserID: Integer; RememberMe: Boolean):
    Boolean;
const
  MName = 'CreaLogInEvent';
begin
  Result := False;
  try
    Query.ExecSQL
      ('INSERT INTO LOGIN_EVENT (USER_ID, DATE, REMEMBER_ME) VALUES (:USER_ID, :DATE, :REMEMBER_ME)',
      [UserID, TLazyFormat.FormatDateTimeSQLite(Now), RememberMe]);
    if Query.RowsAffected > 0 then
      Result := True;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.CreaUtente(Username, Password: String; var UserID:
    Integer): Boolean;
const
  MName = 'CreaUtente';
begin
  UserID := -1;
  Result := False;
  try
    if Query.ExecSQL('INSERT INTO USER (USERNAME, PASSWORD) VALUES (:USERNAME, :PASSWORD)',
      [Username, Password]) > 0 then
      begin
        Result := True;
        GetUtente(Username, UserID);
      end;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.GetDatiUtenteDaID(UserID: Integer; var Username, Password: String): Boolean;
const
  MName = 'GetDatiUtenteDaID';
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
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.GetDatiUtenteDaUserPass(Username, Password: String; var
    UserID: Integer): Boolean;
const
  MName = 'GetDatiUtenteDaUserPass';
begin
  UserID := -1;
  Result := False;
  try
    Query.Open('SELECT ID FROM USER WHERE USERNAME = :USERNAME AND PASSWORD = :PASSWORD',
      [Username, Password]);
    if Query.RowsAffected > 0 then
      begin
        Result := True;
        UserID := Query.FieldByName('ID').AsInteger;
      end;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.GetUtente(Username: String; var UserID: Integer): Boolean;
const
  MName = 'GetUtente';
begin
  UserID := -1;
  Result := False;
  try
    Query.Open('SELECT ID FROM USER WHERE USERNAME = :USERNAME', [Username]);
    if Query.RowsAffected > 0 then
      begin
        Result := True;
        UserID := Query.FieldByName('ID').AsInteger;
      end;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.GetUtenteCorrente(var UserID: Integer): Boolean;
const
  MName = 'GetUtenteCorrente';
begin
  UserID := -1;
  Result := False;
  try
    Query.Open('SELECT ID FROM CURRENT_USER LIMIT 1', []);
    if Query.RowsAffected > 0 then
      begin
        UserID := Query.FieldByName('ID').AsInteger;
        Result := True;
      end;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.ImpostaUtenteCorrente(UserID: Integer): Boolean;
const
  MName = 'ImpostaUtenteCorrente';
begin
  try
    Result := Query.ExecSQL('INSERT INTO CURRENT_USER (ID) VALUES (:ID)', [UserID]) > 0;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

procedure TQueryUser.SetQuery(const Value: TFDQuery);
begin
  FQuery := Value;
end;

function TQueryUser.UtenteUltimoEvento(var UserID: Integer): Boolean;
const
  MName = 'UtenteUltimoEvento';
begin
  UserID := 0;
  Result := False;
  try
    Query.Open('SELECT USER_ID, REMEMBER_ME FROM LOGIN_EVENT ORDER BY ID DESC LIMIT 1', []);
    if (Query.RowsAffected > 0) and (Query.FieldByName('REMEMBER_ME').AsInteger = 1) then
      begin
        Result := True;
        UserID := Query.FieldByName('USER_ID').AsInteger;
      end;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

function TQueryUser.UtentiPresenti: Boolean;
const
  MName = 'UtentiPresenti';
begin
  Result := False;
  try
    Query.Open('SELECT COUNT(*) AS NR_UTENTI FROM USER', []);
    if Query.RowsAffected > 0 then
      Result := Query.FieldByName('NR_UTENTI').AsInteger > 0;
  except on E: Exception do
    begin
      Result := False;
      Logger.AddLog(Self.ClassName, MName, E.Message);
    end;
  end;
end;

end.
