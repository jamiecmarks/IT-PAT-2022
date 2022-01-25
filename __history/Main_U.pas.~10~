unit Main_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Splash_U, ExtCtrls;

type
  TfrmMain = class(TForm)
    pnlIntro: TPanel;
    btnLearner: TButton;
    btnTeacher: TButton;
    btnAdmin: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnLearnerMouseEnter(Sender: TObject);
    procedure btnLearnerMouseLeave(Sender: TObject);
    procedure btnTeacherMouseEnter(Sender: TObject);
    procedure btnTeacherMouseLeave(Sender: TObject);
    procedure btnAdminMouseEnter(Sender: TObject);
    procedure btnAdminMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnAdminMouseEnter(Sender: TObject);
begin
   btnAdmin.font.Size := 12;
end;

procedure TfrmMain.btnAdminMouseLeave(Sender: TObject);
begin
    btnAdmin.font.Size := 10;
end;

procedure TfrmMain.btnLearnerMouseEnter(Sender: TObject);
begin
  btnLearner.font.Size := 12;


end;

procedure TfrmMain.btnLearnerMouseLeave(Sender: TObject);
begin
  btnLearner.font.Size := 10;


end;

procedure TfrmMain.btnTeacherMouseEnter(Sender: TObject);
begin
  btnTeacher.font.Size := 12;
end;

procedure TfrmMain.btnTeacherMouseLeave(Sender: TObject);
begin
  btnTeacher.font.Size := 10;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmsplash.showmodal;

end;

end.
