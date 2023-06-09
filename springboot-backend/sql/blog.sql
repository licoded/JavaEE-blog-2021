/*
 Navicat Premium Data Transfer

 Source Server         : aliyun
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : rm-uf67zc8e57kq2dqkfeo.mysql.rds.aliyuncs.com:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 17/06/2021 17:19:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT 'postId',
  `fid` int(11) NULL DEFAULT NULL COMMENT 'fatherId',
  `uname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'fromId',
  `tname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'toId',
  `date` date NULL DEFAULT NULL,
  `msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `favors` int(11) NULL DEFAULT NULL COMMENT 'likeNum',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `comment_id_uindex`(`id`) USING BTREE,
  INDEX `comment_user_id_fk`(`uname`) USING BTREE,
  INDEX `comment_post_id_fk`(`pid`) USING BTREE,
  INDEX `comment_comment_id_fk`(`fid`) USING BTREE,
  INDEX `comment_user_id_fk_2`(`tname`) USING BTREE,
  CONSTRAINT `comment_post_id_fk` FOREIGN KEY (`pid`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (2, 1, -1, '犀利的评论家', NULL, '2018-07-05', '非常靠谱的程序员', 3, 'http://ww4.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2pddjuj30v90uvagf.jpg');
INSERT INTO `comment` VALUES (4, 1, 2, '夕阳红', '犀利的评论家', '2018-07-06', '赞同，很靠谱，水平很高', 1, 'https://wx4.sinaimg.cn/mw690/69e273f8gy1ft1541dmb7j215o0qv7wh.jpg');
INSERT INTO `comment` VALUES (5, 1, 2, '清晨一缕阳光', '夕阳红', '2018-07-07', '大神一个！', 9, 'http://imgsrc.baidu.com/imgad/pic/item/c2fdfc039245d688fcba1b80aec27d1ed21b245d.jpg');
INSERT INTO `comment` VALUES (6, 1, -1, '毒蛇郭德纲', NULL, '2018-07-05', '从没见过这么优秀的人', 0, 'http://ww1.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2q2p8pj30v90uzmzz.jpg');
INSERT INTO `comment` VALUES (11, 1, -1, 'Licoded', NULL, '2021-06-17', '测试', 0, 'http://ww1.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2q2p8pj30v90uzmzz.jpg');
INSERT INTO `comment` VALUES (16, 3, -1, 'Licoded', NULL, '2021-06-17', '测试评论', 0, 'http://ww1.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2q2p8pj30v90uzmzz.jpg');
INSERT INTO `comment` VALUES (18, 5, -1, 'Admin1', NULL, '2021-06-17', 'fsfs', 0, 'http://ww1.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2q2p8pj30v90uzmzz.jpg');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `summary` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `readNum` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `poat_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, '# 前言\n\n> 本文转载自 [Ghost Blog安装笔记--淮城一只猫](https://iiong.com/gost-blog-install-notes/)，并有少量原创内容\n\n之前使用过 ghost 搭建博客，但因为速度慢、太难上手、没有好看的主题再加上服务器需要用于其他用途，迁移回了 hexo 。现在除了难于上手外问题基本都解决了，并且 ghost 还有了很多新特性让我难以抗拒，于是乎就搬回了 ghost 。\n\n我用的是阿里云轻量级应用服务器，学生机，Ubuntu18.04LTS，1 CPU/2G RAM/40G ROM.废话不多说，开始整活，详细介绍一下搭建 ghost 博客的具体步骤。\n\n# 创建新管理员用户\n\n由于 Ghost 不允许 root 安装，所以需要新建一个账户并让他以 root 身份登录\n\n```bash\n# 更新软件\nsudo apt update && sudo apt upgrade         \n\n# ghost不允许root用户安装，所以需要新建个<user>用户\nadduser <user>                              \n\n# 给予<user>用户为超级权限\nusermod -aG sudo <user>                     \n\n# 登录用户\nsu - <user>                                 \n```\n\n> 这里的 <user> 用户名可以自己任意修改，例如 tom 、 gh 、 lic 等。\n> 但不能使用 ghost 作为用户名，因为和 ghost-cli 用户名产生冲突。\n\n# 安装 Node.js 环境和 ghost-cli\n\n```bash\n# 下载并安装 nvm\ncurl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash\n# 添加下面这句话到 ~/.bashrc 或 ~/.zshrc\nexport NVM_DIR=\"$([ -z \"${XDG_CONFIG_HOME-}\" ] && printf %s \"${HOME}/.nvm\" || printf %s \"${XDG_CONFIG_HOME}/nvm\")\"\n[ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\" # This loads nvm\n\n# 查看最新的 nodejs-lts 版本\nnvm ls-remote --lts \n# 安装 nodejs。版本号可能会有变化\nnvm install 12.16.1\n\n# 安装 nrm 并更换 npm 源为 taobao 镜像\nnpm install nrm -g\nnrm use taobao\n\n# 安装 ghost-cli\nnpm install ghost-cli@latest -g\n```\n\n# 安装Nginx环境\n\n```bash\nsudo apt-get install nginx\nnginx -v                                    \n\n# 关闭防火墙\nsudo ufw allow \'Nginx Full\'                 \n```\n\n#  安装数据库\n\n> 我使用的是 MariaDB，而不是官方推荐的 MySql  \n> MariaDB 的安装很简单，只需要点击这个[链接](https://downloads.mariadb.org/mariadb/repositories/)，选择你的操作系统，复制安装脚本，粘贴到你的命令行就好了\n\n例如Ubuntu 18.04安装10.4版本的数据库：\n\n```bash\nsudo apt-get install software-properties-common\nsudo apt-key adv --fetch-keys \'https://mariadb.org/mariadb_release_signing_key.asc\'\nsudo add-apt-repository \'deb [arch=amd64,arm64,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/ubuntu bionic main\'\nsudo apt update\nsudo apt install mariadb-server\n```\n\n安装完成之后，使用 `mysqladmin -u root -p password <your password>` 命令修改 root 密码\n\n# 创建网站目录，并安装 ghost \n\n```bash\n# 创建ghost文件夹的网站目录，这个名字可以自己随便定义\nsudo mkdir -p /var/www/ghost\n \n# 使文件夹拥有权限，<user>是当前用户名\n# 例如当前用户名是ubuntu，那么应该是：sudo chown ubuntu:ubuntu /var/www/ghost\nsudo chown <user>:<user> /var/www/ghost\n \n# 设置读写权限\nsudo chmod 775 /var/www/ghost\n \n# 定位\ncd /var/www/ghost\n \n# 进行Ghost博客平台安装\nghost install\n```\n\n安装过程根据主机性能来决定，下面是选项配置讲解：\n\n- Enter your blog URL: 博客展示地址，格式:http(s):(www.)example.com，不支持ip地址。\n- Enter your MySQL hostname: 数据库主机地址，回车默认是localhost。\n- Enter your MySQL username: / Enter your MySQL password: 数据库用户名/密码，上面安装的数据库用户名是root，密码是自己设置的。\n- Enter your Ghost database name: Ghost博客数据库名\n- Do you wish to set up \"ghost\" mysql user? 设置数据库用户名为ghost，这个为了避免权限太大导致数据瞎搞，Ghost官方推荐是y。\n- Do you wish to set up Nginx? 自动化Nginx，推荐y。\n- Do you wish to set up SSL? 配置SSL证书，推荐y，如果你有证书问题，请查看文章最下面的问题。\n- Enter your email (For SSL Certificate):个人邮箱，配置ssl证书需要的邮箱地址。\n- Do you wish to set up Systemd? 使用ghost进程管理工具，推荐y，个人觉得海星。\n- Do you want to start Ghost? 启动Ghost博客就可以进入网址访问。\n\n# CDN 加速\n\n我使用的是[腾讯云的免费CDN](https://console.cloud.tencent.com/cdn)，使用 CDN 本身没有什么难度，我用的时候主要有下面两个困惑\n\n### SSL 证书下载\n\n在上一步 `ghost install` 过程中，我们免费申请了 letsencrypt 的免费 SSL 证书，而使用 cdn 就需要提供 SSL 证书，哪我们的证书在哪里呢？\n\n网上的资料不多，我最后通过谷歌找到了，就在我们的服务器的 `/etc/letsencrypt/yoursite.com` 中，文件目录如下：\n\n![91c7cb115a3d8ee6](https://ghimg-1257912392.file.myqcloud.com/ghost/content/images/2020/03/91c7cb115a3d8ee6.png)\n\n腾讯云使用的就是 `fullchain.cer` 和 `yoursite.com.key` 两个证书\n\n### 域名解析设置\n\n勇敢地把 A 记录删除掉就 OK了，具体原因我也不是很懂\n\n# 图片优化\n\n安装并配置 [qn-store](https://github.com/minwe/qn-store) 后，我们在 ghost 后台上传的图片就直接存储在七牛云图床上，而不是在服务器上了 \n\n在/var/www/ghost/content/adapters文件下新建个storage文件夹\n\n```bash\ncd /var/www/ghost/content/adapters/storage # 定位\ngit clone https://github.com/Minwe/qn-store.git # 拉取源码\ncd qn-store # 定位\nnpm install # 安装模块依赖\n```\n\n然后打开/var/www/ghost/config.production.json文件，添加代码：\n\n```json\n{\n  // ...\n  \"storage\": {\n    \"active\": \"qn-store\",\n    \"qn-store\": {\n      \"accessKey\": \"your access key\", // https://portal.qiniu.com/user/key获取AK密匙\n      \"secretKey\": \"your secret key\", // https://portal.qiniu.com/user/key获取SK密匙\n      \"bucket\": \"your bucket name\", // 存储对象空间名字\n      \"origin\": \"http://xx.xx.xx.glb.clouddn.com\", // 七牛CDN地址\n      \"fileKey\": {\n        \"safeString\": true,\n        \"prefix\": \"YYYYMM/\"\n      }\n    }\n  }\n  // ...\n}\n```\n\n最后重启Ghost\n\n```bash\ncd /var/www/ghost\nghost restart\n```\n\n', '2021-06-11 00:00:00', 'Ubuntu服务器搭建Ghost博客', '记录服务器搭建GhostBlog的详细过程', 0, 97);
INSERT INTO `post` VALUES (2, '在 Ubuntu 下播放视频使用，把文件拖入 Chrome 的地址栏，F12 打开检查工具，选择console栏，粘贴下面的代码即可\n\n> 页面刷新后就会失效\n\n实现的快捷键有：左右方向键调整进度（同时使用Ctrl加快调整速度），v/b: 增加/减慢播放速度\n\n```js\nconst video = document.getElementsByTagName(\'video\')[0];\nfunction setv(speed) {\n    video.playbackRate = speed;\n}\n\n// speed_control\nlet now_speed_value = 0;\nconst max_speed_value = 5;\nconst speed_array = [1, 1.25, 1.5, 2,3];\n\n// play_percent\nconst total = video.duration;\n\nfunction right_move(per) {\n    if(video.currentTime + per <= total) {\n        video.currentTime += per;\n    } else {\n        video.currentTime = total;\n    }\n}\nfunction left_move(per) {\n    if(video.currentTime - per >= 0) {\n        video.currentTime -= per;\n    } else {\n        video.currentTime = 0;\n    }\n}\n\nfunction catchKey() {\n    const input = window.event.keyCode;\n    const flag = window.event.ctrlKey;\n    if (input == 86 || input == 66) {\n        now_speed_value += (input==86?1:(max_speed_value-1));\n        now_speed_value %= max_speed_value;\n        speed = speed_array[now_speed_value];\n        setv(speed);\n        alert(\'当前播放速度：\'+speed);\n    } else if(input == 39 || input == 76) {             // l 和 右方向键\n        right_move(flag?30:10);\n    } else if(input == 37 || input == 72) {             // h 和 左方向键\n        left_move(flag?30:10);\n    }\n}\ndocument.onkeydown = catchKey;\n```', '2020-03-19 22:41:27', 'Chrome 视频播放快捷键脚本', '在 Ubuntu 下播放视频使用，把文件拖入 Chrome 的地址栏，F12 打开检查工具，选择console栏，粘贴下面的代码即可', 0, 0);
INSERT INTO `post` VALUES (3, '---\ntitle: 修改cmd控制台默认编码为utf-8\ndate: 2020-03-19\ntags:\n    - 工具使用\n---\n打开注册表 `计算机\\HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Command Processor`   \n\n添加 autorun字符串，值为 `chcp 65001 && cls`\n\n1. 使用 `win+r` 快捷键打开运行窗口，输入 regedit 接着使用回车打开注册表编辑器  \n\n    ![99657d27eabec5b0](https://ghimg-1257912392.file.myqcloud.com/ghost/content/images/2020/03/99657d27eabec5b0.png?imageMogr2/thumbnail/!80p)\n\n2. 打开 \"Command Processor\" 目录，新建字符串值\n\n    ![addaaaf4b57be065](https://ghimg-1257912392.file.myqcloud.com/ghost/content/images/2020/03/addaaaf4b57be065.png?imageMogr2/thumbnail/!80p)\n\n3. 编辑新建的字符串值\n\n    ![eea409a7fd45ebd7](https://ghimg-1257912392.file.myqcloud.com/ghost/content/images/2020/03/eea409a7fd45ebd7.png?imageMogr2/thumbnail/!80p)\n\n> 有时候如果想要临时改回 GBK 编码，可以用 `chcp 936` 命令临时改变当前窗口的编码', '2020-03-19 22:47:00', '修改cmd控制台默认编码为utf-8', '修改cmd控制台默认编码为utf-8', 1, 0);
INSERT INTO `post` VALUES (4, '对我个人来说，博客对数学公式的支持必不可少。这次在ghost上依然是使用MathJax.js来实现，但和在网上搜到的代码不太一样，我是从[最新的MathJax官方文档](http://docs.mathjax.org/en/latest/web/start.html#configuring-mathjax)拿过来的。\n\n![e25ed418c45cb963](https://ghimg.licoded.site/ghost/content/images/2020/03/e25ed418c45cb963.png?imageMogr2/thumbnail/!60p)\n\n很简单，把下面的代码粘贴到ghost后台的Code injection中\n\n```html\n<script>\nMathJax = {\n  tex: {\n    inlineMath: [[\'$\', \'$\'], [\'\\\\(\', \'\\\\)\']]\n  },\n  svg: {\n    fontCache: \'global\'\n  }\n};\n</script>\n<script type=\"text/javascript\" id=\"MathJax-script\" async\n  src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js\">\n</script>\n```', '2020-03-20 22:50:23', 'Ghost 博客添加数学公式支持', 'Ghost 博客添加数学公式支持', 0, 0);
INSERT INTO `post` VALUES (5, '在介绍直接安装最新版pip之前我先介绍一种简单通用的安装办法\n\n```bash\nsudo apt install python3-pip\npip install -U pip\n```\n\n但本人有一定强迫症，所以不想通过升级的方式安装，下面开始正文。\n\n\n\n这里是[官方安装向导](https://pip.pypa.io/en/stable/installing/)\n\n首先，下载get-pip.py文件：\n\n```bash\ncurl https://bootstrap.pypa.io/get-pip.py -o get-pip.py\n```\n\n> 有些系统会提示curl没安装，按照提示装上就可以了\n\n```bash\npython3 get-pip.py\n```\n\n有的系统到这里就已经成功安装了，但我用的Ubuntu18.04一路坎坷\n\n首先，运行get-pip.py出错，提示distutils.util没有安装\n\n![image-20210323094804870](https://ghimg.licoded.site//picgo/image-20210323094804870.png)\n\n```bash\nsudo apt install python3-distutils\n```\n\n运行get-pip之后又报错：1.要把~/.local/bin目录添加到环境变量 2.缺少依赖testresources\n\n![image-20210323095855362](https://ghimg.licoded.site//picgo/image-20210323095855362.png)\n\n添加环境变量我就不演示了\n\n```bash\nsudo apt install python3-testresources\n```\n\n', '2021-03-23 10:04:55', 'ubuntu安装最新版pip', 'ubuntu使用get-pip方式直接安装最新版pip', 1, 2);
INSERT INTO `post` VALUES (6, '如果正在写JavaWeb项目的你有一台云服务器，恭喜你，你可以参照这篇文章将你的项目发布到你的云服务器上。这在让你获得一定成就感的同时,也更方便向其他人演示你的项目。前后端也能彻底分离，开发前端时不再需要在你的电脑上专门开一个窗口运行后端代码了。最棒的一点是它只占用你服务器的一个端口号，不会和服务器上的其他应用冲突。\n\n## 本地Win10的准备工作\n\n安装 winscp \n\n安装 wsl 作为 Linux 环境，使用 ssh 命令远程操作云服务器\n\n## 服务器上的准备工作\n\n> 注意：这里选择jdk8和tomcat7.0.100作为演示，实际要选择和你本地开发环境一致的配置\n\n### 使用 ssh 命令连接云服务器\n\n```bash\nssh username@ip_address \n```\n\n\n\n### 更换国内源\n\n````bash\n# 备份sources.list文件\nsudo cp /etc/apt/sources.list /etc/apt/sources_init.list\n# 修改sources.list，推荐换成清华源或者阿里源\nsudo gedit /etc/apt/sources.list\n# 执行update应用更新\nsudo apt update\n````\n\n清华源：https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/\n\n阿里云：https://developer.aliyun.com/mirror/ubuntu\n\n> 注意选择和自己服务器对应的版本（可以用 `lsb_release -a` 命令查看）\n\n### 安装 jdk\n\n```bash\nsudo apt install openjdk-8-jdk -y\n```\n\n### 安装tomcat\n\n> 运行 war 包才需要安装 tomcat，如果你要运行的是 jar 包可以跳过这一步\n\n```bash\n# 创建存放tomcat的目录\nmkdir -p /usr/tomcat && cd /usr/tomcat\n# 下载tomcat安装包\nwget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.100/bin/apache-tomcat-7.0.100.tar.gz\n# 解压缩\nsudo tar -xvzf apache-tomcat-7.0.100.tar.gz \n```\n\n\n\n## Struts项目\n\n在IDEA中选择Build->Build Artifacts，会target目录下生成war包\n\n使用 winscp 或其他工具把 war 包上传到云服务器 tomcat 的 webapps 目录下，然后 ssh 连接云服务器启动 tomcat\n\n```bash\n# 使用scp上传war包到云服务器\nscp local_path/your_project.war root@ip_address:cloud_tomcat_path/webapps/\n# 使用ssh远程连接云服务器\nssh root@ip_address \n# 跳转到云服务器tomcat的bin目录\ncd cloud_tomcat_path/bin/\n# 如果之前tomcat处于运行状态需要先关闭\n./shutdown.sh\n# 启动tomcat服务器\n./startup.sh\n```\n\n> 这里执行 scp 和 ssh 命令时必须以 root 用户的身份，因为 tomcat 的 webapps 目录需要权限才能打开\n\n## SpringBoot项目\n\n在IDEA中点击右侧的Maven面板，点击Lifecycle->package，会target目录下生成jar包\n\n使用 winscp 或其他工具把 war 包上传到云服务器的任意位置，然后 ssh 连接云服务器使用 nohup 命令以后台方式运行 jar 包\n\n```bash\n# 使用scp上传war包到云服务器\nscp local_path/your_project.jar root@ip_address:cloud_path/\n# 使用ssh远程连接云服务器\nssh root@ip_address \n# 跳转到云服务器tomcat的bin目录\ncd cloud_path/\n# 使用nohup命令以后台方式运行jar包\nnohup java -jar your_project.jar\n# 查看进程号\nps -ef|grep java\n# 杀掉进程来强制关闭后台运行的jar包\nkill -9 port\n```\n\n一些错误的参考解决办法：\n\n- [解决Error resolving template template might not exist or might not be accessible问题](https://blog.csdn.net/u012613251/article/details/80304722)\n\n## 待解决问题\n\n- tomcat修改 `/conf/server.xml` 中的端口号之后，shutdown时报错', '2020-06-14 16:36:42', '将你的JavaWeb项目发布到线上', '教你如何将JavaWeb项目发布到线上（云服务器）', 1, 0);
INSERT INTO `post` VALUES (7, '## Linux\n\n```bash\npip install virtualenv virtualenvwrapper\nmkdir ~/.virtualenvs\n```\n\n在~/.bashrc文件末尾添加下面的内容\n\n```ini\n# python3 virtualenvs\nexport WORKON_HOME=$HOME/.virtualenvs\nexport VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3\nsource $HOME/.local/bin/virtualenvwrapper.sh\n```\n\n重启terminal就OK了\n\n\n\n#####  使用介绍\n\n```bash\nmkvirtualenv name #建立新虚拟环境\nworkon #查看虚拟环境列表\nworkon name #切换到该虚拟环境\ndeactivate #退出当前虚拟环境\n```\n\n\n\n## Win10\n\nwindows要安装virtualenvwrapper-win而不是virtualenvwrapper\n\n且workon命令不能再powershell中使用，目前有两种解决方案：\n\n- `cmd /k workon`\n- 手动激活 `venv\\Script\\activate.ps1`', '2021-03-23 10:26:46', '使用virtualenv搭建Python虚拟环境', '使用virtualenvwrapper便捷管理Python虚拟环境', 0, 0);
INSERT INTO `post` VALUES (8, '> 不想再windows上装mysql，所以就装在了vmware虚拟机上。但vmware虚拟的ip地址是固定分配的，这就意味着我每次开机都要在配置文件上换一次ip地址，太麻烦了。我作为一条懒狗加强迫症晚期患者根本忍不了，于是就百度+谷歌折腾了大概一上午，然后有了这篇博客\n\n1. 打开VMware的编辑-虚拟网络编辑器，点击更改设置\n\n   ![01](https://ghimg.licoded.site/picgo/20201107170726.png)\n   \n   \n\n\n2. 选择类型为NAT模式的那一项，点击下面的NAT设置\n\n   ![02](https://ghimg.licoded.site/picgo/20201107171123.png)\n\n3. 修改网关（只能修改4为ip地址的最后一位，并且不能和子网IP的冲突）\n\n   然后一定不要忘记，点击确定，点击应用，点击确定\n\n   ![03](https://ghimg.licoded.site/picgo/20201107171313.png)\n\n   ![04](https://ghimg.licoded.site/picgo/20201107171331.png)\n\n4. 开启你要固定ip地址的虚拟机\n\n5. 查看网卡名字`ifconfig`\n\n   ![01_ifconfig](https://ghimg.licoded.site/picgo/20201107171714.png)\n\n   记住带有“RUNNING”字样的网卡的名字，如上图\n\n   一般Centos是eth0或eth1，Ubuntu是ens33\n\n6. 修改interfaces配置`sudo vim /etc/network/interfaces  `\n\n   在文件末尾添加下面内容\n\n   ```\n   auto ens33						# 上一步查看的带有RUNNING字样的网卡名称\n   iface ens33 inet static			# 上一步查看的带有RUNNING字样的网卡名称\n   address 192.168.247.200			# 要设为的ip地址\n   netmask 255.255.255.0			# 子网掩码，跟我一样就行了\n   gateway 192.168.247.20			# 网关（要和第3步中修改的一样）\n   dns-nameservers 180.76.76.76 	# dns，我这里用的百度的，可以自行更换\n   ```\n\n   ![05](https://ghimg.licoded.site/picgo/20201107173426.png)\n\n   搞完执行` service network restart`重启网络服务就OK了，如果不行可以先重启一下虚拟机试试\n\n7. 如果上面配置完没出问题就不用看这一步了\n\n   `sudo vim /etc/NetworkManager/NetworkManager.conf`如下图，修改managed=true\n\n   ![03_networkmanager](https://ghimg.licoded.site/picgo/20201107172718.png)\n\n   搞完重启一下虚拟机应该就好了', '2020-11-07 17:29:00', 'vmware固定IP', 'VMware设置Linux虚拟机的IP地址为固定IP地址', 1, 0);
INSERT INTO `post` VALUES (9, '---\ntitle: \ndate: \ncatalog: true\ntags:\n    - \n---\n\n# 前言\n\n> 本文主要总结 Vue.js 的基础语法，对应 [Vue中文官方文档的教程-基础部分](https://cn.vuejs.org/v2/guide/)， 供自己以后速查使用。    \n> 如果要深入学习建议使用 [Vue.js 中文官网](https://cn.vuejs.org/v2/guide/)\n\n# 第一个 Vue 实例\n\n<script async src=\"//jsrun.net/Qp2Kp/embed/all/light\"></script>\n\n通过这个简单的实例我们就能明显地感受出使用 Vue.js 的好处之一就是不需要直接操作 DOM，减少了代码量。\n\n# 模板语法\n\n## v-text、v-html和v-once\n\n`v-text` 指令和使用“Mustache”语法 (双大括号) 的文本插值一样会将数据解释为普通文本，而非 HTML 代码。\n`v-html` 指令则会解析html然后输出。\n\n使用以上两种语法时都会建立起数据绑定，数据改变时会重新渲染相应DOM。\n而使用 `v-once` 指令，你也能执行一次性地插值，取消数据改变时的更新。\n\n## v-if和v-show\n\n`v-if` 是“真正”的条件渲染，如果v-if的条件为假该元素的DOM就不会被渲染。\n而 `v-show` 不管条件的真假，元素总是会被渲染，并且只是简单地基于 CSS 的 `display` 属性进行切换。\n\n一般来说，`v-if` 有更高的切换开销，而 `v-show` 有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 v-show 较好；如果在运行时条件很少改变，则使用 `v-if` 较好。\n\n## 用 key 管理可复用的元素\n\n[Vue官网 - 用 key 管理可复用的元素](https://cn.vuejs.org/v2/guide/conditional.html#用-key-管理可复用的元素)\n大致就是讲可以通过给标签加key属性来避免Vue对元素的复用造成的bug\n\n## 缩写\n\n`v-bind` 缩写为 `:`，`v-on`缩写为 `@`     \n\n# 计算属性和侦听器\n\n## 计算属性的 setter\n\n计算属性默认只有 getter，不过在需要时你也可以提供一个 setter，具体见[Vue官网 - 计算属性的 setter 实例](https://cn.vuejs.org/v2/guide/computed.html#计算属性的-setter)\n\n## 计算属性缓存 vs 方法\n\n两种方式的最终结果确实是完全相同的。然而，不同的是计算属性是基于它们的响应式依赖进行缓存的。只在相关响应式依赖发生改变时它们才会重新求值。这就意味着只要依赖值还没有发生改变，多次访问计算属性会立即返回之前的计算结果，而不必再次执行函数。\n相比之下，每当触发重新渲染时，调用方法将总会再次执行函数。\n我们为什么需要缓存？假设我们有一个性能开销比较大的计算属性 A，它需要遍历一个巨大的数组并做大量的计算。然后我们可能有其他的计算属性依赖于 A。如果没有缓存，我们将不可避免的多次执行 A 的 getter！如果你不希望有缓存，请用方法来替代。\n\n## 计算属性 vs 侦听属性\n\nVue 提供了一种更通用的方式来观察和响应 Vue 实例上的数据变动：侦听属性。当你有一些数据需要随着其它数据变动而变动时，你很容易滥用 watch（写出不必要的复杂代码）。通常更好的做法是使用计算属性而不是命令式的 watch 回调。\n\n## 侦听器\n\n虽然计算属性在大多数情况下更合适，但有时也需要一个自定义的侦听器。这就是为什么 Vue 通过 watch 选项提供了一个更通用的方法，来响应数据的变化。当需要在数据变化时执行异步或开销较大的操作时，这个方式是最有用的。\n[Vue官网 - 侦听器实例](https://cn.vuejs.org/v2/guide/computed.html#侦听器)\n\n# Class 与 Style 绑定\n\n[Vue官网 - Class 与 Style 绑定](https://cn.vuejs.org/v2/guide/class-and-style.html)\n\n# 列表渲染\n\n[Vue官网 - 列表渲染](https://cn.vuejs.org/v2/guide/list.html)\n\n# 事件处理\n\n[Vue官网 - 事件处理](https://cn.vuejs.org/v2/guide/events.html)\n\n# 表单输入绑定\n\n[Vue官网 - 表单输入绑定](https://cn.vuejs.org/v2/guide/events.html)\n\n# 组件基础\n\n## 全局组件\n\n<script async src=\"//jsrun.net/7p2Kp/embed/all/light\"></script>\n\n## 局部组件\n\n<script async src=\"//jsrun.net/dp2Kp/embed/all/light\"></script>\n\n## 子组件向父组件传值\n\n**父组件**向**子组件**传值在前面已经用到了，下面来写一个子组件向父组件传值的例子\n\n<script async src=\"//jsrun.net/up2Kp/embed/all/light\"></script>\n\n# 一些细节\n\n## 最好不要使用箭头函数\n\nVue的data和methods中最好不要使用箭头函数，因为在箭头函数中this不会指向这个组件的实例\n\n## 特殊元素的DOM解析\n\n有些 HTML 元素，诸如 `<ul>`、`<ol>`、`<table>` 和 `<select>`，对于哪些元素可以出现在其内部是有严格限制的。而有些元素，诸如 `<li>`、`<tr>` 和 `<option>`，只能出现在其它某些特定的元素内部。\n这会导致我们使用这些有约束条件的元素时遇到一些问题。例如：\n\n```html\n<table>\n    <blog-post-row></blog-post-row>\n</table>\n```\n\n这个自定义组件 `<blog-post-row>` 会被作为无效的内容提升到外部，并导致最终渲染结果出错。幸好这个特殊的 `is` attribute 给了我们一个变通的办法：\n\n```html\n<table>\n    <tr is=\"blog-post-row\"></tr>\n</table>\n```\n\n需要注意的是如果我们从以下来源使用模板的话，这条限制是不存在的：\n* 字符串 (例如：`template: \'...\'`)\n* 单文件组件 (`.vue`)\n* `<script type=\"text/x-template\">`\n\n## 使用驼峰命名法定义组件名时要注意\n\nPascalCase(首字母大写命名) 其实就是驼峰命名法。当你使用此命名法时，在html中必须转化成kebab-case(短横线分隔命名) 来使用，在其他地方两种命名方法都可以使用。\n\n## 使用$开头的数据名时要注意\n\n以 `_` 或 `$` 开头的属性不会被 Vue 实例代理，因为它们可能和 Vue 内置的属性、API 方法冲突。你可以使用例如 `vm.$data._property` 的方式访问这些属性。\n\n## 组件data必须定义为函数\n\n当一个组件被定义，data 必须声明为返回一个初始数据对象的函数，因为组件可能被用来创建多个实例。如果 data 仍然是一个纯粹的对象，则所有的实例将共享引用同一个数据对象！通过提供 data 函数，每次创建一个新实例后，我们能够调用 data 函数，从而返回初始数据的一个全新副本数据对象。  \n\n```js\nVue.component(\"TodoItem\", {     \n    data() {\n        return {\n            content: \'something\',\n        }\n    },\n});\n```\n\n## Vue数据绑定的局限性\n\n由于Javascript中的数组和对象都是引用形式，所以用绑定了数组和对象无法像其他类型的绑定那样直接实现实时更新，但有一些解决方案。\n\n* 通过赋值的方法给一个全新的对象或者用splice、unshift等变异方法的返回值（本质是使引用发生改变）\n* 使用Vue.set()方法', '2020-04-24 22:57:04', 'Vue学习笔记01-基础部分', '本文主要总结 Vue.js 的基础语法', 1, 0);
INSERT INTO `post` VALUES (10, '注册Algolia账号，并新建Index；新建API Key，需要有`search`、`addObject`、`editSettings`和`deleteIndex`权限\n\n#### 创建配置文件\n\n`.env`文件\n\n```ini\nAPPLICATION_ID=YOUR_APP_ID\nAPI_KEY=YOUR_ADMIN_KEY\n```\n\nconfig.json文件（示例仅供参考）\n\n```json\n{\n  \"index_name\": \"docs_test\",\n  \"start_urls\": [\"https://licoded.gitee.io/docs/\"],\n  \"selectors\": {\n    \"lvl0\": {\n      \"selector\": \"p.sidebar-heading.open\",\n      \"global\": true,\n      \"default_value\": \"Documentation\"\n    },\n    \"lvl1\": \".content__default h1\",\n    \"lvl2\": \".content__default h2\",\n    \"lvl3\": \".content__default h3\",\n    \"lvl4\": \".content__default h4\",\n    \"lvl5\": \".content__default h5\",\n    \"lvl6\": \".content__default h6\",\n    \"text\": \".content__default p, .content__default ul, .content__default li, .content__default blockquote,a.header-anchor\"\n  }\n}\n```\n\n#### 使用docker爬取数据并添加到Index\n\n> 部分操作仅适用于Manjaro\n\n```bash\n# 安装jq和docker\nyay -S jq docker\n# 配置docker镜像\nsudo mkdir -p /etc/docker\nsudo tee /etc/docker/daemon.json <<-\'EOF\'\n{\n  \"registry-mirrors\": [\"https://yourid.mirror.aliyuncs.com\"]\n}\nEOF\nsudo systemctl daemon-reload\nsudo systemctl restart docker\n# 运行docker爬虫\ndocker run -it --env-file = .env -e“ CONFIG = $（cat /path/to/your/config.json | jq -r tostring）” algolia / docsearch-scraper\n# 注意config.json一定要使用绝对路径\n```\n\n#### 用Algolia Search替换内置搜索\n\n在config.js的themeConfig中添加如下配置\n\n```json\n{\n	algolia: {\n      appId: \"APP ID\",\n      apiKey: \"API Key\",\n      indexName: \"docs_test\",\n      algoliaOptions: {\n        hitsPerPage: 10,\n        facetFilters: \"\",\n      },\n    },\n}\n```\n\n在 `package.json` 中添加快捷命令\n\n```json\n{\n	\"algolia\": \"cd docs/.vuepress/algolia && sudo sh crawl.sh\"\n}\n```\n\n完成上述配置以后，就只需要执行 `yarn algolia` 便可以同步更新 Algolia 的 Index，但要注意一定要先把项目发布到线上，因为docker的爬虫爬取的是线上的网站而非本地的。\n\n参考链接：\n\n- [B站 |一步步搭建 VuePress 及优化|20-algolia 替换默认搜索](https://www.bilibili.com/video/BV1vb411m7NY?p=20)\n- [Algolia DocSearch | Run your own](https://docsearch.algolia.com/docs/run-your-own/)', '2020-06-21 18:17:00', 'VuePress添加Algolia搜索', 'VuePres使用Algolia搜索实现全文搜索', 1, 0);
INSERT INTO `post` VALUES (11, '### 初始化VuePress项目\n\n```bash\n# 创建文件夹\nmkdir your-project && cd your-project\n# 安装vuepress\nyarn add -D vuepress\n# 创建文档目录，并写入一些文字\nmkdir docs && echo \'# Hello VuePress\' > docs/README.md\n```\n\n接着，在 `package.json` 中添加一些快捷脚本\n\n```json\n{\n  \"scripts\": {\n    \"dev\": \"vuepress dev docs\",\n    \"build\": \"vuepress build docs\",\n  }\n},\n```\n\n执行`yarn dev`，VuePress会在 [http://localhost:8080](http://localhost:8080/) 启动一个热重载的本地开发服务器\n\n### 配置\n\n```js\nconst navConf = require(\"./config/navConf.js\");\nconst pluginConf = require(\"./config/pluginConf.js\");\n\nmodule.exports = {\n  base: \"/docs/\",\n  port: 8000,\n  title: \"Licoded\'s Note\",\n  description: \"Licoded的笔记, vuepress 文档\",\n  themeConfig: {\n    repo: \"https://gitee.com/licoded/docs\",\n    repoLabel: \'Gitee\',\n    nav: navConf,\n  },\n  plugins: pluginConf,\n};\n```\n\n| 配置项    | 说明                                                     |\n| --------- | -------------------------------------------------------- |\n| base      | 站点的基础路径，可以理解成GitHub仓库名                   |\n| port      | 指定本地开发服务器(dev Server) 的端口，不会影响build文件 |\n| repo      | Github仓库/链接                                          |\n| repoLabel | 自定义仓库链接文字                                       |\n| nav       | 导航栏链接配置                                           |\n| plugins   | 插件配置                                                 |\n\n**navConf.js**\n\n```js\nmodule.exports = [\n  { text: \"初心\", link: \"/guide/\" },\n  { text: \"大学 \", link: \"/university/\" },\n  {\n    text: \"系统\",\n    items: [\n      { text: \"Linux\", link: \"/os/linux/\" },\n      { text: \"Manjaro\", link: \"/os/manjaro/\" },\n    ],\n  },\n  {\n    text: \"前端\",\n    items: [{ text: \"JavaScript\", link: \"/frontend/javascript/\" }],\n  },\n  {\n    text: \"开发工具\",\n    items: [\n      { text: \"Git\", link: \"/tools/git/\" },\n      { text: \"VSCode\", link: \"/tools/vscode/\" },\n    ],\n  },\n];\n```\n\n**pluginConf.js**\n\n```js\nmodule.exports = {\n  \"@vuepress/back-to-top\": true,\n  \"vuepress-plugin-auto-sidebar\": {\n    titleMode: \"uppercase\",\n    titleMap: {\n      linux: \"Linux 基础\",\n      javascript: \"JavaScript 基础\",\n      guide: \"不忘初心\",\n      university: \"大学记忆\",\n      manjaro: \"Manjaro\",\n      git: \"Git\",\n      vscode: \"VSCode\",\n    },\n    collapsable: true,\n    // collapseList: [\"/os/linux\"],\n  },\n};\n```\n\ntitleMap相当于起别名，优先级最高，会覆盖titleMap；\n\ncollapsable，是否折叠侧边栏分组；也可以指定需要折叠的路径数组；\n\n### 使用gh-pages插件\n\n> 使用这个插件可以很方便地把build出来的dist目录推送到gh-pages分支，不需要手动切换分支\n\n**安装**\n\n```bash\nyarn add -D gh-pages\n```\n\n**编写脚本**\n\n```js\nvar ghpages = require(\"gh-pages\");\nghpages.publish(\n  \"./docs/.vuepress/dist\",\n  {\n    branch: \"gh-pages\",\n  },\n  function (err) {\n    if (err) {\n      console.log(\"docs同步失败!\");\n      console.log(err);\n    } else {\n      console.log(\"docs同步完成!\");\n    }\n  }\n);\n```\n\n在 `package.json` 中添加快捷命令\n\n```json\n{\n	\"pages\": \"yarn build && node scripts/pages.js\",\n}\n```\n\n### 更新文章后需要的操作\n\n```bash\n# 提交VuePress项目到Gitee\ngit commit -am \"your comments\"\ngit push -u origin master\n# 推送dist文件夹到gh-pages分支，然后手动到Gitee跟新Pages部署\nyarn pages \n# 更新AlgoliaSearch的Index\nyarn algolia\n```\n\n> 选择Gitee也是出于无奈，GithubPages在国内访问慢，coding的Pages现在好像用不了了，它更新之后我就不会用了\n>\n> Gitee的自动部署是要付费的，一年99元\n\n参考链接：\n\n- [VuePress快速上手](https://vuepress.vuejs.org/zh/guide)\n- [vuepress 自动生成侧边栏插件](https://shanyuhai123.github.io/vuepress-plugin-auto-sidebar/)', '2020-06-21 18:13:00', '使用VuePress搭建在线笔记站点', '静态网站生成器VuePress的教程', 1, 0);
INSERT INTO `post` VALUES (12, '# 下载并安装\n\n> 下载地址：https://github.com/coreybutler/nvm-windows/releases\n> 我下载的是 nvm-noinstall.zip 版本\n\n解压到 D:\\npm\\nvm，如下图所示。\n\n![12e3c1688084122a](https://ghimg.licoded.site/ghost/content/images/2020/03/12e3c1688084122a.png?imageMogr2/thumbnail/!80p)\n\n# 环境变量配置\n\n我准备把 node 放在 D:\\npm\\node 目录下，所以我的环境变量配置是\n\n1. 添加这两个变量： NVM_HOME：D:\\npm\\nvm NVM_SYMLINK：D:\\npm\\node\n2. 在path里面添加 D:\\npm\\nvm 和 D:\\npm\\node \n\n在 D:\\npm\\nvm 即 nvm 的安装目录下创建 setting.txt 文件，内容如下：\n\n```\nroot:  D:\\npm\\nvm\npath:  D:\\npm\\nodejs\narch: 64 \nproxy: none\nnode_mirror: http://npm.taobao.org/mirrors/node/\n```\n> node_mirror 是下载 node 的镜像， 如果你想设置 npm 的镜像可以使用 `npm_mirror: https://npm.taobao.org/mirrors/npm/`\n\n# 用户自定义配置\n\n默认用户配置文件 C:\\Users\\owexp\\.npmrc 内容如下：\n\n```ini\nuserconfig=D:\\npm\\config\\.npmrc\ncache=D:\\npm\\cache\ntmp=D:\\npm\\temp\ninit-module=D:\\npm\\config\\.npm-init.js\n```\n> npm config ls [-l] 可以查看自己的配置  ([]表示可选项)\n> npm config set name \"string\" 进行自定义配置 \n\n# 安装 nodejs\n\n```bash\n# 查看可安装的 node 版本\nnpm list available\n# 安装 node\nnvm install 12.16.1 64\n# 删除 node\nnvm uninstall 12.16.1\n# 切换到指定版本\nnvm use 12.16.1\n# 查看安装了哪些全局包\nnpm list --depth=0\n```\n\n# 使用 npm\n\n```bash\n# 注意 global 不能写最后，解析不了\nnpm install --global nrm \n# 查看全局安装了哪些包\nnpm --global list --depth=0\n# 在vscode项目中开启智能提示\nnpm install --save-dev @types/node （以前是typings）\n```', '2020-03-19 22:59:16', 'win-nvm使用', '使用nvm来管理你的Node和NPM', 1, 0);
INSERT INTO `post` VALUES (13, '## 下载和安装\n\n从 [mysql官网](https://dev.mysql.com/downloads/mysql) 下载安装包，如下图所示\n\n![e7303436b14c8dc7](https://ghimg.licoded.site/ghost/content/images/2020/03/e7303436b14c8dc7.png?imageMogr2/thumbnail/!80p)\n\n将 MySQL 解压到自定义的位置，然后在环境变量 Path 中添加 MySQL 解压后的 bin 目录所在的路径，比如我的是：D:\\mysql-5.7.28-winx64\\bin。\n\n以管理员身份执行下面的命令安装 mysql 服务并启动\n\n```bash\nmysqld -install\nmysqld --initialize\nnet start mysql\n```\n\n## 更改编码\n\n> 不更改的话后果很严重哦，除非你只是用纯英文的数据库\n> 使用命令 `show variables like \'char%\';` 可以查看你的数据库编码\n> 改完记得重启数据库哦，之前已经创建的表也需要重新创建，编码更改才会生效\n\n在mysql安装目录下新增一个my.ini文件。内容如下：\n\n![d3dfb348db812291](https://ghimg.licoded.site/ghost/content/images/2020/03/d3dfb348db812291.png)\n\n```ini\n[client]\nport=3306\ndefault-character-set=utf8\n[mysqld]\nport=3306\ncharacter_set_server=utf8\nbasedir=D:\\mysql-5.7.28-winx64\n#解压目录\ndatadir=D:\\mysql-5.7.28-winx64\\data\n#解压目录下data目录\nsql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES\n[WinMySQLAdmin]\nD:\\mysql-5.7.28-winx64\\bin\\mysqld.exe\n```\n\n## 修改密码\n\n首先，要获取初始密码，如下图   \n\n![23bdff25032e2947](https://ghimg.licoded.site/ghost/content/images/2020/03/23bdff25032e2947.png)\n\n```\nmysql -u root -p        # 输入刚才看到的密码\n# 修改密码，分新旧版本\nset password for root@localhost = password(\'123\');      # 旧，我用的就是这个\nalter user \'root\'@\'localhost\' identified by \'123\';      # 新，我猜是8.0以上版本\n```\n\n## 参考博客    \n\n- [Mysql5.7及以上版本的MySQL下载、安装及配置教程（附图）](https://www.cnblogs.com/water-1/p/10802256.html)   \n- [mysql默认密码的查找与修改](https://blog.csdn.net/qwq1503/article/details/86215704)   \n- [Windows中mysql数据库中文乱码永久解决方法 ](https://blog.csdn.net/yezhuanxu/article/details/52093826)  ', '2020-03-19 23:00:14', 'win10 mysql-5.7.28x64位安装', 'win10 mysql-5.7.28x64位安装', 1, 0);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`pid`, `name`) USING BTREE,
  UNIQUE INDEX `tag_id_uindex`(`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  CONSTRAINT `tag_post_id_fk` FOREIGN KEY (`pid`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (6, 1, 'Ghost');
INSERT INTO `tag` VALUES (7, 1, '博客');
INSERT INTO `tag` VALUES (8, 2, 'JavaScript');
INSERT INTO `tag` VALUES (10, 4, 'Ghost博客');
INSERT INTO `tag` VALUES (11, 5, '工具使用');
INSERT INTO `tag` VALUES (12, 5, 'Python');
INSERT INTO `tag` VALUES (13, 6, '工具使用');
INSERT INTO `tag` VALUES (14, 7, 'Python');
INSERT INTO `tag` VALUES (15, 7, '工具使用');
INSERT INTO `tag` VALUES (16, 8, '工具使用');
INSERT INTO `tag` VALUES (17, 9, 'Vue');
INSERT INTO `tag` VALUES (18, 10, '工具使用');
INSERT INTO `tag` VALUES (19, 11, '工具使用');
INSERT INTO `tag` VALUES (20, 12, 'NodeJs');
INSERT INTO `tag` VALUES (21, 13, 'MySQL');
INSERT INTO `tag` VALUES (22, 3, '工具使用');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` int(11) NULL DEFAULT 0,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
  `moto` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Talk is cheap, show me the code!',
  PRIMARY KEY (`username`) USING BTREE,
  UNIQUE INDEX `user_username_uindex`(`username`) USING BTREE,
  UNIQUE INDEX `user_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, 'admin', '123456', 1, 'https://ghimg.licoded.site/vexo/avator.jpeg', 'Talk is cheap, show me the code!');
INSERT INTO `user` VALUES (6, 'admin1', 'admin1', 0, 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'Talk is cheap, show me the code!');
INSERT INTO `user` VALUES (1, 'licoded', 'licoded', 0, 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'Talk is cheap, show me the code!');
INSERT INTO `user` VALUES (3, 'test', 'test', 0, 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'Talk is cheap, show me the code!');
INSERT INTO `user` VALUES (4, 'test1', 'test1', 0, 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'Talk is cheap, show me the code!');
INSERT INTO `user` VALUES (5, 'test2', 'test3', 0, 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', 'Talk is cheap, show me the code!');

SET FOREIGN_KEY_CHECKS = 1;
