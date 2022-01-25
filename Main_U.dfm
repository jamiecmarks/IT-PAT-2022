object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Welcome'
  ClientHeight = 325
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlIntro: TPanel
    Left = 8
    Top = 8
    Width = 545
    Height = 73
    Caption = 'Who are you?'
    Color = clSilver
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object btnLearner: TButton
    Left = 8
    Top = 87
    Width = 545
    Height = 73
    Caption = 'Learner'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnMouseEnter = btnLearnerMouseEnter
    OnMouseLeave = btnLearnerMouseLeave
  end
  object btnTeacher: TButton
    Left = 8
    Top = 166
    Width = 545
    Height = 73
    Caption = 'Teacher'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnMouseEnter = btnTeacherMouseEnter
    OnMouseLeave = btnTeacherMouseLeave
  end
  object btnAdmin: TButton
    Left = 10
    Top = 244
    Width = 545
    Height = 73
    Caption = 'Dataase administrator'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnMouseEnter = btnAdminMouseEnter
    OnMouseLeave = btnAdminMouseLeave
  end
  object menMain: TMainMenu
    Left = 272
    Top = 160
    object OurStory1: TMenuItem
      Caption = 'Our Story'
      OnClick = OurStory1Click
    end
    object Resourcecentre1: TMenuItem
      Caption = 'Resource centre'
    end
    object Help1: TMenuItem
      Caption = 'Help'
    end
    object Ourgithub1: TMenuItem
      Caption = 'Our github'
      OnClick = Ourgithub1Click
    end
  end
end
