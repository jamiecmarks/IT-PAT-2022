program Main_P;

uses
  Forms,
  Main_U in 'Main_U.pas' {frmMain},
  Splash_U in 'Splash_U.pas' {frmSplash},
  DBConnection_u in 'DBConnection_u.pas',
  dbAdmin_u in 'dbAdmin_u.pas' {frmDbAdmin},
  Queries_u in 'Queries_u.pas' {frmQueries},
  clsTutor_u in 'clsTutor_u.pas',
  clsStudent_U in 'clsStudent_U.pas',
  Student_u in 'Student_u.pas' {frmLearner},
  Tutor_u in 'Tutor_u.pas' {frmTutor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmDbAdmin, frmDbAdmin);
  Application.CreateForm(TfrmQueries, frmQueries);
  Application.CreateForm(TfrmLearner, frmLearner);
  Application.CreateForm(TfrmTutor, frmTutor);
  Application.Run;
end.
