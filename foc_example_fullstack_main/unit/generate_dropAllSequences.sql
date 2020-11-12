/*set colsep ,*/
set headsep off
set pagesize 0
set trimspool on
set numwidth 5

spool dropAllSequences.sql

select 'drop sequence "'||sequence_name||'";' from dba_sequences where sequence_owner='STATELESS_UNIT';

spool off

