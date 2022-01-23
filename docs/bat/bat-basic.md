cmd常用命令与语法
===========================

CMD命令行是windows下的批处理处理程序。一般以.bat为后缀
可以通过cmd批处理来自动化一些程序的运行。
cmd中一行就是一个命令，称为行命令或命令行
命令不区分大小写，比如`echo abc`跟`ECHO abc`效果是一样的
> 本文后文所说的"代码"，如无特殊说明，都是指bat代码

## ECHO 输出 
### 基本用法 
**代码(bat)**
```powershell
ECHO 要显示的文本
```
**效果**
> D:\IDE\docs\bat>test
> D:\bat\echo abc
> 要显示的文本

## 命令行回显 
批处理默认会回显执行的命令，有2种方式关闭显示命令行回显：

1. 单行关闭命令回显
在命令行前添加@符号，关闭命令的回显
**代码(test.bat)**
```powershell
@ECHO hello
```
**效果**
> D:\IDE\docs\cmd>test
> hello

2. 命令行回显开关
可以用@echo off/on来打开/关闭批处理的命令行回显
**代码(bat)**
```powershell
@ECHO OFF
ECHO hello1
ECHO hello2
```
**效果**
> D:\IDE\docs\cmd>test
> hello1
> hello2


## 注释
批处理中有三种方式做注释[^1]
+ REM 注释内容
	为cmd批处理命令中的行注释。批处理程序不处理REM开头的命令行。注意REM后面的空格
	不能出现重定向符号和管道符号
+ ::注释内容
  ::是REM命令的缩写。
	第一个冒号后也可以跟任何一个非字母数字的字符
	***注意:是2个::,单个冒号表示批程序标签，用于GOTO语句***
+ %注释内容%
  可以用作行间注释，不能出现重定向符号和管道符号
+ :标签内容
  单个冒号开头的行表示一个标签，goto语句可以跳转该位置。如果不用于goto，也可以当做注释行来使用

**代码**
```powershell
@ECHO OFF 
REM 关闭命令行回显,REM注释
ECHO hello1 %行内注释%
::简化的注释
ECHO hello2
:标签，也可以当做注释使用
```
**效果**
> D:\IDE\docs\cmd>test
> hello1 
> hello2

## SET命令
在批处理中，所有的变量都是环境变量。有一些变量是预先定义的。可以通过SET命令修改变量[^2]。
1. 输出变量值
形式为：不带等号的set、set后面只接个变量名(其实是变量名前缀)。
输出以SET参数作为变量名前缀的所有环境变量的值
**语法代码(cmd)**
```powershell
::语法
set 变量名(前缀)
::代码
SET PATHE
```
**效果**
> D:\IDE\docs\bat>SET PATHE
> PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.PY;.PYW

2. 给环境变量赋值
形式为一般赋值形式 set后面接变量名=要付的值
***代码***
```powershell
:: 语法
set 变量名=值

:: 示例
@set name=严一
@set str=%name% is my name.
@echo %str%
```
***效果***
>  D:\IDE\docs\bat>test
> 严一 is my name
***作用***
+ 如果变量名不在环境变量中，将变量名加入到环境变量中，并赋值
+ 值里面可以出现变量引用%%，引用的变量的值会做字符串替换
+ 值可以包含空格、一直到命令结束，也可以是Ctrl+G这种代表警报声的字符(echo输出会发出警报声“滴～”），与echo类似


3. 输入并赋值
形式为带/P参数的赋值语句
变量将通过用户输入接收值，提示作为提示信息输出
**语法代码**
```powershell
::语法
set /P 变量=提示
::代码
SET /P MyVar=请输入
@ECHO 您输入的是:%MyVar%
```
**效果**
> D:\IDE\docs\bat>SET /p myvar=请输入:
> 请输入:1223
> 您输入的是:1223

4. 表达式赋值
表达式将被视为算术表达式，变量赋值为算术表达式的值，算术运算符参照帮助文档或者官方网站文档（可以发现，与C语言运算符基本相同）：

如果要使用其他变量的值，需要使用%变量名%（或者 !变量名!)来表示该变量。同时0X与0分别表示十六进制与八进制数字。

**代码**
形式为带/a参数，其后接""(双银行)括起来的表达式
```powershell
::语法
SET /a "表示式"

::代码
SET N1=1
SET /a "N2=%N1%+5"
ECHO %N2%
```
结果为6

