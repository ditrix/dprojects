unit fixDBF;

interface

uses dbtables, DB, Controls;

{ ������������ ��������� Clipper �����, ��� BDE }
{ARGUMENTS: aFName ������ ��� �����}
{RETURN: 1 � ������ ������ � 0 ��� ������� }
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
