unit Main_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Splash_U, ExtCtrls, shellapi, Menus, Buttons, dbAdmin_u,
  pngimage;

type
  TfrmMain = class(TForm)
    pnlIntro: TPanel;
    btnLearner: TButton;
    btnTeacher: TButton;
    btnAdmin: TButton;
    menMain: TMainMenu;
    OurStory1: TMenuItem;
    Resourcecentre1: TMenuItem;
    Help1: TMenuItem;
    Ourgithub1: TMenuItem;
    edtUsername: TEdit;
    edtPassword: TEdit;
    pnlMain: TPanel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    btnReg: TButton;
    btnLogin: TButton;
    btnCancel: TBitBtn;
    rgpGender: TRadioGroup;
    edtName: TEdit;
    edtSurname: TEdit;
    edtTPassword: TEdit;
    btnTLogin: TButton;
    edtTSurname: TEdit;
    edtTUsername: TEdit;
    edtTName: TEdit;
    lblTUsername: TLabel;
    lblTPassword: TLabel;
    btnTReg: TButton;
    btnTCancel: TBitBtn;
    imgEyeOpen: TImage;
    imgEyeClosed: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnLearnerMouseEnter(Sender: TObject);
    procedure btnLearnerMouseLeave(Sender: TObject);
    procedure btnTeacherMouseEnter(Sender: TObject);
    procedure btnTeacherMouseLeave(Sender: TObject);
    procedure btnAdminMouseEnter(Sender: TObject);
    procedure btnAdminMouseLeave(Sender: TObject);
    procedure OurStory1Click(Sender: TObject);
    procedure Ourgithub1Click(Sender: TObject);
    procedure btnLearnerClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure btnTLoginClick(Sender: TObject);
    procedure btnTCancelClick(Sender: TObject);
    procedure btnTeacherClick(Sender: TObject);
    procedure btnAdminClick(Sender: TObject);
    procedure imgEyeOpenClick(Sender: TObject);
    procedure imgEyeClosedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  // going back to the main home page
  edtUsername.Visible := False;
  edtPassword.Visible := False;
  lblUsername.Visible := False;
  lblPassword.Visible := False;
  btnLearner.Show;
  btnReg.Visible := False;
  btnLogin.Visible := False;
  btnCancel.Hide;
  btnLogin.Enabled := True;
  rgpGender.Visible := False;
  edtName.Hide;
  edtSurname.Hide;
  imgEyeOpen.Hide;
  imgEyeclosed.Hide;

end;

procedure TfrmMain.btnAdminClick(Sender: TObject);
begin
  frmDBAdmin.Show;
end;

procedure TfrmMain.btnAdminMouseEnter(Sender: TObject);
begin
  btnAdmin.font.Size := 12;
  pnlIntro.Color := clMoneyGreen;
  pnlMain.Color := clMoneyGreen;
end;

procedure TfrmMain.btnAdminMouseLeave(Sender: TObject);
begin
  btnAdmin.font.Size := 10;
  pnlIntro.Color := clSilver;
  pnlMain.Color := clSilver;
end;

procedure TfrmMain.btnLearnerClick(Sender: TObject);
begin
  // showing the appropriate components for login as a student
  btnLearner.Hide;
  edtUsername.Show;
  edtPassword.Show;
  lblUsername.Visible := True;
  lblPassword.Visible := True;
  btnReg.Visible := True;
  btnLogin.Visible := True;
  btnCancel.Show;
  imgEyeOpen.Show;

end;

procedure TfrmMain.btnLearnerMouseEnter(Sender: TObject);
begin
  btnLearner.font.Size := 12;
  pnlIntro.Color := clBlue;
  pnlMain.Color := clBlue;

end;

procedure TfrmMain.btnLearnerMouseLeave(Sender: TObject);
begin
  btnLearner.font.Size := 10;
  pnlIntro.Color := clSilver;
  pnlMain.Color := clSilver;

end;

procedure TfrmMain.btnRegClick(Sender: TObject);
begin
  // showing and hidint appropriate components for registering a new account
  btnLogin.Enabled := False;
  MessageDlg(
    'Please fill out the rest of your information and press the "register button" once you have done that', mtWarning, [mbOK], 0);
  edtName.Show;
  edtSurname.Show;
  rgpGender.Show;
end;

procedure TfrmMain.btnTCancelClick(Sender: TObject);
begin
  // remove the log in components
  edtTUsername.Visible := False;
  edtTPassword.Visible := False;
  lblTUsername.Visible := False;
  lblTPassword.Visible := False;
  btnTeacher.Show;
  btnTReg.Visible := False;
  btnTLogin.Visible := False;
  btnTCancel.Hide;
  btnTLogin.Enabled := True;
  edtTName.Hide;
  edtTSurname.Hide;
end;

procedure TfrmMain.btnTeacherClick(Sender: TObject);
begin
  btnTeacher.Hide;
  edtTUsername.Show;
  edtTPassword.Show;
  lblTUsername.Visible := True;
  lblTPassword.Visible := True;
  btnTReg.Visible := True;
  btnTLogin.Visible := True;
  btnTCancel.Show;

end;

procedure TfrmMain.btnTeacherMouseEnter(Sender: TObject);
begin
  btnTeacher.font.Size := 12;
  pnlIntro.Color := clTeal;
  pnlMain.Color := clTeal;

end;

procedure TfrmMain.btnTeacherMouseLeave(Sender: TObject);
begin
  btnTeacher.font.Size := 10;
  pnlIntro.Color := clSilver;
  pnlMain.Color := clSilver;
end;

procedure TfrmMain.btnTLoginClick(Sender: TObject);
begin
  // showing and hidint appropriate components for registering a new account
  btnTLogin.Enabled := False;
  MessageDlg(
    'Please fill out the rest of your information and press the "register button" once you have done that', mtWarning, [mbOK], 0);
  edtTName.Show;
  edtTSurname.Show;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmsplash.showmodal;
  edtPassword.Hide;
  edtUsername.Hide;
  lblUsername.Visible := False;
  lblPassword.Visible := False;
  btnReg.Visible := False;
  btnLogin.Visible := False;
  btnCancel.Hide;
  rgpGender.Visible := False;
  edtName.Hide;
  edtSurname.Hide;
  imgEyeOpen.Hide;
  imgEyeClosed.hide;

  edtTPassword.Hide;
  edtTUsername.Hide;
  lblTUsername.Visible := False;
  lblTPassword.Visible := False;
  btnTReg.Visible := False;
  btnTLogin.Visible := False;
  btnTCancel.Hide;
  edtTName.Hide;
  edtTSurname.Hide;

end;

procedure TfrmMain.imgEyeClosedClick(Sender: TObject);
begin
edtPassword.PasswordChar := '*';
imgEyeCLosed.Hide;
imgEyeopen.Show;
end;

procedure TfrmMain.imgEyeOpenClick(Sender: TObject);
begin
edtPassword.PasswordChar := #0;
imgEyeOpen.Hide;
imgEyeClosed.Show;
end;

procedure TfrmMain.Ourgithub1Click(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('https://github.com/jamiecmarks/IT-PAT-2022'),
    nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.OurStory1Click(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('ourstory.html'), nil, nil, SW_SHOWNORMAL);
end;

end.
