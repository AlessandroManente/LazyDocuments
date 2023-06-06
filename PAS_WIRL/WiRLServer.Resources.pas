unit WiRLServer.Resources;

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

  WiRLServer.Entities;

type

  [Path('/person')]
  TPersonResource = class
  public
    [GET]
    [Produces(TMediaType.APPLICATION_JSON)]
    function GetPerson: TPerson;
  end;

implementation

uses
  System.DateUtils;

function TPersonResource.GetPerson: TPerson;
begin
  Result := TPerson.Create;
  Result.FirstName := 'Paolo';
  Result.LastName := 'Rossi';
  Result.Birthday := Today;
  Result.Notes.Date := Today;
  Result.Notes.Text := 'Not my birthday!';
  Result.AddAddress('Piacenza', 'Italy');
  Result.AddAddress('Parma', 'Italy');
  Result.RandomNumber := Random(999999);
end;

initialization

Randomize;
TWiRLResourceRegistry.Instance.RegisterResource<TPersonResource>;

end.
