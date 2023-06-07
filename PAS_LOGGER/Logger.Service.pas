unit Logger.Service;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Win.Registry,

  System.SysUtils,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.SvcMgr,
  Vcl.Dialogs,

  // WiRL units
  WiRL.Core.Engine,
  WiRL.http.Server,
  WiRL.Console.Base,
  WiRL.Core.Application,
  WiRL.Console.Factory,
  WiRL.http.Server.Indy,

  Quick.Logger,
  Quick.Logger.Provider.Files;

type
  TLazyDocumentsLoggerService = class(TService)
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
    FServer: TWiRLServer;
    procedure ConfigureServer;
    procedure ConfigureLogger;
    procedure SetServer(const Value: TWiRLServer);
  protected
    property Server: TWiRLServer read FServer write SetServer;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  LazyDocumentsLoggerService: TLazyDocumentsLoggerService;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  LazyDocumentsLoggerService.Controller(CtrlCode);
end;

procedure TLazyDocumentsLoggerService.ServiceDestroy(Sender: TObject);
begin
  //
end;

procedure TLazyDocumentsLoggerService.ServiceCreate(Sender: TObject);
begin
  //
end;

{ TServiceWiRL }

procedure TLazyDocumentsLoggerService.ConfigureLogger;
begin
  Quick.Logger.Logger.Providers.Add(GlobalLogFileProvider);
  GlobalLogFileProvider.FileName := '.\LazyDocuments.log';
  GlobalLogFileProvider.DailyRotate := True;
  GlobalLogFileProvider.MaxFileSizeInMB := 100;
  GlobalLogFileProvider.LogLevel := LOG_ALL;
  GlobalLogFileProvider.ShowHeaderInfo := False;
  GlobalLogFileProvider.Enabled := True;
end;

procedure TLazyDocumentsLoggerService.ConfigureServer;
begin
  Log('Logger - Initialized server configuration', etInfo);
  FServer.SetPort(8079).SetThreadPoolSize(10).AddEngine<TWiRLEngine>
    ('lazydocuments').SetEngineName('REST Service').AddApplication('logger')
    .SetAppName('LazyDocuments WiRL Service').SetFilters('*')
    .SetResources(['*']);
  Log('Logger - Ended server configuration', etInfo);
end;

function TLazyDocumentsLoggerService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TLazyDocumentsLoggerService.ServiceAfterInstall(Sender: TService);
var
  LReg: TRegistry;
begin
  ConfigureLogger;
  Log('Logger - Registered ' + DisplayName, etInfo);
  LReg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    LReg.RootKey := HKEY_LOCAL_MACHINE;
    if LReg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False) then
    begin
      LReg.WriteString('Description', 'LazyDocuments Logger Service');
      LReg.CloseKey;
    end;
  finally
    LReg.Free;
  end;
end;

procedure TLazyDocumentsLoggerService.ServiceAfterUninstall(Sender: TService);
begin
  Log('Logger - Unregistered ' + DisplayName, etInfo);
end;

procedure TLazyDocumentsLoggerService.ServiceBeforeInstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsLoggerService.ServiceBeforeUninstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsLoggerService.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  //
end;

procedure TLazyDocumentsLoggerService.ServiceExecute(Sender: TService);
begin
  ConfigureLogger;
  FServer := TWiRLServer.Create(nil);
  try
    ConfigureServer;

    Log('Logger - Service starting...', etInfo);
    try
      FServer.Active := True;
    except
      on E: Exception do
        Log('Logger - ' + E.Message, etError);
    end;
    Log('Logger - Service started...', etInfo);

    while not Terminated do
      ServiceThread.ProcessRequests(True); // wait for termination

    Log('Logger - Service stopping...', etInfo);
    FServer.Active := False;
    Log('Logger - Service stopped...', etInfo);
  finally
    FreeAndNil(FServer);
  end;
end;

procedure TLazyDocumentsLoggerService.ServicePause(Sender: TService;
  var Paused: Boolean);
begin
  //
end;

procedure TLazyDocumentsLoggerService.ServiceShutdown(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsLoggerService.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  //
end;

procedure TLazyDocumentsLoggerService.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  //
end;

procedure TLazyDocumentsLoggerService.SetServer(const Value: TWiRLServer);
begin
  FServer := Value;
end;

end.
