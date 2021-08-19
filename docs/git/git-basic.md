# 概念 #

# 安装 #
## 下载
+ 本仓库会定期更新git的二进制分发，地址在dist文件夹
+ 也可以到[git官网地址](https://git-scm.com/)去直接下载最新版本
## 安装
windows下直接运行exe

安装完成后在终端运行
```
git --version
```

如果能得到版本信息，表示安装成功
![git版本检查](img/git-version.png "git版本检查")

# 初始化git仓库 init #
在终端跳转到某个指定的目录(目录可以为空)，运行```git init```,将该目录创建为git仓库。
![创建git仓库](img/git-init.png)
创建后该目录下会有一个隐藏的文件夹.git。该文件夹里面放置着git相关信息与数据库
![git仓库的配置与数据库目录](img/git-init-dir0.png)

# 添加文件到git仓库 add #
在刚才创建的git仓库目录，新建一个文件README.txt
运行以下命令
```
git add RADEME.txt
```
将指定文件添加到仓库中
![添加文件到仓库中](img/git-add.png)

# 提交变更到本地暂存库 #
运行```git commit -m "变更说明文本"```到本地版本库
![提交变更到暂存区](img/git-commit.png)
> _注意参数 -m,表示后面跟着的是message
> _commit命令还可以指定文件提交```git commit filename filename -m "commit note"```_

# 查看提交记录 #
运行命令```git log```可以查看所有的提交记录
![查看提交记录](img/git-log.png)

# 查看某个远程仓库 #
运行命令```git remote show http://xxxx.git```来查看远程仓库的信息
![查看远程仓库信息](img/git-remote-show.png)
> 如果该仓库不允许匿名访问，需要输入用户名跟密码

# 将本地仓库与远程仓库联系起来 #
```git remote add [remote-shortname] [remote-url]
git remote add master https://gitee.com/yitec/gitrepo.git
```

> 这里的url可以有这样一种格式```http://yourname:password@github.com/yourrepo```。直接在url中明文用户名密码，用这种格式对内网开发者来说非常方便，不必每次提交都输入用户名密码或配置git的远程验证配置。
> 以上格式中用户名通常是邮箱地址，要用%40来转义邮箱地址中的@符号。比如: y-tec%40qq.com
> 一个完整的带用户名密码的案例如下: git remote add origin https://y-tec%40qq.com:yourpswd@gitee.com/yitec/gitrepo.git
> 可以通过命令```git remote set-url --add origin <url2>```将多个远程仓库关联到本地仓库，后面可以一次性将本地仓库的变更，推送给多个远程仓库
# 查看与本地仓库关联的远程仓库 #
```git remote -v```
![查看与本地仓库关联的远程仓库](img/git-remote-v.png)

# 推送本地变更到远程仓库 #
```git push <远程主机名> <本地分支名>:<远程分支名>```
```git push origin master```
> the remote end hung up unexpectedly 问题: 一次提交的文件太多太大，超出了git的默认大小。可以使用命令```git config http.postBuffer 52428800```或在.git/config文件中配置
	```
	[http]
	postBuffer = 524288000
	```
> 没有上游分支问题: 调用命令```git push --set-upstream origin master```