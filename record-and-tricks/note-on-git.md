# using git

[git:official site](https://git-scm.com)   > git is a **distributed version-control system** for tracking changes in source code during software development.  > It is designed for coordinating work among programmers, but it can be used to track changes in any set of files.  > Its goals include **speed, data integrity, and support for distributed, non-linear workflows**.  >   > git is free and open-source software distributed under the terms of GPL v2.  > > -- from wikipedia:git - git虽然是分布式版本控制系统,为大规模协作开发而诞生,但是集中式管理,个人开发中仍然可以用得上.  - git已经是实际上的行业标准(甚至有在IT之外的领域被广泛使用的趋势).  - 已经有不少vim plugin,shell plugin(比如我喜欢的fish shell)集成了git操作.也有不少TUI,GUI的git client,还有gitlab,gitea,github等webapp提供便利操作.

### git的概念与设计
- git的分布式管理从实践来看,是比svn的集中式管理更优秀的.
  - 不需要一个统一管理的中心服务器,可以轻松离线工作,轻松多人协同,不用每次都联网进行pull,update,push还要解决冲突.
  - 在git中,每个人本地都有完整的版本仓库,把自己做的修改同步给其他人就可以完成协作(当然还需要解决不同修改的冲突).
  - 为了方便,也可以建立一个中心服务器,不用搭建p2p网络,方便交换数据,比如程序员喜闻乐见的github与gitlab以及国内的gitee都是这种平台.
- git除了分布式无需中心,方便离线工作的特点,最重要的特性是分支管理,这也是它取代svn的重要原因.
- 每个版本独立保存(方便了分支管理).
- 维护`working directory`,`stage `,`repository`(工作区,暂存区,仓库).
  - 直接操作working dir,此时是隔离其他版本与分支的.
  - 将改动(插入,删除,修改,移动...)的文件加入stage.
  - 将stage中的文件,提交到repo.存放所有版本.
- 文件状态
  - modified
  - staged
  - committed

### git常规操作.
在一切使用之前,要做基本的配置.
```bash
#使用--global flag则会修改`~/.gitconfig`,否则修改当前repo的`.git/.config`
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL

git config --list #查看已有配置
```
- git clone:把远程repo下载到本地,可以用https或者git协议(一般而言这笔直接用http传输文件快很多).
- git init:在当前目录创建`.git/`初始化git repo
- git add:把working dir的修改加入stage中,可以指定要加入的文件,也可以`git add -A`
- git checkout:用stage替代working dir(**危险**操作,谨慎使用)
- git reset:撤销commit.使用`git reset HEAD`(**危险**操作,谨慎使用),如果是`--hard`则会影响working dir.
- git commit:把stage提交到repo,使用`git commmit -m "message"`可以附带一个提交说明.(会给出这个commit的全局唯一id,由于是多人协作的,所以需要搞一个全局唯一id标识提交)一个commit就是一个版本.
- git status:它会返回 当前所在brach,working dir中尚未加入stage的修改(untracked),stage中未提交的修改.
- git log:查看提交记录
- git diff:版本比较.

