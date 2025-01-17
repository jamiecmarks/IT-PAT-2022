unit Tutor_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, Grids, DBGrids, ExtCtrls, pngimage,
  DBConnection_u, DateUtils, ShellApi, Spin;

type
  TfrmTutor = class(TForm)
    imgExit: TImage;
    lblExit: TLabel;
    pgcntrlLearner: TPageControl;
    TabSheet2: TTabSheet;
    lblPreviousPass: TLabel;
    lblNew: TLabel;
    lblNewUsername: TLabel;
    rdgpPassword: TRadioGroup;
    edtPrevious: TEdit;
    edtNewPass: TEdit;
    btnSubmit: TButton;
    rdgUsername: TRadioGroup;
    btnUsernameSubmit: TButton;
    edtNewUsername: TEdit;
    TabSheet1: TTabSheet;
    btnAll: TButton;
    btnUpcoming: TButton;
    btnToday: TButton;
    Button1: TButton;
    dbgridSessions: TDBGrid;
    redTutor: TRichEdit;
    mainmenTutor: TMainMenu;
    Mainmenu1: TMenuItem;
    Learnerresourcecenter1: TMenuItem;
    Userinfo1: TMenuItem;
    imgSave: TImage;
    TabSheet3: TTabSheet;
    pnlSchedule: TPanel;
    lblUsername: TLabel;
    lblMeetingLInk: TLabel;
    lblSubject: TLabel;
    lblSessionDate: TLabel;
    edtUsername: TEdit;
    edtMeetingLink: TEdit;
    cmbSubject: TComboBox;
    DateTimeSessions: TDateTimePicker;
    btnSchedule: TButton;
    Label1: TLabel;
    lblHour: TLabel;
    lblMinute: TLabel;
    sedHour: TSpinEdit;
    sedMinute: TSpinEdit;
    btnChangeAttendance: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
    procedure btnUpcomingClick(Sender: TObject);
    procedure btnTodayClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure btnUsernameSubmitClick(Sender: TObject);
    procedure imgSaveClick(Sender: TObject);
    procedure Mainmenu1Click(Sender: TObject);
    procedure Learnerresourcecenter1Click(Sender: TObject);
    procedure Userinfo1Click(Sender: TObject);
    procedure btnScheduleClick(Sender: TObject);
    procedure btnChangeAttendanceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SessionSql(sSql: string);
  end;

var
  frmTutor: TfrmTutor;
  sOriginalUsername: string;
  arrSubjects: array [1 .. 13] of string;

implementation

uses Main_u, student_u;
{$R *.dfm}

procedure TfrmTutor.btnAllClick(Sender: TObject);
var
  iSubject: integer;
