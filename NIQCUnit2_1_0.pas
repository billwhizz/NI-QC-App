unit NIQCUnit2_1_0;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, inifiles, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZSqlMonitor, ZAbstractConnection, ZConnection, StdCtrls, ExtCtrls, clipbrd,
  Menus;
  
Type
    TSetNums = set of '0'..'9';
    // 2.1 name suffix additions
type
  TForm1 = class(TForm)
    gbSearch: TGroupBox;
    rbExtSD43: TRadioButton;
    rbExtHD: TRadioButton;
    rbExtWav: TRadioButton;
    rbCinegySD: TRadioButton;
    rbCinegyHD: TRadioButton;
    btSearch: TButton;
    btSearchNext: TButton;
    rbAny: TRadioButton;
    DataSource1: TDataSource;
    ZConnection1: TZConnection;
    ZSQLMonitor1: TZSQLMonitor;
    ZQuery1: TZQuery;
    ZQueryManfEdit: TZQuery;
    DataSourceManfEdit: TDataSource;
    stDatabaseConn: TStatusBar;
    gbDatabase: TGroupBox;
    rbLiveDB: TRadioButton;
    rbTestDB: TRadioButton;
    rbPlayDB: TRadioButton;
    stDB: TStaticText;
    rbDevDB: TRadioButton;
    leRecords: TLabeledEdit;
    GroupBox2: TGroupBox;
    btFail: TButton;
    btPass: TButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    cbTopTail: TCheckBox;
    cbMetaData: TCheckBox;
    ZQuery2: TZQuery;
    DataSource2: TDataSource;
    btCancel: TButton;
    GroupBox3: TGroupBox;
    btCopySpoolNo: TButton;
    stExportReq: TStaticText;
    btExportConfirmed: TButton;
    tmrSearch: TTimer;
    meSQL: TMemo;
    GroupBox4: TGroupBox;
    cb1PcExport: TCheckBox;
    cb1PCQC: TCheckBox;
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    CLose1: TMenuItem;
    DBase1: TMenuItem;
    Show1: TMenuItem;
    Label1: TLabel;
    rbSearchSpool: TRadioButton;
    ebSearchSpool: TEdit;
    cbNewest: TCheckBox;
    btStart: TButton;
    ZQueryDBQuery: TZQuery;
    DataSourceDBQuery: TDataSource;
    GroupBox1: TGroupBox;
    leSpool: TLabeledEdit;
    leProgNo: TLabeledEdit;
    LeSerNo: TLabeledEdit;
    leLocation: TLabeledEdit;
    st1PC: TStaticText;
    leDateTime: TLabeledEdit;
    leQCSource: TLabeledEdit;
    leQCLocationDesc: TLabeledEdit;
    leLocationDesc: TLabeledEdit;
    leProgTitle: TLabeledEdit;
    leEpisodeTitle: TLabeledEdit;
    gbNotres: TGroupBox;
    btNotesSave: TButton;
    btNotesCancel: TButton;
    stMemoWrite: TStaticText;
    meNotes: TMemo;
    rbSearchQC: TRadioButton;
    rbExtSD169: TRadioButton;
    procedure btSearchClick(Sender: TObject);
    procedure meNotesKeyPress(Sender: TObject; var Key: Char);
    procedure btNotesCancelClick(Sender: TObject);
    procedure cbTopTailClick(Sender: TObject);
    procedure btPassClick(Sender: TObject);
    procedure btNotesSaveClick(Sender: TObject);
    procedure btSearchNextClick(Sender: TObject);
    procedure btExportConfirmedClick(Sender: TObject);
    procedure ZSQLMonitor1LogTrace(Sender: TObject; Event: TZLoggingEvent);
    procedure FormCreate(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure cb1PCQCClick(Sender: TObject);
    procedure cb1PcExportClick(Sender: TObject);
    procedure btCopySpoolNoClick(Sender: TObject);
    procedure CLose1Click(Sender: TObject);
    procedure Show1Click(Sender: TObject);
    procedure btStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbSearchSpoolClick(Sender: TObject);
    procedure ebSearchSpoolKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function bbConnecttoDB: boolean;
    function bbSQLEscape(sSQL: string): string;
    procedure bbWriteDBFieldStr(sTable, sField, sValue, sCondition: String);
    procedure bbGetDBFieldStr(sTable, sField, sCondition: String;
      out sValue: string; out iRecords: Integer);
    function bbBarcodePad9(sBarcode: String): String;
    procedure bbGetRecord(Dataset: TDataset; iIncrement: integer);
    procedure bbReassignSpool(sSpool, sDestination: String);
    procedure bbMemoTrim(meMemo: tMemo);
    procedure bbSetQCStatus(sContent, sMeta, sSpool: String);
    function bbBarcodeClean(sBarcode: string): string;
    function bbWriteDBFieldFn(sTable, sField, sValue,
      sCondition: String): boolean;
    procedure bbWriteDBFieldDT(sTable, sField: String; dtValue: TDateTime;
      sCondition: String);
    procedure bbGetDBFieldDT(sTable, sField, sCondition: String;
      out dtValue: TDatetime; out iRecords: Integer);
    procedure bbGetDBNow(out dtValue: TDatetime);
    procedure bbSearchSpool;
    function bbLocationToDesc(sLocation: string): string;
    procedure bbStartQC;
    procedure bbSaveIni(sIniFilePath: String);
    procedure bbGetIni(sIniFilePath: String);
    procedure bbNameSuffixStrip(sName, sSeperator: String; out sCoreName,
      sSuffix: String);
    function bbBarcodePad9Sfx(sBarcode: String): String;
    function bbBarcodeCleanSfx(sBarcode: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  dtGbTimeStamp : TDatetime;
  sGbIniFilePath : String;

implementation

{$R *.dfm}

Function TForm1.bbConnecttoDB:boolean;
var IsConnected : boolean;
begin
    // Connect to the database
    ZConnection1.disconnect;
    if rbTestDB.Checked then
       begin
          ZConnection1.Database := 'nitracking_test';
          ZConnection1.HostName := '9gbbedbnid1001';
          ZConnection1.User := 'NiDigitsUser';
          ZConnection1.Password := 'n1dus3r';
          stDatabaseConn.Color := clYellow;
       end;

     if rbDevDB.Checked then
       begin
          ZConnection1.Database := 'nitracking_test';
          ZConnection1.HostName := '127.0.0.1';
          ZConnection1.User := 'NiDigitsUser';
          ZConnection1.Password := 'n1dus3r'; 
          stDatabaseConn.Color := clTeal;

       end;

     if rbLiveDB.Checked then
       begin
          ZConnection1.Database := 'nitracking';
          ZConnection1.HostName := '9gbbedbnid1001';
          ZConnection1.User := 'NiDigitsUser';
          ZConnection1.Password := 'n1dus3r'; 
          stDatabaseConn.Color := cllime;
       end;

     if rbPlayDB.Checked then
       begin
          ZConnection1.Database := 'nitracking_play';
          ZConnection1.HostName := '9gbbedbnid1001';
          ZConnection1.User := 'NiDigitsUser';
          ZConnection1.Password := 'n1dus3r';
          stDatabaseConn.Color := clAqua;
       end;

     If (( not (rbLiveDB.Checked))  and ( not (rbTestDB.Checked))   and ( not (rbPlayDB.Checked)) AND( not (rbDevDB.Checked))) then
      begin
      //  bbSound(3,sBings);
        Beep;
        Showmessage('Please Select Database');
        Exit;
      end;
       // ext db were here

      try
        ZConnection1.Connect;
        IsConnected := ZConnection1.Connected;
        Zquery1.Active := false;
        Zquery1.sql.Clear;
        Zquery1.sql.Add(' SELECT * FROM t_tape_status Limit 10' );
        Zquery1.Active := true;
       // bbSetCols;

      except
        On E: Exception do
        begin

          IsConnected := False;
         // bbsound(3,sbings);
         Beep;
          If NOT FileExists(extractfilepath(application.ExeName ) + 'libmysql.dll') then
          ShowMessage('Cannot connect to the database at the moment. Please, ensure the network is connected, and ensure a copy of libmysql.dll is saved with this Application exe') else
          ShowMessage('Cannot connect to the database at the moment. Please try again later.');
          ZConnection1.Disconnect;
          //Exit;
        end;
      end;

      Result := IsConnected;
      If IsConnected = true
      then
      begin

     //   bbsound(4,sbings);
       // stDatabaseConn.Color := clLime;
     //   form1.Caption := sFormCaption + '     Connected ' ;
         // If (( ZConnection1.HostName = '127.0.0.1' ) AND (ZConnection1.database = 'nitracking_test')) then  stDatabaseConn.SimpleText := 'Database Connected - Test';
         //  If (( ZConnection1.HostName = '127.0.0.1' ) AND (ZConnection1.database = 'nitracking')) then  stDatabaseConn.SimpleText := 'Database Connected - Live';
        // If ZConnection1.HostName = 'localhost' then  stDatabaseConn.SimpleText := 'Database Connected - Test on ' + ZConnection1.HostName + ': ' + ZConnection1.database;
        // If ZConnection1.HostName = '10.149.10.9' then  stDatabaseConn.SimpleText := 'Database Connected - ' + ZConnection1.database ;
        //  If ZConnection1.HostName = '127.0.0.1' then  stDatabaseConn.Color := clyellow;
          stDatabaseConn.SimpleText := 'Database : ' + ZConnection1.database;
      end
       else
       begin
         stDatabaseConn.SimpleText := 'Database: Not Connected';
         stDatabaseConn.Color := clred;
         form1.Caption := form1.Caption + '   Database: Not Connected';
       end;

   //  bbDisconnectTimerReset;

end;




procedure TForm1.btSearchClick(Sender: TObject);
begin
   bbSearchSpool;
end;


Procedure TForm1.bbSearchSpool;
var iRec, iRecs : integer;
    sSpool, sSQL, sSource, sFilter, sSrchSpool , sOrder, sCoreName,sSuffix: String;
begin
    bbConnectToDB;

    If not (zConnection1.Connected )then
    begin
      Showmessage(' DB Not Connecting' );
    end;
    // set SQL filter
    sSource := '';
    If rbExtHD.Checked then sSource := '5101';
    If rbExtSD43.Checked then sSource := '5102';
    If rbExtSD169.Checked then sSource := '5103';
    If rbExtWav.Checked then sSource := '5104';
    If rbCinegyHD.Checked then sSource := '5105';
    If rbCinegySD.Checked then sSource := '5106';

    sFilter := ' f_location = ' + sSource ;

    If cb1PcExport.Checked Then sFilter := ' f_location = ' + sSource + ' AND f_qc_id <> 0  AND MOD(f_qc_id,100) = 0 ';
    If cb1PcQC.Checked  then sFilter := ' ( (f_location = 7100 )OR( f_location = 7200) ) AND f_qc_src = ' + sSource ;   // 1% selection  check box


    If rbAny.Checked then
    begin
      sFilter := ' f_location  LIKE ''510%''';
      If cb1PcExport.Checked Then sFilter := ' f_location LIKE ''510%''  AND f_qc_id <> 0  AND MOD(f_qc_id,100) = 0 ';
      If cb1PCQC.Checked  then sFilter := ' ( (f_location = 7100 )OR( f_location = 7200) ) AND f_qc_src LIKE ''510%''';

    end;

    If cbNewest.Checked Then sOrder := ' ORDER BY f_time DESC '
      else sOrder := ' ORDER BY f_time ASC ';

    sSQL := 'SELECT * FROM t_tape_status WHERE ' + sFilter + sOrder;

    // Search specific Spool
    If rbSearchSpool.checked then
    Begin
      sSrchSpool := UpperCase(ebSearchSpool.Text);
      If Trim(ebSearchSpool.Text) = '' then
        begin
        Showmessage('Please Enter Spool No');
        EXIT;
      End;

      bbNamesuffixStrip(sSrchSpool,'_',sCoreName,sSuffix);

      sSrchSpool := bbBarcodeCleanSfx( sCoreName ) + bbSQLEscape(sSuffix) ;

      sSQL := 'SELECT * FROM t_tape_status WHERE f_spool LIKE ''' + sSrchSpool + '''';
    end;

    If rbSearchQC.Checked then
    begin
      sSQL := 'SELECT * FROM t_tape_status WHERE f_location = 5199';

    end;

    ZQuery1.Active := false;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add(sSQL);
    ZQuery1.Active := true;

    iRecs := Datasource1.DataSet.RecordCount;
    leRecords.Text := intToStr(iRecs);

    If iRecs >= 1 then
    begin
        btStart.Enabled := True;
    end;

    If iRecs > 1 then
    begin
        btSearchNext.Enabled := true;
        tmrSearch.Enabled := true;  // timeout on 'Next'
    end;


    {If iRecs >0 then btFail.Enabled := True;
    If iRecs >0 then btHold.Enabled := True;

    leSpool.Text := Datasource1.dataset.fieldbyname('f_spool').AsString;
    leProgTitle.Text := Datasource1.dataset.fieldbyname('f_prog_title').AsString;
    leEpisodeTitle.Text := Datasource1.dataset.fieldbyname('f_episode_title').AsString;
    leProgNo.Text := Datasource1.dataset.fieldbyname('f_prog_no').AsString;
    LeSerNo.Text := Datasource1.dataset.fieldbyname('f_qc_id').AsString;
    meNotes.Text := Datasource1.dataset.fieldbyname('f_notes').AsString; }

    bbGetRecord(Datasource1.dataset,0);

end;

Procedure TForm1.bbNameSuffixStrip( sName , sSeperator : String; OUT sCoreName, sSuffix : String);
var iLen, iPos : integer;
begin
  sSuffix := '';
  sCoreName := sName;
  iLen := Length( sname ) ;
  iPos := Pos(sSeperator,sName);

  If ((iPos = iLen -1)  OR (iPos = iLen -2))
  then
  begin
    sCoreName := Copy(sName, 1,iPos -1);
    sSuffix := Copy(sName,iPos, ilen - Ipos + 1);
  end;
  iLen:= 1;
end;

procedure TForm1.btSearchNextClick(Sender: TObject);
begin
  // Look for next one, updates varaiables
  If Datasource1.DataSet.RecNo < Datasource1.DataSet.RecordCount then
    bbGetRecord(Datasource1.DataSet, 1);

  If Datasource1.DataSet.RecNo = Datasource1.DataSet.RecordCount then btSearchNext.enabled := false;
end;


procedure TForm1.bbGetRecord(Dataset : TDataset ; iIncrement : integer);
var iRec, iRecs, iQCID, ilocation : integer; sLocation, sQCLocation : String ;
begin

    iRecs := Datasource1.DataSet.RecordCount;
    leRecords.Text := intToStr(iRecs);

    iRec := Datasource1.DataSet.RecNo;
    If iRec + iIncrement <= iRecs then Datasource1.DataSet.MoveBy(iIncrement)
    else EXIT; 

    iLocation := Datasource1.dataset.fieldbyname('f_location').asinteger;


    leSpool.Text := Datasource1.dataset.fieldbyname('f_spool').AsString;
    //GBSpool :=
    leProgTitle.Text := Datasource1.dataset.fieldbyname('f_prog_title').AsString;
    leEpisodeTitle.Text := Datasource1.dataset.fieldbyname('f_episode_title').AsString;
    leProgNo.Text := Datasource1.dataset.fieldbyname('f_prog_no').AsString;
    sLocation := Datasource1.dataset.fieldbyname('f_location').AsString;
    LeSerNo.Text := Datasource1.dataset.fieldbyname('f_qc_id').AsString;
    meNotes.Text := Datasource1.dataset.fieldbyname('f_notes').AsString;
    leLocation.Text := sLocation;
    leLocationDesc.Text := bbLocationToDesc(sLocation);
    iQCID := Datasource1.dataset.fieldbyname('f_qc_id').AsInteger;
    sQCLocation := Datasource1.dataset.fieldbyname('f_qc_src').AsString;
    leQCSource.Text :=  sQCLocation;
    leQCLocationDesc.Text :=  bbLocationToDesc(sQCLocation);
    leDateTime.Text := Datasource1.dataset.fieldbyname('f_time').AsString;

    If ((iQCID <> 0 ) and( iQCID Mod 100 = 0 )) then  st1PC.Color := clRed else st1PC.Color := clGray;

    If ((iQCID <> 0 ) and( iQCID Mod 100 = 0 ) AND (( iLocation > 5100 ) AND ( iLocation < 5107 )) ) then
    begin
      stExportReq.Caption :=   '  Export From Cinegy Req';
      stExportReq.Color := clRed;
      btExportConfirmed.Enabled := True;
    end
    else
    begin
      stExportReq.Caption :=   '';
      stExportReq.Color := clBtnFace;
      btExportConfirmed.Enabled := False;
    end;

end;


procedure TForm1.meNotesKeyPress(Sender: TObject; var Key: Char);
begin
  If leSpool.Text = '' then exit;
  btNotesSave.Enabled := true;
  stMemoWrite.Color := clRed;
end;
Procedure TForm1.bbWriteDBFieldStr (sTable, sField, sValue, sCondition : String);
var sSQL : String;
begin
  sValue := bbSQLEscape(sValue);   //  escape 'nasty characters' such as backslash
  sSQL := 'UPDATE ' + sTable + ' SET ' + sField + ' = ''' + sValue +''' '
     + ' WHERE ' + sCondition ;    //  f_news_day_no = "' + dbNewsDay.text + '"';
  If Trim( sCondition ) = '' then
  begin
    Showmessage('WriteDBField Error - No WHERE condition: ' + sSQL);
    Exit;
  end;
  Try
  ZQueryDBQuery.SQL.Clear;
  ZQueryDBQuery.SQL.Add(sSQL);
  ZQueryDBQuery.ExecSQL;
  Except
  Showmessage('WriteDBField Error - failed ' + sSQL);
  End;
end;

Procedure TForm1.bbWriteDBFieldDT(sTable, sField  : String; dtValue :TDateTime; sCondition : String);
var sSQL, sValue : String;
begin
  sValue := FormatDateTime( 'yyyy-mm-dd hh:nn:ss.zzzz', dtValue);   //  escape 'nasty characters' such as backslash
  sSQL := 'UPDATE ' + sTable + ' SET ' + sField + ' = ''' + sValue +''' '
     + ' WHERE ' + sCondition ;    //  f_news_day_no = "' + dbNewsDay.text + '"';
  If Trim( sCondition ) = '' then
  begin
    Showmessage('WriteDBField Error - No WHERE condition: ' + sSQL);
    Exit;
  end;
  Try
  ZQueryDBQuery.SQL.Clear;
  ZQueryDBQuery.SQL.Add(sSQL);
  ZQueryDBQuery.ExecSQL;
  Except
  Showmessage('WriteDBField Error - failed ' + sSQL);
  End;
end;

Function TForm1.bbLocationToDesc(sLocation:string):string;
var sSQL : String; iRecords : Integer;
begin
  Result := '';
  If  sLocation = '' Then Exit;  

  sSQL := 'SELECT  f_location_description FROM t_location_lookup '
     + ' WHERE f_location_id = ' + sLocation  ;    //  f_news_day_no = "' + dbNewsDay.text + '"';

  ZQueryDBQuery.active := false;
  ZQueryDBQuery.SQL.Clear;
  ZQueryDBQuery.SQL.Add(sSQL);
  ZQueryDBQuery.active := True;

  Result :=  DataSourceDBQuery.DataSet.FieldbyName('f_location_description').AsString;
  iRecords :=  DataSourceDBQuery.DataSet.RecordCount;
  If iRecords = 0 then Result := ' **Not Found';

end;



Function TForm1.bbSQLEscape(sSQL : string ) :string;
begin
     sSQL := StringReplace(sSQL ,'\','\\',[rfReplaceAll]);// backslash
     sSQL := StringReplace(sSQL ,'"','\"',[rfReplaceAll]);// sing quote
     sSQL := StringReplace(sSQL ,'''','\''',[rfReplaceAll]);// double quote    
     sSQL := StringReplace(sSQL ,'_','\_',[rfReplaceAll]);// double quote
     sSQL := StringReplace(sSQL ,#10,'\n',[rfReplaceAll]);// linefeed
     sSQL := StringReplace(sSQL ,#13,'\r',[rfReplaceAll]);// cr
     sSQL := StringReplace(sSQL ,#11,'\t',[rfReplaceAll]);// tab
     Result := sSQL;
end;



Procedure TForm1.bbGetDBFieldStr (sTable, sField, sCondition : String; OUT sValue : string; OUT iRecords : Integer);
var sSQL : String;
begin
  //bbConnectToDB;
 // sValue := bbSQLEscape(sValue);   //  escape 'nasty characters' such as backslash

  sSQL := 'SELECT  '  + sField + ' FROM ' + sTable
     + ' WHERE ' + sCondition ;    //  f_news_day_no = "' + dbNewsDay.text + '"';

  ZQueryDBQuery.active := false;
  ZQueryDBQuery.SQL.Clear;
  ZQueryDBQuery.SQL.Add(sSQL);
  ZQueryDBQuery.active := True;

  sValue :=  DataSourceDBQuery.DataSet.FieldbyName(sfield).AsString;
  iRecords :=  DataSourceDBQuery.DataSet.RecordCount;

  //bbDisconnectDB;
end;

Procedure TForm1.bbGetDBFieldDT (sTable, sField, sCondition : String; OUT dtValue : TDatetime; OUT iRecords : Integer);
var sSQL : String;
begin
  //bbConnectToDB;
 // sValue := bbSQLEscape(sValue);   //  escape 'nasty characters' such as backslash

  sSQL := 'SELECT  '  + sField + ' FROM ' + sTable
     + ' WHERE ' + sCondition ;    //  f_news_day_no = "' + dbNewsDay.text + '"';

  ZQueryDBQuery.active := false;
  ZQueryDBQuery.SQL.Clear;
  ZQueryDBQuery.SQL.Add(sSQL);
  ZQueryDBQuery.active := True;

  dtValue :=  DataSourceDBQuery.DataSet.FieldbyName(sfield).AsDatetime;
  iRecords :=  DataSourceDBQuery.DataSet.RecordCount;

  //bbDisconnectDB;
end;

Procedure TForm1.bbGetDBNow ( OUT dtValue : TDatetime);
var sSQL : String;
begin
  //bbConnectToDB;
 // sValue := bbSQLEscape(sValue);   //  escape 'nasty characters' such as backslash

  sSQL := 'SELECT NOW() ' ;
  ZQueryDBQuery.active := false;
  ZQueryDBQuery.SQL.Clear;
  ZQueryDBQuery.SQL.Add(sSQL);
  ZQueryDBQuery.active := True;

  dtValue :=  DataSourceDBQuery.DataSet.Fields[0].AsDateTime;
  //bbDisconnectDB;
end;


procedure TForm1.btNotesCancelClick(Sender: TObject);
var sMemo : string;  iRecs, iQCID : Integer;
begin

  btNotesSave.Enabled := false;
   bbGetDBFieldstr( 't_tape_status','f_notes','f_spool = ''' + lespool.Text + '''', SMemo, iRecs );
   meNotes.Text := sMemo;
   stMemoWrite.Color := clBtnFace;

end;

procedure TForm1.cbTopTailClick(Sender: TObject);
begin
  If (cbTopTail.Checked and cbMetaData.Checked AND ( Length(leSpool.Text ) > 2 ))
   Then btPass.Enabled := true
   else btPass.Enabled := false;
end;

procedure TForm1.btPassClick(Sender: TObject);
var sName, sLocation, sDestination, sSpool, sSQL, sContent, sMeta, sQCLocation, sSourceID : string;
   irecs, iLocation , iQCLocation, i1PCQC, iQCID, iSourceID: integer;
begin
   sName := (Sender As TButton).Name;

   bbConnectToDB;

   sSpool := leSpool.Text;
   If Trim( SSpool ) = ''
   then
   begin
     Showmessage('Error - No Spool Selected ');
     Exit;
   end;

   If (( sName = 'btPass' ) AND  btNotesSave.Enabled ) then
      If Messagedlg('Have you Added Reason Notes?? Please Save First.',mtWarning,[mbYes,MbNo],0) = mrNo then Exit;
   
   If (( sName = 'btFail' ) AND  btNotesSave.Enabled ) then
      If Messagedlg('Have you Added Reason Notes?? Please Save First.',mtWarning,[mbYes,MbNo],0) = mrNo then Exit;

    // look up spool - check it is a valid one

    sSQL := 'SELECT * FROM t_tape_status WHERE f_spool = ''' + sSpool + '''';

    ZQuery1.Active := false;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add(sSQL);
    ZQuery1.Active := true;

    iRecs := Datasource1.DataSet.RecordCount;

    If iRecs <> 1 then
    begin
      Showmessage('Error - Spool selection issue - irecs = ' + inttostr(irecs));
      Exit;
    end;

    IF Datasource1.DataSet.FieldByName('f_spool').AsString <> leSpool.Text
    then
    begin
      Showmessage('Error - Spool selection to DBase missmatch' );
      Exit;
    end;

    sLocation := Datasource1.DataSet.FieldByName('f_location').AsString ;
    iLocation := Datasource1.DataSet.FieldByName('f_location').AsInteger ;


   { IF Datasource1.DataSet.FieldByName('f_location').AsInteger <> Datasource1.DataSet.FieldByName('f_qc_src').AsInteger
    then
    begin

      Showmessage('Error - Spool has been QC''d - location now - ' + sLocation );
      Exit;
    end;  }


    sQCLocation := Datasource1.DataSet.FieldByName('f_qc_src').AsString ;
    iQCLocation := Datasource1.DataSet.FieldByName('f_qc_src').AsInteger ;
    sSourceID := Copy(sQCLocation,3,2);
    iSourceID := iQCLocation Mod 100;

    iQCID := Datasource1.DataSet.FieldByName('f_qc_id').AsInteger ;

    If ((iQCID <> 0 ) and( iQCID Mod 100 = 0 )) then i1PCQC := 2000 else i1PCQC := 0;

    If sName = 'btPass' then sDestination :=  intToStr(6100 + i1PCQC + iSourceID );
    If sName = 'btHold' then sDestination :=   intToStr(6300 + i1PCQC + iSourceID );
    If sName = 'btFail' then sDestination :=   intToStr(6200 + i1PCQC + iSourceID );;

    If cbTopTail.Checked then sContent := 'Yes' else sContent := 'No';
    If cbMetaData.Checked then sMeta := 'Yes' else sMeta := 'No';

    //If btNotesSave.Enabled then btNotesSave.Click;

    bbReassignSpool(sSpool,sDestination);

      Showmessage('Status Set To: ' + Copy(sName,3,4));

      btPass.Enabled := false;
   //   btHold.Enabled := false;
      btFail.Enabled := false;

      btSearch.enabled := true;
      
     cbMetaData.Checked := false;
     cbTopTail.checked := false;

      zConnection1.Disconnect;

end;

Procedure TForm1.bbReassignSpool(sSpool, sDestination : String);
var sSQL : String;
begin
      bbConnectToDb;

      Zquery2.Active := false;
      Zquery2.sql.Clear;

      sSQL :=  ' UPDATE t_tape_status SET f_prev_time = f_time, f_prev_location = f_location, f_time = NOW()'
               + ' , f_location := ''' + sDestination
               + ''' WHERE f_spool = '''  + sSpool + '''';
      Zquery2.sql.Add(sSQL);
      Zquery2.ExecSQL;

      Zquery2.Active := false;   // log
      Zquery2.sql.Clear;


      sSQL := ' INSERT INTO t_tape_log  (f_spool , f_location, f_time  )'
               + ' VALUES ( '''  + sSpool + ''', '''  + sDestination + ''', NOW() )';

      Zquery2.sql.Add(sSQL);
      Zquery2.ExecSQL;
end;

Procedure TForm1.bbSetQCStatus(sContent, sMeta, sSpool : String);
var sSQL : String;
begin
      bbConnectToDb;

      Zquery2.Active := false;
      Zquery2.sql.Clear;

      sSQL :=  ' UPDATE t_tape_status SET f_qc_content = ''' + sContent + ''''
             +  ' , f_qc_meta = ''' + sMeta + ''', '
             +  ''' WHERE f_spool = '''  + sSpool + '''';
      Zquery2.sql.Add(sSQL);
      Zquery2.ExecSQL;

end;




function TForm1.bbBarcodePad9(sBarcode: String):String ;
var iPos, iNum, iLength, iTest : Integer; sTest : String;
begin

  Trim(sBarcode);                // remove outer spaces
  // now 1 to 3 letters, 1 to 6 numbers
  // find first number
  iLength := Length(sBarcode);
  iPOs := 1;

  While (( iPos < iLength ) AND ( NOT TryStrToInt(sBarcode[ipos],iTest)) ) do
  Inc(iPos);

  Case iPOs of   // gets here when found number
  2 : sBarcode := Copy(sBarcode,1,1 ) + '00' + Copy(sBarcode,2,iLength-1); // single letter
  3 : sBarcode := Copy(sBarcode,1,2 ) + '0' + Copy(sBarcode,3,iLength-2);  // two letters
  else end;

  // Pad number
  iLength := Length(sBarcode);
  While Length(sBarcode) < 9 do Insert('0',sBarcode,4);

  Result := UpperCase(sBarcode);
end;


function TForm1.bbBarcodePad9Sfx(sBarcode: String):String ;
var iPos, iNum, iLength, iTest : Integer; sTest, sCore, sSuffix : String;
begin

  Trim(sBarcode);                // remove outer spaces
  // now 1 to 3 letters, 1 to 6 numbers
  // find first number
  iLength := Length(sBarcode);
  iPOs := 1;

  bbNameSuffixStrip(sBarcode,'_',sCore, sSuffix);
  sBarcode := sCore;

  While (( iPos < iLength ) AND ( NOT TryStrToInt(sBarcode[ipos],iTest)) ) do
  Inc(iPos);

  Case iPOs of   // gets here when found number
  2 : sBarcode := Copy(sBarcode,1,1 ) + '00' + Copy(sBarcode,2,iLength-1); // single letter
  3 : sBarcode := Copy(sBarcode,1,2 ) + '0' + Copy(sBarcode,3,iLength-2);  // two letters
  else end;

  // Pad number
  iLength := Length(sBarcode);
  While Length(sBarcode) < 9 do Insert('0',sBarcode,4);

  Result := UpperCase(sBarcode) + sSuffix;
end;


procedure TForm1.btNotesSaveClick(Sender: TObject);
var iRecs : integer; SMemo : string;
begin
  bbConnectToDB;

  If  Trim(leSpool.Text) <> '' then
  begin
   bbWriteDBFieldStr('t_tape_status','f_notes',meNotes.text + #10#13,'f_spool = ''' + lespool.Text + '''');
  // bbRefresh_PreservePosition;
   bbGetDBFieldstr( 't_tape_status','f_notes','f_spool = ''' + lespool.Text+ '''', SMemo, iRecs );
   meNotes.text := SMemo;
   btNotesSave.Enabled := false;
   stMemoWrite.Color := clBtnFace;
   end;
   zConnection1.Disconnect;


end;


procedure TForm1.btExportConfirmedClick(Sender: TObject);
var sSpool : string; iDestination : integer;
begin
    iDestination := 5999 ; // strToInt(leLocation.Text) + 1000;
   { If ((iDestination > 6200 ) OR (iDestination < 6100 ))
    then
    begin
      Showmessage('Error - Export Location Out of Range ! Cannot Move Asset' );
      Exit;

    end; }
    // move to 1% zone
    bbReassignSpool(leSpool.Text, inttoStr(iDestination));

    begin
      stExportReq.Caption :=   '';
      stExportReq.Color := clBtnFace;
      btExportConfirmed.Enabled := False;
    end;
end;

Procedure TForm1.bbMemoTrim(meMemo : tMemo);
begin
   If meMemo.Lines.Count > 600 then
   while meMemo.Lines.Count > 500 do meMemo.Lines.Delete(meMemo.Lines.Count-1); ;
end;

procedure TForm1.ZSQLMonitor1LogTrace(Sender: TObject;
  Event: TZLoggingEvent);
begin
  meSql.Lines.Add(Event.asstring);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption := 'Billtrack QC App -  ';
  Form1.Caption := Form1.Caption + (application.ExeName) + '  Ver 2.1.0.1';
  sGbIniFilePath := application.ExeName;
  sGbIniFilePath := changefileext(sGbIniFilePath,'.ini');
  bbGetIni(sGbIniFilePath);
end;

procedure TForm1.btCancelClick(Sender: TObject);
begin
   btSearchNext.enabled := false;
   btSearch.enabled := True;
   btPass.enabled := false;
   btFail.enabled := false; 
   btStart.enabled := false;
   cbMetaData.Checked := false;
   cbTopTail.checked := false;
   ZConnection1.disconnect;
   

end;


procedure TForm1.cb1PCQCClick(Sender: TObject);
begin
  btSearch.Click;;
  If cb1PCQC.checked then cb1PCQC.color := clRed else cb1PCQC.Color := clgray;
  If cb1PcExport.checked then  cb1PcExport.Color := clgray;
  cb1PcExport.OnClick := nil;
  If cb1PcExport.checked then cb1PcExport.checked := false;
  cb1PcExport.OnClick := cb1PcExportClick;
end;

procedure TForm1.cb1PcExportClick(Sender: TObject);
begin  
  btSearch.Click;;
  If cb1PcExport.checked then cb1PcExport.color := clRed else cb1PcExport.Color := clgray;
  If cb1PCQC.checked then  cb1PCQC.Color := clgray;
  cb1PCQC.OnClick := nil;
  If cb1PCQC.checked then cb1PCQC.checked := false; 
  cb1PCQC.OnClick := cb1PCQCClick;


end;

procedure TForm1.btCopySpoolNoClick(Sender: TObject);
begin
  Clipbrd.Clipboard.AsText := leSpool.Text;
end;

procedure TForm1.CLose1Click(Sender: TObject);
begin
  bbSaveIni(sGbIniFilePath);
  Form1.Close;
end;

procedure TForm1.Show1Click(Sender: TObject);
begin
   Show1.Checked := NOT Show1.Checked  ;
   If Show1.Checked then
   begin
    form1.Height := 775
   end
    else form1.Height := 605;

   meSQL.Visible := Show1.Checked;
   gbDatabase.Visible := Show1.Checked;
end;

Function TForm1.bbBarcodeClean( sBarcode : string):string;
var  ipos , ilen: integer;
  sNums : TSetNums;
  cChar :Char;
begin                              // trims out spaces and leading 0
  sNums := ['0'..'9'];

  iPos  := pos('_',sBarcode);    // Remove _ from I&A padded barcodes
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);
  iPos  := pos('_',sBarcode);    // Remove _ from I&A padded barcodes
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);

  Trim(sBarcode);                // remove outer spaces

  iPos  := pos(' ',sBarcode);    // remove the inner space from padded code
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);
  iPos  := pos(' ',sBarcode);    // remove the inner space from padded code
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);
  iPos  := pos(' ',sBarcode);    // remove the inner space from padded code
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);

   ilen := length(sBarcode);
   ipos := 1;
   While (( iPos < ilen )  )  do   // remove leading zeros from padded codes
   begin
    cChar := sBarcode[ipos];
    if not (cchar in sNums )  // sNums set of '0'..'9'
       then inc(ipos)         // walk code to find numbers
       else
       begin
         If cchar <> '0' then     // remove 0's until number not 0
           begin
             result := sBarcode;
             exit
           end
           else
           begin
             delete(sBarcode, ipos, 1);
             dec(ilen)
           end;
       end;

   end;
  Result := sBarcode;
end;

Function TForm1.bbBarcodeCleanSfx( sBarcode : string):string;
var  ipos , ilen: integer; sCore, sSuffix : string;
  sNums : TSetNums;
  cChar :Char;
begin                              // trims out spaces and leading 0
  sNums := ['0'..'9'];

  bbNameSuffixStrip(sBarcode,'_',sCore, sSuffix);
  sBarcode := sCore;

  iPos  := pos('_',sBarcode);    // Remove _ from I&A padded barcodes
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);
  iPos  := pos('_',sBarcode);    // Remove _ from I&A padded barcodes
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);

  Trim(sBarcode);                // remove outer spaces

  iPos  := pos(' ',sBarcode);    // remove the inner space from padded code
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);
  iPos  := pos(' ',sBarcode);    // remove the inner space from padded code
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);
  iPos  := pos(' ',sBarcode);    // remove the inner space from padded code
  If (( iPos <> 0 ) ) then delete(sBarcode,iPos, 1);

   ilen := length(sBarcode);
   ipos := 1;
   While (( iPos < ilen )  )  do   // remove leading zeros from padded codes
   begin
    cChar := sBarcode[ipos];
    if not (cchar in sNums )  // sNums set of '0'..'9'
       then inc(ipos)         // walk code to find numbers
       else
       begin
         If cchar <> '0' then     // remove 0's until number not 0
           begin
             result := sBarcode + SSuffix;
             exit
           end
           else
           begin
             delete(sBarcode, ipos, 1);
             dec(ilen)
           end;
       end;

   end;
  Result := sBarcode + SSuffix;
end;


procedure TForm1.btStartClick(Sender: TObject);
begin
   bbStartQC;
end;

Procedure TForm1.bbStartQC;
var sTimeStamp, sReadTimeStamp, sSpool , sDTExpiry, sCount: string;
  dtStamp, dtExpiry, dtReadStamp : TDateTime;
  iRecs, iResult, iLocation : Integer;
  bQCEnable, bQCPassEnable : Boolean;

 sName, sLocation, sDestination,  sSQL, sContent, sMeta, sQCLocation : string;
    iQCLocation: integer;
begin
  If leSpool.Text = '' then
  begin
    Showmessage('No Spool Selected');
    beep;
    Exit;
  End;

  iLocation := STrToInt(leLOcation.text);

  bQCEnable := False;
  bQCPassEnable := False;

  sSpool := leSpool.Text;

  //Show messages
  Case iLocation of
  0..5000    : ShowMessage('PreBaton Check - Cannot QC');
  5200..5299 : ShowMessage('Baton Compliance Fail - Cannot QC');
  5999,7000 : ShowMessage('Awaiting 1% AS11 Checks - Cannot QC');
  7200 :      ShowMessage('Baton Reject File - Cannot QC');
  6100..6300 : If messageDlg('Already QC''d - but can be changed', mtConfirmation, [mbYes, mbNo], 0 ) = mrNo then EXIT;
  8100..8300 : If messageDlg('Already QC''d - but can be changed', mtConfirmation, [mbYes, mbNo], 0 ) = mrNo then EXIT;

  else
  iLocation := iLocation ;
  end;

  //Now Act
  Case iLocation of
  0..5000    : Exit;
  5100..5199 : bQCEnable := true;
  5200..5299 : Exit;
  5999,7000  : Exit;
  7200      :  Exit;
  6100..6300 : bQCEnable := true;
  8100..8300 : bQCEnable := true;
  else
  end;

  //Everything now can be QC set

  
    sSQL := 'SELECT * FROM t_tape_status WHERE f_spool = ''' + sSpool + '''';

    ZQuery1.Active := false;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.Add(sSQL);
    ZQuery1.Active := true;

    iRecs := Datasource1.DataSet.RecordCount;

    If iRecs <> 1 then
    begin
      Showmessage('Error - Spool selection issue - irecs = ' + inttostr(irecs));
      Exit;
    end;

    IF Datasource1.DataSet.FieldByName('f_spool').AsString <> leSpool.Text
    then
    begin
      Showmessage('Error - Spool selection to DBase missmatch' );
      Exit;
    end;






  // Set QC


  btSearch.Enabled := false;
  btSearchNext.Enabled := false;

   bbGetDBNow(dtGbTimeStamp);
  sTimeStamp := FormatDateTime( 'yyyy-mm-dd hh:nn:ss.zzzz', dtGbTimeStamp);
  sTimeStamp := sTimeStamp;
  // Is there a time stamp

  bbGetDBFieldStr( 't_tape_status','f_qc_lock',' f_spool = ''' + sSpool + '''',sReadTimeStamp, irecs );
  bbGetDBFieldDT( 't_tape_status','f_qc_lock',' f_spool = ''' + sSpool + '''',dtReadStamp, irecs );


  {
  IF ( dtReadStamp > 1000) then //                      AND
  begin
       If  ( dtGbTimeStamp >  (dtReadStamp + 0.15 )) then   // if older than 3 hours
       begin
          iResult := Messagedlg('Time Expired QC Found - Yes to Renew, No to Leave as is and Abort',mtWarning,[mbYes,MbNo],0);
          If  iResult = mrNo then Exit;
          // Clear stamp  to 1.0
          bbWriteDBFieldDT( 't_tape_status','f_qc_lock',1.0,' f_spool = ''' + sSpool + '''');
       end;//time +0.15

       If  ( ( dtReadStamp > 1000)  AND   ( dtGbTimeStamp >  dtReadStamp ) )  then   // in use
       begin
          iResult := Messagedlg('Time Expired QC Found - Yes to Renew, No to Leave as is and Abort',mtWarning,[mbYes,MbNo],0);
          If  iResult = mrNo then Exit;
          // Clear stamp  to 1.0
       end;
  end;


  // Try New TimeStamp

  bbWriteDBFieldStr ('t_tape_status','f_qc_lock',sTimeStamp ,' f_spool = ''' + sSpool + '''');

 // bbWriteDBField ('t_tape_status','f_qc_lock',sTimeStamp  bbGetDBFieldStr( 't_tape_status','f_qc_lock',' f_spool = ''' + sSpool + '''',sReadTimeStamp, irecs );
   
   bbGetDBFieldDT( 't_tape_status','f_qc_lock',' f_spool = ''' + sSpool + '''',dtReadStamp, irecs );

  If ( (dtReadStamp - dtGbTimeStamp) > 0.05 ) then
  begin
    ShowMessage('Could Not Aquire Spool - Other Station May Have It - Try another spool');
    Exit;
  end;   }


  // Good to go

   // Test for and set  qc id qnd qc source fields
   // get location stuff

    sLocation := Datasource1.DataSet.FieldByName('f_location').AsString ;
    iLocation := Datasource1.DataSet.FieldByName('f_location').AsInteger ;

    sQCLocation := Datasource1.DataSet.FieldByName('f_qc_src').AsString ;
    iQCLocation := Datasource1.DataSet.FieldByName('f_qc_src').AsInteger ;

    // check qc-Src



    If NOT ( ( iQCLocation >= 5101 ) AND (iQCLocation <= 5106 ))
    then
    begin

      If messageDlg('QC source was not set by QC status app - manual add? - note no count added',
          mtConfirmation, [mbYes, mbNo], 0 ) = mrNo then EXIT;

          sSQL := 'UPDATE t_tape_status SET f_qc_src = ''' + sLocation + ''''
               + 'WHERE f_spool = ''' + sSpool + '''';

      ZQuery1.Active := false;
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.Add(sSQL);
      ZQuery1.ExecSQL;

    end;
   // set to 5199 if not
    If ( ( iLocation >= 5101 ) AND (iLocation <= 5106 ))
    then
    begin
        bbReassignSpool(sSpool, '5199' );
            begin

      sSQL := 'SELECT * FROM t_tape_status WHERE f_spool = ''' + sSpool +'''';

      end;

      ZQuery1.Active := false;
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.Add(sSQL);
      ZQuery1.Active := true;

      bbGetRecord(Datasource1.DataSet,0);
    end;


    btSearch.Enabled := false;
    btSearchNext.Enabled := false;
    btStart.Enabled := False;
    btPass.Enabled := false;
    btFail.Enabled := true;
    cbMetaData.Enabled := true;
    cbTopTail.Enabled := true;

end;

Function TForm1.bbWriteDBFieldFn (sTable, sField, sValue, sCondition : String):boolean;
var sSQL : String;
begin
  sValue := bbSQLEscape(sValue);   //  escape 'nasty characters' such as backslash
  sSQL := 'UPDATE ' + sTable + ' SET ' + sField + ' = ''' + sValue +''' '
     + ' WHERE ' + sCondition ;    //  f_news_day_no = "' + dbNewsDay.text + '"';
  If Trim( sCondition ) = '' then
  begin
    Showmessage('WriteDBField Error - No WHERE condition: ' + sSQL);
    Exit;
  end;
  Result := true;
  Try
  ZQueryDBQuery.SQL.Clear;
  ZQueryDBQuery.SQL.Add(sSQL);
  ZQueryDBQuery.ExecSQL;
  Except
  Showmessage('WriteDBField Error - Failed ' + sSQL);
  Result := false;
  End;
end;

Procedure TForm1.bbSaveIni(sIniFilePath : String);
var  iStrings, icount : integer;  ifIni : TInifile;
begin
  Try
   // leIngestedAudio.text := Trim(excludeTrailingBackslash(leIngestedAudio.text));
    ifIni := TIniFile.Create(sIniFilePath);

    ifIni.WriteBool('DBase', 'rbDevDB', rbDevDB.checked);
    ifIni.WriteBool('DBase', 'rbLiveDB', rbLiveDB.checked);
    ifIni.WriteBool('DBase', 'rbPlayDB', rbPlayDB.checked);
    ifIni.WriteBool('DBase', 'rbTestDB', rbTestDB.checked);
  finally
    ifIni.Free;
  end;
end;

Procedure TForm1.bbGetIni(sIniFilePath : String);
var  iStrings, icount : integer;  ifIni : TInifile;
begin
  Try
    ifIni := TIniFile.Create(sIniFilePath);

   rbDevDB.checked := ifIni.ReadBool('DBase', 'rbDevDB',false );
   rbLiveDB.checked := ifIni.ReadBool('DBase', 'rbLiveDB',false) ;
   rbPlayDB.checked := ifIni.ReadBool('DBase', 'rbPlayDB',false );
   rbTestDB.checked := ifIni.ReadBool('DBase', 'rbTestDB',false );

  finally
    ifIni.Free;
  end;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bbSaveIni(sGbIniFilePath);
end;

procedure TForm1.rbSearchSpoolClick(Sender: TObject);
begin
   ebSearchSpool.SetFocus;
end;

procedure TForm1.ebSearchSpoolKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If Key = VK_RETURN then
   begin
      bbSearchSpool;
      ebSearchSpool.SelectAll;
   end;
end;

end.


