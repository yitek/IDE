@echo off
chcp 936
setlocal enabledelayedexpansion

SET __DIR__ = %~dp0
SET ENABLED=状态 : 已启用

:HyperV
dism /online  /Get-FeatureInfo /FeatureName:Microsoft-Hyper-V-All > 1.txt
for /f "tokens=1* delims=:" %%i in ('findstr /B /n "状态.*" 1.txt') do (
	if "%%j" == "%ENABLED%" goto HyperV-enabled
	goto enable-HyperV
) %end for 1.txt%

:install-HyperV
	echo 没有安装hyper-V
	echo install Hyper-V
	call hyperV-install.bat
	goto hyper-V-enabled

:enable-HyperV
	echo 未启动hyper-V
	echo enable hyper-V
	DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V

:hyperV-enabled
echo hyper-V已启动

:WSL
dism /online  /Get-FeatureInfo /FeatureName:Microsoft-Windows-Subsystem-Linux > 2.txt

for /f "tokens=1* delims=:" %%i in ('findstr /B /n "状态.*" 1.txt') do (
	if "%%j" == "%ENABLED%" goto WSL-enabled
	goto enable-WSL
) %end for 2.txt%
:install-WSL
	echo 安装Windows Subsystem Linux...
	
:enable-WSL
	echo 启用Windows Subsystem Linux...
	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

:WSL-enabled




