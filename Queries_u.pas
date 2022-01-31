unit Queries_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DBConnection_u, Menus, dbAdmin_u;

type
  TfrmQueries = class(TForm)
    Button1: TButton;
    rdgSearch: TRadioGroup;
    btnEnter: TButton;
    edtName: TEdit;
    edtSurname: TEdit;
    btnInsert: TButton;
    btnEdit: TButton;
    Button2: TButton;
    btnAverage: TButton;
    btn2Tables: TButton;
    btnDelete: TButton;
    dbgTutor: TDBGrid;
    dbgStudent: TDBGrid;
    MainMenu1: TMainMenu;
    Seealltables1: TMenuItem;
    MainMenu2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Seealltables1Click(Sender: TObject);
    procedure MainMenu2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
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

{$R *.dfm}

procedure TfrmQueries.btnEnterClick(Sender: TObject);
begin
  StudentSql('SELECT * FROM tblStudents WHERE Surname LIKE ''%' +
      edtSurname.Text + '%'' AND Firstname LIKE ''%' + edtName.Text + '%''')
end;

procedure TfrmQueries.btnInsertClick(Sender: TObject);
var
  sFirstname, sSurname, sPass, sUsername: string;
  rProposedPrice: real;
  iLastUserID:integer;
begin
  sUserName :=  InputBox('Enter Username', '', '');
  sFirstname := InputBox('Enter Firstname', '', '');
  sSurname := InputBox('Enter Surname', '', '');
  sPass := uppercase(InputBox('Enter gender (password', '', ''));
  tblTutors.last;
  tblTutors.Append;
  tblTutors['Username'] := sUserName;
  tblTutors['Firstname'] := sFirstname;
  tblTutors['Surname'] := sSurname;
  tblTutors['Password'] := sPass;
  tblTutors['Active'] := True;
  tblTutors.Post;
end;

procedure TfrmQueries.Button1Click(Sender: TObject);
begin
  TutorSql('SELECT * FROM tblTutors ORDER BY UserName');
  StudentSql('SELECT * FROM tblStudents ORDER BY UserName');
end;

procedure TfrmQueries.FormShow(Sender: TObject);
begin
  conTechno.dbConnection;
  conTechno.ConnectTutorAndStudent(dbgTutor, dbgStudent);
  dbgTutor.Columns[2].Visible := False; // hides password column
  dbgStudent.Columns[6].Visible := False;
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