begin
  frmLearner.FormatRichedit(redTutor); ; // formatting richedit using procedure
  redTutor.Lines.Add(#9 + #9 + 'ALL SESSIONS:'); // title
  redTutor.Lines.Add('|Student Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redTutor.Lines.Add( // line to seperate titles from info
    '----------------------------------------------------------------------------------------------------------------------------');

  conTechno.dbconnection; // database connection
  tblSessions.First; // start at begginging of textfile
  while not tblSessions.Eof do
  begin
    if (tblSessions['TutorUsername'] = objTutor.GetUsername) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID']; // extracting subject number to access subject name from array
      if tblSessions['Meetinglink'] = null then // if no link is provided, to prevent errors
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime']))
      else
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
          // if a meeting link is provided
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime']));
    end;
    tblSessions.Next; // table sessions next record

  end;
end;

procedure TfrmTutor.btnChangeAttendanceClick(Sender: TObject);
var
  iSessionID: integer;
  bFound: boolean;
begin
  SessionSql(
    'SELECT SessionID as [Session ID], StudentUsername AS [Student Username], Attended FROM tblSessions where TutorUsername = ' + quotedstr(objTutor.GetUsername));
  // edited dbgrid for ease of use
  bFound := False;
  try // error checking for inputting of an integer ahead to check sessions for
    iSessionID := strtoint(inputbox(
        'Enter the sessionID that you would like to change the attendance for',
        'Session ID', ''));
    // if no errors come up
  Except
    begin // if an error shows up show this message
      messagedlg('Please insert a number', mterror, [mbok], 0);
      exit;
    end;
  end;
  tblSessions.First; // beggining of db
  while not tblSessions.Eof do
  begin
    if (tblSessions['SessionID'] = iSessionID) AND
      (tblSessions['TutorUSername'] = objTutor.GetUsername) then
    // if the iSessionID is found
    begin
      bFound := True; // the record was succesfully found
      if tblSessions['Attended'] then
      begin
        tblSessions.edit;
        tblSessions['Attended'] := False; // changes attendance to opposite of what it was
        tblSessions.post;
      end
      else
      begin
        tblSessions.edit;
        tblSessions['Attended'] := True; // changes attendance to opposite of what it was
        tblSessions.post;
      end;
      messagedlg('Succesfully changed session attendance', mtinformation,
        [mbok], 0);
    end;

    tblSessions.Next;
  end;
  if not bFound then
    messagedlg(
      'Entered Session ID either does not exist or is not the ID of one of your students'
        , mtinformation, [mbok], 0); // if the record wasnt found succesfully
  SessionSql(
    'SELECT SessionID as [Session ID], StudentUsername AS [Student Username], Sessiondate as [Date of session], meetinglink AS [Link used], Attended FROM tblSessions where TutorUsername = ' + quotedstr(objTutor.GetUsername));
  // 'refreshing' the dbgrid info to be updated);

end;

procedure TfrmTutor.btnScheduleClick(Sender: TObject);
var
  sUsername: string;
  iSubject: integer;
  SelectedTime: TDateTime;
  iHour, iMinute: integer;
begin
  // username validation
  sUsername := edtUsername.Text; // storing entered username
  if frmMain.IsUniqueUsernameNoMssge(tblStudents, sUsername) then
  // if the username is not unique, ie no learner of that username
  begin
    messagedlg('The entered learner username does not exist', mterror, [mbok],
      0); // error message
    exit;
  end;

  // subject presence check
  if cmbSubject.ItemIndex = -1 then // if no subject is selected
  begin
    messagedlg('Please select a subject', mterror, [mbok], 0);
    // error message
    exit;
  end;
  iSubject := cmbSubject.ItemIndex;

  // date and time validation
  if datetostr(DateTimeSessions.Date) < datetostr(Today) then
  // if the day selected is less than today
  begin
    messagedlg('The selected date has passed, please select another one',
      mterror, [mbok], 0); // error message
    exit;
  end;

  iHour := sedHour.Value;
  iMinute := sedMinute.Value;
  SelectedTime := encodetime(iHour, iMinute, 0, 0);
  // convert spin edit values into a time
  if (datetostr(DateTimeSessions.Date) = datetostr(Today)) AND
    ((TimeToStr(SelectedTime) < TimeToStr(now))) then
  // if the day selected is today but the time has already passed
  begin
    messagedlg(
      'The selected time has already passed, please choose an applicable time',
      mterror, [mbok], 0); // error message
    exit;
  end;
  showmessage(datetostr(DateTimeSessions.Date));
  // All session data has been validated, now have to insert into database
  tblSessions.Last; // last record in db
  tblSessions.Append; // add new record
  tblSessions['StudentUsername'] := sUsername;
  tblSessions['TutorUsername'] := objTutor.GetUsername;
  tblSessions['SubjectID'] := iSubject;
  if edtMeetingLink.Text <> '' then
    tblSessions['MeetingLink'] := edtMeetingLink.Text;
  tblSessions['Sessiondate'] := DateTimeSessions.Date;
  tblSessions['SessionTime'] := SelectedTime;
  tblSessions.post;

  // success message
  messagedlg('Session succesfully added!', mtinformation, [mbok], 0);

end;

procedure TfrmTutor.btnSubmitClick(Sender: TObject);
begin
  if objTutor.ComparePass(edtPrevious.Text) then // if the entered password is the same as the old password
  begin
    if not frmMain.IsValidPassword(edtNewPass.Text) then
      // check if the password is a valid one
      exit;
    objTutor.SetPassword(edtNewPass.Text);
    // set password to new password
    bPassChanged := True; // changed for db update purposes
    messagedlg(
      'Your password has been succesfully updated!, , remember to save changes for then to take affect', mtinformation, [mbok], 0);
    sNewPass := edtNewPass.Text;
    // saved for db update purposes
  end
  else
    messagedlg('Your previous password is incorrect', mtinformation, [mbok], 0);
  // if the previous password is incorrect

end;

procedure TfrmTutor.btnTodayClick(Sender: TObject);
var
  iSubject: integer;
begin
  frmLearner.FormatRichedit(redTutor);
  // format richedit
  redTutor.Lines.Add(#9 + #9 + 'TODAY''S SESSIONS:'); // title
  redTutor.Lines.Add('|Student Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redTutor.Lines.Add( // line to seperate headings from info
    '----------------------------------------------------------------------------------------------------------------------------');

  conTechno.dbconnection; // db connection
  tblSessions.First; // first record in db
  while not tblSessions.Eof do
  begin
    if (tblSessions['TutorUsername'] = objTutor.GetUsername) AND // if the username matches the client's and the date of the session is today
      (tblSessions['SessionDate'] = Today) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID']; // reading subject number to extract subject name from array later on
      if tblSessions['Meetinglink'] = null then
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime'])) // if no meeting link is provided
      else
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime'])); // if meeting link is provided
    end;
    tblSessions.Next; // next record in db
  end;
end;

procedure TfrmTutor.btnUpcomingClick(Sender: TObject);
var
  iSubject: integer;
begin
  frmLearner.FormatRichedit(redTutor);
  // formatting richedit
  redTutor.Lines.Add(#9 + #9 + 'UPCOMING SESSIONS:'); // title
  redTutor.Lines.Add('|Student Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redTutor.Lines.Add( // line to seperate info from headings
    '----------------------------------------------------------------------------------------------------------------------------');

  conTechno.dbconnection; // database connection
  tblSessions.First; // begining of database
  while not tblSessions.Eof do
  begin
    if (tblSessions['TutorUsername'] = objTutor.GetUsername) AND // if the client is the wanted client and the date of the session is later than todays date
      (tblSessions['SessionDate'] > Today) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID']; // reading subject number to extract subject name from array later on
      if tblSessions['Meetinglink'] = null then
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime'])) // output if meeting link isnt provided
      else
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime']));
      // outputed if meeting link is provided
    end; // next record in db
    tblSessions.Next;
  end;
end;

procedure TfrmTutor.btnUsernameSubmitClick(Sender: TObject);
begin
  if frmMain.IsUniqueUsername(tblTutors, edtNewUsername.Text) then
  // if the username is unique, ie has not been used by any other users
  begin
    objTutor.SetUsername(edtNewUsername.Text);
    // set new username to object
    messagedlg(
      'Your username has been succesfully updated!, remember to save changes for then to take affect', mtinformation, [mbok], 0);
    // confirmation message
  end
  else
    messagedlg('Your'' username is not unique, please choose another one',
      mtinformation, [mbok], 0); // if the username is not unique

end;

procedure TfrmTutor.Button1Click(Sender: TObject);
var
  iSubject, iHours: integer;
  dDate: TDateTime;
begin
  try // error checking for inputting of hours ahead to check sessions for
    iHours := strtoint(inputbox(
        'Enter the amount of hours ahead from now you would like to see sessions for'
          , 'Hours', '1'));
    // if no errors come up
  Except

    begin // if an error shows up show this message
      messagedlg('Please insert a number', mterror, [mbok], 0);
      exit;
    end;
  end;
  frmLearner.FormatRichedit(redTutor); // format richedit
  redTutor.Lines.Add(#9 + #9 + 'SESSIONS WITHIN THE NEXT ' + inttostr(iHours)
      + ' HOURS(S):'); // title
  redTutor.Lines.Add('|Student Username|' + #9 + '|Session Date|' + #9 +
      '|Subjectname|' + #9 + '|Meeting Link|' + #9 + '|Session Time|');
  // headings
  redTutor.Lines.Add( // line to seperate info from headings
    '----------------------------------------------------------------------------------------------------------------------------');
  // database connection
  conTechno.dbconnection;
  tblSessions.First; // start of db
  while not tblSessions.Eof do // loop through db
  begin
    if (tblSessions['TutorUsername'] = objTutor.GetUsername) AND
      ((tblSessions['SessionDate'] = Today) AND
        (datetostr(tblSessions['SessionTime']) > TimeToStr(now))) AND
      (TimeToStr(tblSessions['sessiontime']) < TimeToStr(IncHour(now, iHours))
      // if the clientid matches db and the session time is between now and the incrimented time acccording to user input
      ) then
    // all session records relation to a certain student
    begin
      iSubject := tblSessions['SubjectID'];
      if tblSessions['Meetinglink'] = null then
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + 'No link provided' + #9 + TimeToStr
            (tblSessions['SessionTime'])) // output if no meeting link is supplied
      else
        redTutor.Lines.Add(tblSessions['StudentUsername'] + #9 + datetostr
            (tblSessions['SessionDate']) + #9 + arrSubjects[iSubject]
            + #9 + tblSessions['Meetinglink'] + #9 + TimeToStr
            (tblSessions['SessionTime'])); // output if no meeting link is supplied
    end;
    tblSessions.Next; // next record in db
  end;
end;

procedure TfrmTutor.FormShow(Sender: TObject);

var
  myFile: textfile;
  sLine: string;
  iCount, I: integer;
begin
  sOriginalUsername := objTutor.GetUsername;
  // storing orignal surname incase it gets changed later
  pgcntrlLearner.TabIndex := 1; // setting page control default page
  conTechno.dbconnection; // database connection
  conTechno.ConnectSessions(dbgridSessions);
  SessionSql(
    'SELECT SessionID as [Session ID], StudentUsername AS [Student Username], Sessiondate as [Date of sesion], meetinglink AS [Link used], Attended FROM tblSessions where TutorUsername = ' + quotedstr(objTutor.GetUsername));
  // shows all the database records relating to the teacher and no one else

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
  // close subject textfile


  // ***************loading combo box*******************************//

  // load subjects into combobox from array
  for I := 1 to length(arrSubjects) do // cycle trhough array
  begin
    cmbSubject.Items.Add(arrSubjects[I]);
    // load array context into combobox
  end;
end;

procedure TfrmTutor.imgExitClick(Sender: TObject);
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

procedure TfrmTutor.imgSaveClick(Sender: TObject);
begin
  tblTutors.First;
  // begining of db
  while not tblTutors.Eof do // loop through db
  begin
    if tblTutors['Username'] = sOriginalUsername then // finding the user (with their original username) in the db
    begin
      tblTutors.edit; // edit mode for db
      tblTutors['Username'] := objTutor.GetUsername; // set new username
      if bPassChanged then
        tblTutors['Password'] := sNewPass;
      // if the password was changed change db
      tblTutors.post;
      messagedlg('Changes have been permanantly saved', mtinformation, [mbok],
        // confirmation message
        0);

    end;
    tblTutors.Next; // next record in db
  end;

end;

procedure TfrmTutor.Learnerresourcecenter1Click(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('resource_centre.html'), nil, nil, SW_SHOWNORMAL);
  // opens resource centre for learners
end;

procedure TfrmTutor.Mainmenu1Click(Sender: TObject);
begin
  objStudent.Free;
  frmLearner.close;
  frmMain.Show;
end;

procedure TfrmTutor.SessionSql(sSql: string);
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

procedure TfrmTutor.Userinfo1Click(Sender: TObject);
begin
  redTutor.Lines.Add(objTutor.ToString);
  // outputs info about the user
end;

end.
