IMPORT $;
Schools := $.File_AllSchools.File;
OUTPUT(Schools,NAMED('AllSchools'));
OUTPUT(COUNT(Schools),NAMED('Cnt_AllSchools'));

SORT(Schools,name);



