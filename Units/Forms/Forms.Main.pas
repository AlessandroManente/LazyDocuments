unit Forms.Main;

interface

uses
  Database.Manager,
  Database.Query.User,
  Database.Query.Files,
  Utils.Format,
  Utils.Log,

  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,
  System.StrUtils,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.CategoryButtons,
  Vcl.Buttons,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,

  Data.DB,

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
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.CheckLst,
  Datasnap.DBClient;

type
  TLazyDocumentsForm = class(TForm)
    SplitView: TSplitView;
    PCMain: TPageControl;
    ActList: TActionList;
    BtnImpostazioni: TSpeedButton;
    BtnAggiungi: TSpeedButton;
    BtnCerca: TSpeedButton;
    TSCerca: TTabSheet;
    TSAggiungi: TTabSheet;
    TSImpostazioni: TTabSheet;
    ActionPCCerca: TAction;
    ActionPCAggiungi: TAction;
    ActionPCImpostazioni: TAction;
    PCercaBase: TPanel;
    PDropBase: TPanel;
    PImpostazioniBase: TPanel;
    LDragFile: TLabel;
    SBAggiungiFile: TSpeedButton;
    ActionAggiungiFile: TAction;
    PCAggiungiFiles: TPageControl;
    TSDropFiles: TTabSheet;
    TSAddFiles: TTabSheet;
    PAddFilesBase: TPanel;
    DSAddFiles: TDataSource;
    PAddFilesMiddle: TPanel;
    PAddFilesBottom: TPanel;
    PAddFilesTop: TPanel;
    SBSaveFiles: TSpeedButton;
    SBAnnullaSaveFiles: TSpeedButton;
    SBNextFile: TSpeedButton;
    SBPrevFile: TSpeedButton;
    LCurFile: TLabel;
    ActionPrevFile: TAction;
    ActionNextFile: TAction;
    ActionSaveFiles: TAction;
    ActionAnnullaSaveFiles: TAction;
    DBEPathAddFiles: TDBEdit;
    LPathAddFiles: TLabel;
    LSezioneAddFiles: TLabel;
    LSottosezioneAddFiles: TLabel;
    LTagAddFiles: TLabel;
    CLBTagAddFiles: TCheckListBox;
    LAddTagAddFiles: TLabel;
    ENewTag: TEdit;
    SBAddTagAddFiles: TSpeedButton;
    LAddSezioneAddFiles: TLabel;
    ENewSezione: TEdit;
    SBAddSezioneAddFiles: TSpeedButton;
    LAddSottosezioneAddFiles: TLabel;
    ENewSottoSezione: TEdit;
    SBAddSottosezioneAddFiles: TSpeedButton;
    ActionAddTag: TAction;
    ActionAddSezione: TAction;
    ActionAddSottosezione: TAction;
    CBSezioneAddFiles: TComboBox;
    CBSottosezioneAddFiles: TComboBox;
    Panel1: TPanel;
    GSearchFiles: TDBGrid;
    MTSearchFiles: TFDMemTable;
    Panel2: TPanel;
    BSearchFiles: TButton;
    DSSearchFiles: TDataSource;
    MTSearchFilesFILE_NAME: TStringField;
    MTSearchFilesFILE_ID: TIntegerField;
    ActionSearchFiles: TAction;
    CDAddFiles: TClientDataSet;
    BPulisciCerca: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    procedure ActionAddSezioneExecute(Sender: TObject);
    procedure ActionAddSottosezioneExecute(Sender: TObject);
    procedure ActionAddTagExecute(Sender: TObject);
    procedure ActionAggiungiFileExecute(Sender: TObject);
    procedure ActionAnnullaSaveFilesExecute(Sender: TObject);
    procedure ActionNextFileExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionPCAggiungiExecute(Sender: TObject);
    procedure ActionPCCercaExecute(Sender: TObject);
    procedure ActionPCImpostazioniExecute(Sender: TObject);
    procedure ActionPrevFileExecute(Sender: TObject);
    procedure ActionSaveFilesExecute(Sender: TObject);
    procedure ActionSearchFilesExecute(Sender: TObject);
    procedure CBSezioneAddFilesChange(Sender: TObject);
    procedure CBSottosezioneAddFilesChange(Sender: TObject);
    procedure CLBTagAddFilesClickCheck(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TSAddFilesShow(Sender: TObject);
  private
    FIUser: IQueryUser;
    FUserID: Integer;
    FIFiles: IQueryFiles;
    FCurrentAddedFile: Integer;
    procedure SetTSCerca;
    procedure SetTSAggiungi;
    procedure SetTSImpostazioni;
    procedure LoadData;
    procedure ResizeForm;
    procedure LoadCBSezioni;
    procedure LoadCBSottosezioni;
    procedure LoadCLBTag;
    function GetCheckedTags: String;
    procedure UpdateTSAddFiles;
    procedure UpdateCurrentAddedFile(Op: String; TotFiles: Integer);
    procedure CaricaFilesSuCDAddFiles(List: TStrings);
    procedure SetFieldMTAddFiles(Field, Value: String);
    procedure AggiungiDroppedFiles(NumFiles: Integer; var Msg: TWMDropFiles);
    procedure ResizeAggiungiButton(W, H: Integer);
    procedure SetIUser(const Value: IQueryUser);
    procedure SetUserID(const Value: Integer);
    procedure SetIFiles(const Value: IQueryFiles);
    procedure SetCurrentAddedFile(const Value: Integer);
  protected
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    property IUser: IQueryUser read FIUser write SetIUser;
    property IFiles: IQueryFiles read FIFiles write SetIFiles;
    property UserID: Integer read FUserID write SetUserID;
    property CurrentAddedFile: Integer read FCurrentAddedFile
      write SetCurrentAddedFile;
  public
    procedure SetupDaUtente(Utente: Integer);
  end;

const
  FormWidth = 776;
  FormHeight = 499;

var
  LazyDocumentsForm: TLazyDocumentsForm;

implementation

{$R *.dfm}

procedure TLazyDocumentsForm.ActionAddSezioneExecute(Sender: TObject);
begin
  if ENewSezione.Text = '' then
    ShowMessage('Inserire il nome di una sezione da aggiungere')
  else if IFiles.EsisteSezione(ENewSezione.Text) then
    ShowMessage('Sezione con questo nome già esistente')
  else if not IFiles.AddSezione(ENewSezione.Text) then
    ShowMessage('Impossibile creare nuova sezione')
  else
    LoadCBSezioni;
end;

procedure TLazyDocumentsForm.ActionAddSottosezioneExecute(Sender: TObject);
begin
  if CBSezioneAddFiles.Text = '' then
    ShowMessage('Aggiungere una Sezione per la sottosezione')
  else if not IFiles.EsisteSezione(CBSezioneAddFiles.Text) then
    ShowMessage('Sezione indicata non esiste')
  else if ENewSottoSezione.Text = '' then
    ShowMessage('Inserire il nome di una sottosezione da aggiungere')
  else if IFiles.EsisteSottosezione(ENewSottoSezione.Text) then
    ShowMessage('Sottosezione con questo nome già esistente')
  else if not IFiles.AddSottosezione(CBSezioneAddFiles.Text,
    ENewSottoSezione.Text) then
    ShowMessage('Impossibile creare nuova sottosezione')
  else
    LoadCBSottosezioni;
end;

procedure TLazyDocumentsForm.ActionAddTagExecute(Sender: TObject);
begin
  if ENewTag.Text = '' then
    ShowMessage('Inserire il nome di un Tag da aggiungere')
  else if IFiles.EsisteTag(ENewTag.Text) then
    ShowMessage('Tag con questo nome già esistente')
  else if not IFiles.AddTag(ENewTag.Text) then
    ShowMessage('Impossibile creare nuovo Tag')
  else
    LoadCLBTag;
end;

procedure TLazyDocumentsForm.ActionAggiungiFileExecute(Sender: TObject);
var
  Dg: TFileOpenDialog;
begin
  Dg := TFileOpenDialog.Create(nil);
  try
    Dg.Options := Dg.Options + [fdoAllowMultiSelect];
    if Dg.Execute and (Dg.Files.Count > 0) then
      begin
        CaricaFilesSuCDAddFiles(Dg.Files);
        PCAggiungiFiles.ActivePage := TSAddFiles;
      end;
  finally
    Dg.Free;
  end;
end;

procedure TLazyDocumentsForm.ActionAnnullaSaveFilesExecute(Sender: TObject);
begin
  PCAggiungiFiles.ActivePage := TSDropFiles;
  CDAddFiles.EmptyDataSet;
end;

procedure TLazyDocumentsForm.ActionNextFileExecute(Sender: TObject);
begin
  CDAddFiles.Next;
  UpdateCurrentAddedFile('NEXT', CDAddFiles.RecordCount);
  UpdateTSAddFiles;
end;

procedure TLazyDocumentsForm.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TLazyDocumentsForm.FormCreate(Sender: TObject);
begin
  inherited;
  ChangeWindowMessageFilter(WM_DROPFILES, MSGFLT_ADD);
  ChangeWindowMessageFilter(WM_COPYDATA, MSGFLT_ADD);
  ChangeWindowMessageFilter($0049, MSGFLT_ADD);

  PCMain.ActivePage := TSCerca;

  FIUser := GetIQueryUser;
  FIFiles := GetIQueryFiles;

  MTSearchFiles.CreateDataSet;
  MTSearchFiles.Open;

  CurrentAddedFile := 1;
end;

procedure TLazyDocumentsForm.SetIFiles(const Value: IQueryFiles);
begin
  FIFiles := Value;
end;

procedure TLazyDocumentsForm.SetIUser(const Value: IQueryUser);
begin
  FIUser := Value;
end;

procedure TLazyDocumentsForm.SetCurrentAddedFile(const Value: Integer);
begin
  FCurrentAddedFile := Value;
end;

procedure TLazyDocumentsForm.SetFieldMTAddFiles(Field, Value: String);
begin
  CDAddFiles.Edit;
  CDAddFiles.FieldByName(Field).AsString := Value;
  CDAddFiles.Post;
end;

procedure TLazyDocumentsForm.SetTSAggiungi;
begin
  PCMain.ActivePage := TSAggiungi;
  PCAggiungiFiles.ActivePage := TSDropFiles;
end;

procedure TLazyDocumentsForm.SetTSCerca;
begin
  PCMain.ActivePage := TSCerca;
end;

procedure TLazyDocumentsForm.SetTSImpostazioni;
begin
  PCMain.ActivePage := TSImpostazioni;
end;

procedure TLazyDocumentsForm.SetupDaUtente(Utente: Integer);
begin
  //
end;

procedure TLazyDocumentsForm.SetUserID(const Value: Integer);
begin
  FUserID := Value;
end;

procedure TLazyDocumentsForm.WMDropFiles(var Msg: TWMDropFiles);
var
  NumFiles: Integer;
begin
  NumFiles := DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0);
  if NumFiles > 0 then
    begin
      Application.BringToFront;
      case PCMain.ActivePageIndex of
        1:
          begin
            AggiungiDroppedFiles(NumFiles, Msg);
            PCAggiungiFiles.ActivePage := TSAddFiles;
          end;
      end;
      DragFinish(Msg.Drop);
    end;
