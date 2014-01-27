# MySQL-Front 5.0  (Build 1.0)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: 127.0.0.1    Database: phonelibv2test
# ------------------------------------------------------
# Server version 5.5.27

DROP DATABASE IF EXISTS `phonelibv2test`;
CREATE DATABASE `phonelibv2test` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `phonelibv2test`;

#
# Table structure for table book
#

CREATE TABLE `book` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `category_id` bigint(20) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `isbn13` varchar(255) NOT NULL,
  `pubdate` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2E3AE99D986995` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
INSERT INTO `book` VALUES (1,1,'',31,'','9787111187776','','','','算法导论');
INSERT INTO `book` VALUES (2,1,'',19,'','9787512500983','','','','1988：我想和这个世界谈谈');
INSERT INTO `book` VALUES (3,1,'',19,'','9787208061644','','','','追风筝的人');
INSERT INTO `book` VALUES (4,1,'',19,'','9787544253994','','','','百年孤独');
INSERT INTO `book` VALUES (5,1,'',19,'','9787561339121','','','','杜拉拉升职记');
INSERT INTO `book` VALUES (6,1,'',19,'','9787532725694','','','','挪威的森林');
INSERT INTO `book` VALUES (7,1,'',21,'','9787505722460','','','','明朝那些事儿（壹）');
INSERT INTO `book` VALUES (8,1,'',19,'','9787532756728','','','','江城');
INSERT INTO `book` VALUES (9,1,'',19,'','9787208050037','','','','达·芬奇密码');
INSERT INTO `book` VALUES (10,1,'',19,'','9787536692930','','','','三体');
INSERT INTO `book` VALUES (11,1,'',19,'','9787532731077','','','','不能承受的生命之轻');
INSERT INTO `book` VALUES (12,1,'',19,'','9787020024759','','','','围城');
INSERT INTO `book` VALUES (13,1,'',29,'','9787542629586','','','','民主的细节');
INSERT INTO `book` VALUES (14,1,'',19,'','9787805508405','','','','独唱团（第一辑）');
INSERT INTO `book` VALUES (15,1,'',22,'','9787508630069','','','','史蒂夫·乔布斯传');
INSERT INTO `book` VALUES (16,1,'',31,'','9787121100529','','','','妙解Hibernate 3.x');
INSERT INTO `book` VALUES (17,1,'',31,'','9787302185659','','','','数值分析');
INSERT INTO `book` VALUES (18,1,'',31,'','9787040195835','','','','数据库系统概论');
INSERT INTO `book` VALUES (19,0,NULL,19,NULL,'9787115230270',NULL,NULL,NULL,'Python基础教程');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table borrow
#

CREATE TABLE `borrow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `borrow_status` int(11) NOT NULL,
  `borrower_id` bigint(20) NOT NULL,
  `borrower_ack` bit(1) NOT NULL,
  `date_back` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `owner_ack` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAD8CA9F5EAACA335` (`book_id`),
  KEY `FKAD8CA9F5DCF35139` (`borrower_id`),
  KEY `FKAD8CA9F54B481E48` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `borrow` VALUES (1,0,19,2,7,b'0','2014-03-28 12:39:05','2014-01-27 12:39:06',4,b'0');
/*!40000 ALTER TABLE `borrow` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table category
#

CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `cname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
INSERT INTO `category` VALUES (19,19,'小说');
INSERT INTO `category` VALUES (21,1,'文学');
INSERT INTO `category` VALUES (22,2,'传记');
INSERT INTO `category` VALUES (23,1,'艺术');
INSERT INTO `category` VALUES (24,0,'励志与成功');
INSERT INTO `category` VALUES (25,0,'管理');
INSERT INTO `category` VALUES (26,0,'经济');
INSERT INTO `category` VALUES (27,0,'旅游/地图');
INSERT INTO `category` VALUES (28,0,'心理学');
INSERT INTO `category` VALUES (29,1,'政治/军事');
INSERT INTO `category` VALUES (31,6,'教育');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table internal_message
#

