unit clsStudent_U;

interface

uses
  Sysutils;

type
  TStudent = class(TObject)
  private
    fUsername: string;
    fPassword: string;
    fFirstName: string;
    fSurname: string;
    fAtttendedlessons: integer;
    fGender: string;

  public
    constructor Create(sUsername, sPassword, sFirstname, sSurname: string;
      cGender: string); overload;
    constructor Create(sUsername, sPassword, sFirstname, sSurname: string;
      iAttendedlessons: integer; cGender: string); overload;
    function GetUsername: string;
    function GetFirstname: string;
    function GetSurname: string;
    function GetNumAttended: integer;
    procedure SetPassword(sNewPass: string);
    procedure SetUsername(sUsername: string);
    procedure IncSessions;
    function GetGender: string;
    function ToString: string;
    destructor Destroy; override;

  end;

implementation

{ TTutor }

function TStudent.GetGender: string;
begin
  result := fGender;
end;

constructor TStudent.Create(sUsername, sPassword, sFirstname, sSurname: string;
  cGender: string);
begin
  fUsername := sUsername;
  fPassword := sPassword;
  fFirstName := sFirstname;
  fSurname := sSurname;
  fAtttendedlessons := 0;
  fGender := cGender;
end;

constructor TStudent.Create(sUsername, sPassword, sFirstname, sSurname: string;
  iAttendedlessons: integer; cGender: string);
begin
  fUsername := sUsername;
  fPassword := sPassword;
  fFirstName := sFirstname;
  fSurname := sSurname;
  fAtttendedlessons := iAttendedlessons;
  fGender := cGender;

end;

destructor TStudent.Destroy;
begin

  inherited;
end;

function TStudent.GetFirstname: string;
begin
  result := fFirstName;
end;

function TStudent.GetNumAttended: integer;
begin
  result := fAtttendedlessons;
end;

function TStudent.GetSurname: string;
begin
  result := fSurname;
end;

function TStudent.GetUsername: string;
begin
  result := fUsername;
end;

procedure TStudent.IncSessions;
begin
  fAtttendedlessons := fAtttendedlessons + 1;
end;

procedure TStudent.SetPassword(sNewPass: string);
begin
  fPassword := sNewPass;
end;

procedure TStudent.SetUsername(sUsername: string);
begin
  fUsername := sUsername;
end;

function TStudent.ToString: string;
begin
  result := fFirstName + ' ' + fSurname + ' (' + fUsername + ') ' + #13 +
    'Has attended a total of ' + inttostr(fAtttendedlessons) + ' lessons';
end;

end.
