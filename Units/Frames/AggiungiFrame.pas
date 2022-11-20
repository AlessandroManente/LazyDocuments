unit AggiungiFrame;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls;

type
  TAggiungiFrm = class(TFrame)
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AggiungiFrm: TAggiungiFrm;

function GetAggiungiFrm: TAggiungiFrm;

implementation

function GetAggiungiFrm: TAggiungiFrm;
begin
  if not Assigned(AggiungiFrm) then
    AggiungiFrm := TAggiungiFrm.Create(Application);
  Result := AggiungiFrm;
end;

{$R *.dfm}

end.
