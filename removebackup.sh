#!/bin/sh

# @Shan - 25/07/2016
# Remove old backup files

# Config
FILES_DIR="/root/dbbackups/files"
CUTOFF_DAY=1
USE_S3=1
S3_BUCKET_NAME="<S3 bucket name>"

for file in $(find ${FILES_DIR} -iname "*.tar.gz" -mtime +${CUTOFF_DAY} -exec basename {} \;)
do

if [ $USE_S3 -eq 1 ]
  then
    echo "Deleting files on S3 s3://${S3_BUCKET_NAME}/${file}"
    aws s3 rm s3://${S3_BUCKET_NAME}/${file}
else
    echo "No S3 bucket is being used"
fi

echo "Deleting file on local disk ${FILES_DIR}/${file}"
rm -f ${FILES_DIR}/${file}

done
