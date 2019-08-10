
[![Language](https://img.shields.io/badge/Language-Shell-blue.svg)](https://github.com/letseeqiji/git-helper)
[![Build Status](https://travis-ci.org/bilibili/kratos.svg?branch=master)](https://github.com/letseeqiji/git-helper)

# Git命令行辅助脚本

-------------

Git命令行辅助脚本是大名鼎鼎的git命令行下工作的开源辅助工具。  

> 很多人喜欢在命令行下工作，单总是敲击冗长重复的命令，不仅容易出错，也容易疲倦，所以诞生了这个脚本。

## 目标

> 致力于提供更加方便快捷的操作方式，节省更多的时间去创造更具价值的东西。

## 特色

* 自动检测git安装和配置;
* 自动添加gitignore文件;
* 可自由定制：有编程基础的同学可自己修改添加更多功能;
* 不断完善：后期会根据更多反馈，完善功能。


## 目前功能
* 添加所有的文件到缓存区, 对应命令: git add -A. 
* 确认更改，对应命令：git commit -m 备注. 
* 对比其他版本和当前版本的区别，对应命令：git diff HEAD --. 
* 拉取远程分支并合并到本地，对应命令：git fetch && git merge origin_master. 
* 显示两周内日志记录，对应命令：git log --since=2.weeks. 
* 推送到远程服务器，对应命令：git push origin master. 
* 配置运行自定义命令(回车退出), 对应命令：git config 
* 回滚操作，对应命令：git reset --hard . 
* 显示当前文件的状态，对应命令：git status. 
* 删除指定文件，对应命令：git rm 文件. 
* 文件改名，对应命令：git mv 文件. 
* 分支切换
* 退出脚本，对应命令：exit 0.
* 显示帮助文档. 

## 快速开始

### 版本要求

git version>=1.0.0

### 获取


    git clone git@github.com:letseeqiji/git-helper.git
    cd git-helper
    其中 git-helper.sh 是主文件，你可以把他复制到你的项目目录下面，直接使用或者改为其它任意名称使用即可，在界面会有相应的提示
    sh ./git-helper.sh

-------

## 文档

[简体中文](https://github.com/letseeqiji/git-helper/blob/master/README.md)


-------------

*Please report bugs, concerns, suggestions by issues, or join QQ 962310113 to discuss problems around source code.*