end;

procedure TLazyDocumentsForm.ActionPCAggiungiExecute(Sender: TObject);
begin
  SetTSAggiungi;
end;

procedure TLazyDocumentsForm.ActionPCCercaExecute(Sender: TObject);
begin
  SetTSCerca;
end;

procedure TLazyDocumentsForm.ActionPCImpostazioniExecute(Sender: TObject);
begin
  SetTSImpostazioni;
end;

procedure TLazyDocumentsForm.ActionPrevFileExecute(Sender: TObject);
begin
  CDAddFiles.Prior;
  UpdateCurrentAddedFile('PRIOR', CDAddFiles.RecordCount);
  UpdateTSAddFiles;
end;

procedure TLazyDocumentsForm.ActionSaveFilesExecute(Sender: TObject);
var
  UserID: Integer;
begin
  if not IUser.GetUtenteCorrente(UserID) then
    ShowMessage('Impossibile ottenere utente corrente')
  else if not IFiles.AddFiles(CDAddFiles, UserID) then
    ShowMessage('Impossime aggiungere nuovi files')
  else
    begin
      ShowMessage('Files salvati');
      PCAggiungiFiles.ActivePage := TSDropFiles;
      PCMain.ActivePage := TSCerca;
    end;
end;

procedure TLazyDocumentsForm.ActionSearchFilesExecute(Sender: TObject);
var
  UserID: Integer;
