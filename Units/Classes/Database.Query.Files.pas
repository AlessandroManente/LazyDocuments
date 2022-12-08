unit Database.Query.Files;

interface

uses
  Database.Manager,
  Utils.Format,
  Utils.Log,

  System.SysUtils,
  System.Classes,
  System.SyncObjs,
  System.IOUtils,
  System.Generics.Collections,

  Datasnap.DBClient,

  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  IQueryFiles = interface
    ['{610C93BD-FD07-4466-8356-477D0C48DC62}']
    function AddFiles(Files: TClientDataset; UserID: Integer): Boolean;
    function AddSezione(Sezione: String): Boolean;
    function AddSottosezione(Sezione, SottoSezione: String): Boolean;
    function AddTag(Tag: String): Boolean;
    function AddTagFile(TagID, FileID: Integer): Boolean;
    function EsisteSezione(Sezione: String): Boolean;
    function EsisteSottosezione(SottoSezione: String): Boolean;
    function EsisteTag(Tag: String): Boolean;
    function GetIDLastFileByUserID(UserID: Integer; var ID: Integer): Boolean;
    function GetIDSezione(Sezione: String; var ID: Integer): Boolean;
    function GetIDSottoSezione(SottoSezione: String; var ID: Integer): Boolean;
    function GetIDTag(Tag: String; var ID: Integer): Boolean;
    function GetSezioni(var List: TStrings): Boolean;
    function GetSottosezioni(var List: TStrings): Boolean;
    function GetSottosezioniBySezione(Sezione: String; var List: TStrings): Boolean;
    function GetTag(var List: TStrings): Boolean;
    function SearchFiles(Files: TFDMemTable; UserID: Integer): Boolean;
  end;

function GetIQueryFiles: IQueryFiles;

implementation

type
  TQueryFiles = class(TInterfacedObject, IQueryFiles)
  private
    FQuery: TFDQuery;
    procedure SetQuery(const Value: TFDQuery);
  protected
    property Query: TFDQuery read FQuery write SetQuery;
  public
    constructor Create; overload;
    destructor Destroy; override;
    function AddFiles(Files: TClientDataset; UserID: Integer): Boolean;
    function AddSezione(Sezione: String): Boolean;
    function AddSottosezione(Sezione, SottoSezione: String): Boolean;
    function AddTag(Tag: String): Boolean;
    function AddTagFile(TagID, FileID: Integer): Boolean;
    function EsisteSezione(Sezione: String): Boolean;
    function EsisteSottosezione(SottoSezione: String): Boolean;
    function EsisteTag(Tag: String): Boolean;
    function GetIDLastFileByUserID(UserID: Integer; var ID: Integer): Boolean;
    function GetIDSezione(Sezione: String; var ID: Integer): Boolean;
    function GetIDSottoSezione(SottoSezione: String; var ID: Integer): Boolean;
    function GetIDTag(Tag: String; var ID: Integer): Boolean;
    function GetSezioni(var List: TStrings): Boolean;
    function GetSottosezioni(var List: TStrings): Boolean;
    function GetSottosezioniBySezione(Sezione: String; var List: TStrings): Boolean;
    function GetTag(var List: TStrings): Boolean;
    function SearchFiles(Files: TFDMemTable; UserID: Integer): Boolean;
  end;

function GetIQueryFiles: IQueryFiles;
begin
  Result := TQueryFiles.Create;
end;

{ TQueryFiles }

function TQueryFiles.AddFiles(Files: TClientDataset; UserID: Integer): Boolean;
const
  MName = 'AddFiles';
var
  FullPath, FilePath, FileName, MD5: String;
  SubSectionID: Integer;
  FileID: Integer;
  TagID: Integer;
  Errori: Integer;
  List: TStrings;
  I: Integer;
