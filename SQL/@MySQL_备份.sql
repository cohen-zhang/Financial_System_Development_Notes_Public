
-- 开启日志模式 (会导致 general_log.CSV 非常大)
-- 修改时需要用 root 用户，还需要重启 mysql 服务
-- set GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'ON';
-- set GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'OFF';


-- 数据库备份
-- 指定库
mysql -e "show databases;" -h127.0.0.1 -uUser -pPassword -P3306 | grep -Ev "Database|information_schema|mysql|sys|performance_schema" | xargs mysqldump -h127.0.0.1 -uUser -pPassword -t -P3306 --databases ob_basedb ob_tradingconfigdb ob_riskdb > /home/archforce/mysql/all_20210109.sql
mysql -e "show databases;" -h127.0.0.1 -uUser -pPassword -P3306 | grep -Ev "Database|information_schema|mysql|sys|performance_schema" | xargs mysqldump -h127.0.0.1 -uUser -pPassword -t -P3306 --all-databases > /home/archforce/mysql/all_20210109.sql

-- 使用 mysqldump 分别备份 appconfigdb cm_basedb cm_bosgwdb cm_clearingdb cm_dpdb cm_exportdb cm_importdb cm_tradingconfigdb cm_tradingdb mddb operationdb userdb （共12个库）为不同的文件


-- 选择具体的database，执行sql文件
mysql -h127.0.0.1 -uUser -pPassword -P3306 basedb < /home/archforce/mysql/all_20210109.sql
mysql -h127.0.0.1 -uUser -pPassword -P3306 < /home/archforce/mysql/all_20210109.sql

-- 利用mysqldump导出 t_order_status 表 backup_date 大于 2022-09-01 的数据
mysqldump -h127.0.0.1 -uroot -p123456 --where="backup_date > '2022-09-01'" cm_tradingdb t_order > t_order_history.sql
