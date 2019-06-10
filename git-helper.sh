#!/bin/bash
# 简单易用高效的git命令行助手
# Author: letseeqiji
# version: 1.0.0
# data: 2018.5.1

git --version &> /dev/null
if [ $? -ne 0 ]; then
	echo "没有检测到git命令,请首先安装并配置好git "
	exit 1
fi

git status
options="[Add|Commit|Diff|Fetch|Exit|Help|Log|Push|User|Reset|Status]"
while echo -e -n "\n\n\033[01;36m选择操作，输入要执行操作首字母即可.\n$options: \033[0m "
	read -n1 choose
do
	echo -e "\n"
	case $choose in
	A | a)
		git add -A
		git status;;
	C | c)
		echo -e -n "\033[01;36m请输入备注: \033[0m "
		read commit
		commitDate="[20"$(date +%y-%m-%d])
		commit=$commitDate$commit
		git commit -m "$commit";;
	D | d)
		git diff HEAD -- *;;
	E | e)
		exit 0;;
	F | f)
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
		git branch -D origin_master;;
	H | h)
		echo "	A: 添加所有的文件到缓存区, 对应命令: git add -A. "
		echo "	C: 确认更改，对应命令：git commit -m 备注. "
		echo "	D: 对比其他版本和当前版本的区别，对应命令：git diff HEAD --. "
		echo "	E: 退出脚本，对应命令：exit 0. "
		echo "	F: 拉取远程分支并合并到本地，对应命令：git fetch && git merge origin_master. "
		echo "	L: 显示两周内日志记录，对应命令：git log --since=2.weeks. "
		echo "	P: 推送到远程服务器，对应命令：git push origin master. "
		echo "	U: 配置用户信息(回车退出), 对应命令：git config "
		echo "	R: 回滚操作，对应命令：git reset --hard . "
		echo "	S: 显示当前文件的状态，对应命令：git status. ";;
	L | l)
		echo -e -n "\033[01;36m仅展示两周内日志. \033[0m "
		git log --since=2.weeks --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit;;
	P | p)
	        git push origin master
			git status;;
	U | u)
		echo -e "\033[01;36m输入配置用户信息的命令并回车, 例如[git config --global user.name 'XXX']. \033[0m "
		while read -p ">> " gitConfig
		do
			echo $gitConfig
			if [[ $gitConfig != '' ]]; then
				$gitConfig
			else
				break
			fi
		done;;
	R | r)
		git log --since=2.weeks --color --graph --pretty=oneline
		echo -e -n "\033[01;36m请输入要回滚到的id: \033[0m "
		read reset_id
		git reset --hard $reset_id;;
	S | s)
		git status;;
	*)
		echo
		echo -e -n "\033[31m	亲，别逗我，请按照提示输入.\033[0m"
		echo;;
	esac
done
