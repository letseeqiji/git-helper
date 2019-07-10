#!/bin/bash
# 简单易用高效的git命令行助手
# Author: letseeqiji
# version: 1.0.2
# data: 2018.5.1

# 首先避免自己被添加到git管理中
sfile=$(ls | grep .sh)
if [ -f .gitignore ]; then
	if [ -z $(grep ${sfile} .gitignore) ]; then
		echo "${sfile}" >> .gitignore
	fi
else
	echo "##ignore this file##" >> .gitignore
	echo "${sfile}" >> .gitignore
fi

# 检测是否安装了git或者正确配置git到path
clear
git --version &> /dev/null
if [ $? -ne 0 ]; then
	echo -e -n "\n\n\033[01;36m没有检测到git命令,请首先安装并配置好git.\n \033[0m "
	exit 1
fi

# 检测是否配置了user.name 和 user.email
if [[ -z $(git config --global --list | grep user.name) ]] && [[ -z $(git config --local --list | grep user.name) ]]; then
	
	echo -e -n "\n\n\033[01;36m检测到您还没有配置用户信息, 是否要配置用户信息[Y/N]:\033[0m"
	read -n1 config_choose
	echo -e "\n"
	if [[ $config_choose == 'y' ]] || [[ $config_choose == 'Y' ]]; then
		echo -e -n "\033[01;36m请输入要是用的name:\033[0m "
		read -p "" user_name
		git config --global user.name "$user_name"
		echo -e -n "\033[01;36m请输入要是用的email：\033[0m "
		read -p "" user_email
		git config --global user.email "$user_email"
		clear
		echo -e -n "\033[01;36m恭喜，用户信息设置成功！\n\033[0m "
	else
		echo -e -n "\033[01;36m取消成功.\n\033[0m "
		exit 129
	fi
	
fi

# 还可以添加自动运行脚本和加入命令行自动运行  以及 优化一些步骤 比如推送之前应该首先 git pull  以及自动处理冲突等 处理冲突的设计才需要完善
git status
options="[ 0-查看状态 | 1-添加修改 | 2-提交修改 | 3-比较文件 | 4-拉取文件 | 5-查看日志 | 6-推送修改 ]\n[ 7-运行命令 | 8-回滚操作 | 9-删除文件 | A-文件改名 | E-退出命令 | H-帮助文档 ]"
while echo -e -n "\n\n\033[01;36m选择操作，输入对应的数字即可.\n$options: \033[0m "
	read -p "" choose
do
	echo -e "\n"
	case $choose in
	0)
		git status
		;;
	1)
		git add -A
		git status
		;;
	2)
		echo -e -n "\033[01;36m请输入备注: \033[0m "
		read commit
		commitDate="[20"$(date +%y-%m-%d])
		commit=$commitDate$commit
		git commit -m "$commit"
		;;
	3)
		git diff HEAD -- *
		;;
	4)
		git fetch origin master:origin_master
		git checkout origin_master
		git diff master
		git checkout master
		echo -e -n "\033[01;36m确认合并origin_master[Y/N] \033[0m "
		read -n1 merge_choose
		echo -e "\n"
		if [[ $merge_choose == 'y' ]] || [[ $merge_choose == 'Y' ]]; then
			git merge origin_master
		else
			echo -e -n "\033[01;36m取消成功.\n \033[0m "
		fi
		git branch -D origin_master
		;;

	5)
		echo -e -n "\033[01;36m仅展示两周内日志. \033[0m "
		git log --since=2.weeks --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit;;
	6)
	        git push origin master
			git status
			;;
	7)
		echo -e "\033[01;36m输入配置用户信息的命令并回车, 例如[git config --global user.name 'XXX']. \033[0m "
		while read -p ">> " gitConfig
		do
			echo $gitConfig
			if [[ $gitConfig != '' ]]; then
				$gitConfig
			else
				break
			fi
		done
		;;
	8)
		git log --since=2.weeks --color --graph --pretty=oneline
		echo -e -n "\033[01;36m请输入要回滚到的id: \033[0m "
		read reset_id
		git reset --hard $reset_id
		git status
		;;
	
	9)
		clear
		ls
		echo -e -n "\033[01;36m请输入要回删除的文件名: \033[0m "
		read rm_file
		git rm $rm_file
		git status
		;;
	a | A)
		echo -e -n "\033[01;36m请输入要修改的文件名: \033[0m "
		read sr_file
		echo -e -n "\033[01;36m请输入要修改后的文件名: \033[0m "
		read mv_file
		git mv $sr_file $mv_file
		git status;;
	e | E)
		exit 0
		;;
	h | H)
		echo "	0: 添加所有的文件到缓存区, 对应命令: git add -A. "
		echo "	1: 确认更改，对应命令：git commit -m 备注. "
		echo "	2: 对比其他版本和当前版本的区别，对应命令：git diff HEAD --. "
		echo "	3: 拉取远程分支并合并到本地，对应命令：git fetch && git merge origin_master. "
		echo "	4: 显示两周内日志记录，对应命令：git log --since=2.weeks. "
		echo "	5: 推送到远程服务器，对应命令：git push origin master. "
		echo "	6: 配置运行自定义命令(回车退出), 对应命令：git config "
		echo "	7: 回滚操作，对应命令：git reset --hard . "
		echo "	8: 显示当前文件的状态，对应命令：git status. "
		echo "	9: 删除指定文件，对应命令：git rm 文件. "
		echo "	A: 文件改名，对应命令：git mv 文件. "
		echo "	E: 退出脚本，对应命令：exit 0. "
		echo "	H: 显示帮助文档. "
		;;
	*)
		echo
		echo -e -n "\033[31m	亲，别逗我，请按照提示输入.\033[0m"
		echo;;
	esac
done
