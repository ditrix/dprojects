unit fixDBF;

interface

uses dbtables, DB, Controls;

{ корректирует заголовок Clipper файла, для BDE }
{ARGUMENTS: aFName полное имя файла}
{RETURN: 1 в случае успеха и 0 при неудачи }
function FixHeader(aFName: string): byte;

implementation


function FixHeader(aFName: string): byte;
var ccode, cnt, smb: byte;
    f: file of byte;
begin
   ccode:= 1;
   smb:= 0;
   Assign(f, aFName);
   {$I-}
   Reset(f);
   for cnt:= 15 to 31 do begin
     seek(f,cnt); write(f,smb);
     end;
   Close(f);
   if IOResult <> 0 then ccode:= 0;
   {$I+}
   FixHeader:= ccode;
end;


end.
