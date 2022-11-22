unit Utils.Log;

interface

uses
  System.SysUtils,
  System.Classes,
  System.SyncObjs,
  System.IOUtils,

  Utils.Format;

type
  ILogger = interface
    ['{81D5A5ED-8A52-48DC-A542-D61BDBE0B6E9}']
    procedure AddLog(Oggetto, NomeFun, Log: String);
  end;

function Logger: ILogger;

implementation

type
  TLogger = class(TInterfacedObject, ILogger)
  private
    function CreaCartellaLog(Path: String): Boolean;
    function GetFileName: String;
  public
    procedure AddLog(Oggetto, NomeFun, Log: String);
  end;

  { TLogger }

procedure TLogger.AddLog(Oggetto, NomeFun, Log: String);
var
  FileName: String;
  Riga: String;
begin
  FileName := GetFileName;
  if FileName <> '' then
    begin
      Riga := Format('[%s - %s - ' + TLazyFormat.FormatDateTimeSQLite(Now) + '] %s',
        [Oggetto, NomeFun, Log]) + sLineBreak;
      TFile.AppendAllText(FileName, Riga);
    end;
end;

function TLogger.CreaCartellaLog(Path: String): Boolean;
begin
  Result := False;
  if ForceDirectories(Path) then
    Result := True;
end;

function TLogger.GetFileName: String;
var
  FileName: String;
begin
  Result := '';
  if CreaCartellaLog(FileName) then
    Result := TLazyFormat.CartellaCorrente + 'LOG' + TLazyFormat.FormatDateLog(Now);
end;

{ Global Function }

var
  LockLogger: TCriticalSection;
  _Logger: ILogger;

function Logger: ILogger;
begin
  LockLogger.Acquire;
  try
    if not Assigned(_Logger) then
      _Logger := TLogger.Create;
    Result := _Logger;
  finally
    LockLogger.Release;
  end;
end;

initialization

LockLogger := TCriticalSection.Create;

finalization

LockLogger.Free;

end.
