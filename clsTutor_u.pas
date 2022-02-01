unit clsTutor_u;

interface

uses
  Sysutils;

type
  TTutor = class(TObject)
  private
    fUsername: string;
    fPassword: string;
    fFirstName: string;
    fSurname: string;
    fScheduledSessions: integer;
    fActive: boolean;

  public
    constructor Create(sUsername, sPassword, sFirstname, sSurname: string);overload;
    constructor Create(sUsername, sPassword, sFirstname, sSurname, sScheduledSessions,sActive: string);overload;
    function GetUsername: string;
    function GetFirstname: string;
    function GetSurname: string;
    function GetNumSched: string;
    function IsActive: boolean;
    procedure SetPassword(sNewPass: string);
    procedure SetUsername(sUsername: string);
    procedure IncSessions;
    procedure ChangeActivity(bActive: boolean);
    function ToString: string;
    destructor Destroy; override;


  end;

implementation

{ TTutor }

procedure TTutor.ChangeActivity(bActive: boolean);
begin
  fActive := bActive;
end;

constructor TTutor.Create(sUsername, sPassword, sFirstname, sSurname: string);
begin
  fUsername := sUsername;
  fPassword := sPassword;
  fFirstName := sFirstname;
  fSurname := sSurname;
  fScheduledSessions := 0;
  fActive := True;
end;

destructor TTutor.Destroy;
begin

  inherited;
end;

function TTutor.GetFirstname: string;
begin
  result := fFirstName;
end;

function TTutor.GetNumSched: string;
begin
  result := fScheduledSessions;
end;

function TTutor.GetSurname: string;
begin
  result := fSurname;
end;

function TTutor.GetUsername: string;
begin
  result := fUsername;
end;

procedure TTutor.IncSessions;
begin
  fScheduledSessions := fScheduledSessions + 1;
end;

function TTutor.IsActive: boolean;
begin
  result := fActive;
end;

procedure TTutor.SetPassword(sNewPass: string);
begin
  fPassword := sNewPass;
end;

procedure TTutor.SetUsername(sUsername: string);
begin
  fUsername := sUsername;
end;

function TTutor.ToString: string;
begin
  if fActive then
    result := fFirstName + ' ' + fSurname + ' (' + fUsername + ') ' + #13 +
      'Has scheduled a total of ' + inttostr(fScheduledSessions)
      + ' sessions' + 'and is currently an active tutor'
  else
    result := fFirstName + ' ' + fSurname + ' (' + fUsername + ') ' + #13 +
      'Has scheduled a total of ' + inttostr(fScheduledSessions)
      + ' sessions' + 'and is currently not an active tutor';
end;

end.
