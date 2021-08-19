# 概述 #
CMD命令行是windows下的批处理处理程序。一般以.bat为后缀。
可以通过cmd批处理来自动化一些程序的运行。
cmd中一行就是一个命令，称为行命令或命令行
+ 不区分大小写，比如`echo abc`跟`ECHO abc`效果是一样的
# ECHO 输出 #
## 基本用法 ##
**语法代码**
```
ECHO 要显示的文本
```
**效果**
> D:\IDE\docs\cmd>test
> D:\cmd\echo abc
> 要显示的文本

# 命令行回显 #
批处理默认会回显执行的命令，有2种方式不显示命令行回显

## 单行关闭命令回显 ## 
在命令行前添加@符号，关闭命令的回显
**代码(test.bat)**
```
@ECHO hello
```
**效果**
> D:\IDE\docs\cmd>test
> hello

## 命令行回显开关 ##
可以用@echo off/on来打开/关闭批处理的命令行回显
**代码(test.bat)**
```
@ECHO OFF
ECHO hello1
ECHO hello2
```
**效果**
> D:\IDE\docs\cmd>test
> hello1
> hello2


# 注释 #
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

**代码**
```
@ECHO OFF 
REM 关闭命令行回显,REM注释
ECHO hello1 %行内注释%
::简化的注释
ECHO hello2
```
**效果**
> D:\IDE\docs\cmd>test
> hello1 
> hello2

# SET命令 #
在批处理中，所有的变量都是环境变量。有一些变量是预先定义的。可以通过SET命令修改变量[^2]。
## 输出变量值 ##
不带等号的set。输出以SET参数作为变量名前缀的所有环境变量的值
**语法代码**
```
::语法
set 变量名(前缀)
::代码
SET PATHE
```
**效果**
> D:\IDE\docs\cmd>SET PATHE
> PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.PY;.PYW

## SET直接赋值 ##
```
set 变量名=值
```
如果变量名不在环境变量中，将变量名加入到环境变量中，并赋值
值可以包含空格、一直到命令结束，也可以是Ctrl+G这种代表警报声的字符(echo输出会发出警报声“滴～”），与echo类似


## 输入并赋值 ##
变量将通过用户输入接收值，提示作为提示信息输出
**语法代码**
```
::语法
set /P 变量=提示
::代码
SET /P MyVar=请输入
```
**效果**
> D:\IDE\docs\cmd>SET /p myvar=请输入:
> 请输入:1223

## 表达式赋值 ##
表达式将被视为算术表达式，变量赋值为算术表达式的值，算术运算符参照帮助文档或者官方网站文档（可以发现，与C语言运算符基本相同）：

如果要使用其他变量的值，需要使用%变量名%（或者 !变量名!)来表示该变量。同时0X与0分别表示十六进制与八进制数字。

**语法代码**
```
::语法
SET /a "表示式"
::代码
SET N1=1
SET /a "N2=%N1%+5"
ECHO %N2%
```
结果为6

## 字符串替换 ##
该部分参考了[^3]的相关代码
**语法代码**
```
::语法:
SET newVar = %variable:targetStr=replacementStr%
```
```
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
> D:\IDE\docs\cmd>test
> Active code page: 65001
> v1=www.baidu.com
> variable=www. baidu.com
> v2=www.bXdu.com

## 字符串截取 ##
格式:
    %variable:~[ start [, length] ]%
        start   : 从第几个字符开始, 缺省为0
                    正数(+p), 总左边数p个
                    负数(-p), 从右边数p个
        length  : 截取多少个, 缺省则取到末尾
                    正数(+n), n个
                    负数(-n), 总数-n  个



# 变量与表达式 #
在SET命令的说明中，SET能够给环境变量赋值。
除了环境变量外，还有其他的变量。
## 命令行参数 ##
%1,%2,...%9
表示批处理命令行所接的参数，最多能有9个
%0表示当前正在执行的批处理
**代码**
```
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
```
::test.bat代码
@ECHO off
echo %~0
echo %~1
```
```
:: 执行test.bat
call "test" "abc"
```
**效果**
> D:\IDE\docs\cmd>test "abc"
> test
> abc

## 变量引用 ##
被%符号括起来的部分，是作为变量的引用来使用的。除了在SET命令中能够无%%设置变量名，其他地方要使用变量，都应该用%%来引用

```
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



[^1]:[CMD注释形式](https://blog.csdn.net/u012867174/article/details/22861869)
[^2]:[cmd的变量总结](https://www.cnblogs.com/feiquan/p/10170203.html)
[^3][07-CMD_set命令详解](https://blog.csdn.net/wuqinfei_cs/article/details/9331869)
[^4]:[cmd批处理常用符号详解](https://www.cnblogs.com/shiningrise/p/3761135.html)

