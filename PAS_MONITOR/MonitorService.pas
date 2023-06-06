unit MonitorService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TLazyDocumentsMonitorService = class(TService)
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
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  LazyDocumentsMonitorService: TLazyDocumentsMonitorService;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  LazyDocumentsMonitorService.Controller(CtrlCode);
end;

procedure TLazyDocumentsMonitorService.ServiceDestroy(Sender: TObject);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceCreate(Sender: TObject);
begin
  //
end;

function TLazyDocumentsMonitorService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TLazyDocumentsMonitorService.ServiceAfterInstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceAfterUninstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceBeforeInstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceBeforeUninstall(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceExecute(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServicePause(Sender: TService;
  var Paused: Boolean);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceShutdown(Sender: TService);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  //
end;

procedure TLazyDocumentsMonitorService.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  //
end;

end.
