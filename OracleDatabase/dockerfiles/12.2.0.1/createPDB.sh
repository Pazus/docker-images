#!/bin/bash
# LICENSE CDDL 1.0 + GPL 2.0
#
# Copyright (c) 1982-2016 Oracle and/or its affiliates. All rights reserved.
# 
# Since: November, 2016
# Author: gerald.venzl@oracle.com
# Description: Creates an Oracle Database based on following parameters:
#              $ORACLE_SID: The Oracle SID and CDB name
#              $ORACLE_PDB: The PDB name
# 
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 

sqlplus / as sysdba <<EOF
CREATE PLUGGABLE DATABASE $ORACLE_PDB ADMIN USER PDBADMIN IDENTIFIED BY "$ORACLE_PWD"
  FILE_NAME_CONVERT=('$ORACLE_BASE/oradata/ORCLCDB/pdbseed/','$PDB_BASE_DIR/$ORACLE_PDB/');
ALTER PLUGGABLE DATABASE $ORACLE_PDB SAVE STATE;  
ALTER PLUGGABLE DATABASE $ORACLE_PDB OPEN READ WRITE;
ALTER SESSION SET CONTAINER = $ORACLE_PDB;
CREATE TABLESPACE users DATAFILE '$PDB_BASE_DIR/$ORACLE_PDB/users01.dbf' SIZE 50M AUTOEXTEND ON NEXT 1M;
exit;
EOF