begin
  if not IUser.GetUtenteCorrente(UserID) then
    ShowMessage('Impossibile ottenere utente corrente')
  else if not IFiles.SearchFiles(MTSearchFiles, UserID) then
    ShowMessage('Impossibile cercare files')
  else
    begin
      //
    end;
end;

procedure TLazyDocumentsForm.AggiungiDroppedFiles(NumFiles: Integer;
  var Msg: TWMDropFiles);
var
  buf: array [0 .. MAX_PATH] of char;
  List: TStrings;
  I: Integer;
begin
  List := TStringList.Create;
  try
    for I := 0 to NumFiles - 1 do
      if DragQueryFile(Msg.Drop, I, buf, MAX_PATH) <> 0 then
        List.Add(buf);
    CaricaFilesSuCDAddFiles(List);
  finally
    List.Free;
  end;
end;

procedure TLazyDocumentsForm.CaricaFilesSuCDAddFiles(List: TStrings);
var
  I: Integer;
begin
  CDAddFiles.DisableControls;
  CDAddFiles.EmptyDataSet;
  try
    for I := 0 to List.Count - 1 do
      begin
        CDAddFiles.Append;
        CDAddFiles.FieldByName('FULL_PATH').AsString := List[I];
        CDAddFiles.Post;
      end;
  finally
    CDAddFiles.First;
    CDAddFiles.EnableControls;
  end;
