unit Queries_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBConnection_u, Menus, dbAdmin_u;

type
  TfrmQueries = class(TForm)
    btnSort: TButton;
    rdgSearch: TRadioGroup;
    btnEnter: TButton;
    edtName: TEdit;
    edtSurname: TEdit;
    btnInsert: TButton;
    btnEdit: TButton;
    btnSelect: TButton;
    btnAverage: TButton;
    btn2Tables: TButton;
    btnDelete: TButton;
    dbgTutor: TDBGrid;
    dbgStudent: TDBGrid;
    MainMenu1: TMainMenu;
    Seealltables1: TMenuItem;
    MainMenu2: TMenuItem;
    btnActive: TButton;
    btnMinMax: TButton;
    Changeadminpassword1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Seealltables1Click(Sender: TObject);
    procedure MainMenu2Click(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnActiveClick(Sender: TObject);
    procedure btnAverageClick(Sender: TObject);
    procedure btnMinMaxClick(Sender: TObject);
    procedure btn2TablesClick(Sender: TObject);
    procedure Changeadminpassword1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TutorSql(sSql: string);
    procedure StudentSql(sSql: string);
  end;

var
  frmQueries: TfrmQueries;
  conTechno: TConnection;

implementation

uses Main_u;
{$R *.dfm}

procedure TfrmQueries.btnAverageClick(Sender: TObject);

var
  rTotal: real;
  iCount: integer;
begin
  // calculating average attended lessons
  tblSTudents.first; // start of database records
  iCount := 0; // instantiation of icount
  while not tblSTudents.Eof do
  begin
    if tblSTudents['AttendedSessions'] <> null then
    // if an attended value is entered
    begin
      rTotal := rTotal + tblSTudents['AttendedSessions'];
      // add record's attended value to total
      inc(iCount);
    end;
    tblSTudents.Next;

  end;
  showmessage('The average student attended lessons is: ' + floattostrf
      (rTotal / iCount, fffixed, 5, 2) + ' lessons');
  // output + finding average

end;

procedure TfrmQueries.btnDeleteClick(Sender: TObject);
begin
  if MessageDlg('Delete This Record?', mtConfirmation, mbYesNoCancel, 0)
    = mrYes then
    tblSTudents.Delete; // deleting the currently highlated learner in the dbgrid
end;

procedure TfrmQueries.btnEditClick(Sender: TObject);
begin
  with conTechno do
  begin
    tblSTudents.Edit;
    tblSTudents['Username'] := inputbox('Enter updated username', 'Username',
      '');
    tblSTudents.Post;
  end;
end;

procedure TfrmQueries.btnEnterClick(Sender: TObject);
begin
  StudentSql(
    'SELECT UserName, Firstname, surname, Gender, attendedsessions'
      + ' FROM tblStudents WHERE Surname LIKE ''%' + edtSurname.Text +
      '%'' AND Firstname LIKE ''%' + edtName.Text + '%''')
end;

procedure TfrmQueries.btnInsertClick(Sender: TObject);
var
  sFirstname, sSurname, sPass, sUsername: string;
  rProposedPrice: real;
  iLastUserID: integer;
begin
  sUsername := inputbox('Enter Username', '', '');
  sFirstname := inputbox('Enter Firstname', '', '');
  sSurname := inputbox('Enter Surname', '', '');
  sPass := uppercase(inputbox('Enter password', '', ''));
  tblTutors.last;
  tblTutors.Append;
  tblTutors['Username'] := sUsername;
  tblTutors['Firstname'] := sFirstname;
  tblTutors['Surname'] := sSurname;
  tblTutors['Password'] := sPass;
  tblTutors['Active'] := True;
  tblTutors.Post;
end;

procedure TfrmQueries.btnMinMaxClick(Sender: TObject);
var
  iMax, iMin: integer;
begin
  iMin := 10000; // high max value so first real max is set to the max
  iMax := 0; // low min value so first real min is set to the min
  tblSTudents.first;
  while not tblSTudents.Eof do
  begin
    if tblSTudents['AttendedSessions'] > iMax then // checking for new max
    begin
      iMax := tblSTudents['AttendedSessions'];
    end;
    if tblSTudents['AttendedSessions'] < iMin then // checking for new min
    begin
      iMin := tblSTudents['AttendedSessions'];
    end;
    tblSTudents.Next
  end;
  showmessage('The max attended lessons is: ' + inttostr(iMax)); // output
  showmessage('The min attended lesson is: ' + inttostr(iMin)); // output

end;

procedure TfrmQueries.btnSelectClick(Sender: TObject);
begin
  StudentSql('SELECT FirstName, Surname FROM tblStudents WHERE Gender = ''M''');
end;

procedure TfrmQueries.btnSortClick(Sender: TObject);
begin
  TutorSql(
    'SELECT Username,FirstName, Surname, scheduledsessions, active FROM tblTutors ORDER BY UserName');
  StudentSql(
    'SELECT UserName, Firstname, surname, Gender, attendedsessions FROM tblStudents ORDER BY UserName');
end;

procedure TfrmQueries.Changeadminpassword1Click(Sender: TObject);
var
  myFile: textfile;
  sNewPassword, sNewEncrypted, sKey: string;
begin
  // encrypting and saving a new admin password
  sNewPassword := lowercase(inputbox('Enter a new password', 'Enter:',
      'Technotutor'));
  sKey := frmMain.KeyCreator('tech');
  sNewEncrypted := frmMain.Encrypt(sKey, sNewPassword);
  assignfile(myFile, 'EncryptedAdminPassword.txt');
  rewrite(myFile);
  writeln(myFile, sNewEncrypted);
  closefile(myFile);

end;

procedure TfrmQueries.btn2TablesClick(Sender: TObject);
begin
  StudentSql(
    'SELECT Firstname, Surname, SessionDate, SubjectID, Attended, MeetingLink'
      + ' FROM tblStudents s, tblSessions e WHERE s.Username = e.StudentUsername ');
end;

procedure TfrmQueries.btnActiveClick(Sender: TObject);
begin
  TutorSql(
    'SELECT UserName, Firstname, Surname FROM tblTutors WHERE Active = True AND ScheduledSessions > 5;');
end;

procedure TfrmQueries.FormShow(Sender: TObject);
begin
  conTechno.dbConnection;
  conTechno.ConnectTutorAndStudent(dbgTutor, dbgStudent);
  dbgTutor.Columns[2].Visible := False; // hides password column
  dbgStudent.Columns[5].Visible := False;
end;

procedure TfrmQueries.MainMenu2Click(Sender: TObject);
begin
  frmQueries.Close;
  frmDBAdmin.Close;
end;

procedure TfrmQueries.Seealltables1Click(Sender: TObject);
begin
  frmDBAdmin.show;
end;

procedure TfrmQueries.StudentSql(sSql: string);
begin
  qryStudents.Close;
  qryStudents.SQL.Clear;
  qryStudents.SQL.Add(sSql);

  if uppercase(copy(sSql, 1, 6)) = 'SELECT' then
  // checking for select statement
  begin
    qryStudents.Open; // running select sql
    dsStudents.DataSet := qryStudents;
  end
  else
  begin
    qryStudents.ExecSQL; // running anything that isnt a select statemnt
  end;

end;

procedure TfrmQueries.TutorSql(sSql: string);
begin
  qryTutors.Close;
  qryTutors.SQL.Clear;
  qryTutors.SQL.Add(sSql);

  if uppercase(copy(sSql, 1, 6)) = 'SELECT' then
  // checking for select statement
  begin
    qryTutors.Open; // running select sql
    dsTutors.DataSet := qryTutors;
  end
  else
  begin
    qryTutors.ExecSQL; // running anything that isnt a select statemnt
  end;
end;

end.
