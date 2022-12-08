object LazyDocumentsForm: TLazyDocumentsForm
  Left = 0
  Top = 0
  Caption = 'LazyDocuments'
  ClientHeight = 644
  ClientWidth = 895
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
    Height = 638
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
    ExplicitHeight = 454
    object BtnImpostazioni: TSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 609
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
    Width = 833
    Height = 638
    ActivePage = TSAggiungi
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    ExplicitWidth = 706
    ExplicitHeight = 454
    object TSCerca: TTabSheet
      AlignWithMargins = True
      Caption = 'TSCerca'
      TabVisible = False
      object PCercaBase: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 813
        Height = 616
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 686
        ExplicitHeight = 432
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 807
          Height = 118
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 680
          object Panel2: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 80
            Width = 801
            Height = 35
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 0
            ExplicitLeft = 0
            ExplicitWidth = 674
            object BSearchFiles: TButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 75
              Height = 29
              Action = ActionSearchFiles
              Align = alLeft
              TabOrder = 0
              ExplicitLeft = 596
            end
            object BPulisciCerca: TButton
              AlignWithMargins = True
              Left = 723
              Top = 3
              Width = 75
              Height = 29
              Align = alRight
              Caption = 'Pulisci'
              TabOrder = 1
              ExplicitLeft = 304
              ExplicitTop = 8
              ExplicitHeight = 25
            end
          end
          object Panel3: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 801
            Height = 71
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            ExplicitLeft = 248
            ExplicitTop = 40
            ExplicitWidth = 185
            ExplicitHeight = 41
          end
        end
        object GSearchFiles: TDBGrid
          Left = 0
          Top = 124
          Width = 813
          Height = 492
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
        Width = 813
        Height = 616
        ActivePage = TSAddFiles
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        StyleElements = [seFont, seClient]
        ExplicitWidth = 686
        ExplicitHeight = 432
        object TSDropFiles: TTabSheet
          AlignWithMargins = True
          Caption = 'TSDropFiles'
          TabVisible = False
          object PDropBase: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 793
            Height = 594
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            ExplicitWidth = 666
            ExplicitHeight = 410
            object LDragFile: TLabel
              Left = 0
              Top = 0
              Width = 793
              Height = 594
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
            Width = 793
            Height = 594
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            ExplicitWidth = 666
            ExplicitHeight = 410
            object PAddFilesMiddle: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 43
              Width = 787
              Height = 508
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              ExplicitWidth = 660
              ExplicitHeight = 324
              object Panel4: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 781
                Height = 502
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 787
                ExplicitHeight = 465
                object Panel5: TPanel
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 775
                  Height = 48
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 0
                  ExplicitLeft = 1
                  ExplicitTop = 1
                  ExplicitWidth = 785
                  object LPathAddFiles: TLabel
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 769
                    Height = 13
                    Align = alTop
                    Caption = 'Nome File:'
                    ExplicitWidth = 54
                  end
                  object DBEPathAddFiles: TDBEdit
                    AlignWithMargins = True
                    Left = 3
                    Top = 22
                    Width = 769
                    Height = 21
                    Align = alTop
                    DataField = 'FULL_PATH'
                    DataSource = DSAddFiles
                    TabOrder = 0
                    ExplicitWidth = 781
                  end
                end
                object Panel6: TPanel
                  AlignWithMargins = True
                  Left = 3
                  Top = 57
                  Width = 775
                  Height = 112
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 1
                  object Panel7: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 33
                    Width = 769
                    Height = 32
                    Align = alTop
                    BevelOuter = bvNone
                    TabOrder = 0
                    ExplicitLeft = 1
                    ExplicitTop = 25
                    ExplicitWidth = 783
                    object CBSezioneAddFiles: TComboBox
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 300
                      Height = 21
                      Align = alLeft
                      TabOrder = 0
                      OnChange = CBSezioneAddFilesChange
                      ExplicitTop = 27
                    end
                    object ENewSezione: TEdit
                      AlignWithMargins = True
                      Left = 466
                      Top = 3
                      Width = 300
                      Height = 26
                      Align = alRight
                      TabOrder = 1
                      ExplicitLeft = 331
                      ExplicitTop = 27
                      ExplicitHeight = 21
                    end
                  end
                  object Panel8: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 769
                    Height = 24
                    Align = alTop
                    BevelOuter = bvNone
                    TabOrder = 1
                    ExplicitLeft = 1
                    ExplicitTop = 1
                    ExplicitWidth = 783
                    object LSezioneAddFiles: TLabel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 43
                      Height = 18
                      Align = alLeft
                      Caption = 'Sezione:'
                      ExplicitTop = 35
                      ExplicitHeight = 13
                    end
                    object LAddSezioneAddFiles: TLabel
                      AlignWithMargins = True
                      Left = 672
                      Top = 3
                      Width = 94
                      Height = 18
                      Align = alRight
                      Caption = 'Aggiungi Sezione:'
                      ExplicitLeft = 335
                      ExplicitTop = 11
                      ExplicitHeight = 13
                    end
                  end
                  object Panel9: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 71
                    Width = 769
                    Height = 38
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 2
                    ExplicitHeight = 22
                    object SBAddSezioneAddFiles: TSpeedButton
                      AlignWithMargins = True
                      Left = 696
                      Top = 3
                      Width = 70
                      Height = 32
                      Action = ActionAddSezione
                      Align = alRight
                      ExplicitLeft = 561
                      ExplicitTop = 56
                      ExplicitHeight = 28
                    end
                  end
                end
                object Panel10: TPanel
                  AlignWithMargins = True
                  Left = 3
                  Top = 175
                  Width = 775
                  Height = 110
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 2
                  object Panel11: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 769
                    Height = 27
                    Align = alTop
                    BevelOuter = bvNone
                    TabOrder = 0
                    ExplicitLeft = 1
                    ExplicitTop = 5
                    ExplicitWidth = 783
                    object LAddSottosezioneAddFiles: TLabel
                      AlignWithMargins = True
                      Left = 645
                      Top = 3
                      Width = 121
                      Height = 21
                      Align = alRight
                      Caption = 'Aggiungi Sottosezione:'
                      ExplicitLeft = 335
                      ExplicitTop = 32
                      ExplicitHeight = 13
                    end
                    object LSottosezioneAddFiles: TLabel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 70
                      Height = 21
                      Align = alLeft
                      Caption = 'Sottosezione:'
                      ExplicitTop = 32
                      ExplicitHeight = 13
                    end
                  end
                  object Panel12: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 36
                    Width = 769
                    Height = 31
                    Align = alTop
                    BevelOuter = bvNone
                    TabOrder = 1
                    ExplicitLeft = 1
                    ExplicitTop = 28
                    ExplicitWidth = 783
                    object CBSottosezioneAddFiles: TComboBox
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 300
                      Height = 21
                      Align = alLeft
                      TabOrder = 0
                      OnChange = CBSottosezioneAddFilesChange
                      ExplicitTop = 24
                    end
                    object ENewSottoSezione: TEdit
                      AlignWithMargins = True
                      Left = 466
                      Top = 3
                      Width = 300
                      Height = 25
                      Align = alRight
                      TabOrder = 1
                      ExplicitLeft = 331
                      ExplicitTop = 24
                      ExplicitHeight = 21
                    end
                  end
                  object Panel13: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 73
                    Width = 769
                    Height = 34
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 2
                    ExplicitLeft = 2
                    ExplicitTop = 65
                    ExplicitWidth = 783
                    ExplicitHeight = 44
                    object SBAddSottosezioneAddFiles: TSpeedButton
                      AlignWithMargins = True
                      Left = 696
                      Top = 3
                      Width = 70
                      Height = 28
                      Action = ActionAddSottosezione
                      Align = alRight
                      ExplicitLeft = 561
                      ExplicitTop = 120
                    end
                  end
                end
                object Panel14: TPanel
                  AlignWithMargins = True
                  Left = 3
                  Top = 291
                  Width = 775
                  Height = 208
                  Align = alClient
                  BevelOuter = bvNone
                  TabOrder = 3
                  ExplicitLeft = 296
                  ExplicitTop = 330
                  ExplicitWidth = 185
                  ExplicitHeight = 41
                  object Panel15: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 769
                    Height = 24
                    Align = alTop
                    BevelOuter = bvNone
                    TabOrder = 0
                    ExplicitLeft = 1
                    ExplicitTop = 1
                    ExplicitWidth = 783
                    object LAddTagAddFiles: TLabel
                      AlignWithMargins = True
                      Left = 708
                      Top = 3
                      Width = 58
                      Height = 18
                      Align = alRight
                      Caption = 'Nuovo Tag:'
                      ExplicitLeft = 331
                      ExplicitTop = 28
                      ExplicitHeight = 13
                    end
                    object LTagAddFiles: TLabel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 21
                      Height = 18
                      Align = alLeft
                      Caption = 'Tag:'
                      ExplicitTop = 28
                      ExplicitHeight = 13
                    end
                  end
                  object Panel16: TPanel
                    AlignWithMargins = True
                    Left = 460
                    Top = 33
                    Width = 312
                    Height = 172
                    Align = alRight
                    BevelOuter = bvNone
                    TabOrder = 1
                    ExplicitLeft = 472
                    ExplicitTop = 25
                    ExplicitHeight = 189
                    object Panel17: TPanel
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 306
                      Height = 32
                      Align = alTop
                      BevelOuter = bvNone
                      TabOrder = 0
                      ExplicitLeft = 1
                      ExplicitTop = 1
                      ExplicitWidth = 310
                      object ENewTag: TEdit
                        AlignWithMargins = True
                        Left = 3
                        Top = 3
                        Width = 300
                        Height = 26
                        Align = alRight
                        TabOrder = 0
                        ExplicitLeft = 50
                        ExplicitTop = 20
                        ExplicitHeight = 21
                      end
                    end
                    object Panel18: TPanel
                      AlignWithMargins = True
                      Left = 3
                      Top = 41
                      Width = 306
                      Height = 41
                      Align = alTop
                      BevelOuter = bvNone
                      TabOrder = 1
                      ExplicitLeft = 64
                      ExplicitTop = 72
                      ExplicitWidth = 185
                      object SBAddTagAddFiles: TSpeedButton
                        AlignWithMargins = True
                        Left = 233
                        Top = 3
                        Width = 70
                        Height = 35
                        Action = ActionAddTag
                        Align = alRight
                        ExplicitLeft = 240
                        ExplicitTop = 13
                        ExplicitHeight = 28
                      end
                    end
                  end
                  object Panel19: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 33
                    Width = 304
                    Height = 172
                    Align = alLeft
                    BevelOuter = bvNone
                    TabOrder = 2
                    ExplicitLeft = 1
                    ExplicitTop = 25
                    ExplicitHeight = 189
                    object CLBTagAddFiles: TCheckListBox
                      AlignWithMargins = True
                      Left = 3
                      Top = 3
                      Width = 298
                      Height = 166
                      OnClickCheck = CLBTagAddFilesClickCheck
                      Align = alClient
                      ItemHeight = 13
                      TabOrder = 0
                      ExplicitLeft = 41
                      ExplicitTop = 59
                      ExplicitWidth = 300
                      ExplicitHeight = 108
                    end
                  end
                end
              end
            end
            object PAddFilesBottom: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 557
              Width = 787
              Height = 34
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 1
              ExplicitTop = 373
              ExplicitWidth = 660
              object SBSaveFiles: TSpeedButton
                AlignWithMargins = True
                Left = 714
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
              Width = 787
              Height = 34
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
              ExplicitWidth = 660
              object SBNextFile: TSpeedButton
                AlignWithMargins = True
                Left = 756
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
                Width = 719
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
        Width = 813
        Height = 616
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 686
        ExplicitHeight = 432
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
