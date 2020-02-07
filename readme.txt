Backup location /root/dbbackups/files
Set DB system variable log_bin_trust_function_creators to true/ON
Steps :
1) Use dbbackup.sh to take backup
2) Upload to S3 e.g : aws s3 sync /root/dbbackups/files/  s3://testing-pdfs/  --acl public-read --exclude "*.sql"
3) Use removebackup.sh script to remove old backups