5. 字符串替换
形式为赋值语句，但值的部分全部被%%括起来，%%里面有:=来分割不同的部分
该部分参考了[^3]的相关代码
**代码**
```powershell
::语法:
SET newVar = %variable:targetStr=replacementStr%

:: test.bat
@ECHO off
chcp 65001 
SETLOCAL
SET variable=www. baidu.com
REM 将变量variable中的空格替换为空字符串
SET v1=%variable: =%
ECHO v1=%v1%
ECHO variable=%variable%
SET v2=%v1:ai=X%
ECHO v2=%v2%
ENDLOCAL
```
**效果**
> D:\IDE\docs\bat>test
> Active code page: 65001
> v1=www.baidu.com
> variable=www. baidu.com
> v2=www.bXdu.com

6. 字符串截取
与字符串替换类似，但值的部分有:~[]固定语法结构
格式:
    %variable:~[ start [, length] ]%
        start   : 从第几个字符开始, 缺省为0
                    正数(+p), 总左边数p个
                    负数(-p), 从右边数p个
        length  : 截取多少个, 缺省则取到末尾
                    正数(+n), n个
                    负数(-n), 总数-n  个



## 变量与表达式
在SET命令的说明中，SET能够给环境变量赋值。
除了环境变量外，还有其他的变量。
### 命令行参数
%1,%2,...%9
表示批处理命令行所接的参数，最多能有9个
%0表示当前正在执行的批处理
**代码**
```powershell
::test.bat代码
@ECHO off
echo %0
echo %1
```
```
:: 执行test.bat
call "test" "abc"
```
**效果**
> D:\IDE\docs\cmd>test "abc"
> "test"
> "abc"

可以用%~1来去掉引号
**代码**
```powershell
::test.bat代码
@ECHO off
echo %~0
echo %~1
```

**效果**
> D:\IDE\docs\bat>test "abc"
> test
> abc

### 变量引用
被%符号括起来的部分，是作为变量的引用来使用的。除了在SET命令中能够无%%设置变量名，其他地方要使用变量，都应该用%%来引用

```powershell
@echo off
if defined str goto next
set str=
set /p str=请把文件拉到本窗口后回车：
call "%~0" %str%
pause
exit
:next
cls
echo 本批处理文件完整路径为："%~0"
echo 拖到本窗口的文件完整路径为："%~1"
goto :eof
```

## 重定向
ECHO以及许多程序的输入语句，比如js的console.log，c#的Console.Write等，其实是将字符串输出到标准输出流。
标准输出(输入)流是可以通过脚本与程序做改变的，这个改变用术语表述为:重定向
在批处理命令中 >(大于) <(小于)就是用来改变标准输入输出流的
```powershell
:: 将前一个命令的输出重定向到指向1.txt的文件流
:: 即将原本在控制台显示的内容，写到1.txt中去
ECHO hello > 1.txt
```
Command | 功能
-|-
command > filename | 把标准输出重定向到一个文件中
command >> filename | 把标准输出重定向到一个文件中(追加)
command 1 > fielname | 把标准输出重定向到一个文件中
command > filename 2>&1 | 把标准输出和标准错误一起重定向到一个文件
command 2 > filename |	把标准错误重定向到一个文件中
command 2 >> filename	| 把标准错误重定向到一个文件中(追加)
command >> filename 2>&1 |	把标准输出和标准错误一起重定向到一个文件中(追加)
command < filename1 > filename2 |	command命令以filename1文件作为标准输入，以filename2文件作为标准输出
command < filename |	command命令以filename文件作为标准输入
command << delimiter |	从标准输入中读入，直至遇到delimiter分界符
command < &m |	将文件描述符m作为标准输入
command > &m |	将标准输出重定向到文件描述符m中
command < &- |	关闭标准输入
该部分参考了[^5]

