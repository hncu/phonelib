# MySQL-Front 5.0  (Build 1.0)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: 127.0.0.1    Database: phonelibv2
# ------------------------------------------------------
# Server version 5.5.27

DROP DATABASE IF EXISTS `phonelibv2`;
CREATE DATABASE `phonelibv2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `phonelibv2`;

#
# Table structure for table book
#

CREATE TABLE `book` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `isbn13` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2E3AE99D986995` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
INSERT INTO `book` VALUES (1,1,31,'9787111187776','算法导论');
INSERT INTO `book` VALUES (2,1,19,'9787512500983','1988：我想和这个世界谈谈');
INSERT INTO `book` VALUES (3,1,19,'9787208061644','追风筝的人');
INSERT INTO `book` VALUES (4,1,19,'9787544253994','百年孤独');
INSERT INTO `book` VALUES (5,1,19,'9787561339121','杜拉拉升职记');
INSERT INTO `book` VALUES (6,1,19,'9787532725694','挪威的森林');
INSERT INTO `book` VALUES (7,1,21,'9787505722460','明朝那些事儿（壹）');
INSERT INTO `book` VALUES (8,1,19,'9787532756728','江城');
INSERT INTO `book` VALUES (9,1,19,'9787208050037','达·芬奇密码');
INSERT INTO `book` VALUES (10,1,19,'9787536692930','三体');
INSERT INTO `book` VALUES (11,1,19,'9787532731077','不能承受的生命之轻');
INSERT INTO `book` VALUES (12,1,19,'9787020024759','围城');
INSERT INTO `book` VALUES (13,1,29,'9787542629586','民主的细节');
INSERT INTO `book` VALUES (14,1,19,'9787805508405','独唱团（第一辑）');
INSERT INTO `book` VALUES (15,1,22,'9787508630069','史蒂夫·乔布斯传');
INSERT INTO `book` VALUES (16,1,31,'9787121100529','妙解Hibernate 3.x');
INSERT INTO `book` VALUES (17,1,31,'9787302185659','数值分析');
INSERT INTO `book` VALUES (18,1,31,'9787040195835','数据库系统概论');
INSERT INTO `book` VALUES (19,1,19,'9787550007161','青少年');
INSERT INTO `book` VALUES (20,1,19,'9787533937256','活着活着就老了');
INSERT INTO `book` VALUES (21,1,19,'9787544268417','没有色彩的多崎作和他的巡礼之年');
INSERT INTO `book` VALUES (23,1,22,'9787549544004','站在两个世界的边缘');
INSERT INTO `book` VALUES (24,1,19,'9787544745741','幸福过了头');
INSERT INTO `book` VALUES (25,1,23,'9787539966755','原谅我一生不羁放纵爱自由');
INSERT INTO `book` VALUES (26,1,19,'9787544726900','永别了，武器');
INSERT INTO `book` VALUES (27,5,19,'9787201066660','长安乱');
INSERT INTO `book` VALUES (29,1,31,'9787544715775','现代性的后果');
INSERT INTO `book` VALUES (30,1,19,'9787515508023','移民');
INSERT INTO `book` VALUES (31,0,31,'9787111213826','Java编程思想 （第4版）');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table borrow
#

CREATE TABLE `borrow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `borrower_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `owner_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAD8CA9F5EAACA335` (`book_id`),
  KEY `FKAD8CA9F5DCF35139` (`borrower_id`),
  KEY `FKAD8CA9F54B481E48` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