CREATE TABLE `internal_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `borrow_id` bigint(20) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `message` varchar(255) NOT NULL,
  `recipient_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `statue` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDCDA6085EA11AF86` (`sender_id`),
  KEY `FKDCDA608533849D22` (`recipient_id`),
  KEY `FKDCDA60859D9E9CF5` (`borrow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `internal_message` VALUES (1,1,1,'2014-01-27 12:39:06','浣犲ソ锛屾垜鎯冲�闃呬綘鐨勩�Python基础教程銆嬭繖鏈功銆�',4,7,b'0');
/*!40000 ALTER TABLE `internal_message` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table own
#

CREATE TABLE `own` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `book_status` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1AF86EAACA335` (`book_id`),
  KEY `FK1AF86DF616E30` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
INSERT INTO `own` VALUES (1,0,19,0,'2014-01-27 12:37:40',4);
/*!40000 ALTER TABLE `own` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table shiro_role
#

CREATE TABLE `shiro_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
INSERT INTO `shiro_role` VALUES (1,1,'ROLE_ADMIN');
INSERT INTO `shiro_role` VALUES (2,6,'ROLE_USER');
/*!40000 ALTER TABLE `shiro_role` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table shiro_role_permissions
#

CREATE TABLE `shiro_role_permissions` (
  `shiro_role_id` bigint(20) DEFAULT NULL,
  `permissions_string` varchar(255) DEFAULT NULL,
  KEY `FK389B46C92FFB3E02` (`shiro_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40000 ALTER TABLE `shiro_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table shiro_role_users
#

CREATE TABLE `shiro_role_users` (
  `shiro_user_id` bigint(20) NOT NULL,
  `shiro_role_id` bigint(20) NOT NULL,
  KEY `FKB3D7380DD52601E2` (`shiro_user_id`),
  KEY `FKB3D7380D2FFB3E02` (`shiro_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40000 ALTER TABLE `shiro_role_users` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table shiro_user
#

CREATE TABLE `shiro_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `btouxiang` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mtouxiang` varchar(255) DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `password_hash` varchar(70) NOT NULL,
  `province` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `stouxiang` varchar(255) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `weibo` varchar(255) DEFAULT NULL,
  `weixin` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
INSERT INTO `shiro_user` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,'5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,NULL,NULL,NULL,NULL,'admin',NULL,NULL);
INSERT INTO `shiro_user` VALUES (2,1,NULL,NULL,NULL,NULL,NULL,'5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,NULL,NULL,NULL,NULL,'joe',NULL,NULL);
INSERT INTO `shiro_user` VALUES (3,1,NULL,NULL,NULL,NULL,NULL,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,NULL,NULL,NULL,NULL,'knight0',NULL,NULL);
INSERT INTO `shiro_user` VALUES (4,3,'D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\4\\3\\1390797376390_162.jpg','长春','dfgdf@qq.com','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\4\\3\\1390797376390_48.jpg','fgfg','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','吉林','dsfsfds','fdgdfg','2','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\4\\3\\1390797376390_20.jpg','knight1','dfsfds','dsfdsfsd');
INSERT INTO `shiro_user` VALUES (5,1,NULL,NULL,NULL,NULL,NULL,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,NULL,NULL,NULL,NULL,'knight2',NULL,NULL);
INSERT INTO `shiro_user` VALUES (6,1,NULL,NULL,NULL,NULL,NULL,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,NULL,NULL,NULL,NULL,'knight3',NULL,NULL);
INSERT INTO `shiro_user` VALUES (7,2,NULL,'济南','dsfasfwjhg83337@qq.com',NULL,'jkhkgh','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','山东','hhf','dsfsdfsdfs','1',NULL,'zyk1','dfsdfs','rtre');
/*!40000 ALTER TABLE `shiro_user` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table shiro_user_permissions
#

CREATE TABLE `shiro_user_permissions` (
  `shiro_user_id` bigint(20) DEFAULT NULL,
  `permissions_string` varchar(255) DEFAULT NULL,
  KEY `FK34555A9ED52601E2` (`shiro_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40000 ALTER TABLE `shiro_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table shiro_user_roles
#

CREATE TABLE `shiro_user_roles` (
  `shiro_role_id` bigint(20) NOT NULL,
  `shiro_user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`shiro_user_id`,`shiro_role_id`),
  KEY `FKBA221057D52601E2` (`shiro_user_id`),
  KEY `FKBA2210572FFB3E02` (`shiro_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `shiro_user_roles` VALUES (1,1);
INSERT INTO `shiro_user_roles` VALUES (2,2);
INSERT INTO `shiro_user_roles` VALUES (2,3);
INSERT INTO `shiro_user_roles` VALUES (2,4);
INSERT INTO `shiro_user_roles` VALUES (2,5);
INSERT INTO `shiro_user_roles` VALUES (2,6);
INSERT INTO `shiro_user_roles` VALUES (2,7);
/*!40000 ALTER TABLE `shiro_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

#
#  Foreign keys for table book
#

ALTER TABLE `book`
ADD CONSTRAINT `FK2E3AE99D986995` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

#
#  Foreign keys for table borrow
#

ALTER TABLE `borrow`
ADD CONSTRAINT `FKAD8CA9F54B481E48` FOREIGN KEY (`owner_id`) REFERENCES `shiro_user` (`id`),
  ADD CONSTRAINT `FKAD8CA9F5DCF35139` FOREIGN KEY (`borrower_id`) REFERENCES `shiro_user` (`id`),
  ADD CONSTRAINT `FKAD8CA9F5EAACA335` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`);

#
#  Foreign keys for table internal_message
#

ALTER TABLE `internal_message`
ADD CONSTRAINT `FKDCDA60859D9E9CF5` FOREIGN KEY (`borrow_id`) REFERENCES `borrow` (`id`),
  ADD CONSTRAINT `FKDCDA608533849D22` FOREIGN KEY (`recipient_id`) REFERENCES `shiro_user` (`id`),
  ADD CONSTRAINT `FKDCDA6085EA11AF86` FOREIGN KEY (`sender_id`) REFERENCES `shiro_user` (`id`);

#
#  Foreign keys for table own
#

ALTER TABLE `own`
ADD CONSTRAINT `FK1AF86DF616E30` FOREIGN KEY (`user_id`) REFERENCES `shiro_user` (`id`),
  ADD CONSTRAINT `FK1AF86EAACA335` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`);

#
#  Foreign keys for table shiro_role_permissions
#

ALTER TABLE `shiro_role_permissions`
ADD CONSTRAINT `FK389B46C92FFB3E02` FOREIGN KEY (`shiro_role_id`) REFERENCES `shiro_role` (`id`);

#
#  Foreign keys for table shiro_role_users
#

ALTER TABLE `shiro_role_users`
ADD CONSTRAINT `FKB3D7380D2FFB3E02` FOREIGN KEY (`shiro_role_id`) REFERENCES `shiro_role` (`id`),
  ADD CONSTRAINT `FKB3D7380DD52601E2` FOREIGN KEY (`shiro_user_id`) REFERENCES `shiro_user` (`id`);

#
#  Foreign keys for table shiro_user_permissions
#

ALTER TABLE `shiro_user_permissions`
ADD CONSTRAINT `FK34555A9ED52601E2` FOREIGN KEY (`shiro_user_id`) REFERENCES `shiro_user` (`id`);

#
#  Foreign keys for table shiro_user_roles
#

ALTER TABLE `shiro_user_roles`
ADD CONSTRAINT `FKBA2210572FFB3E02` FOREIGN KEY (`shiro_role_id`) REFERENCES `shiro_role` (`id`),
  ADD CONSTRAINT `FKBA221057D52601E2` FOREIGN KEY (`shiro_user_id`) REFERENCES `shiro_user` (`id`);


/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
