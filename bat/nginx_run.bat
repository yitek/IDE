@echo off
@chcp 65001 
setlocal


SET root_dir=%~dp0/..
SET nginx_dir=%root_dir%/bin/nginx/nginx-1.21.1/
SET nginx_conf=%root_dir%/conf/nginx-1.21.1/nginx.conf
echo 跳转到执行文件所在位置:%nginx_dir%
cd /d %nginx_dir%
echo 配置文件所在位置:%nginx_conf%

set hasit=no
for /F "tokens=1*" %%a in ('tasklist /nh /fi "imagename eq nginx.exe"') do if %%a == nginx.exe set hasit=yes
if %hasit% == yes goto end
echo 开始nginx
call nginx -c %nginx_conf%

:end
echo 终止已存在的nginx进程
taskkill /f /t /im "nginx.exe"
echo 开始nginx
call nginx -c %nginx_conf%
endlocal

pause