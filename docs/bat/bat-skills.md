# 控制台显示中文 #
用设置字符编码页命令
```
chcp 65001
```
常用编码表
编码|说明
-|-
65001|utf-8
936|gbk

# 获取脚本所在目录 #
**代码(D:\IDE\docs\cmd\test.bat)**
```
@ECHO off
chcp 65001 
echo %~dp0
cd /d %~dp0
```

**效果**
> D:\IDE>docs\bat\test.bat
> Active code page: 65001
> D:\IDE\docs\bat\

> D:\IDE\docs\bat>
