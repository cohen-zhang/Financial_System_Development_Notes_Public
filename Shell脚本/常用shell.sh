
# 问题日志打包

# 查询出 ~/log 路径下, 包含 ORS或者CTE或者AGW 且日期为 2022-09-03 结尾的全部 .log 日志文件
# 并将结果打包成 atp_log.tar.gz
find ~/log -type f -name "*ORS*2022-09-03.log" -o -name "*AGW*2022-09-03.log" -name "*CTE*2022-09-03.log"  |xargs -exec tar -cvf atp_log.tar.gz
# find . -type f -name "*ORS*2022-09-03.log" -o -name "*AGW*2022-09-03.log" -name "*CTE*2022-09-03.log"  |xargs -exec tar -cvf atp.tar.gz
 

# 把多台服务器时间调一致，MobaXterm 开启多窗口模式， 然后执行

date -s ‘20221018 09:00:00’

# 生成数据库连接密码密文

java -cp ~/BOS/bosweb/lib/jasypt-1.9.2.jar org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="数据库密码" password=123456 algorithm=PBEWithMD5AndDES

# 开Debug日志
~/ASF/opt/send_usr.sh -i 3  -n DTE

# 关闭Debug日志
~/ASF/opt/send_usr.sh -i 4  -n DTE

# 此命令可以查看当前目录下的文件数量
find ./ -type f | wc -l  


# 使用 find 命令，在当前目录查找 keepalived 关键字的文件
find ./ -type f -name "keepalived"

mysqldump -hlocalhost -P3306 -ubos -p --routines --set-gtid-purged=OFF --databases appconfigdb cm_basedb cm_bosgwdb cm_clearingdb cm_dpdb cm_exportdb cm_importdb cm_tradingconfigdb cm_tradingdb mddb operationdb userdb --ignore-table=operationdb.t_audit_operation_log --ignore-table=operationdb.t_endofday_log --ignore-table=operationdb.t_error_log --ignore-table=operationdb.t_heartbeat_time --ignore-table=operationdb.t_indicator_la > /home/archforce/atp_bos_yyyymmdd.sql


# 使用msyqldump命令备份全量数据库命令，解释： 
# 1. --flush-logs：刷新日志，生成新的二进制日志文件
# 2. --quick：快速导出，不缓存查询结果
# 3. --single-transaction：导出时，不锁表
# 4. --master-data=2：导出时，生成 CHANGE MASTER TO 语句，用于主从复制
# 5. -A：导出所有数据库
# 6. -R：导出存储过程和函数
# 7. --triggers：导出触发器
# 8. --set-gtid-purged=OFF：导出时，不生成 GTID 相关的语句
# 9. --events：导出事件
mysqldump -uroot -p  --flush-logs --quick --single-transaction --master-data=2  -A -R --triggers --set-gtid-purged=OFF --events > /home/archforce/databases/product/atp_bos_$(hostname)_yyyymmdd.sql

# 服务器重启： 重新mount
mount -t cifs -o username=hqreader,password=qwe123\!\@\# //172.24.151.180/hq/szhq/info /home/archforce/import/szhq

# Notepad++ 中查找文件中涉及 IP 的行使用的正则表达式是：([0-9]{1,3}\.){3}[0-9]{1,3}，也可以使用： (?:\d+)(?:\.\d+){3}


# 使用 shell 命令，查找当前文件中，包含 IP 的行并打印出来
#  解释下面的正则表达式和 grep 命令的参数含义如下：
# -E, --extended-regexp 此参数表示使用扩展正则表达式，也就是支持正则表达式的元字符
# 正则表达式的含义为：([0-9]{1,3}\.){3}[0-9]{1,3} ，即匹配 1-3 位数字，后面跟着一个 . ，重复 3 次，最后再匹配 1-3 位数字，这样就匹配了一个 IP 地址
grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}' ./test.txt

# 服务器时间同步 crontab里配一个ntpdate定时任务
# 0 0 * * * /usr/sbin/ntpdate

# 查看当前系统的时区
date -R

# 查看服务器时钟
hwclock


# 解释下面的脚本含义：
# 1. 先同步服务器时间
# 2. 再同步硬件时钟（&&：前提是服务器时间已经同步成功）
# 3. 最后将硬件时钟写入 CMOS
date -s "2019-09-09 09:09:09" && hwclock -w


## 挂载盘符

# username：windows机共享用户
# password：windows机共享用户对应密码
# uid：挂载后文件所属用户
# gid：挂载后文件所属用户组
# 10.1.1.1：windows机共享IP
# d$：windows机共享盘符
# file：windows机共享文件夹
# /home/archforce/import/：挂载目标文件目录

mount -t cifs -o username=admin,password=admin,uid=1000,gid=1000 //10.1.1.1/d$/file /home/archforce/import/

## ps 命令

当我们在 Linux 终端中执行 ps -ef | grep <关键字> 命令时，会先通过 ps 命令列出系统当前正在运行的进程信息，然后通过管道符将输出结果传递给 grep 命令进行过滤，从而找到匹配的进程。这个命令在 Linux 系统中被广泛用于查找特定进程，进行相关操作。

将该命令的输出分成了以下九列：

UID（用户 ID）：进程所属用户的 ID 号

PID（进程 ID）：进程的唯一标识符

PPID（父进程 ID）：进程的父进程 ID 号

C（CPU 占用率）：进程占用 CPU 的百分比

STIME（启动时间）：进程启动的时间

TTY（终端设备）：进程所连接的终端设备

TIME（CPU 时间）：进程已经使用的 CPU 时间

CMD（命令行）：进程对应的命令行

<关键字>：在命令最后添加的关键字，用于过滤出包含该关键字的进程

下面是一个示例输出：

UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 12:15 ?        00:00:05 /usr/lib/systemd/systemd --switched-root --system --deserialize 22
root         2     0  0 12:15 ?        00:00:00 [kthreadd]
root         3     2  0 12:15 ?        00:00:00 [rcu_gp]
root         4     2  0 12:15 ?        00:00:00 [rcu_par_gp]
root         6     2  0 12:15 ?        00:00:00 [kworker/0:0H-kblockd]
root         8     2  0 12:15 ?        00:00:00 [mm_percpu_wq]
root         9     2  0 12:15 ?        00:00:01 [ksoftirqd/0]
root        10     2  0 12:15 ?        00:00:06 [rcu_sched]
root        11     2  0 12:15 ?        00:00:00 [migration/0]
root        12     2  0 12:15 ?        00:00:00 [cpuhp/0]
root        13     2  0 12:15 ?        00:00:00 [kdevtmpfs]

在输出中，我们可以看到每个进程的 UID、PID、PPID、C、STIME、TTY、TIME、CMD 以及匹配的关键字（如果有）。这些信息对于查找和管理进程非常有帮助，特别是在排除一些系统问题时。


## 使用 root 用户迁移了 MySQL 的 data 目录后，MySQL 无法启动，提示没有权限访问 data 目录，这时就需要将 data 目录的 owner 修改为 mysql 用户
## 下面脚本的含义是：将 /data/mysql/data 目录下的所有文件和目录的 owner 修改为 mysql 用户
chown -R mysql:mysql /data/mysql/data