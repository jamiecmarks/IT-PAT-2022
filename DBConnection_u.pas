unit DBConnection_u;

interface

Uses
  Db, ADODB, DBGrids, Dialogs, Classes, DBCtrls, StdCtrls, Forms;

Type
  TConnection = class(TObject)
  private
  public
    Procedure dbConnection;
    Procedure ConnectDBGrids(Var dbgT, dbgSe, dbgSt, dbgSub: TDBGrid);
  end;

var
  frmConnect: TForm;
  conTechno: TADOConnection;
  tblTutors, tblSubjects, tblSessions, tblStudents: TADOTable;
  dsTutors, dsSubjects, dsSessions, dsStudents: TDataSource;

implementation

{ TConnection }

procedure TConnection.ConnectDBGrids(var dbgT, dbgSe, dbgSt, dbgSub: TDBGrid);
begin
  dbgT.DataSource := dsTutors;
  dbgSe.DataSource := dsSessions;
  dbgSt.DataSource := dsStudents;
  dbgSub.DataSource := dsSubjects;
end;

procedure TConnection.dbConnection;
begin
  conTechno := TADOConnection.Create(frmConnect);
  conTechno.LoginPrompt := False;
  conTechno.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;' + 'Data Source=TechnoTutorsDB.mdb;' +
    'Mode=ReadWrite;' + 'Persist Security Info=False;' +
    'Jet OLEDB:Database Password=**********';
  conTechno.Provider := 'Provider=Microsoft.Jet.OLEDB.4.0;';
  conTechno.open;

  tblTutors := TADOTable.Create(frmConnect);
  tblTutors.Connection := conTechno;
  tblTutors.TableName := 'tblTutors';
  tblTutors.open;

  tblStudents := TADOTable.Create(frmConnect);
  tblStudents.Connection := conTechno;
  tblStudents.TableName := 'tblStudents';
  tblStudents.open;

  tblSessions := TADOTable.Create(frmConnect);
  tblSessions.Connection := conTechno;
  tblSessions.TableName := 'tblSessions';
  tblSessions.open;

  tblSubjects := TADOTable.Create(frmConnect);
  tblSubjects.Connection := conTechno;
  tblSubjects.TableName := 'tblSubjects';
  tblSubjects.open;

  dsTutors := TDataSource.Create(frmConnect);
  dsTutors.DataSet := tblTutors;

  dsStudents := TDataSource.Create(frmConnect);
  dsStudents.DataSet := tblStudents;

  dsSessions := TDataSource.Create(frmConnect);
  dsSessions.DataSet := tblSessions;

  dsSubjects := TDataSource.Create(frmConnect);
  dsSubjects.DataSet := tblSubjects;

end;

end.