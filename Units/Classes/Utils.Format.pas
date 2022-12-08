unit Utils.Format;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Hash,
  System.DateUtils;

type
  TLazyFormat = class
  public
    class function FormatDateTimeSQLite(Data: TDateTime): String; static;
    class function CartellaCorrente: String; static;
    class function FormatDateLog(Data: TDateTime): String; static;
    class procedure DaStringaALista(Stringa: String; Separatore: Char; var List:
        TStrings);
    class function HashString(ToHash: String): String; static;
    class function HashFile(ToHash: String): String; static;
  end;

implementation

class function TLazyFormat.CartellaCorrente: String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

class procedure TLazyFormat.DaStringaALista(Stringa: String; Separatore: Char;
    var List: TStrings);
var
  Temp: TStrings;
begin
  Temp := TStringList.Create;
  try
    Temp.Delimiter := Separatore;
    Temp.DelimitedText := Stringa;
    List.Assign(Temp);
  finally
    Temp.Free;
  end;
end;

class function TLazyFormat.FormatDateLog(Data: TDateTime): String;
begin
  Result := FormatDateTime('YYYY_MM_DD', Data);
end;

class function TLazyFormat.FormatDateTimeSQLite(Data: TDateTime): String;
begin
  Result := FormatDateTime('YYYY-MM-DD HH:MM:SS.SSS', Data);
end;

class function TLazyFormat.HashString(ToHash: String): String;
begin
  Result := THashMD5.Create.GetHashString(ToHash);
end;

class function TLazyFormat.HashFile(ToHash: String): String;
begin
  Result := THashMD5.Create.GetHashStringFromFile(ToHash);
end;

end.
