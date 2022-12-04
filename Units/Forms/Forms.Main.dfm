object LazyDocumentsForm: TLazyDocumentsForm
  Left = 0
  Top = 0
  Caption = 'LazyDocuments'
  ClientHeight = 460
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SplitView: TSplitView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 50
    Height = 454
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    OpenedWidth = 50
    ParentFont = False
    Placement = svpLeft
    TabOrder = 0
    UseAnimation = False
    object BtnImpostazioni: TSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 425
      Width = 44
      Height = 26
      Action = ActionPCImpostazioni
      Align = alBottom
      ExplicitTop = 426
      ExplicitWidth = 54
    end
    object BtnAggiungi: TSpeedButton
      Tag = 2
      AlignWithMargins = True
      Left = 3
      Top = 35
      Width = 44
      Height = 26
      Action = ActionPCAggiungi
      Align = alTop
      ExplicitTop = 31
      ExplicitWidth = 54
    end
    object BtnCerca: TSpeedButton
      Tag = 1
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 44
      Height = 26
      Action = ActionPCCerca
      Align = alTop
      ExplicitWidth = 54
    end
  end
  object PCMain: TPageControl
    AlignWithMargins = True
    Left = 59
    Top = 3
    Width = 706
    Height = 454
    ActivePage = TSCerca
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object TSCerca: TTabSheet
      AlignWithMargins = True
      Caption = 'TSCerca'
      TabVisible = False
      object PCercaBase: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 686
        Height = 432
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 680
          Height = 118
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Panel2: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 80
            Width = 674
            Height = 35
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 0
            object BSearchFiles: TButton
              AlignWithMargins = True
              Left = 596
              Top = 3
              Width = 75
              Height = 29
              Action = ActionSearchFiles
              Align = alRight
              TabOrder = 0
              ExplicitTop = 6
            end
          end
        end
        object GSearchFiles: TDBGrid
          Left = 0
          Top = 124
          Width = 686
          Height = 308
          Align = alClient
          DataSource = DSSearchFiles
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'FILE_ID'
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'FILE_NAME'
              Visible = True
            end>
        end
      end
    end
    object TSAggiungi: TTabSheet
      AlignWithMargins = True
      Caption = 'TSAggiungi'
      ImageIndex = 1
      TabVisible = False
      object PCAggiungiFiles: TPageControl
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 686
        Height = 432
        ActivePage = TSAddFiles
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        StyleElements = [seFont, seClient]
        object TSDropFiles: TTabSheet
          AlignWithMargins = True
          Caption = 'TSDropFiles'
          TabVisible = False
          object PDropBase: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 666
            Height = 410
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object LDragFile: TLabel
              Left = 0
              Top = 0
              Width = 666
              Height = 410
              Align = alClient
              Alignment = taCenter
              Caption = 'Trascina file qui'#13#10'o...'#13#10#13#10
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -27
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
              ExplicitWidth = 182
              ExplicitHeight = 148
            end
            object SBAggiungiFile: TSpeedButton
              Left = 248
              Top = 208
              Width = 145
              Height = 49
              Action = ActionAggiungiFile
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
          end
        end
        object TSAddFiles: TTabSheet
          AlignWithMargins = True
          Caption = 'TSAddFiles'
          ImageIndex = 1
          TabVisible = False
          OnShow = TSAddFilesShow
          object PAddFilesBase: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 666
            Height = 410
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object PAddFilesMiddle: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 43
              Width = 660
              Height = 324
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object LPathAddFiles: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 654
                Height = 13
                Align = alTop
                Caption = 'Nome File:'
                ExplicitWidth = 54
              end
              object LSezioneAddFiles: TLabel
                Left = 3
                Top = 49
                Width = 43
                Height = 13
                Caption = 'Sezione:'
              end
              object LSottosezioneAddFiles: TLabel
                Left = 3
                Top = 123
                Width = 70
                Height = 13
                Caption = 'Sottosezione:'
              end
              object LTagAddFiles: TLabel
                Left = 3
                Top = 197
                Width = 21
                Height = 13
                Caption = 'Tag:'
              end
              object LAddTagAddFiles: TLabel
                Left = 331
                Top = 197
                Width = 58
                Height = 13
                Caption = 'Nuovo Tag:'
              end
              object SBAddTagAddFiles: TSpeedButton
                Left = 561
                Top = 243
                Width = 70
                Height = 28
                Action = ActionAddTag
              end
              object LAddSezioneAddFiles: TLabel
                Left = 335
                Top = 49
                Width = 94
                Height = 13
                Caption = 'Aggiungi Sezione:'
              end
              object SBAddSezioneAddFiles: TSpeedButton
                Left = 561
                Top = 90
                Width = 70
                Height = 28
                Action = ActionAddSezione
              end
              object LAddSottosezioneAddFiles: TLabel
                Left = 335
                Top = 123
                Width = 121
                Height = 13
                Caption = 'Aggiungi Sottosezione:'
              end
              object SBAddSottosezioneAddFiles: TSpeedButton
                Left = 561
                Top = 164
                Width = 70
                Height = 28
                Action = ActionAddSottosezione
              end
              object DBEPathAddFiles: TDBEdit
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 654
                Height = 21
                Align = alTop
                DataField = 'FULL_PATH'
                DataSource = DSAddFiles
                TabOrder = 0
              end
              object CLBTagAddFiles: TCheckListBox
                Left = 3
                Top = 216
                Width = 300
                Height = 108
                OnClickCheck = CLBTagAddFilesClickCheck
                ItemHeight = 13
                TabOrder = 1
              end
              object ENewTag: TEdit
                Left = 331
                Top = 216
                Width = 300
                Height = 21
                TabOrder = 2
              end
              object ENewSezione: TEdit
                Left = 331
                Top = 68
                Width = 300
                Height = 21
                TabOrder = 3
              end
              object ENewSottoSezione: TEdit
                Left = 331
                Top = 142
                Width = 300
                Height = 21
                TabOrder = 4
              end
              object CBSezioneAddFiles: TComboBox
                Left = 3
                Top = 68
                Width = 300
                Height = 21
                TabOrder = 5
                OnChange = CBSezioneAddFilesChange
              end
              object CBSottosezioneAddFiles: TComboBox
                Left = 3
                Top = 142
                Width = 300
                Height = 21
                TabOrder = 6
                OnChange = CBSottosezioneAddFilesChange
              end
            end
            object PAddFilesBottom: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 373
              Width = 660
              Height = 34
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 1
              object SBSaveFiles: TSpeedButton
                AlignWithMargins = True
                Left = 587
                Top = 3
                Width = 70
                Height = 28
                Action = ActionSaveFiles
                Align = alRight
                ExplicitLeft = 609
                ExplicitHeight = 35
              end
              object SBAnnullaSaveFiles: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 70
                Height = 28
                Action = ActionAnnullaSaveFiles
                Align = alLeft
                ExplicitHeight = 35
              end
            end
            object PAddFilesTop: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 660
              Height = 34
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
              object SBNextFile: TSpeedButton
                AlignWithMargins = True
                Left = 629
                Top = 3
                Width = 28
                Height = 28
                Action = ActionNextFile
                Align = alRight
                ExplicitLeft = 600
              end
              object SBPrevFile: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 28
                Height = 28
                Action = ActionPrevFile
                Align = alLeft
              end
              object LCurFile: TLabel
                Left = 34
                Top = 0
                Width = 592
                Height = 34
                Align = alClient
                Alignment = taCenter
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                Layout = tlCenter
                ExplicitWidth = 3
                ExplicitHeight = 15
              end
            end
          end
        end
      end
    end
    object TSImpostazioni: TTabSheet
      AlignWithMargins = True
      Caption = 'TSImpostazioni'
      ImageIndex = 2
      TabVisible = False
      object PImpostazioniBase: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 686
        Height = 432
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object ActList: TActionList
    Left = 40
    Top = 72
    object ActionPCCerca: TAction
      OnExecute = ActionPCCercaExecute
    end
    object ActionPCAggiungi: TAction
      Caption = 'Aggiungi'
      OnExecute = ActionPCAggiungiExecute
    end
    object ActionPCImpostazioni: TAction
      OnExecute = ActionPCImpostazioniExecute
    end
    object ActionAggiungiFile: TAction
      Caption = 'Aggiungi File'
      OnExecute = ActionAggiungiFileExecute
    end
    object ActionPrevFile: TAction
      Caption = '<'
      OnExecute = ActionPrevFileExecute
    end
    object ActionNextFile: TAction
      Caption = '>'
      OnExecute = ActionNextFileExecute
    end
    object ActionSaveFiles: TAction
      Caption = 'Salva'
      OnExecute = ActionSaveFilesExecute
    end
    object ActionAnnullaSaveFiles: TAction
      Caption = 'Annulla'
      OnExecute = ActionAnnullaSaveFilesExecute
    end
    object ActionAddTag: TAction
      Caption = 'Aggiungi'
      OnExecute = ActionAddTagExecute
    end
    object ActionAddSezione: TAction
      Caption = 'Aggiungi'
      OnExecute = ActionAddSezioneExecute
    end
    object ActionAddSottosezione: TAction
      Caption = 'Aggiungi'
      OnExecute = ActionAddSottosezioneExecute
    end
    object ActionSearchFiles: TAction
      Caption = 'Ricerca'
      OnExecute = ActionSearchFilesExecute
    end
  end
  object DSAddFiles: TDataSource
    DataSet = CDAddFiles
    Left = 40
    Top = 168
  end
  object MTSearchFiles: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 40
    Top = 312
    object MTSearchFilesFILE_ID: TIntegerField
      FieldName = 'FILE_ID'
    end
    object MTSearchFilesFILE_NAME: TStringField
      FieldName = 'FILE_NAME'
      Size = 100
    end
  end
  object DSSearchFiles: TDataSource
    DataSet = MTSearchFiles
    Left = 40
    Top = 360
  end
  object CDAddFiles: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'FULL_PATH'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'SECTION'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'SUBSECTION'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'TAGS'
        DataType = ftMemo
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 120
  end
end