end;

procedure TLazyDocumentsForm.CBSezioneAddFilesChange(Sender: TObject);
begin
  inherited;
  SetFieldMTAddFiles('SECTION', CBSezioneAddFiles.Text);
  UpdateTSAddFiles;
end;

procedure TLazyDocumentsForm.CBSottosezioneAddFilesChange(Sender: TObject);
begin
  inherited;
  SetFieldMTAddFiles('SUBSECTION', CBSottosezioneAddFiles.Text);
  UpdateTSAddFiles;
end;

procedure TLazyDocumentsForm.CLBTagAddFilesClickCheck(Sender: TObject);
var
  Tags: String;
begin
  inherited;
  Tags := GetCheckedTags;
  SetFieldMTAddFiles('TAGS', Tags);
end;

procedure TLazyDocumentsForm.CreateWnd;
begin
  inherited;
  DragAcceptFiles(Handle, true);
end;

procedure TLazyDocumentsForm.DestroyWnd;
begin
  DragAcceptFiles(Handle, false);
  inherited;
end;

procedure TLazyDocumentsForm.FormResize(Sender: TObject);
begin
  ResizeForm;
end;

procedure TLazyDocumentsForm.FormShow(Sender: TObject);
begin
  inherited;
  LoadData;
end;

function TLazyDocumentsForm.GetCheckedTags: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to CLBTagAddFiles.Count - 1 do
    if CLBTagAddFiles.Checked[I] then
      Result := Result + CLBTagAddFiles.Items[I] + ';';
  Result := Copy(Result, 1, System.Length(Result) - 1);
