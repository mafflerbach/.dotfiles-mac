#!/bin/bash

sql=$1
pass=$(pass show Sixt/sxbi | head -n1)
user=$(pass show Sixt/sxbi | tail -n1)
FILE="/tmp/queryResult.csv"

sqlplus -s /nolog << !EOF!
connect $user/$pass@sxbi-d01.sixt.de:1521/sxbidev_rw.sixt.de

SET PAGESIZE 50000
SET LINESIZE 250
SET NUMWIDTH 5
SET FEEDBACK OFF
set echo off
set heading on
set wrap off
SET COLSEP "|"
column Title format a22
column Summary format a15

SPOOL $FILE

$sql

SPOOL OFF
EXIT
!EOF!
