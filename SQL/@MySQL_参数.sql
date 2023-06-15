--------------------------------
-- dml 操作行级锁的等待时间 
show VARIABLES like '%innodb_lock_wait_timeout%';
-- 隔离级别
show VARIABLES like 'transaction_isolation';
-- 最大可链接数
show VARIABLES like '%connections%';
SELECT user,max_user_connections from mysql.user where user = 'User';


show ENGINES;

-- 开启日志模式 (会导致 general_log.CSV 非常大)
-- 修改时需要用 root 用户，还需要重启 mysql 服务
-- set GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'ON';
-- set GLOBAL log_output = 'TABLE';  SET GLOBAL general_log = 'OFF';

select * from mysql.general_log order by event_time desc;

select * from performance_schema.metadata_locks;
select * from  information_schema.TABLES;

-- 时间比较

select * FROM ob_tradingconfigdb.t_calendar 
WHERE physical_date >= STR_TO_DATE('2021-01-01','%Y-%m-%d') AND physical_date <= STR_TO_DATE('2021-12-31','%Y-%m-%d');

select * from ob_tradingconfigdb.t_ors_business_rule where UNIX_TIMESTAMP(add_time )> UNIX_TIMESTAMP('2020-11-11 18:00:00'); 


-- 设置mysql最大可执行的sql文件大小
show global VARIABLES like 'max_allowed_packet';
set global max_allowed_packet = (1024*1024*1024)


-- 自增主键 初始值设置
-- alter table ob_tradingconfigdb.t_ors_special_order_routing AUTO_INCREMENT = 12;
-- truncate table ob_tradingconfigdb.t_ors_special_order_routing;


-- MySQL 执行 select now() 显示比当前时区的时间早了8小时，怎么排查这个问题？

SELECT @@global.time_zone, @@session.time_zone;

SET time_zone = 'Asia/Shanghai';  -- 将时区设置为上海，可根据实际情况选择合适的时区
