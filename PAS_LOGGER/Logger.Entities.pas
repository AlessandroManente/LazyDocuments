unit Logger.Entities;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Contnrs,
  System.Generics.Collections,

  Neon.Core.Attributes;
{$M+}

type
  TLogEntry = class
  private
    FLevel: String;
    FMsg: String;
    FApp: String;
    procedure SetApp(const Value: String);
    procedure SetLevel(const Value: String);
    procedure SetMsg(const Value: String);
  published
    property App: String read FApp write SetApp;
    property Level: String read FLevel write SetLevel;
    property Msg: String read FMsg write SetMsg;
  end;

implementation

{ TLogEntry }

procedure TLogEntry.SetApp(const Value: String);
begin
  FApp := Value;
end;

procedure TLogEntry.SetLevel(const Value: String);
begin
  FLevel := Value;
end;

procedure TLogEntry.SetMsg(const Value: String);
begin
  FMsg := Value;
end;

end.
