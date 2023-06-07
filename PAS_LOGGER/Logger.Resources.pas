unit Logger.Resources;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,

  WiRL.Core.Engine,
  WiRL.Core.Application,
  WiRL.Core.Registry,
  WiRL.Core.Attributes,
  WiRL.http.Accept.MediaType,
  WiRL.http.URL,
  WiRL.Core.MessageBody.Default,
  WiRL.Core.Auth.Context,
  WiRL.http.Request,
  WiRL.http.Response,

  Neon.Core.Utils,

  Logger.Entities,

  Quick.Logger;

type

  [Path('/logs')]
  TLogsResource = class
  public
    [POST]
    [Path('/addlog')]
    [Consumes(TMediaType.APPLICATION_JSON)]
    [Produces(TMediaType.APPLICATION_JSON)]
    procedure WriteLog([BodyParam] ALog: TLogEntry);
  end;

implementation

uses
  System.DateUtils;

procedure TLogsResource.WriteLog(ALog: TLogEntry);
var
  evType: TEventType;
begin
  if ALog.Level = 'INFO' then
    evType := etInfo
  else if ALog.Level = 'DEBUG' then
    evType := etDebug
  else if ALog.Level = 'WARNING' then
    evType := etWarning
  else if ALog.Level = 'EXCEPTION' then
    evType := etException
  else if ALog.Level = 'ERROR' then
    evType := etError
  else
    evType := etInfo;
  Quick.Logger.Logger.Add(ALog.App + ' - ' + ALog.Msg, evType);
end;

initialization

Randomize;
TWiRLResourceRegistry.Instance.RegisterResource<TLogsResource>;

end.
