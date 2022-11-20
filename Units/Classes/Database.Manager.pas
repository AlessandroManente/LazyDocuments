unit Database.Manager;

interface

uses
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
  IDatabaseManager = interface
    ['{5AA0A1D9-3B42-41D6-A24E-C3DA13D77291}']
    procedure SetConnection(const Value: TFDConnection);
    function GetConnection: TFDConnection;
    property Connection: TFDConnection read GetConnection write SetConnection;
  end;

function DatabaseManager: IDatabaseManager;

implementation

type
  TDatabaseManager = class(TInterfacedObject, IDatabaseManager)
  private
    FConnection: TFDConnection;
    FDriver: TFDPhysSQLiteDriverLink;
    procedure SetupConnection;
    procedure EndConnection;
    procedure SetConnection(const Value: TFDConnection);
    function GetConnection: TFDConnection;
    procedure SetDriver(const Value: TFDPhysSQLiteDriverLink);
    function GetDriver: TFDPhysSQLiteDriverLink;
  protected
    property Driver: TFDPhysSQLiteDriverLink read GetDriver write SetDriver;
  public
    constructor Create; overload;
    destructor Destroy; override;
    property Connection: TFDConnection read GetConnection write SetConnection;
  end;

  { TDatabaseManager }

constructor TDatabaseManager.Create;
begin
  inherited;
  FDriver := TFDPhysSQLiteDriverLink.Create(nil);
  FConnection := TFDConnection.Create(nil);
  SetupConnection;
end;

destructor TDatabaseManager.Destroy;
begin
  EndConnection;
  FConnection.Free;
  FDriver.Free;
  inherited;
end;

procedure TDatabaseManager.EndConnection;
begin
  Connection.Connected := False;
end;

function TDatabaseManager.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

function TDatabaseManager.GetDriver: TFDPhysSQLiteDriverLink;
begin
  Result := FDriver;
end;

procedure TDatabaseManager.SetConnection(const Value: TFDConnection);
begin
  FConnection := Value;
end;

procedure TDatabaseManager.SetDriver(const Value: TFDPhysSQLiteDriverLink);
begin
  FDriver := Value;
end;

procedure TDatabaseManager.SetupConnection;
begin
  Connection.Params.Values['Database'] := ExtractFilePath(ParamStr(0)) +
    'LazyDocuments.db';
  Connection.DriverName := 'SQLite';
  Connection.Connected := True;
end;

{ Global Function }

var
  LockDatabaseManager: TCriticalSection;
  _DatabaseManager: IDatabaseManager;

function DatabaseManager: IDatabaseManager;
begin
  LockDatabaseManager.Acquire;
  try
    if not Assigned(_DatabaseManager) then
      _DatabaseManager := TDatabaseManager.Create;
    Result := _DatabaseManager;
  finally
    LockDatabaseManager.Release;
  end;
end;

initialization

LockDatabaseManager := TCriticalSection.Create;

finalization

LockDatabaseManager.Free;

end.
