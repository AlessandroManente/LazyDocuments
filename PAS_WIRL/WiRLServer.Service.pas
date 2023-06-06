unit WiRLServer.Service;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, System.Win.Registry,

  // WiRL units
  WiRL.Core.Engine,
  WiRL.http.Server,
  WiRL.Console.Base,
  WiRL.Core.Application,
  WiRL.Console.Factory,
  WiRL.http.Server.Indy;

type
  TLazyDocumentsWiRLService = class(TService)
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
  LazyDocumentsWiRLService: TLazyDocumentsWiRLService;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  LazyDocumentsWiRLService.Controller(CtrlCode);
end;

procedure TLazyDocumentsWiRLService.ServiceDestroy(Sender: TObject);
begin
  //
end;

procedure TLazyDocumentsWiRLService.ServiceCreate(Sender: TObject);
begin
  //
end;

{ TServiceWiRL }

procedure TLazyDocumentsWiRLService.ConfigureServer;
begin
  FServer.SetPort(8080).SetThreadPoolSize(10).AddEngine<TWiRLEngine>
    ('wirlservice').SetEngineName('REST Service')
    .AddApplication('lazydocuments').SetAppName('LazyDocuments WiRL Service')
    .SetFilters('*').SetResources(['*']);
end;

function TLazyDocumentsWiRLService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TLazyDocumentsWiRLService.Log(const AMessage: string);
begin
  OutputDebugString(PChar(DateTimeToStr(Now) + ' ' + AMessage));
end;

procedure TLazyDocumentsWiRLService.ServiceAfterInstall(Sender: TService);
var
  LReg: TRegistry;
begin
  Log('Registered ' + DisplayName);
  LReg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    LReg.RootKey := HKEY_LOCAL_MACHINE;
    if LReg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False) then
      begin
        LReg.WriteString('Description', 'LazyDocuments WiRL Service');
        LReg.CloseKey;
      end;
  finally
    LReg.Free;
  end;
end;

procedure TLazyDocumentsWiRLService.ServiceAfterUninstall(Sender: TService);
begin
  Log('Unregistered ' + DisplayName);
end;

procedure TLazyDocumentsWiRLService.ServiceBeforeInstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsWiRLService.ServiceBeforeUninstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsWiRLService.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  //
end;

procedure TLazyDocumentsWiRLService.ServiceExecute(Sender: TService);
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

procedure TLazyDocumentsWiRLService.ServicePause(Sender: TService;
  var Paused: Boolean);
begin
  //
end;

procedure TLazyDocumentsWiRLService.ServiceShutdown(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsWiRLService.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  //
end;

procedure TLazyDocumentsWiRLService.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  //
end;

procedure TLazyDocumentsWiRLService.SetServer(const Value: TWiRLServer);
begin
  FServer := Value;
end;

end.
