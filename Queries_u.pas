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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueries: TfrmQueries;
  conTechno: TConnection;

implementation

{$R *.dfm}

procedure TfrmQueries.FormShow(Sender: TObject);
begin
 conTechno.dbConnection;
 conTechno.ConnectTutorAndStudent(dbgTutor, dbgStudent);
 dbgTutor.Columns[2].Visible := False;//hides password column
 dbgStudent.Columns[6].Visible := False;
end;

procedure TfrmQueries.MainMenu2Click(Sender: TObject);
begin
frmQueries.Close;
frmDBAdmin.Close;
end;

procedure TfrmQueries.Seealltables1Click(Sender: TObject);
begin
frmDbAdmin.show;
end;

end.