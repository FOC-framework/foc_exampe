del dropAllSequences.sql
echo exit | sqlplus SYSTEM/root @generate_dropAllSequences.sql
del db\restore.log
echo exit | sqlplus FENIX_UNIT/1234 @dropAllSequences.sql
impdp STATELESS_UNIT/1234 directory=ECLIPSE_STATELESS_UNIT dumpfile=unit.dmp logfile=_restore.log TABLE_EXISTS_ACTION=REPLACE 
REM REMAP_SCHEMA=FENIX_STATELESS:STATELESS_UNIT