unit Scripts;

interface
const

FNAME_TMP_IMPORT_FIZ = 'a%dimportfiz.dbf';
SQL_DROP_IMPORT_FIZ = 'drop table "a%dimportfiz.dbf"';

SQL_CREATE_IMPORT_FIZ =
'create table "a%dimportfiz.dbf"('
+'	name char(64),'
+'	budget numeric(10,2),'
+'	tags numeric(10,0),'
+'	dt_close date,'
+'	contact char(200),'
+'	birthday date,'
+'	phone char(13),'
+'	dsouce char(64))';

SQL_MAKE_IMPORT_FIZ_OSGPO =
'insert into a%dimportfiz'
+' select distinct'
+'	"ОСГПО" as name,'
+'	pl as budget,'
+'	pol_no as tags,'
+'	dt_end  dt_close,'
+'	lname || " " || fname || " " || sname as contact,'
+'	datar birthday,'
+'  phone phone,'
+' "импортировано из БД" as data_souce'
+' from go_state st '
+' join cities on st.id_city = cities.code'
+' where dt_create  between "%s"  and "%s"'
+' and its_pers = true'
+' and lname is not null';

SQL_MAKE_IMPORT_FIZ_RISK =
'insert into a%dimportfiz'
+' select  distinct'
+'	products.name as name,'
+'	sp as budget,'
+'	pol as tags,'
+'	dt_end  dt_close,'
+'	lname || " " || fname || " " || sname as contact,'
+'	dt_born as birthday,'
+'	phone,'
+'  "импортировано из БД" as data_souce'
+' from state st'
+' right join clients on st.id_client = clients.id'
+' left join products on st.id_product = products.id'
+' where dt_begin  between "%s"  and "%s"'
+' and clients.its_pers = true';


FNAME_TMP_IMPORT_FIRM = 'a%dimpfirm.dbf';
SQL_DROP_IMPORT_FIRM = ' drop table "a%dimpfirm.dbf"';

SQL_CREATE_IMPORT_FIRM = ' create table "a%dimpfirm.dbf"('
+' 	name char(64),'
+' 	budget numeric(10,2),'
+' 	tags numeric(10,0),'
+' 	dt_close date,'
+' 	contact char(200),'
+' 	phone char(13),'
+' 	addr char(200),'
+' 	data_souce char(64))';

SQL_MAKE_IMPORT_FIRM_OSGPO = ' insert into "a%dimpfirm.dbf"'
+' select distinct'
+' 	"ОСГПО" as name,'
+' 	pl as budget,  '
+' 	pol_no as tags, '
+' 	dt_end  dt_close,'
+' 	lname || " " || fname || " " || sname as contact,'
+' 	phone phone, '
+'  cities.name || " .  " || addr as addr,'
+' "импортировано из БД" as data_souce'
+' from go_state st '
+' join cities on st.id_city = cities.code'
+' where dt_create  between "%s"  and "%s"'
+' and its_pers =  false'
+' and lname is not null';

SQL_MAKE_IMPORT_FIRM_RISK =
' insert into "a%dimpfirm.dbf"'
+' select  distinct'
+' 	products.name as name,'
+' 	sp as budget,'
+' 	pol as tags,'
+' 	dt_end  dt_close,'
+'  lname || " " || fname || " " || sname as contact,'
+' 	phone,'
+'   cities.name || " .  " || addr as addr,'
+'  "импортировано из БД" as data_souce '
+' from state st'
+' right join clients on st.id_client = clients.id'
+' left join products on st.id_product = products.id'
+' join cities on clients.id_city = cities.code'
+' where dt_begin  between "%s"  and "%s"'
+' and clients.its_pers = false';

/////////////////////////////////////////////////////////////////////////////////////////////////
DROP_IMPORT_FIZ   = 'drop table "importFIZ.dbf"';
CREATE_IMPORT_FIZ = 
'create table "importFIZ.dbf"('
+'	contact char(200),'
+'	birthday date,'
+'	phone char(13),'
+'	dsouce char(64))';

MAKE_IMPORT_FIZ_OSGPO = 

'INSERT INTO IMPORTFIZ'+
' SELECT DISTINCT LNAME ||" "|| FNAME ||" "|| SNAME AS CONTACT, datar birthday,phone phone,"импортировано из БД" as data_souce'+
' FROM GO_STATE '+
' WHERE DT_END BETWEEN "%s" AND "%s"';


MAKE_IMPORT_FIZ_RISK =

'insert into importFIZ'+
' SELECT LNAME ||" "|| FNAME ||" "|| SNAME AS CONTACT, DT_BORN  birthday, phone phone,"импортировано из БД" as data_souce'+
' from state st'+
' right join clients on st.id_client = clients.id'+
' where dt_end  between "%s"  and "%s"'+
' and clients.its_pers = true';


CREATE_IMPORT_FIZ_CNT = 
'create table "%s"('
+'	contact char(200),'
+'	birthday date,'
+'	phone char(13),'
+'	dsouce char(64))';

DROP_IMPORT_FIRM   = 'drop table "importFIRM.dbf"';

CREATE_IMPORT_FIRM = ' create table "importFIRM.dbf"('
+' 	contact char(200),'
+' 	phone char(13),'
+' 	addr char(200),'
+' 	data_souce char(64))';

MAKE_IMPORT_FIRM_OSGPO = ' insert into "importFIRM.dbf"'
+' select distinct'
+' 	lname || " " || fname || " " || sname as contact,'
+' 	phone phone, '
+'  cities.name || " .  " || addr as addr,'
+' "импортировано из БД" as data_souce'
+' from go_state st '
+' join gcities cities on st.id_city = cities.code'
+' where dt_end  between "%s"  and "%s"'
+' and its_pers =  false'
+' and lname is not null';


MAKE_IMPORT_FIRM_RISK =
' insert into "importFIRM.dbf"'
+' select  distinct'
+'  lname || " " || fname || " " || sname as contact,'
+' 	phone,'
+'   cities.name || " .  " || addr as addr,'
+'  "импортировано из БД" as data_souce '
+' from state st'
+' right join clients on st.id_client = clients.id'
+' join rcities cities on clients.id_city = cities.code'
+' where dt_end  between "%s"  and "%s"'
+' and clients.its_pers = false';



implementation

end.
