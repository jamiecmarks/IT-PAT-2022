unit dbAdmin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, DBConnection_u;

type
  TfrmDbAdmin = class(TForm)
    lblTutors: TLabel;
    lblSessions: TLabel;
    lblStudents: TLabel;
    dbgridTutors: TDBGrid;
    DBNavigatorTutors: TDBNavigator;
    DBGridSessions: TDBGrid;
    DBNavigatorSessions: TDBNavigator;
    DBGridStudents: TDBGrid;
    DBNavigatorStudents: TDBNavigator;
    MainMenu1: TMainMenu;
    fff1: TMenuItem;
    Exit1: TMenuItem;
    DBGridSubjects: TDBGrid;
    DBNavigatorSubjects: TDBNavigator;
    lblSubjects: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDbAdmin: TfrmDbAdmin;
  conTechno: TConnection;

implementation

{$R *.dfm}

procedure TfrmDbAdmin.Exit1Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TfrmDbAdmin.FormShow(Sender: TObject);
begin
  conTechno.dbConnection;
  conTechno.ConnectDBGrids(dbgridTutors, DBGridSessions, DBGridStudents,
    DBGridSubjects);
  conTechno.ConnectToNav(DBNavigatorTutors, DBNavigatorSessions,
    DBNavigatorStudents, DBNavigatorSubjects);
  dbgridTutors.Columns[2].Visible := False; // hides password column
  DBGridStudents.Columns[6].Visible := False;

end;

end.
