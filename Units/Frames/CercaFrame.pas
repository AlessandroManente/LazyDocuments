unit CercaFrame;

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
  Vcl.Dialogs,
  Vcl.StdCtrls, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.SQLite;

type
  TCercaFrm = class(TFrame)
    SQLiteDriver: TFDPhysSQLiteDriverLink;
  private
  public
  end;

var
  CercaFrm: TCercaFrm;

function GetCercaFrm: TCercaFrm;

implementation

function GetCercaFrm: TCercaFrm;
begin
  if not Assigned(CercaFrm) then
    CercaFrm := TCercaFrm.Create(Application);
  Result := CercaFrm;
end;

{$R *.dfm}

end.