## 条件判断[^6]
1. 字符串比较
```powershell
:: 语法格式
IF [NOT] %ERRORLEVEL% number command
:: test.bat
net user
IF %ERRORLEVEL% == 0 echo net user 执行成功了!
```
配合输入与goto语句
```pwershell
@echo off
set /p var=随便输入个命令:
%var%
if %ERRORLEVEL% == 0 goto yes
goto no
:yes
echo %var% 执行成功了
pause
exit
:no
echo 基本上执行失败了..
pause
```
多行形式
```powershell
@echo off
set /p var=随便输入个命令:
%var%
if %ERRORLEVEL% == 0 (
   echo %var% 执行成功了
   ) ELSE (
   echo 基本上执行失败了..
   )
pause
```
2. 判断文件是否存在
```powershell
@echo off
if not exist "c:/test" (echo 存在文件) ELSE echo 不存在文件
pause
```
3. 增强用法
```
::/i区分大小写./I不区分
IF [/i] string1 compare-op string2 command

IF CMDEXTVERSION number command
:: 是否定义过变量
IF DEFINED variable command
```
4.比较数字
操作符 | 含义
-|-
EQU | 等于
NEQ | 不等于
LSS | 小于
LEQ | 小于或等于
GTR | 大于
GEQ | 大于或等于

## 循环[^7]
1. 基本形式
```powershell
for [for参数][参数选项] %%循环变量名 in (for命令) do [命令]
```
> 这里的循环变量要用%%,而后do中也用%%来引用循环变量
> for参数影响for命令的解释
> 只有指定了for参数，才会指定参数选项

2. 查找文件并循环(无参数)
无for参数，for命令为文件统配符
```powershell
::显示当前目录下与t*.*相匹配的文件(只显示文件名，不显示路径) 
for %%i in (t*.*) do echo %%i

::显示d:\mydocuments\目录下与*.doc相匹配的文件
for %%i in (d:\mydocuments\*.doc) do @echo %%i
```

3. 查找目录并循环(/d参数)
```powershell
:: 语法格式

::显示c盘根目录下的所有目录
for /d %%i in (c:\*) do echo %%i

::显示当前目录下名字只有1-3个字母的目录
for /d %%i in (???) do echo %%i
```
> 这个参数主要用于目录搜索,不会搜索文件
> /d 参数只能显示当前目录下的目录名字。(只会搜索指定目录下的目录，不会搜索再下一级的目录。)

4. 递归搜索(包含子目录)指定目录下的文件(/r参数)
```powershell
::语法格式
FOR /R [[drive:]path] %variable IN (set) DO command [command-parameters]

::列举boot.ini存在的目录
for /r c:\ %%i in (boot.ini) do if exist %%i echo %%i
```
5. 步进循环(/L参数，基本等同语言中的for(i=0;i<4;i++)循环)
```powershell
:: 格式
FOR /L %variable IN (start,step,end) DO command [command-parameters]

::输出1 2 3 4 5
for /l %%i in (1,1,5) do @echo %%i

::输出1,3，5,7，9
for /l %%i in (1,2,10) do @echo %%i 

::输出100,80,60,40,20
for /l %%i in (100,-20,1) do @echo %%i

:: 打开5个CMD窗口
for /l %%i in (1,1,5) do start cmd

:: 建立从1~5共5个文件夹
for /l %%i in (1,1,5) do md %%i

:: 删除从1~5共5个文件夹
for /l %%i in (1,1,5) do rd /q %%i
```

## 变量延迟[^8]
```powershell
@echo off
setlocal enabledelayedexpansion    ::注意这里
 
set str=test
 
if %str%==test (
    set str=another test
    echo !str!      ::注意这里
    echo %str%  ::区别
)
```
> windows在解释执行if/for时，在遇到if语句后的括号后，只把它当一条语句处理而不是两条语句,导致里面的变量赋值不起作用
> setlocal enabledelayedexpansion 用于开启变量延迟，这是告诉解释器，在遇到复合语句的时候，不要将其作为一条语句同时处理，而仍然一条一条地去解释。但是这时必须用!str!来引用变量，如果仍然用%str%引用是不起作用的。

[^1]:[CMD注释形式](https://blog.csdn.net/u012867174/article/details/22861869)
[^2]:[cmd的变量总结](https://www.cnblogs.com/feiquan/p/10170203.html)
[^3][07-CMD_set命令详解](https://blog.csdn.net/wuqinfei_cs/article/details/9331869)
[^4]:[cmd批处理常用符号详解](https://www.cnblogs.com/shiningrise/p/3761135.html)
[^5]:[Windows下cmd标准输入输出重定向](https://www.cnblogs.com/shawnchou/p/10929535.html)
[^6]:[cmd中if命令讲解](https://blog.csdn.net/coolmir2/article/details/4485966)
[^7]:[cmd for 用法](https://www.cnblogs.com/cbugs/p/8992059.html)
[^8]:[cmd enabledelayedexpansion](https://www.cnblogs.com/cbugs/p/8976843.html)