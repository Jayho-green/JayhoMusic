/*
 Navicat Premium Data Transfer

 Source Server         : root@localhost
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : musicsystem

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 27/04/2022 11:31:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `date` datetime NOT NULL,
  `userid` int NOT NULL,
  `musicid` int NOT NULL,
  PRIMARY KEY (`date`) USING BTREE,
  INDEX `userid1`(`userid`) USING BTREE,
  INDEX `musicid1`(`musicid`) USING BTREE,
  CONSTRAINT `musicid1` FOREIGN KEY (`musicid`) REFERENCES `music` (`musicid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userid1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES ('2020-03-24 16:09:37', 2, 1);
INSERT INTO `collect` VALUES ('2020-03-30 12:10:05', 2, 4);
INSERT INTO `collect` VALUES ('2022-04-26 18:21:58', 1, 4);

-- ----------------------------
-- Table structure for collectlist
-- ----------------------------
DROP TABLE IF EXISTS `collectlist`;
CREATE TABLE `collectlist`  (
  `userid` int NOT NULL,
  `listid` int NOT NULL,
  INDEX `listid2`(`listid`) USING BTREE,
  INDEX `userid7`(`userid`) USING BTREE,
  CONSTRAINT `listid2` FOREIGN KEY (`listid`) REFERENCES `list` (`listid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userid7` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collectlist
-- ----------------------------
INSERT INTO `collectlist` VALUES (1, 1);
INSERT INTO `collectlist` VALUES (1, 2);
INSERT INTO `collectlist` VALUES (1, 4);
INSERT INTO `collectlist` VALUES (2, 3);
INSERT INTO `collectlist` VALUES (2, 4);
INSERT INTO `collectlist` VALUES (2, 6);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `commentid` int NOT NULL AUTO_INCREMENT,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userid` int NOT NULL,
  `musicid` int NOT NULL,
  `date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`commentid`) USING BTREE,
  INDEX `userid`(`userid`) USING BTREE,
  INDEX `musicid`(`musicid`) USING BTREE,
  CONSTRAINT `musicid` FOREIGN KEY (`musicid`) REFERENCES `music` (`musicid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '这首歌太好听了!', 1, 3, '2020-03-23 11:43:30');
INSERT INTO `comment` VALUES (2, '。。。', 2, 3, '2020-03-23 11:45:57');
INSERT INTO `comment` VALUES (3, '就是这种感觉', 1, 2, '2020-03-23 19:02:36');
INSERT INTO `comment` VALUES (4, '66666666666666666666666', 2, 3, '2020-03-23 19:55:01');
INSERT INTO `comment` VALUES (5, '第一条哦', 2, 1, '2020-03-24 11:00:37');
INSERT INTO `comment` VALUES (6, '🍋🍋', 2, 3, '2020-03-24 12:11:56');
INSERT INTO `comment` VALUES (7, '🍋🍋🍋🍋🍋', 2, 3, '2020-03-24 12:12:15');
INSERT INTO `comment` VALUES (8, '🍋🍋🍋🍋🍋🍋🍋🍋🍋🍋', 2, 3, '2020-03-24 12:12:19');
INSERT INTO `comment` VALUES (9, '新评论！', 2, 3, '2020-03-24 18:05:27');
INSERT INTO `comment` VALUES (10, '我喜欢', 2, 3, '2020-03-30 11:48:23');
INSERT INTO `comment` VALUES (11, '加一', 2, 3, '2020-03-30 11:54:13');
INSERT INTO `comment` VALUES (12, 'aaaaaa', 2, 4, '2020-03-30 12:10:02');
INSERT INTO `comment` VALUES (13, '我喜欢', 2, 7, '2020-03-30 12:10:59');
INSERT INTO `comment` VALUES (14, 'like', 1, 7, '2022-04-26 18:22:11');

-- ----------------------------
-- Table structure for list
-- ----------------------------
DROP TABLE IF EXISTS `list`;
CREATE TABLE `list`  (
  `listid` int NOT NULL AUTO_INCREMENT,
  `listimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `listname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `listintro` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`listid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of list
-- ----------------------------
INSERT INTO `list` VALUES (1, 'http://p3.music.126.net/dqVDe7C34Ve0mB04NS87rA==/109951164883872819.jpg', '周杰伦曲目推荐', '此歌单包含了周杰伦的相关曲目');
INSERT INTO `list` VALUES (2, 'http://p4.music.126.net/a5ilHhoZIwrpXPzTXiI92g==/109951164147062236.jpg', '华晨宇曲目推荐', '此歌单包含了华晨宇的相关曲目');
INSERT INTO `list` VALUES (3, 'http://p4.music.126.net/o_OjL_NZNoeog9fIjBXAyw==/18782957139233959.jpg', '陈奕迅曲目推荐', '此歌单包含了陈奕迅的相关曲目');
INSERT INTO `list` VALUES (4, 'http://p4.music.126.net/yKjpbkjawkKABkHy818gOQ==/109951164175679778.jpg', '2020英文流行金曲', '2020年中，无论是在商场里，餐厅里还是其他场合都能听到这些歌曲');
INSERT INTO `list` VALUES (5, 'http://p4.music.126.net/sxDhSlOktmQ_-dd6ZKxUaA==/109951163861324799.jpg', '新曲推荐', '此歌单将推出近期新歌，持续更新！');
INSERT INTO `list` VALUES (6, 'http://p3.music.126.net/636SSPpKW0avAqkK1QgzgQ==/43980465112096.jpg', '经典老歌', '暴露年龄的歌曲，有木有');

-- ----------------------------
-- Table structure for music
-- ----------------------------
DROP TABLE IF EXISTS `music`;
CREATE TABLE `music`  (
  `musicid` int NOT NULL AUTO_INCREMENT,
  `musicname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `singerid` int NOT NULL,
  `hot` int NULL DEFAULT NULL,
  `musicimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `musicfile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`musicid`) USING BTREE,
  INDEX `singerid`(`singerid`) USING BTREE,
  CONSTRAINT `singerid` FOREIGN KEY (`singerid`) REFERENCES `singer` (`singerid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of music
-- ----------------------------
INSERT INTO `music` VALUES (1, '说好不哭', 2, 10, 'http://localhost:8088/musicimg/Buku.png', 'http://localhost:8088/musicfile/Buku.ogg');
INSERT INTO `music` VALUES (2, 'Closer', 1, 20, 'http://localhost:8088/musicimg/Closer.png', 'http://localhost:8088/musicfile/Closer.ogg');
INSERT INTO `music` VALUES (3, 'Lemon', 3, 21, 'http://localhost:8088/musicimg/Lemon.png', 'http://localhost:8088/musicfile/Lemon.ogg');
INSERT INTO `music` VALUES (4, '不为谁而作的歌', 4, 23, 'http://localhost:8088/musicimg/BuWei.jpg', 'http://localhost:8088/musicfile/BuWei.mp3');
INSERT INTO `music` VALUES (5, '国王与乞丐', 5, 30, 'http://localhost:8088/musicimg/guowang.jpg', 'http://localhost:8088/musicfile/QiGai.mp3');
INSERT INTO `music` VALUES (6, '烟火里的尘埃', 5, 32, 'http://localhost:8088/musicimg/YanHuo.jpg', 'http://localhost:8088/musicfile/ChenAi.mp3');
INSERT INTO `music` VALUES (7, '浮夸', 6, 50, 'http://localhost:8088/musicimg/FuKua.jpg', 'http://localhost:8088/musicfile/Fukua.mp3');
INSERT INTO `music` VALUES (8, '无条件(Live)', 6, 30, 'http://localhost:8088/musicimg/TiaoJian.jpg', 'http://localhost:8088/musicfile/WuTiaoJian.mp3');

-- ----------------------------
-- Table structure for musiclist
-- ----------------------------
DROP TABLE IF EXISTS `musiclist`;
CREATE TABLE `musiclist`  (
  `listid` int NOT NULL,
  `musicid` int NOT NULL,
  INDEX `listid1`(`listid`) USING BTREE,
  INDEX `musicid6`(`musicid`) USING BTREE,
  CONSTRAINT `listid1` FOREIGN KEY (`listid`) REFERENCES `list` (`listid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `musicid6` FOREIGN KEY (`musicid`) REFERENCES `music` (`musicid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of musiclist
-- ----------------------------
INSERT INTO `musiclist` VALUES (1, 1);
INSERT INTO `musiclist` VALUES (2, 5);
INSERT INTO `musiclist` VALUES (2, 6);
INSERT INTO `musiclist` VALUES (3, 7);
INSERT INTO `musiclist` VALUES (3, 8);

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `reviewid` int NOT NULL AUTO_INCREMENT,
  `userid` int NULL DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `details` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `result` int NULL DEFAULT NULL,
  `music` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`reviewid`) USING BTREE,
  INDEX `userid_review`(`userid`) USING BTREE,
  CONSTRAINT `userid_review` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------

-- ----------------------------
-- Table structure for singer
-- ----------------------------
DROP TABLE IF EXISTS `singer`;
CREATE TABLE `singer`  (
  `singerid` int NOT NULL AUTO_INCREMENT,
  `singername` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `singerdetails` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `singerimg` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `singercountry` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`singerid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of singer
-- ----------------------------
INSERT INTO `singer` VALUES (1, 'Wiz Khalifa', '卡梅伦·贾布里勒·托马斯（Cameron Jibril Thomaz），生于1987年9月8日，以其艺名维兹·卡利法（Wiz Khalifa）出名，是美国宾夕法尼亚州匹兹堡出身的说唱歌手。\r\n他于2006年发行了自己的首张专辑《Show and Prove》，并于2007年签约华纳兄弟唱片公司。\r\n2008年，他欧陆舞曲风格单曲“Say Yeah”，获得城市电台（英语：urban radio）的播放并登上Rhythmic四十佳和热门说唱歌曲榜。\r\n卡利法与华纳兄弟分道扬镳，并于2009年11月发行了自己的第二张专辑《Deal or No Deal》。\r\n他的混音带《Kush and Orange Juice》于2010年4月问世，并提供免费下载；接着，他和大西洋唱片公司签约。\r\n他与大西洋唱片合作的首支单曲“Black and Yellow”广受欢迎，登上公告牌百强单曲榜头名。\r\n在该厂牌下的首张专辑《Rolling Papers》于2011年3月29日发布。', 'http://localhost:8088/singerimg/Wiz Khalifa.jpg', '美国');
INSERT INTO `singer` VALUES (2, '周杰伦', '流行乐坛最重要的音乐人\r\n周杰伦的音乐横空出世以来，华语乐坛似乎早就已经掀起了一场对于音乐的革命，一批对于曲风完全没有概念的年轻歌迷便开始狂热的喜欢上了各种给人们的感觉耳目一新、天马行空的音乐题材。自此，RAP，R&B，中国风在华语乐坛正式登堂入室的成为主流。如果没有周杰伦，华语乐坛会成为另外一番景象。周杰伦对于华语乐坛的贡献实在是太大了。周杰伦的曲风足以承前启后、极具里程碑意义，从此，以C-Pop为代表的曲风可以转为根植于黑人。除了涵盖Rap、Hip Hop、R&B之外，顺便夹杂、\r\n引领了新曲风的潮流，开创了中国风这一系列高度成功的概念化。\r\n周杰伦影响、激励着层出不穷、出类拔萃的一支数量很多、素质很高、实力很强的模仿者、追随者、竞争者。因此，能够真正作为新时代符号的流行文化指标而被人们所铭记的恐怕唯有周杰伦，他用自己的个性定义，用自己的才华诠释，以平均每年一张专辑的速度，当仁不让的为新世纪的C-Pop不断倾注、融会贯通了各路新鲜血液，全面的丰富了多元化的音乐创作思路。', 'http://localhost:8088/singerimg/jielun.jpg', '中国台湾');
INSERT INTO `singer` VALUES (3, '米津玄师', '米津玄师（1991年3月10日－），是日本的音乐家、创作歌手、插画家、摄影师。出生于德岛县德岛市。血型O型。另有发表笔名“Hachi（ハチ）”。在第57回日本唱片大奖获得优秀专辑奖。', 'http://localhost:8088/singerimg/xuanshi.jpg', '日本');
INSERT INTO `singer` VALUES (4, '林俊杰', '著名男歌手，作曲人、作词人、音乐制作人，偶像与实力兼具。林俊杰出生于新加坡的一个音乐世家。在父母的引导下，4岁就开始学习古典钢琴，不善言辞的他由此发现了另一种与人沟通的语言。小时候的林俊杰把哥哥林俊峰当作偶像，跟随哥哥的步伐做任何事，直到接触流行音乐后，便爱上创作这一条路。2003年以专辑《乐行者》出道，2004年一曲《江南》红遍两岸三地，凭借其健康的形象，迷人的声线，出众的唱功，卓越的才华，迅速成为华语流行乐坛的领军人物之一，迄今为止共创作数百首音乐作品，唱片销量在全亚洲逾1000万张。2007年成立个人音乐制作公司JFJ，2008创立潮流品牌SMG。2011年被媒体封为“新四大天王”之一，同年8月8日正式加盟华纳音乐，开启事业新乐章。2012年发行故事影像书《记得》，成功跻身畅销书作家行列。获得多项奖项：第15届台湾金曲奖最佳新人奖，6届新加坡金曲奖大奖，6届新加坡词曲版权协会大奖，8届全球华语歌曲排行榜大奖，5届MusicRadio中国TOP排行榜大奖。', 'http://localhost:8088/singerimg/junjie.jpg', '新加坡');
INSERT INTO `singer` VALUES (5, '华晨宇', '华晨宇，1990年2月7日生于湖北十堰 ，中国男歌手，毕业于武汉音乐学院。 2013年，参加湖南卫视《快乐男声》获年度总冠军出道 。2014年1月，首登央视春晚舞台。9月6日-7日，在北京万事达中心连开两场“火星”演唱会 ，随后首张个人专辑《卡西莫多的礼物》发行 ，并凭此专辑获第十五届音乐风云榜年度最受欢迎男歌手等奖项。同年7月31日—8月2日，2015火星演唱会在上海大舞台连开三场。12月，发行第二张专辑《异类》。 2016年7-9月，2016火星演唱会相继在北上深三个城市举办。9月27日，出席亚洲新歌榜2016年度盛典，揽获最佳男歌手奖。10月，加盟东方卫视《天籁之战》。12月2日，获2016MAMA亚洲最佳艺人奖。2017年3月14日，专辑《H》发行。', 'http://localhost:8088/singerimg/huachenyu.jpg', '中国');
INSERT INTO `singer` VALUES (6, '陈奕迅', '著名实力派粤语流行音乐歌手、演员，香港演艺人协会副会长之一，曾被美国《时代杂志》形容为影响香港乐坛风格的人物，同时也是继许冠杰、张学友之后第三个获得“歌神”称号的香港男歌手。同时他也是继张学友后另一个在台湾获得成功的香港歌手，在2003年他成为了第二个拿到台湾金曲奖“最佳国语男演唱人”的香港歌手。陈奕迅曾被《时代》杂志形容为影响香港乐坛风格的人物。2010年，陈奕迅入选全球华人音乐殿堂华语金曲奖“30年经典评选”，成为1990年代出道歌手唯一代表。陈奕迅曾在多个亚太地区获得多个奖项和提名，包括香港地区的“叱咤乐坛男歌手金奖”、“叱咤乐坛我最喜爱的男歌手奖”、“十大劲歌金曲最受欢迎男歌星奖”。代表作品：《爱情转移》、《十年》、《浮夸》、《K歌之王》。', 'http://localhost:8088/singerimg/chenyixun.jpg', '中国香港');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userid` int NOT NULL AUTO_INCREMENT,
  `rowid` int NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `birth` date NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1, 'admin', '123456', '男', '1994-01-12');
INSERT INTO `user` VALUES (2, 0, 'abc', '123456', '女', '2000-04-12');
INSERT INTO `user` VALUES (3, 0, 'user', '123456', '女', '1992-02-01');

SET FOREIGN_KEY_CHECKS = 1;
