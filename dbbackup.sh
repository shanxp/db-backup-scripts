#!/bin/sh

# @Shan - 25/07/2016
# Take a full backup of Ontrack database on daily basis

#DATE=`date +%Y-%m-%d:%H:%M:%S`
#echo "Path to $(basename $0) is $(readlink -f $0)"
#exit;
#BASE_DIR="/root/dbbackups/"
BASE_DIR=""
#CURRENT_DIR=`date +%Y%m%d%H`
FILE_PREFIX="db"
CURRENT_DIR="/root/dbbackups/files"
CURRENT_FILE="${BASE_DIR}${CURRENT_DIR}/${FILE_PREFIX}_`date +"%Y%m%d%H%M%S"`.sql"
CURRENT_TAR_FILE="${BASE_DIR}${CURRENT_DIR}/${FILE_PREFIX}_`date +"%Y%m%d%H%M%S"`.tar.gz"
DBSERVER=127.0.0.1
DATABASE=<DB>
USER=<USER>
PASS=<PASSWORD>

#echo $CURRENT_TAR_FILE
#exit;
NOW=`date '+%d/%m/%Y %H:%M:%S'`;
echo "Backup started ${NOW}"

if [ -d "$CURRENT_DIR" ]
then
    echo "Directory ${CURRENT_DIR} exists"
else
    echo "Creating directory ${CURRENT_DIR} as it does not exist..."
    mkdir -p ${CURRENT_DIR}

    # Check if directory has been created
    if [ -d "${CURRENT_DIR}" ]
    then
    echo "Directory ${CURRENT_DIR} created"
    else
    echo "Directory ${CURRENT_DIR} could not be created"
    fi
fi

# MySQL dump
echo "Taking a fullbackup of ${DATABASE}"
#echo ${CURRENT_FILE}
mysqldump --user=${USER} --password=${PASS} ${DATABASE} --routines > ${CURRENT_FILE}

if [ -f "${CURRENT_FILE}" ]
then 
    echo "${CURRENT_FILE} created"
    echo "Creating tar ball at ${CURRENT_TAR_FILE}"
    tar -zcvf ${CURRENT_TAR_FILE}  ${CURRENT_FILE}
    if [ -f "${CURRENT_TAR_FILE}" ]
    then 
       echo "${CURRENT_TAR_FILE} created"
       rm -f ${CURRENT_FILE} 
       echo "${CURRENT_FILE} deleted"	
       if [ -f "${CURRENT_FILE}" ]	
	  then 
              echo "ERROR: SQL file could not be deleted after creating tar zip file"
          #else 
	  #NOW=`date '+%d/%m/%Y %H:%M:%S'`;	
          #echo "Backup completed at ${NOW}"	              
       fi
    fi		
else
    echo "ERROR: backup at ${CURRENT_FILE} could not be created!"
fi

NOW=`date '+%d/%m/%Y %H:%M:%S'`;
echo "Backup process finished ${NOW}"
echo "++++++++++++++++++++++++++++++++++++"
