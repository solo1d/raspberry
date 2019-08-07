# apt-get 和 aptitude

```bash
aptitude 与 apt-get 一样，是 Debian 及其衍生系统中功能极其强大的包管理工具。
与 apt-get 不同的是，aptitude 在处理依赖问题上更佳一些。
举例来说，aptitude 在删除一个包时，会同时删除本身所依赖的包。
这样，系统中不会残留无用的包，整个系统更为干净。以下一些常用 aptitude 命令。

aptitude update 更新可用的包列表
aptitude upgrade 升级可用的包
aptitude dist-upgrade 将系统升级到新的发行版
aptitude install pkgname 安装包
aptitude remove pkgname 删除包
aptitude purge pkgname 删除包及其配置文件
aptitude search string 搜索包
aptitude show pkgname 显示包的详细信息
aptitude clean 删除下载的包文件
aptitude autoclean 仅删除过期的包文件

当然，你也可以在文本界面模式中使用 aptitude。


常用apt命令列表:

apt-cache search # ------(package 搜索包)
apt-cache show #------(package 获取包的相关信息，如说明、大小、版本等)
sudo apt-get install # ------(package 安装包)
sudo apt-get install # -----(package - - reinstall 重新安装包)
sudo apt-get -f install # -----(强制安装?#"-f = --fix-missing"当是修复安装吧...)
sudo apt-get remove #-----(package 删除包)
sudo apt-get remove - - purge # ------(package 删除包，包括删除配置文件等)
sudo apt-get autoremove --purge # ----(package 删除包及其依赖的软件包+配置文件等（只对6.10有效，强烈推荐）)
sudo apt-get update #------更新源
sudo apt-get upgrade #------更新已安装的包
sudo apt-get dist-upgrade # ---------升级系统
sudo apt-get dselect-upgrade #------使用 dselect 升级
apt-cache depends #-------(package 了解使用依赖)
apt-cache rdepends # ------(package 了解某个具体的依赖?#当是查看该包被哪些包依赖吧...)
sudo apt-get build-dep # ------(package 安装相关的编译环境)
apt-get source #------(package 下载该包的源代码)
sudo apt-get clean && sudo apt-get autoclean # --------清理下载文件的存档 && 只清理过时的包
sudo apt-get check #-------检查是否有损坏的依赖



apt-get update——在修改/etc/apt/sources.list或者/etc/apt/preferences之后运行该命令。此外您需要定期运行这一命令以确保您的软件包列表是最新的。 
apt-get install packagename——安装一个新软件包（参见下文的aptitude） 
apt-get remove packagename——卸载一个已安装的软件包（保留配置文件） 
apt-get --purge remove packagename——卸载一个已安装的软件包（删除配置文件） 
dpkg --force-all --purge packagename 有些软件很难卸载，而且还阻止了别的软件的应用，就可以用这个，不过有点冒险。 
apt-get autoclean apt会把已装或已卸的软件都备份在硬盘上，所以如果需要空间的话，可以让这个命令来删除你已经删掉的软件 
apt-get clean 这个命令会把安装的软件的备份也删除，不过这样不会影响软件的使用的。 
apt-get upgrade——更新所有已安装的软件包 
apt-get dist-upgrade——将系统升级到新版本 
apt-cache search string——在软件包列表中搜索字符串 
dpkg -l package-name-pattern——列出所有与模式相匹配的软件包。如果您不知道软件包的全名，您可以使用“*package-name-pattern*”。 
aptitude——详细查看已安装或可用的软件包。与apt-get类似，aptitude可以通过命令行方式调用，但仅限于某些命令——最常见的有安装和卸载命令。由于aptitude比apt-get了解更多信息，可以说它更适合用来进行安装和卸载。 
apt-cache showpkg pkgs——显示软件包信息。 
apt-cache dumpavail——打印可用软件包列表。 
apt-cache show pkgs——显示软件包记录，类似于dpkg –print-avail。 
apt-cache pkgnames——打印软件包列表中所有软件包的名称。 
dpkg -S file——这个文件属于哪个已安装软件包。 
dpkg -L package——列出软件包中的所有文件。 
apt-file search filename——查找包含特定文件的软件包（不一定是已安装的），这些文件的文件名中含有指定的字符串。

apt-file是一个独立的软件包。您必须 先使用apt-get install来安装它，然后运行apt-file update。如果apt-file search filename输出的内容太多，
     您可以尝试使用apt-file search filename | grep -w filename（只显示指定字符串作为完整的单词出现在其中的那些文件名）或者类似方法，
    例如：apt-file search filename | grep /bin/（只显示位于诸如/bin或/usr/bin这些文件夹中的文件，如果您要查找的是某个特定的执行文件的话，
    这样做是有帮助的）。

```

