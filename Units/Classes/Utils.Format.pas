unit Utils.Format;

interface

uses
  System.SysUtils,
  System.DateUtils;

type
  TLazyFormat = class
  public
    class function FormatDateTimeSQLite(Data: TDateTime): String; static;
    class function CartellaCorrente: String; static;
    class function FormatDateLog(Data: TDateTime): String; static;
  end;

implementation

class function TLazyFormat.CartellaCorrente: String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

class function TLazyFormat.FormatDateLog(Data: TDateTime): String;
begin
  Result := FormatDateTime('YYYY_MM_DD', Data);
end;

class function TLazyFormat.FormatDateTimeSQLite(Data: TDateTime): String;
begin
  Result := FormatDateTime('YYYY-MM-DD HH:MM:SS.SSS', Data);
end;

end.