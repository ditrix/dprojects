unit MAIN;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, DBTables, Grids, DBGrids, DB;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    Query1: TQuery;
    Table1: TTable;
    Table2: TTable;
    dtStart: TDateTimePicker;
    progress: TProgressBar;
    dtEnd: TDateTimePicker;
    btnCreateIt: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCreateItClick(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
  public
    { Public declarations }
    function CheckPhone(par: String): String;

    function ExecScript(script: String): Boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses Scripts,  DateUtils, fixDBF;

const
  databasename = 'D:\WRK\ASKOCRM';


procedure PrepareDBF();
begin
  // opendbfu  для go_state.DBF  state.DBF  clients.DBF  PRODUCTS.DBF  CITIES.DBF
  if FileExists('go_state.DBF') then FixHeader('go_state.DBF');

  if FileExists('state.DBF') then FixHeader('state.DBF');
  if FileExists('clients.DBF') then FixHeader('clients.DBF');
  if FileExists('CITIES.DBF') then FixHeader('CITIES.DBF');
  if FileExists('PRODUCTS.DBF') then FixHeader('PRODUCTS.DBF');

end;

function TMainForm.ExecScript(script: String): Boolean;
var res: Boolean;  dtSet: TQuery;
begin
  res:= true;
  try
    dtSet:= TQuery.Create(nil);
    try
      dtSet.SQL.Text:= script;
      dtSet.ExecSQL;
    except
      ShowMessage(dtSet.SQL.Text);
      res:= false;
    end;

  finally
    dtSet.Free;
  end;
  Result:= res;
end;


procedure TMainForm.Button1Click(Sender: TObject);
var i: Integer;
begin

   ShowMessage(GetCurrentDir);






end;

function TMainForm.CheckPhone(par: String): String;
var phone, res: String;
    i: Byte;
begin
  res:= '';
  if par = '' then res:= '+38';
  par:= Trim(par);
  for i := 1 to Length(par) do
    if par[i] in ['0','1','2','3','4','5','6','7','8','9'] then
      phone:= phone + par[i];


  if res = '' then
    if Length(phone) <> 10
      then res:= '+38'
      else res:= '+38' + phone;
  Result:= res;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
var ds1, ds2: String;
    No: TDate;
    fname_fiz, fname_firm: String;
    count, parts: Integer;
    dt1, dt2 : TDate;
begin
end;

procedure TMainForm.CreateMDIChild(const Name: string);
begin
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
//
 dtStart.Date:= Now();
 dtEnd.Date:= IncYear(EndOfTheMonth(dtStart.Date));
 //PrepareDBF();
end;




procedure TMainForm.btnCreateItClick(Sender: TObject);
var ds1, ds2: String;
    res: Boolean;
	cnt_rec: integer;
	impFizName: String;
begin
  ds1:= DateToStr(StartOfTheMonth(dtStart.Date));
  ds2:= DateToStr(EndOfTheMonth(dtEnd.Date));
  PrepareDBF();

   if FileExists('importFIZ.dbf') then ExecScript(DROP_IMPORT_FIZ);
   res:= true;
   res:= ExecScript(CREATE_IMPORT_FIZ);
   // pers 
   if res then res:= ExecScript(Format(MAKE_IMPORT_FIZ_OSGPO,[ds1,ds2]));
   if res then res:= ExecScript(Format(MAKE_IMPORT_FIZ_RISK,[ds1,ds2]));
   if res then begin // обработка телефонов 

	if  Table1.Active then Table1.Close;
		Table1.TableName:= 'importFIZ.dbf';
		Table1.Open;
		while not Table1.Eof do begin
			Table1.Edit;
			Table1.FieldByName('phone').AsString:= CheckPhone(Table1.FieldByName('phone').AsString);
			Table1.Post;
			Table1.Next;
		end;
		if Table1.Active then Table1.Close;

   end;
  // разделение общ реестра на куски по 500 записей
  
    if Table1.Active then Table1.Close;
	if Table2.Active then Table2.Close;
    cnt_rec := 0;

	impFizName:= Format('impFIZ%d.dbf',[cnt_rec]);

    Table1.Open;
	if Table1.RecordCount <> 0 then begin
			if FileExists(impFizName) then ExecScript(Format('drop table "%s"',[impFizName]));
			ExecScript(Format(CREATE_IMPORT_FIZ_CNT,[impFizName]));


	   if Table2.Active then Table2.Close;
	   Table2.TableName:= impFizName;
	   Table2.Open;
	end;

	progress.Min:= 0; progress.Max:= Table1.RecordCount;
	while not Table1.Eof do begin

	   if (Table1.RecNo mod 500) = 0 then
	     begin
			cnt_rec := cnt_rec + 1;
			impFizName:= Format('impFIZ%d.dbf',[cnt_rec]);

		    if Table2.Active then Table2.Close;

			if FileExists(impFizName) then ExecScript(Format('drop table "%s"',[impFizName]));
			ExecScript(Format(CREATE_IMPORT_FIZ_CNT,[impFizName]));

			Table2.TableName:= impFizName;
			Table2.Open;
		 end;
        if Table2.Active then begin
		Table2.Insert();
		Table2.FieldByName('contact').AsString := Table1.FieldByName('contact').AsString; 
		Table2.FieldByName('birthday').AsString := Table1.FieldByName('birthday').AsString;
		Table2.FieldByName('phone').AsString := Table1.FieldByName('phone').AsString;   
		Table2.FieldByName('dsouce').AsString := Table1.FieldByName('dsouce').AsString;  
		Table2.Post;
		end;
	   Table1.Next();
	   progress.Position:= progress.Position + 1;

	end;

	if Table2.Active then Table2.Close;
	if Table1.Active then Table1.Close;
    progress.Position:= 0;
  while cnt_rec <= 100 do begin
    if FileExists(Format('impFIZ%d.dbf',[cnt_rec])) then DeleteFile(Format('impFIZ%d.dbf',[cnt_rec]));
    cnt_rec:= cnt_rec + 1;
  end;

    
   // make firm
   
   
     // OSGPO firm
   if FileExists('importFIRM.dbf') then ExecScript(DROP_IMPORT_FIRM);
   res:= ExecScript(CREATE_IMPORT_FIRM);
   if res then res:= ExecScript(Format(MAKE_IMPORT_FIRM_OSGPO,[ds1,ds2]));
   if res then res:= ExecScript(Format(MAKE_IMPORT_FIRM_RISK,[ds1,ds2]));

   if res then begin // обработка телефонов 
	try
	if  Table1.Active then Table1.Close;
		Table1.TableName:= 'importFIRM.dbf';
		Table1.Open;
		while not Table1.Eof do begin
			Table1.Edit;
			Table1.FieldByName('phone').AsString:= CheckPhone(Table1.FieldByName('phone').AsString);
			Table1.Post;
			Table1.Next;
		end;
		if Table1.Active then Table1.Close;
	except
		res:= false;
	  ShowMessage(Format('%s: ошибка обработки номеров',[Table1.TableName]));
	end;
	end;   
   
  // OSGPO firm
  // RISK firm
 
  // profit
  if res then ShowMessage('Ok') else ShowMessage('Some Error');
end;







end.

{ TODO : разделение результатов по 500 записей. }
{


}