INSERT INTO `borrow` VALUES (1,1,1,4,'2013-11-16 20:10:30',5);
INSERT INTO `borrow` VALUES (2,0,2,5,'2013-11-16 20:10:30',4);
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
INSERT INTO `category` VALUES (19,18,'小说');
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
  `date_created` datetime NOT NULL,
  `message` varchar(255) NOT NULL,
  `recipient_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `statue` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDCDA6085EA11AF86` (`sender_id`),
  KEY `FKDCDA608533849D22` (`recipient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
INSERT INTO `internal_message` VALUES (1,1,'2013-11-17 15:41:38','你好啊，我想借你的一本书',4,1,b'0');
INSERT INTO `internal_message` VALUES (2,1,'2013-11-17 15:46:24','最近过的可好。',4,1,b'0');
/*!40000 ALTER TABLE `internal_message` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table own
#

CREATE TABLE `own` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `book_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1AF86EAACA335` (`book_id`),
  KEY `FK1AF86DF616E30` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
INSERT INTO `own` VALUES (1,1,1,'2013-11-17 16:00:19',5);
INSERT INTO `own` VALUES (3,0,29,'2013-11-17 17:34:14',4);
INSERT INTO `own` VALUES (4,0,30,'2013-11-17 17:35:12',6);
INSERT INTO `own` VALUES (5,0,1,'2013-11-17 17:49:31',3);
INSERT INTO `own` VALUES (6,0,2,'2013-11-17 17:49:38',3);
INSERT INTO `own` VALUES (7,0,4,'2013-11-17 17:49:47',4);
INSERT INTO `own` VALUES (8,0,5,'2013-11-17 17:49:54',4);
INSERT INTO `own` VALUES (9,0,6,'2013-11-17 17:50:02',5);
INSERT INTO `own` VALUES (10,0,7,'2013-11-17 17:50:09',5);
INSERT INTO `own` VALUES (11,0,8,'2013-11-17 17:50:17',6);
INSERT INTO `own` VALUES (12,0,9,'2013-11-17 17:50:25',5);
INSERT INTO `own` VALUES (14,0,10,'2013-11-17 17:51:35',4);
INSERT INTO `own` VALUES (15,0,11,'2013-11-17 17:51:42',6);
INSERT INTO `own` VALUES (16,0,12,'2013-11-17 17:51:49',5);
INSERT INTO `own` VALUES (17,0,13,'2013-11-17 17:51:57',6);
INSERT INTO `own` VALUES (18,0,14,'2013-11-17 17:52:04',3);
INSERT INTO `own` VALUES (19,0,15,'2013-11-17 17:52:11',4);
INSERT INTO `own` VALUES (20,0,16,'2013-11-17 17:52:21',4);
INSERT INTO `own` VALUES (21,0,17,'2013-11-17 17:52:27',3);
INSERT INTO `own` VALUES (22,0,18,'2013-11-17 17:52:34',5);
INSERT INTO `own` VALUES (23,0,19,'2013-11-17 17:52:40',5);
INSERT INTO `own` VALUES (24,0,20,'2013-11-17 17:52:48',6);
INSERT INTO `own` VALUES (25,0,21,'2013-11-17 17:52:54',4);
INSERT INTO `own` VALUES (26,0,23,'2013-11-17 17:53:02',4);
INSERT INTO `own` VALUES (27,0,24,'2013-11-17 17:53:10',6);
INSERT INTO `own` VALUES (28,0,25,'2013-11-17 17:53:18',6);
INSERT INTO `own` VALUES (29,0,26,'2013-11-17 17:53:26',3);
INSERT INTO `own` VALUES (30,0,27,'2013-11-17 17:53:40',6);
INSERT INTO `own` VALUES (31,0,29,'2013-11-17 17:53:48',4);
INSERT INTO `own` VALUES (32,0,30,'2013-11-17 17:53:54',4);
INSERT INTO `own` VALUES (33,0,31,'2013-11-17 17:54:03',6);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
INSERT INTO `shiro_role` VALUES (1,1,'ROLE_ADMIN');
INSERT INTO `shiro_role` VALUES (2,48,'ROLE_USER');
INSERT INTO `shiro_role` VALUES (3,1,'2');
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
  `password_hash` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `btouxiang` varchar(255) DEFAULT NULL,
  `mtouxiang` varchar(255) DEFAULT NULL,
  `stouxiang` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
INSERT INTO `shiro_user` VALUES (1,1,'5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','admin','aaa1@qq.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (3,1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','knight0','aaa3@qq.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (4,16,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','knight1','aaa4@qq.com','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\2\\7\\1385368798112_162.jpg','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\2\\7\\1385368798112_48.jpg','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\2\\7\\1385368798112_20.jpg');
INSERT INTO `shiro_user` VALUES (5,4,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','knight2','aaa5@qq.com','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\6\\5\\1385372124417_162.jpg','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\6\\5\\1385372124417_48.jpg','D:\\workspace-ggts\\phonelibV2\\web-app\\images\\touxiang\\6\\5\\1385372124417_20.jpg');
INSERT INTO `shiro_user` VALUES (6,2,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','knight3','aaa6@qq.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (14,1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','knight4','4545454@129.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (15,1,'6b51d431df5d7f141cbececcf79edf3dd861c3b4069f0b11661a3eefacbba918','knight5','564313213@qq.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (16,1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','kngiht6','984564564@qq.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (17,0,'6b51d431df5d7f141cbececcf79edf3dd861c3b4069f0b11661a3eefacbba918','knight7','465465465132@qq.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (18,1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','knight8','89465456@qq.com',NULL,NULL,NULL);
INSERT INTO `shiro_user` VALUES (19,1,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','knight9','464654654@qq.com',NULL,NULL,NULL);
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
INSERT INTO `shiro_user_roles` VALUES (2,3);
INSERT INTO `shiro_user_roles` VALUES (2,4);
INSERT INTO `shiro_user_roles` VALUES (2,5);
INSERT INTO `shiro_user_roles` VALUES (2,6);
INSERT INTO `shiro_user_roles` VALUES (2,14);
INSERT INTO `shiro_user_roles` VALUES (2,15);
INSERT INTO `shiro_user_roles` VALUES (2,16);
INSERT INTO `shiro_user_roles` VALUES (2,18);
INSERT INTO `shiro_user_roles` VALUES (2,19);
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
