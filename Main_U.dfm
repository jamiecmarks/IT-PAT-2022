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
  object pnlMain: TPanel
    Left = 8
    Top = 79
    Width = 547
    Height = 230
    TabOrder = 1
    object lblUsername: TLabel
      Left = 330
      Top = 28
      Width = 66
      Height = 13
      Caption = 'Username'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPassword: TLabel
      Left = 338
      Top = 55
      Width = 62
      Height = 13
      Caption = 'Password'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTUsername: TLabel
      Left = 330
      Top = 110
      Width = 66
      Height = 13
      Caption = 'Username'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTPassword: TLabel
      Left = 330
      Top = 135
      Width = 62
      Height = 13
      Caption = 'Password'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnLearner: TButton
      Left = 2
      Top = 8
      Width = 545
      Height = 73
      Caption = 'Learner'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnLearnerClick
      OnMouseEnter = btnLearnerMouseEnter
      OnMouseLeave = btnLearnerMouseLeave
    end
    object edtUsername: TEdit
      Left = 400
      Top = 25
      Width = 121
      Height = 21
      Color = clGray
      TabOrder = 1
    end
    object edtPassword: TEdit
      Left = 400
      Top = 52
      Width = 121
      Height = 21
      Color = clAppWorkSpace
      PasswordChar = '*'
      TabOrder = 2
    end
    object btnTeacher: TButton
      Left = 0
      Top = 87
      Width = 545
      Height = 73
      Caption = 'Teacher'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnTeacherClick
      OnMouseEnter = btnTeacherMouseEnter
      OnMouseLeave = btnTeacherMouseLeave
    end
    object btnAdmin: TButton
      Left = 2
      Top = 166
      Width = 545
      Height = 73
      Caption = 'Database administrator'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnAdminClick
      OnMouseEnter = btnAdminMouseEnter
      OnMouseLeave = btnAdminMouseLeave
    end
    object btnReg: TButton
      Left = 224
      Top = 50
      Width = 100
      Height = 25
      Hint = 'If you do not yet have an account'
      Caption = 'Register'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnRegClick
    end
    object btnLogin: TButton
      Left = 224
      Top = 19
      Width = 100
      Height = 25
      Hint = 'If you already have an account'
      Caption = 'Log in'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object rgpGender: TRadioGroup
      Left = 17
      Top = 8
      Width = 183
      Height = 38
      Caption = 'Gender'
      Items.Strings = (
        'Male'
        'Female')
      ParentShowHint = False
      ShowHint = False
      TabOrder = 7
      WordWrap = True
    end
    object edtName: TEdit
      Left = 17
      Top = 52
      Width = 88
      Height = 21
      Color = clGray
      TabOrder = 8
      TextHint = 'First name'
    end
    object edtSurname: TEdit
      Left = 111
      Top = 52
      Width = 89
      Height = 21
      Color = clAppWorkSpace
      PasswordChar = '*'
      TabOrder = 9
      TextHint = 'Last name'
    end
    object edtTUsername: TEdit
      Left = 400
      Top = 104
      Width = 121
      Height = 21
      Color = clGray
      TabOrder = 10
    end
    object edtTName: TEdit
      Left = 25
      Top = 104
      Width = 136
      Height = 21
      Color = clGray
      TabOrder = 11
      TextHint = 'First name'
    end
    object btnCancel: TBitBtn
      Left = 468
      Top = 9
      Width = 53
      Height = 18
      Caption = 'cancel'
      DoubleBuffered = True
      Layout = blGlyphRight
      ParentDoubleBuffered = False
      TabOrder = 12
      OnClick = btnCancelClick
    end
    object edtTPassword: TEdit
      Left = 400
      Top = 131
      Width = 121
      Height = 21
      Color = clAppWorkSpace
      PasswordChar = '*'
      TabOrder = 13
    end
    object btnTLogin: TButton
      Left = 224
      Top = 99
      Width = 100
      Height = 25
      Hint = 'If you already have an account'
      Caption = 'Log in'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      OnClick = btnTLoginClick
    end
    object edtTSurname: TEdit
      Left = 25
      Top = 131
      Width = 136
      Height = 21
      Color = clAppWorkSpace
      PasswordChar = '*'
      TabOrder = 15
      TextHint = 'Last name'
    end
    object btnTReg: TButton
      Left = 224
      Top = 130
      Width = 100
      Height = 25
      Hint = 'If you already have an account'
      Caption = 'Register'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      OnClick = btnTLoginClick
    end
  end
  object btnTCancel: TBitBtn
    Left = 476
    Top = 166
    Width = 53
    Height = 19
    Caption = 'cancel'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btnTCancelClick
  end
  object menMain: TMainMenu
    Left = 184
    Top = 176
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