begin
  Result := False;
  List := TStringList.Create;
  try
    try
      Files.DisableControls;
      Files.First;
      try
        Errori := 0;
        while not Files.Eof do
          begin
            FullPath := Files.FieldByName('FULL_PATH').AsString;
            FilePath := ExtractFilePath(FullPath);
            FileName := ExtractFileName(FullPath);
            MD5 := TLazyFormat.HashFile(FullPath);
            SubSectionID := 0;
            if Files.FieldByName('SUBSECTION').AsString <> '' then
              GetIDSottoSezione(Files.FieldByName('SUBSECTION').AsString, SubSectionID);

            if Query.ExecSQL
              ('INSERT INTO FILE (FULL_PATH, FILE_PATH, FILE_NAME, USER_ID, SUBSECTION_ID, INSERT_DATE, MD5) '
              + 'VALUES (:FULL_PATH, :FILE_PATH, :FILE_NAME, :USER_ID, :SUBSECTION_ID, :INSERT_DATE, MD5)',
              [FullPath, FilePath, FileName, UserID, SubSectionID, Now, MD5]) <= 0 then
              Inc(Errori)
            else if GetIDLastFileByUserID(UserID, FileID) then
              begin
                List.Clear;
                TLazyFormat.DaStringaALista(Files.FieldByName('TAGS').AsString, ';', List);
                for I := 0 to List.Count - 1 do
                  if GetIDTag(List[I], TagID) then
                    AddTagFile(TagID, FileID);
              end;
            Files.Next;
          end;
        if Errori = 0 then
          Result := True;
      finally
        Files.First;
        Files.DisableControls;
      end;
    except
      on E: Exception do
        begin
          Result := False;
          Logger.AddLog(Self.ClassName, MName, E.Message);
        end;
    end;
  finally
    List.Free;
  end;
end;

function TQueryFiles.AddSottosezione(Sezione, SottoSezione: String): Boolean;
const
  MName = 'AddSottosezione';
var
  ID: Integer;
begin
  Result := False;
  try
    if GetIDSezione(Sezione, ID) and (ID > 0) and
      (Query.ExecSQL('INSERT INTO SUBSECTION (NAME, SECTION_ID) VALUES (:NAME, :SECTION_ID)',
      [SottoSezione, ID]) > 0) then
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.AddTag(Tag: String): Boolean;
const
  MName = 'AddTag';
begin
  Result := False;
  try
    if Query.ExecSQL('INSERT INTO TAG (NAME) VALUES (:NAME)', [Tag]) > 0 then
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.AddTagFile(TagID, FileID: Integer): Boolean;
const
  MName = 'AddTagFile';
begin
  Result := False;
  try
    if Query.ExecSQL('INSERT INTO TAG_FILE (ID_TAG, ID_FILE) VALUES (:ID_TAG, :ID_FILE)',
      [TagID, FileID]) > 0 then
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

constructor TQueryFiles.Create;
begin
  inherited;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DatabaseManager.Connection;
end;

destructor TQueryFiles.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TQueryFiles.AddSezione(Sezione: String): Boolean;
const
  MName = 'AddSezione';
begin
  Result := False;
  try
    if Query.ExecSQL('INSERT INTO SECTION (NAME) VALUES (:NAME)', [Sezione]) > 0 then
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.EsisteSezione(Sezione: String): Boolean;
const
  MName = 'EsisteSezione';
begin
  Result := False;
  try
    Query.Open('SELECT COUNT(*) AS C FROM SECTION WHERE NAME = :NAME', [Sezione]);
    if (Query.RowsAffected > 0) and (Query.FieldByName('C').AsInteger > 0) then
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.EsisteSottosezione(SottoSezione: String): Boolean;
const
  MName = 'EsisteSottosezione';
begin
  Result := False;
  try
    Query.Open('SELECT COUNT(*) AS C FROM SUBSECTION WHERE NAME = :NAME', [SottoSezione]);
    if (Query.RowsAffected > 0) and (Query.FieldByName('C').AsInteger > 0) then
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.EsisteTag(Tag: String): Boolean;
const
  MName = 'EsisteTag';
begin
  Result := False;
  try
    Query.Open('SELECT COUNT(*) AS C FROM TAG WHERE NAME = :NAME', [Tag]);
    if (Query.RowsAffected > 0) and (Query.FieldByName('C').AsInteger > 0) then
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetIDLastFileByUserID(UserID: Integer; var ID: Integer): Boolean;
const
  MName = 'GetIDLastFileByUserID';
