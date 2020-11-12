set hh=%time:~0,2%
if "%time:~0,1%"==" " set hh=0%hh:~1,1%
set yymmdd_hhmmss=%date:~6,4%%date:~3,2%%date:~0,2%_%hh%%time:~3,2%%time:~6,2%

move unit.dmp .\db\unit_%yymmdd_hhmmss%.dmp

expdp STATELESS_UNIT/1234 schemas=STATELESS_UNIT directory=ECLIPSE_STATELESS_UNIT dumpfile=unit.dmp logfile=_backup.log