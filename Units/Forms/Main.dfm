object LazyDocumentsForm: TLazyDocumentsForm
  Left = 0
  Top = 0
  Caption = 'LazyDocuments'
  ClientHeight = 457
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SplitView: TSplitView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 50
    Height = 451
    OpenedWidth = 50
    Placement = svpLeft
    TabOrder = 0
    UseAnimation = False
    object BtnImpostazioni: TSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 426
      Width = 44
      Height = 22
      Action = ActionPCImpostazioni
      Align = alBottom
      ExplicitLeft = 16
      ExplicitTop = 24
      ExplicitWidth = 23
    end
    object BtnAggiungi: TSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 31
      Width = 44
      Height = 22
      Action = ActionPCAggiungi
      Align = alTop
      ExplicitLeft = 6
      ExplicitTop = 11
    end
    object BtnCerca: TSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 44
      Height = 22
      Action = ActionPCCerca
      Align = alTop
      ExplicitLeft = 6
      ExplicitTop = 11
    end
  end
  object PageCon: TPageControl
    AlignWithMargins = True
    Left = 59
    Top = 3
    Width = 698
    Height = 451
    ActivePage = TSCerca
    Align = alClient
    TabOrder = 1
    object TSCerca: TTabSheet
      AlignWithMargins = True
      Caption = 'TSCerca'
      TabVisible = False
      object PCercaBase: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 678
        Height = 429
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
    object TSAggiungi: TTabSheet
      AlignWithMargins = True
      Caption = 'TSAggiungi'
      ImageIndex = 1
      TabVisible = False
      object PAggiungiBase: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 678
        Height = 429
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
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
        Width = 678
        Height = 429
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object ActList: TActionList
    Left = 80
    Top = 24
    object ActionPCCerca: TAction
      OnExecute = ActionPCCercaExecute
    end
    object ActionPCAggiungi: TAction
      OnExecute = ActionPCAggiungiExecute
    end
    object ActionPCImpostazioni: TAction
      OnExecute = ActionPCImpostazioniExecute
    end
  end
end