begin
  Result := False;
  try
    Query.Open('SELECT ID FROM FILE WHERE USER_ID = :USER_ID ORDER BY ID DESC LIMIT 1', [UserID]);
    if Query.RowsAffected > 0 then
      begin
        ID := Query.FieldByName('ID').AsInteger;
        Result := True;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetIDSezione(Sezione: String; var ID: Integer): Boolean;
const
  MName = 'GetIDSezione';
begin
  Result := False;
  try
    Query.Open('SELECT ID FROM SECTION WHERE NAME = :NAME', [Sezione]);
    if Query.RowsAffected > 0 then
      begin
        ID := Query.FieldByName('ID').AsInteger;
        Result := True;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetIDSottoSezione(SottoSezione: String; var ID: Integer): Boolean;
const
  MName = 'GetIDSottoSezione';
begin
  Result := False;
  try
    Query.Open('SELECT ID FROM SUBSECTION WHERE NAME = :NAME', [SottoSezione]);
    if Query.RowsAffected > 0 then
      begin
        ID := Query.FieldByName('ID').AsInteger;
        Result := True;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetIDTag(Tag: String; var ID: Integer): Boolean;
const
  MName = 'GetIDTag';
begin
  Result := False;
  try
    Query.Open('SELECT ID FROM TAG WHERE NAME = :NAME', [Tag]);
    if Query.RowsAffected > 0 then
      begin
        ID := Query.FieldByName('ID').AsInteger;
        Result := True;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetSezioni(var List: TStrings): Boolean;
const
  MName = 'GetSezioni';
begin
  Result := False;
  try
    Query.Open('SELECT NAME FROM SECTION', []);
    if Query.RowsAffected > 0 then
      begin
        while not Query.Eof do
          begin
            List.Add(Query.FieldByName('NAME').AsString);
            Query.Next;
          end;
        Result := True;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetSottosezioni(var List: TStrings): Boolean;
const
  MName = 'GetSottosezioni';
begin
  Result := False;
  try
    Query.Open('SELECT NAME FROM SUBSECTION', []);
    if Query.RowsAffected > 0 then
      begin
        while not Query.Eof do
          begin
            List.Add(Query.FieldByName('NAME').AsString);
            Query.Next;
          end;
        Result := True;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetSottosezioniBySezione(Sezione: String; var List: TStrings): Boolean;
const
  MName = 'GetSottosezioniBySezione';
var
  ID: Integer;
begin
  Result := False;
  try
    if GetIDSezione(Sezione, ID) then
      begin
        Query.Open('SELECT NAME FROM SECTION WHERE SECTION_ID = :SECTION_ID', [ID]);
        if Query.RowsAffected > 0 then
          begin
            while not Query.Eof do
              begin
                List.Add(Query.FieldByName('NAME').AsString);
                Query.Next;
              end;
            Result := True;
          end;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.GetTag(var List: TStrings): Boolean;
const
  MName = 'GetTag';
begin
  Result := False;
  try
    Query.Open('SELECT NAME FROM TAG', []);
    if Query.RowsAffected > 0 then
      begin
        while not Query.Eof do
          begin
            List.Add(Query.FieldByName('NAME').AsString);
            Query.Next;
          end;
        Result := True;
      end;
  except
    on E: Exception do
      begin
        Result := False;
        Logger.AddLog(Self.ClassName, MName, E.Message);
      end;
  end;
end;

function TQueryFiles.SearchFiles(Files: TFDMemTable; UserID: Integer): Boolean;
const
  MName = 'GetTag';
begin
  Result := False;
  Files.EmptyDataSet;
  Files.DisableControls;
  try
    try
      Query.Open('SELECT ID, FILE_NAME FROM FILE WHERE USER_ID = :USER_ID', [UserID]);
      if Query.RowsAffected > 0 then
        begin
          Files.CopyDataSet(Query, [coRestart, coAppend]);
          Result := True;
        end;
    except
      on E: Exception do
        begin
          Result := False;
          Logger.AddLog(Self.ClassName, MName, E.Message);
        end;
    end;
  finally
    Files.First;
    Files.EnableControls;
  end;
end;

procedure TQueryFiles.SetQuery(const Value: TFDQuery);
begin
  FQuery := Value;
end;

end.
