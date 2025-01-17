unit Student_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DBConnection_u, pngimage,
  ExtCtrls, Menus, ComCtrls, DateUtils, shellapi;

type
  TfrmLearner = class(TForm)
    imgExit: TImage;
    lblExit: TLabel;
    pgcntrlLearner: TPageControl;
    TabSheet2: TTabSheet;
    mainmenLearner: TMainMenu;
    Mainmenu1: TMenuItem;
    Learnerresourcecenter1: TMenuItem;
    redStudent: TRichEdit;
    TabSheet1: TTabSheet;
    btnAll: TButton;
    btnUpcoming: TButton;
    btnToday: TButton;
    Button1: TButton;
    dbgridSessions: TDBGrid;
    imgSave: TImage;
    rdgpPassword: TRadioGroup;
    lblPreviousPass: TLabel;
    lblNew: TLabel;
    edtPrevious: TEdit;
    edtNewPass: TEdit;
    btnSubmit: TButton;
    Userinfo1: TMenuItem;
    rdgpUsername: TRadioGroup;
    lblNewUsername: TLabel;
    btnUsernameSubmit: TButton;
    edtNewUsername: TEdit;
    procedure FormShow(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
    procedure Mainmenu1Click(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
    procedure FormatRichedit(redOutput: TRichEdit);
    procedure btnUpcomingClick(Sender: TObject);
    procedure Learnerresourcecenter1Click(Sender: TObject);
    procedure btnTodayClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure Userinfo1Click(Sender: TObject);
    procedure btnUsernameSubmitClick(Sender: TObject);
    procedure imgSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SessionSql(sSql: string);
  end;

var
  frmLearner: TfrmLearner;
  conTechno: TConnection;
  arrSubjects: array [1 .. 13] of string;
  sOriginalUsername: string;
  sNewPass: string;
  bPassChanged: boolean = False;

implementation

uses Main_u;
{$R *.dfm}

procedure TfrmLearner.btnAllClick(Sender: TObject);
var
  iSubject: integer;
begin
  FormatRichedit(redStudent); // formatting richedit using procedure
  redStudent.Lines.Add(#9 + #9 + 'ALL SESSIONS:'); // title
  redStudent.Lines.Add('|Tutor Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redStudent.Lines.Add( // line to seperate titles from info
    '----------------------------------------------------------------------------------------------------------------------------');

  conTechno.dbconnection; // database connection
  tblSessions.First; // start at begginging of textfile
  while not tblSessions.Eof do
  begin
    if (tblSessions['StudentUsername'] = objStudent.GetUsername) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID']; // extracting subject number to access subject name from array
      if tblSessions['Meetinglink'] = null then // if no link is provided, to prevent errors
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime']))
      else
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
          // if a meeting link is provided
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime']));
    end;
    tblSessions.Next;

  end;
end;

procedure TfrmLearner.btnSubmitClick(Sender: TObject);
begin
  if objStudent.ComparePass(edtPrevious.Text) then // if the entered password is the same as the old password
  begin
    if not frmMain.IsValidPassword(edtNewPass.Text) then
      // check if the password is a valid one
      exit;
    objStudent.SetPassword(edtNewPass.Text); // set password to new password
    bPassChanged := True; // changed for db update purposes
    messagedlg(
      'Your password has been succesfully updated!, , remember to save changes for then to take affect', mtinformation, [mbok], 0);
    sNewPass := edtNewPass.Text; // saved for db update purposes
  end
  else
    messagedlg('Your previous password is incorrect', mtinformation, [mbok],
      0); // if the previous password is incorrect

end;

procedure TfrmLearner.btnTodayClick(Sender: TObject);
var
  iSubject: integer;
begin
  FormatRichedit(redStudent); // format richedit
  redStudent.Lines.Add(#9 + #9 + 'TODAY''S SESSIONS:'); // title
  redStudent.Lines.Add('|Tutor Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redStudent.Lines.Add( // line to seperate headings from info
    '----------------------------------------------------------------------------------------------------------------------------');

  conTechno.dbconnection; // db connection
  tblSessions.First; // first record in db
  while not tblSessions.Eof do
  begin
    if (tblSessions['StudentUsername'] = objStudent.GetUsername) AND // if the username matches the client's and the date of the session is today
      (tblSessions['SessionDate'] = Today) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID']; // reading subject number to extract subject name from array later on
      if tblSessions['Meetinglink'] = null then
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime'])) // if no meeting link is provided
      else
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime'])); // if meeting link is provided
    end;
    tblSessions.Next; // next record in db
  end;
end;

procedure TfrmLearner.btnUpcomingClick(Sender: TObject);
var
  iSubject: integer;
begin
  FormatRichedit(redStudent); // formatting richedit
  redStudent.Lines.Add(#9 + #9 + 'UPCOMING SESSIONS:'); // title
  redStudent.Lines.Add('|Tutor Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redStudent.Lines.Add( // line to seperate info from headings
    '----------------------------------------------------------------------------------------------------------------------------');

  conTechno.dbconnection; // database connection
  tblSessions.First; // begining of database
  while not tblSessions.Eof do
  begin
    if (tblSessions['StudentUsername'] = objStudent.GetUsername) AND // if the client is the wanted client and the date of the session is later than todays date
      (tblSessions['SessionDate'] > Today) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID']; // reading subject number to extract subject name from array later on
      if tblSessions['Meetinglink'] = null then
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime'])) // output if meeting link isnt provided
      else
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime'])); // outputed if meeting link is provided
    end; // next record in db
    tblSessions.Next;
  end;
end;

procedure TfrmLearner.btnUsernameSubmitClick(Sender: TObject);
begin
  if frmMain.IsUniqueUsername(tblStudents, edtNewUsername.Text) then // if the username is unique, ie has not been used by any other users
  begin
    objStudent.SetUsername(edtNewUsername.Text); // set new username to object
    messagedlg(
      'Your username has been succesfully updated!, remember to save changes for then to take affect', mtinformation, [mbok], 0);
    // confirmation message
  end
  else
    messagedlg('Your'' username is not unique, please choose another one',
      mtinformation, [mbok], 0); // if the username is not unique

end;

procedure TfrmLearner.Button1Click(Sender: TObject);
var
  iSubject, iHours: integer;
begin
  try // error checking for inputting of hours ahead to check sessions for
    iHours := strtoint(inputbox(
        'Enter the amount of hours ahead from now you would like to see sessions for'
          , 'Hours', '1')); // if no errors come up
  Except
    begin // if an error shows up show this message
      messagedlg('Please insert a number', mtError, [mbok], 0);
      exit;
    end;
  end;
  FormatRichedit(redStudent); // format richedit
  redStudent.Lines.Add(#9 + #9 + 'SESSIONS WITHIN THE NEXT ' + inttostr(iHours)
      + ' HOURS(S):'); // title
  redStudent.Lines.Add('|Tutor Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redStudent.Lines.Add( // line to seperate info from headings
    '----------------------------------------------------------------------------------------------------------------------------');
  // database connection
  conTechno.dbconnection;
  tblSessions.First; // start of db
  while not tblSessions.Eof do // loop through db
  begin
    if (tblSessions['StudentUsername'] = objStudent.GetUsername) AND
      ((tblSessions['SessionDate'] = Today) AND
        (TimeToStr(tblSessions['SessionTime']) > TimeToStr(now))) AND
      (TimeToStr(tblSessions['SessionTime']) < TimeToStr(IncHour(now, iHours))
      // if the clientid matches db and the session time is between now and the incrimented time acccording to user input
      ) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID'];
      if tblSessions['Meetinglink'] = null then
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime'])) // output if no meeting link is supplied
      else
        redStudent.Lines.Add(tblSessions['TutorUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime'])); // output if no meeting link is supplied
    end;
    tblSessions.Next; // next record in db
  end;
end;

procedure TfrmLearner.FormatRichedit(redOutput: TRichEdit);
begin
  redOutput.Clear;
  redOutput.Paragraph.TabCount := 5; // formating for richedit
  redOutput.Paragraph.Tab[0] := 80;
  redOutput.Paragraph.Tab[1] := 160;
  redOutput.Paragraph.Tab[2] := 240;
  redOutput.Paragraph.Tab[3] := 320;
  redOutput.Paragraph.Tab[4] := 330;
end;

procedure TfrmLearner.FormShow(Sender: TObject);
var
  myFile: textfile;
  sLine: string;
  iCount: integer;
begin
  sOriginalUsername := objStudent.GetUsername; // storing orignal surname incase it gets changed later
  pgcntrlLearner.TabIndex := 1; // setting page control default page
  conTechno.dbconnection; // database connection
  conTechno.ConnectSessions(dbgridSessions);
  SessionSql(
    'SELECT TutorUsername AS [Tutor Username], Sessiondate as [Date of sesion], meetinglink AS [Link used] FROM tblSessions where StudentUsername = ' + quotedstr(objStudent.GetUsername));
  // shows all the database records relating to the student and no one else

  // loading the arrsubjects array according to subjects.txt
  iCount := 1;
  AssignFile(myFile, 'Subjects.txt');
  reset(myFile);
  while not Eof(myFile) do
  begin
    readln(myFile, sLine);
    arrSubjects[iCount] := sLine;
    inc(iCount);
  end;
  closefile(myFile);
end;

procedure TfrmLearner.imgExitClick(Sender: TObject);
begin
  if Dialogs.messagedlg(
    'Are you sure you want to exit, all unsaved changes will be lost?',
    // checking with the user if they are sure that they want to exit
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    Dialogs.messagedlg(
      'Exiting Technotutors scheduling software, thank you for using us!',
      mtinformation, [mbok], 0, mbok); // exit message
    application.Terminate;
  end;
end;

procedure TfrmLearner.imgSaveClick(Sender: TObject);
begin
  tblStudents.First; // begining of db
  while not tblStudents.Eof do // loop through db
  begin
    if tblStudents['Username'] = sOriginalUsername then // finding the user (with their original username) in the db
    begin
      tblStudents.Edit; // edit mode for db
      tblStudents['Username'] := objStudent.GetUsername; // set new username
      if bPassChanged then
        tblStudents['Password'] := sNewPass; // if the password was changed change db
      tblStudents.Post;
      messagedlg('Changes have been permanantly saved', mtinformation, [mbok],
        // confirmation message
        0);

    end;
    tblStudents.Next;
  end;

end;

procedure TfrmLearner.Learnerresourcecenter1Click(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('resource_centre.html'), nil, nil, SW_SHOWNORMAL);
  // opens resource centre for learners
end;

procedure TfrmLearner.Mainmenu1Click(Sender: TObject);
begin
  objStudent.Free;
  frmLearner.close;
  frmMain.Show;

end;

procedure TfrmLearner.SessionSql(sSql: string);
begin
  qrySessions.close;
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
    qrySessions.ExecSQL;
    // running anything that isnt a select statemnt
  end;
end;

procedure TfrmLearner.Userinfo1Click(Sender: TObject);
begin
  redStudent.Lines.Add(objStudent.ToString); // outputs info about the user
end;

end.
