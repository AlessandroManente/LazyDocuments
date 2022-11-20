object LogInForm: TLogInForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 403
  ClientWidth = 539
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PBase: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 533
    Height = 397
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PTop: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 527
      Height = 110
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object LTitle: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 521
        Height = 104
        Align = alClient
        Alignment = taCenter
        Caption = 'LazyDocuments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlBottom
        ExplicitWidth = 185
        ExplicitHeight = 33
      end
    end
    object PBottom: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 119
      Width = 527
      Height = 275
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PLeft: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 100
        Height = 269
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
      end
      object PRight: TPanel
        AlignWithMargins = True
        Left = 424
        Top = 3
        Width = 100
        Height = 269
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
      end
      object PC: TPageControl
        AlignWithMargins = True
        Left = 109
        Top = 3
        Width = 309
        Height = 269
        ActivePage = TSAccedi
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 2
        object TSAccedi: TTabSheet
          AlignWithMargins = True
          Caption = 'Accedi'
          TabVisible = False
          object LOpAccedi: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 289
            Height = 19
            Align = alTop
            Alignment = taCenter
            Caption = 'Accedi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 46
          end
          object PCentral: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 28
            Width = 289
            Height = 222
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object PDatiAccedi: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 283
              Height = 94
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object LPassword: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 49
                Width = 277
                Height = 13
                Align = alTop
                Caption = 'Password:'
                ExplicitWidth = 50
              end
              object LUsername: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 277
                Height = 13
                Align = alTop
                Caption = 'Username:'
                ExplicitWidth = 52
              end
              object EUsername: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 277
                Height = 21
                Align = alTop
                TabOrder = 0
              end
              object EPassword: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 68
                Width = 277
                Height = 21
                Align = alTop
                PasswordChar = #1
                TabOrder = 1
              end
            end
            object PCentralDown: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 103
              Width = 283
              Height = 116
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object PCheck: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 277
                Height = 25
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object CBRicordami: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 97
                  Height = 19
                  Align = alLeft
                  Caption = 'Ricordami'
                  TabOrder = 0
                end
              end
              object PBtns: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 34
                Width = 277
                Height = 34
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object SBAccedi: TSpeedButton
                  AlignWithMargins = True
                  Left = 201
                  Top = 3
                  Width = 73
                  Height = 28
                  Action = ActionAccedi
                  Align = alRight
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitHeight = 42
                end
                object SBEsci: TSpeedButton
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 73
                  Height = 28
                  Action = ActionEsci
                  Align = alLeft
                  ExplicitLeft = 11
                  ExplicitTop = 6
                  ExplicitHeight = 36
                end
              end
            end
          end
        end
        object TSCrea: TTabSheet
          AlignWithMargins = True
          Caption = 'Crea'
          ImageIndex = 1
          TabVisible = False
          object LOpCrea: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 289
            Height = 19
            Align = alTop
            Alignment = taCenter
            Caption = 'Crea'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 32
          end
          object PCentralCrea: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 28
            Width = 289
            Height = 222
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object PDatiCrea: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 283
              Height = 142
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object LPasswordCrea1: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 49
                Width = 277
                Height = 13
                Align = alTop
                Caption = 'Password:'
                ExplicitWidth = 50
              end
              object LUsernameCrea: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 277
                Height = 13
                Align = alTop
                Caption = 'Username:'
                ExplicitWidth = 52
              end
              object LPasswordCrea2: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 95
                Width = 277
                Height = 13
                Align = alTop
                Caption = 'Ripeti Password:'
                ExplicitWidth = 80
              end
              object EUsernameCrea: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 22
                Width = 277
                Height = 21
                Align = alTop
                TabOrder = 0
              end
              object EPasswordCrea1: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 68
                Width = 277
                Height = 21
                Align = alTop
                PasswordChar = #1
                TabOrder = 1
              end
              object EPasswordCrea2: TEdit
                AlignWithMargins = True
                Left = 3
                Top = 114
                Width = 277
                Height = 21
                Align = alTop
                PasswordChar = #1
                TabOrder = 2
              end
            end
            object PCentralDownCrea: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 151
              Width = 283
              Height = 68
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object PCheckCrea: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 277
                Height = 25
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object CBRicordamiCrea: TCheckBox
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 97
                  Height = 19
                  Align = alLeft
                  Caption = 'Ricordami'
                  TabOrder = 0
                end
              end
              object PBtnsCrea: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 34
                Width = 277
                Height = 34
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object SBCrea: TSpeedButton
                  AlignWithMargins = True
                  Left = 201
                  Top = 3
                  Width = 73
                  Height = 28
                  Action = ActionCrea
                  Align = alRight
                  ExplicitTop = 0
                end
                object SBEsciCrea: TSpeedButton
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 73
                  Height = 28
                  Action = ActionEsci
                  Align = alLeft
                  ExplicitLeft = 11
                  ExplicitTop = 6
                  ExplicitHeight = 36
                end
              end
            end
          end
        end
      end
    end
  end
  object ActionList: TActionList
    Left = 16
    Top = 8
    object ActionEsci: TAction
      Caption = 'Esci'
      OnExecute = ActionEsciExecute
    end
    object ActionAccedi: TAction
      Caption = 'Accedi'
      OnExecute = ActionAccediExecute
    end
    object ActionCrea: TAction
      Caption = 'Crea'
      OnExecute = ActionCreaExecute
    end
  end
end
