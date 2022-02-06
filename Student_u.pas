unit Student_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DBConnection_u, pngimage,
  ExtCtrls;

type
  TfrmLearner = class(TForm)
    dbgridSessions: TDBGrid;
    imgExit: TImage;
    lblExit: TLabel;
    imgSave: TImage;
    lblSave: TLabel;
    pnlLearner: TPanel;
    procedure FormShow(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SessionSql(sSql: string);
  end;

var
  frmLearner: TfrmLearner;
  conTechno: TConnection;

implementation

uses Main_u;
{$R *.dfm}

procedure TfrmLearner.FormShow(Sender: TObject);
begin
  conTechno.dbConnection;
  conTechno.ConnectSessions(dbgridSessions);
  SessionSql(
    'SELECT TutorUsername AS [Tutor Username], Sessiondate as [Date of sesion], meetinglink AS [Link used] FROM tblSessions where StudentUsername = ' + quotedstr(objStudent.GetUsername));

end;

procedure TfrmLearner.imgExitClick(Sender: TObject);
begin
  if Dialogs.MessageDlg(
    'Are you sure you want to exit, all unsaved changes will be lost?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    Dialogs.MessageDlg(
      'Exiting Technotutors scheduling software, thank you for using us!',
      mtInformation, [mbOk], 0, mbOk);
    application.Terminate;
  end;
end;

procedure TfrmLearner.SessionSql(sSql: string);
begin
  qrySessions.Close;
  qrySessions.SQL.Clear;
  qrySessions.SQL.Add(sSql);

  if uppercase(copy(sSql, 1, 6)) = 'SELECT' then
  // checking for select statement
  begin
    qrySessions.Open; // running select sql
    dsSessions.DataSet := qrySessions;
  end
  else
  begin
    qrySessions.ExecSQL; // running anything that isnt a select statemnt
  end;
end;

end.
