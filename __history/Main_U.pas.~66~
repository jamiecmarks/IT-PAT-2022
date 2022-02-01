unit Main_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Splash_U, ExtCtrls, shellapi, Menus, Buttons,
  pngimage, Queries_u;

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
    edtTPassword: TEdit;
    btnTLogin: TButton;
    edtTUsername: TEdit;
    lblTUsername: TLabel;
    lblTPassword: TLabel;
    btnTCancel: TBitBtn;
    imgEyeOpen: TImage;
    imgEyeClosed: TImage;
    imgTEyeOpen: TImage;
    imgTEyeClosed: TImage;
    btnTReg: TButton;
    edtSurname: TEdit;
    edtName: TEdit;
    edtTName: TEdit;
    edtTSurname: TEdit;
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
    procedure btnTCancelClick(Sender: TObject);
    procedure btnTeacherClick(Sender: TObject);
    procedure btnAdminClick(Sender: TObject);
    procedure imgEyeOpenClick(Sender: TObject);
    procedure imgEyeClosedClick(Sender: TObject);
    procedure HideAllTeacher(bAffect: boolean);
    function Decrypt(sKey: string; EncryptedText: string): string;
    function KeyCreator(sKeyword: string): string;
    function Encrypt(sKey: string; PlainText: string): string;
    procedure btnTRegClick(Sender: TObject);
    procedure btnReg2Click(Sender: TObject);
    procedure btnTReg2Click(Sender: TObject);
  private
    procedure HideAllLearner(bAffect: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  sKey: string;
  btnReg2: TButton; // dynamically instantiated object
  btnTReg2: TButton; // dynamically instantiated object

implementation

{$R *.dfm}

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  // going back to the main home page
  HideAllLearner(True);
  imgTEyeClosed.Hide;
  imgTEyeOpen.Hide;
  if assigned(btnReg2) then // if the second register button has been instantiated
  begin
    btnReg2.visible := False;
  end;
end;

procedure TfrmMain.btnAdminClick(Sender: TObject);
var
  sEnteredPass: string;
  myFile: textfile;
  sEncryptedPass: string;
begin
  btnLearner.Show;
  btnTeacher.Show;
  HideAllTeacher(True);
  HideAllLearner(True);
  // reading in the encrypted textfile so it can be used to check against the user entered passcode for admin
  assignfile(myFile, 'EncryptedAdminPassword.txt');
  // myfile assinged to the textfile
  reset(myFile); // reading the passcode from the textfile int o the sEncryptedpass variable
  while not eof(myFile) do
  begin
    readln(myFile, sEncryptedPass);
  end;
  closefile(myFile); // closefile for sEncryptedPass

  sEnteredPass := inputbox('Enter the admin password', '', 'technotutors');
  if sEnteredPass = Decrypt(KeyCreator(sKey), sEncryptedPass) then
  // comparing decrypted passcode to user entered passcode
  begin
    showmessage('Welcome Admin');
    frmQueries.ShowModal;
  end
  else
  begin
    Dialogs.MessageDlg('The entered password is incorrect, please try again',
      // if the passcode does not match the correct decrypted passcode
      mtInformation, [mbOk], 0, mbOk);
  end;

end;

procedure TfrmMain.btnAdminMouseEnter(Sender: TObject);
begin
  // changing the style of the display panel when hovering over admin button for flare
  btnAdmin.font.Size := 12;
  pnlIntro.Color := clMoneyGreen;
  pnlMain.Color := clMoneyGreen;
end;

procedure TfrmMain.btnAdminMouseLeave(Sender: TObject);
begin
  // changing the style of the display panel when hovering over admin button for flare
  btnAdmin.font.Size := 10;
  pnlIntro.Color := clSilver;
  pnlMain.Color := clSilver;
end;

procedure TfrmMain.btnLearnerClick(Sender: TObject);
begin
  // showing the appropriate components for login as a student
  HideAllLearner(False);

  // closing the panes for the other 2 options which is more intuitive and less confusing
  HideAllTeacher(True);
  btnTeacher.Show;
  btnAdmin.Show;

end;

procedure TfrmMain.btnLearnerMouseEnter(Sender: TObject);
begin
  // changing the style of the display panel when hovering over admin button for flare
  btnLearner.font.Size := 12;
  pnlIntro.Color := clBlue;
  pnlMain.Color := clBlue;
  imgEyeOpen.Hide;
  imgEyeClosed.Hide;

end;

procedure TfrmMain.btnLearnerMouseLeave(Sender: TObject);
begin
  // changing the style of the display panel when hovering over learner button for flare
  btnLearner.font.Size := 10;
  pnlIntro.Color := clSilver;
  pnlMain.Color := clSilver;

end;

procedure TfrmMain.btnReg2Click(Sender: TObject);
begin
  // btnreg click

end;

procedure TfrmMain.btnRegClick(Sender: TObject);
begin
  // showing and hiding appropriate components for registering a new account
  btnLogin.Enabled := False;
  MessageDlg(
    'Please fill out the rest of your information and press the "register button" once you have done that', mtWarning, [mbOk], 0);
  // if it is a new account
  edtName.Show;
  edtSurname.Show;
  rgpGender.Show;
  if not assigned(btnReg2) then
  begin
    btnReg2 := TButton.Create(frmMain);
    with btnReg2 do // dynamically instantiating a button
    begin
      font.Style := [fsbold];
      parent := pnlMain;
      font.Name := 'Verdana';
      Caption := 'Register';
      Top := 50;
      Left := 224;
      width := 100;
      visible := True;
      OnClick := btnReg2Click;
    end;
  end
  else
  begin
    btnReg2.visible := True;
  end;

  btnReg.visible := False;

end;

procedure TfrmMain.btnTCancelClick(Sender: TObject);
begin
  // remove the log in components
  HideAllTeacher(True);
  imgEyeClosed.Hide;
  imgEyeOpen.Hide;
  if assigned(btnTReg2) then // if the second register button has been instantiated
  begin
    btnTReg2.visible := False;
  end;
end;

procedure TfrmMain.btnTeacherClick(Sender: TObject);
begin
  // showing the other buttons when clicked for ease of use
  HideAllTeacher(False);

  HideAllLearner(True);
  btnLearner.Show;
  btnAdmin.Show;

end;

procedure TfrmMain.btnTeacherMouseEnter(Sender: TObject);
begin
  // creating a vibrant affect when hovering over teacher button
  btnTeacher.font.Size := 12;
  pnlIntro.Color := clTeal;
  pnlMain.Color := clTeal;
  imgTEyeOpen.Hide;
  imgTEyeClosed.Hide;

end;

procedure TfrmMain.btnTeacherMouseLeave(Sender: TObject);
begin
  // adding to pop of hovering in the mian page
  btnTeacher.font.Size := 10;
  pnlIntro.Color := clSilver;
  pnlMain.Color := clSilver;
end;

procedure TfrmMain.btnTReg2Click(Sender: TObject);
begin
  // btntreg2 onclick event
end;

procedure TfrmMain.btnTRegClick(Sender: TObject);
begin
  // showing and hiding appropriate components for registering a new account
  btnTLogin.Enabled := False;
  MessageDlg(
    'Please fill out the rest of your information and press the "register button" once you have done that', mtWarning, [mbOk], 0);
  edtTName.Show;
  edtTSurname.Show;
  if not assigned(btnTReg2) then
  begin
    btnTReg2 := TButton.Create(frmMain);
    with btnTReg2 do // dynamically instantiating a button
    begin
      font.Style := [fsbold];
      parent := pnlMain;
      font.Name := 'Verdana';
      Caption := 'Register';
      Top := 130;
      Left := 225;
      width := 100;
      visible := True;
      OnClick := btnTReg2Click;
    end;
  end
  else
  begin
    btnTReg2.visible := True;
  end;

  btnTReg.visible := False;

end;

function TfrmMain.Decrypt(sKey: string; EncryptedText: string): string;
var
  m, iIndex: integer;
  sOutput: string;
const
  sValid: string = 'abcdefghijklmnopqrstuvwxyz ';
begin
  // decrypting according to the key
  for m := 1 to length(EncryptedText) do // m assinged the value one to the length of the cyphered text
  begin
    iIndex := pos(EncryptedText[m], sKey); // saved index is the position of the letter at point m of the encrypted text, in the key
    sOutput := sOutput + sValid[iIndex]; // above index used in normal alpahabet (svalid) to decrypt
  end;
  result := sOutput;
end;

function TfrmMain.Encrypt(sKey, PlainText: string): string;
var
  m: integer;
  sOutput: string;
  iIndex: integer;
const
  sValid: string = 'abcdefghijklmnopqrstuvwxyz ';
begin
  // ciphering according to the key
  for m := 1 to length(PlainText) do // m assinged the value one to the length of the plain text
  begin
    iIndex := pos(PlainText[m], sValid); // saved index is the position of the letter at point m of the plain text, in the alphabet
    sOutput := sOutput + sKey[iIndex]; // above index used in the cypher key (skey) to encrypt
  end;
  result := sOutput;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  sKey := 'tech'; // for encryption of the admin password (skey is cannot be accesssed outside of the main form)
  frmsplash.showmodal;
  HideAllLearner(True);
  HideAllTeacher(True);
end;

procedure TfrmMain.HideAllLearner(bAffect: boolean);
begin
  if not bAffect then // if baffect is false then show all learner related content
  begin
    btnLearner.Hide;
    edtUsername.Show;
    edtPassword.Show;
    lblUsername.visible := True;
    lblPassword.visible := True;
    btnReg.visible := True;
    btnLogin.visible := True;
    btnCancel.Show;
    imgEyeOpen.Show;
  end
  else if bAffect then // if baffect is true then show all learner related content
  begin
    edtUsername.visible := False;
    edtPassword.visible := False;
    lblUsername.visible := False;
    lblPassword.visible := False;
    btnLearner.Show;
    btnReg.visible := False;
    btnLogin.visible := False;
    btnCancel.Hide;
    btnLogin.Enabled := True;
    rgpGender.visible := False;
    edtName.Hide;
    edtSurname.Hide;
    imgEyeOpen.Hide;
    imgEyeClosed.Hide;
  end;
end;

procedure TfrmMain.HideAllTeacher(bAffect: boolean);
begin
  if bAffect then // if baffect is true then hide all teacher related content
  begin
    btnTeacher.Show;
    edtTPassword.Hide;
    edtTUsername.Hide;
    lblTUsername.visible := False;
    lblTPassword.visible := False;
    btnTReg.visible := False;
    btnTLogin.visible := False;
    btnTCancel.Hide;
    edtTName.Hide;
    edtTSurname.Hide;
    imgTEyeOpen.Hide;
    imgTEyeClosed.Hide;
  end;
  if not bAffect then // if baffect is false then show all teacher related content
  begin
    btnTeacher.Hide;
    edtTUsername.Show;
    edtTPassword.Show;
    lblTUsername.visible := True;
    lblTPassword.visible := True;
    btnTReg.visible := True;
    btnTLogin.visible := True;
    btnTCancel.Show;
    imgTEyeOpen.Show;
  end;

end;

procedure TfrmMain.imgEyeClosedClick(Sender: TObject);
begin
  // if they closed eye is clicked, hide the password
  edtPassword.PasswordChar := '*';
  imgEyeClosed.Hide;
  imgEyeOpen.Show;
  edtTPassword.PasswordChar := '*';
  imgTEyeClosed.Hide;
  imgTEyeOpen.Show;
end;

procedure TfrmMain.imgEyeOpenClick(Sender: TObject);
begin
  // if the open eye is clicked, show the password
  edtPassword.PasswordChar := #0;
  imgEyeOpen.Hide;
  imgEyeClosed.Show;
  edtTPassword.PasswordChar := #0;
  imgTEyeOpen.Hide;
  imgTEyeClosed.Show;
end;

function TfrmMain.KeyCreator(sKeyword: string): string;
var
  K, iKeyIndex: integer;
  L: integer;
  sKey: string;
begin
  sKey := 'abcdefghijklmnopqrstuvwxyz ';
  Delete(sKey, pos(sKeyword[1], sKey), 1);
  // creating key
  for L := 1 to length(sKey) do
  begin
    for K := 1 to length(sKeyword) do
    begin
      if sKey[L] = sKeyword[K] then // if c, a or t = abcdefghijklmnopqrstuvwxyz
      begin
        iKeyIndex := pos(sKeyword[K], sKey); // Keyindex = position c,a or t in abcdefghijklmnopqrstuvwxyz
        Delete(sKey, iKeyIndex, 1); // deleting letter from keyword in key
      end;
    end;
  end;
  sKey := sKeyword + sKey; // a key with the word at the begging and the rest of the alpahabet as usual (excluding that key) e.g. catbdefghijklmnopqrsuvwxyz
  result := sKey;
end;

procedure TfrmMain.Ourgithub1Click(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('https://github.com/jamiecmarks/IT-PAT-2022'),
    nil, nil, SW_SHOWNORMAL); // open my github page in the default browser
end;

procedure TfrmMain.OurStory1Click(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('ourstory.html'), nil, nil, SW_SHOWNORMAL);
  // open my htnl page in the default browser
end;

end.
