object frmDbAdmin: TfrmDbAdmin
  Left = 0
  Top = 0
  Caption = 'Database admin'
  ClientHeight = 510
  ClientWidth = 1064
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTutors: TLabel
    Left = 260
    Top = -2
    Width = 100
    Height = 20
    Caption = 'Tutors table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSessions: TLabel
    Left = 260
    Top = 254
    Width = 116
    Height = 20
    Caption = 'Sessions table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblStudents: TLabel
    Left = 717
    Top = -2
    Width = 123
    Height = 20
    Caption = 'Students Table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSubjects: TLabel
    Left = 842
    Top = 254
    Width = 120
    Height = 20
    Caption = 'Subjects Table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbgridTutors: TDBGrid
    Left = 8
    Top = 24
    Width = 522
    Height = 193
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigatorTutors: TDBNavigator
    Left = 8
    Top = 223
    Width = 520
    Height = 25
    TabOrder = 1
  end
  object DBGridSessions: TDBGrid
    Left = 2
    Top = 280
    Width = 760
    Height = 193
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigatorSessions: TDBNavigator
    Left = 2
    Top = 479
    Width = 760
    Height = 25
    TabOrder = 3
  end
  object DBGridStudents: TDBGrid
    Left = 536
    Top = 24
    Width = 520
    Height = 193
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigatorStudents: TDBNavigator
    Left = 536
    Top = 223
    Width = 520
    Height = 25
    TabOrder = 5
  end
  object DBGridSubjects: TDBGrid
    Left = 776
    Top = 280
    Width = 280
    Height = 193
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigatorSubjects: TDBNavigator
    Left = 776
    Top = 479
    Width = 280
    Height = 25
    TabOrder = 7
  end
  object MainMenu1: TMainMenu
    Left = 242
    Top = 296
    object fff1: TMenuItem
      Caption = 'Queries'
    end
    object Exit1: TMenuItem
      Caption = 'Exit'
      OnClick = Exit1Click
    end
  end
end