end;

procedure TLazyDocumentsForm.LoadCBSezioni;
var
  List: TStrings;
begin
  CBSezioneAddFiles.Text := '';
  List := TStringList.Create;
  try
    if IFiles.GetSezioni(List) then
      CBSezioneAddFiles.Items.Assign(List);
    CBSezioneAddFiles.ItemIndex :=
      List.IndexOf(CDAddFiles.FieldByName('SECTION').AsString);
  finally
    List.Free;
  end;
end;

procedure TLazyDocumentsForm.LoadCBSottosezioni;
var
  List: TStrings;
  Sezione: String;
begin
  CBSottosezioneAddFiles.Text := '';
  Sezione := CBSezioneAddFiles.Text;
  if Sezione <> '' then
    begin
      List := TStringList.Create;
      try
        if IFiles.GetSottosezioni(List) then
          CBSottosezioneAddFiles.Items.Assign(List);
        CBSottosezioneAddFiles.ItemIndex :=
          List.IndexOf(CDAddFiles.FieldByName('SUBSECTION').AsString);
      finally
        List.Free;
      end;
    end;
end;

procedure TLazyDocumentsForm.LoadCLBTag;
var
  List: TStrings;
  I: Integer;
begin
  List := TStringList.Create;
  try
    if IFiles.GetTag(List) then
      CLBTagAddFiles.Items.Assign(List);
    for I := 0 to CLBTagAddFiles.Count - 1 do
      CLBTagAddFiles.Checked[I] := ContainsText(CDAddFiles.FieldByName('TAGS')
        .AsString, CLBTagAddFiles.Items[I]);
  finally
    List.Free;
  end;
end;

procedure TLazyDocumentsForm.LoadData;
const
  MName = 'LoadData';
var
  Msg: String;
begin
  if not IUser.GetUtenteCorrente(FUserID) then
    begin
      Msg := 'Utente corrente non trovato.' + sLineBreak +
        'Il programma si chiuderà premendo OK. Riprovare l''accesso';
      ShowMessage(Msg);
      Logger.AddLog(Self.ClassName, MName, Msg);
      Close;
    end
  else if UserID <= 0 then
    begin
      Msg := 'Utente corrente non valido.' + sLineBreak +
        'Il programma si chiuderà premendo OK. Riprovare l''accesso';
      ShowMessage(Msg);
      Logger.AddLog(Self.ClassName, MName, Msg);
      Close;
    end
  else
    begin
      CDAddFiles.CreateDataSet;
      CDAddFiles.Open;
    end;
end;

procedure TLazyDocumentsForm.ResizeAggiungiButton(W, H: Integer);
begin
  SBAggiungiFile.Left := Round(W / 2 - 67);
  SBAggiungiFile.Top := Round(H / 2);
end;

procedure TLazyDocumentsForm.ResizeForm;
begin
  if Width < FormWidth then
    Width := FormWidth;
  if Height < FormHeight then
    Height := FormHeight;

  ResizeAggiungiButton(PDropBase.Width, PDropBase.Height);
end;

procedure TLazyDocumentsForm.TSAddFilesShow(Sender: TObject);
begin
  UpdateTSAddFiles;
end;

procedure TLazyDocumentsForm.UpdateCurrentAddedFile(Op: String;
  TotFiles: Integer);
begin
  if (Op = 'NEXT') and (CurrentAddedFile < TotFiles) then
    Inc(FCurrentAddedFile)
  else if (Op = 'PRIOR') and (CurrentAddedFile > 1) then
    Dec(FCurrentAddedFile);
end;

procedure TLazyDocumentsForm.UpdateTSAddFiles;
begin
  LCurFile.Caption := IntToStr(CurrentAddedFile) + '/' +
    IntToStr(CDAddFiles.RecordCount);
  LoadCBSezioni;
  LoadCBSottosezioni;
  LoadCLBTag;
end;

end.
