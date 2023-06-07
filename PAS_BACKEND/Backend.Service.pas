unit Backend.Service;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Classes,
  System.Win.Registry,

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
  WiRL.http.Server.Indy;

type
  TLazyDocumentsBackendService = class(TService)
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
    procedure Log(const AMessage: string);
    procedure SetServer(const Value: TWiRLServer);
  protected
    property Server: TWiRLServer read FServer write SetServer;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  LazyDocumentsBackendService: TLazyDocumentsBackendService;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  LazyDocumentsBackendService.Controller(CtrlCode);
end;

procedure TLazyDocumentsBackendService.ServiceDestroy(Sender: TObject);
begin
  //
end;

procedure TLazyDocumentsBackendService.ServiceCreate(Sender: TObject);
begin
  //
end;

{ TServiceWiRL }

procedure TLazyDocumentsBackendService.ConfigureServer;
begin
  FServer.SetPort(8080).SetThreadPoolSize(10).AddEngine<TWiRLEngine>
    ('lazydocuments').SetEngineName('REST Service').AddApplication('backend')
    .SetAppName('LazyDocuments Backend Service').SetFilters('*')
    .SetResources(['*']);
end;

function TLazyDocumentsBackendService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TLazyDocumentsBackendService.Log(const AMessage: string);
begin
  OutputDebugString(PChar(DateTimeToStr(Now) + ' ' + AMessage));
end;

procedure TLazyDocumentsBackendService.ServiceAfterInstall(Sender: TService);
var
  LReg: TRegistry;
begin
  Log('Registered ' + DisplayName);
  LReg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    LReg.RootKey := HKEY_LOCAL_MACHINE;
    if LReg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False) then
    begin
      LReg.WriteString('Description', 'LazyDocuments Backend Service');
      LReg.CloseKey;
    end;
  finally
    LReg.Free;
  end;
end;

procedure TLazyDocumentsBackendService.ServiceAfterUninstall(Sender: TService);
begin
  Log('Unregistered ' + DisplayName);
end;

procedure TLazyDocumentsBackendService.ServiceBeforeInstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsBackendService.ServiceBeforeUninstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsBackendService.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  //
end;

procedure TLazyDocumentsBackendService.ServiceExecute(Sender: TService);
begin
  FServer := TWiRLServer.Create(nil);
  try
    ConfigureServer;

    Log('Service starting...');
    FServer.Active := True;
    Log('Service started...');

    while not Terminated do
      ServiceThread.ProcessRequests(True); // wait for termination

    Log('Service stopping...');
    FServer.Active := False;
    Log('Service stopped...');
  finally
    FreeAndNil(FServer);
  end;
end;

procedure TLazyDocumentsBackendService.ServicePause(Sender: TService;
  var Paused: Boolean);
begin
  //
end;

procedure TLazyDocumentsBackendService.ServiceShutdown(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsBackendService.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  //
end;

procedure TLazyDocumentsBackendService.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  //
end;

procedure TLazyDocumentsBackendService.SetServer(const Value: TWiRLServer);
begin
  FServer := Value;
end;

end.
