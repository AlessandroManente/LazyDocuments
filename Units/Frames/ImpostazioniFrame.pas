unit ImpostazioniFrame;

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
  TImpostazioniFrm = class(TFrame)
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImpostazioniFrm: TImpostazioniFrm;

function GetImpostazioniFrm: TImpostazioniFrm;

implementation

function GetImpostazioniFrm: TImpostazioniFrm;
begin
  if not Assigned(ImpostazioniFrm) then
    ImpostazioniFrm := TImpostazioniFrm.Create(Application);
  Result := ImpostazioniFrm;
end;

{$R *.dfm}

end.
