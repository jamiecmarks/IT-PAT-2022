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
    Procedure ConnectTutorAndStudent(Var dbgT, dbgSt: TDBGrid);
    Procedure ConnectToNav(Var navT, dbgSe, navSt, navSub: TDBNavigator);
    Procedure ConnectSessions(Var dbgSe:TDBGrid);
  end;

var
  frmConnect: TForm;
  conTechno: TADOConnection;
  tblTutors,tblSessions, tblStudents: TADOTable;
  dsTutors, dsSessions, dsStudents: TDataSource;
  qryTutors, qryStudents, qrySessions: TADOQuery;

implementation

{ TConnection }

procedure TConnection.ConnectDBGrids(var dbgT, dbgSe, dbgSt, dbgSub: TDBGrid);
begin
  dbgT.DataSource := dsTutors;
  dbgSe.DataSource := dsSessions;
  dbgSt.DataSource := dsStudents;
end;

procedure TConnection.ConnectSessions(var dbgSe: TDBGrid);
begin
  dbgSe.DataSource := dsSessions;
end;

procedure TConnection.ConnectToNav(var navT, dbgSe, navSt,
  navSub: TDBNavigator);
begin
   navT.DataSource := dsTutors;
  dbgSe.DataSource := dsSessions;
  navSt.DataSource := dsStudents;
end;

procedure TConnection.ConnectTutorAndStudent(var dbgT, dbgSt: TDBGrid);
begin
  dbgT.DataSource := dsTutors;
  dbgSt.DataSource := dsStudents;
end;

procedure TConnection.dbConnection;
begin
  conTechno := TADOConnection.Create(frmConnect);
  conTechno.LoginPrompt := False;
  conTechno.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
    'Data Source=TechnoTutorsDB.mdb;' + 'Mode=ReadWrite;' +
    'Persist Security Info=False;' + 'Jet OLEDB:Database Password=**********';
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

  dsTutors := TDataSource.Create(frmConnect);
  dsTutors.DataSet := tblTutors;

  dsStudents := TDataSource.Create(frmConnect);
  dsStudents.DataSet := tblStudents;

  dsSessions := TDataSource.Create(frmConnect);
  dsSessions.DataSet := tblSessions;

  qryTutors := TADOQuery.Create(frmConnect);
  qryTutors.Connection := conTechno;

  qryStudents := TADOQuery.Create(frmConnect);
  qryStudents.Connection := conTechno;

  qrySessions := TADOQuery.Create(frmConnect);
  qrySessions.Connection := conTechno;



end;

end.
