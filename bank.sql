-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: bank
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `card` varchar(50) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `sex` varchar(10) NOT NULL DEFAULT '性别不详',
  `money` decimal(10,2) DEFAULT '10.00',
  `open_date` datetime DEFAULT NULL,
  `old_pay_password` varchar(30) NOT NULL,
  `new_pay_password` varchar(30) DEFAULT NULL,
  `isDelete` tinyint(4) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`card`),
  UNIQUE KEY `card_2` (`card`),
  KEY `card` (`card`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'3989441357','pyd123','男',1319.00,'2020-01-08 15:56:14','123456','703815',1,'609615170@qq.com'),(4,'8776028356','pyd1234','男',710.00,'2020-01-09 08:16:38','123456','666666',1,'609615171@qq.com'),(5,'4911850326','pyd1234','男',710.00,'2020-01-09 08:37:51','123456','666666',1,'609615171@qq.com'),(6,'6840548499','lwl123','男',800.00,'2020-01-09 08:43:07','123456','666666',1,'2272062762@qq.com'),(7,'6541986539','lwl123','男',800.00,'2020-01-09 08:49:13','123456','666666',0,'2272062762@qq.com'),(8,'1060117211','lwl1234','男',800.00,'2020-01-09 11:14:10','123456','666666',0,'1002214478@qq.com'),(9,'7728261527','lcy123','男',600.00,'2020-01-09 11:22:53','123456','666666',0,'183917024@qq.com'),(10,'6660994586','wxb123','女',200.00,'2020-01-12 23:47:15','123456','111111',0,'11111@qq.com'),(11,'2312105813','psh123','男',11200.00,'2020-01-16 22:34:12','123456','666666',0,'1554606188@qq.com'),(12,'4184392227','llw123','男',0.00,'2020-06-12 09:43:29','123456','666666',0,'100861@qq.com'),(13,'2940207924','zjd123','男',1000.00,'2020-06-12 10:21:05','123456','666666',0,'2224940076@qq.com'),(14,'5508622740','pyd123','男',2419.00,'2020-06-12 10:29:08','123456','703815',0,'609615170@qq.com'),(15,'8937997735','xyf123','男',2200.00,'2021-03-31 22:52:57','123456','980601',0,'10086@sina.com'),(16,'4131517661','dgw123','女',3239.00,'2021-04-07 21:26:57','666666','703815',0,'12345678@qq.com'),(18,'1266773863','wgqwgq','男',8000.00,'2021-04-13 11:18:09','123456','666666',1,'2048098145@qq.com'),(19,'1086840371','wgqwgq','男',8000.00,'2021-04-13 11:31:23','123456','666666',0,'2048098145@qq.com'),(23,'1133215336','潘昱东','男',2010.00,'2021-04-16 18:49:42','123456','703815',0,'13766874210@qq.com'),(24,'7006666356','pyd1234','男',710.00,'2021-04-16 21:29:52','123456','666666',1,'609615171@qq.com'),(25,'9571451659','pyd1234','男',710.00,'2021-04-16 21:30:45','123456','666666',1,'609615171@qq.com'),(26,'4505980184','pyd1234','男',710.00,'2021-04-16 21:31:45','123456','666666',0,'609615171@qq.com');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposit`
--

DROP TABLE IF EXISTS `deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `save_card` varchar(30) NOT NULL,
  `save_money` int(11) NOT NULL,
  `save_way` varchar(30) NOT NULL,
  `save_arrive` int(11) DEFAULT '0',
  `save_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposit`
--

LOCK TABLES `deposit` WRITE;
/*!40000 ALTER TABLE `deposit` DISABLE KEYS */;
INSERT INTO `deposit` VALUES (1,'3989441357',110,'定期3秒',1,'2020-01-09 00:30:17'),(2,'3989441357',110,'定期3秒',1,'2020-01-09 00:32:14'),(3,'3989441357',110,'定期3秒',1,'2020-01-09 00:35:04'),(4,'3989441357',100,'定期3秒',1,'2020-01-09 00:37:38'),(5,'3989441357',110,'定期3秒',1,'2020-01-09 00:44:24'),(6,'3989441357',110,'定期3秒',1,'2020-01-09 00:45:27'),(7,'3989441357',110,'定期3秒',1,'2020-01-09 00:46:33'),(8,'3989441357',1100,'定期3秒',1,'2020-01-09 00:48:41'),(9,'3989441357',110,'定期3秒',1,'2020-01-09 00:54:19'),(10,'3989441357',110,'定期3秒',1,'2020-01-09 00:59:52'),(11,'3989441357',150,'定期1分',1,'2020-01-09 01:14:42'),(12,'0436953948',1559,'活期存款',1,'2020-01-09 01:54:12'),(13,'0436953948',100,'定期1分',1,'2020-01-09 01:58:23'),(15,'8776028356',100,'定期1分',1,'2020-01-09 08:33:07'),(16,'6840548499',10,'定期3秒',1,'2020-01-09 08:46:18'),(17,'1060117211',110,'定期3秒',1,'2020-01-09 11:17:38'),(18,'7728261527',110,'定期3秒',1,'2020-01-09 11:25:10'),(19,'6660994586',1100,'定期3秒',1,'2020-01-13 00:00:46'),(21,'3989441357',10,'定期3秒',1,'2020-06-11 16:27:38'),(22,'7728261527',20000,'定期1小时',1,'2020-06-11 17:51:17'),(23,'3989441357',1,'定期3秒',1,'2020-06-12 10:09:27'),(24,'2940207924',10,'定期3秒',1,'2020-06-12 10:25:00'),(25,'4911850326',150,'定期1分',1,'2021-03-05 15:27:03'),(28,'4131517661',3,'定期3秒',1,'2021-04-10 17:09:42'),(30,'1266773863',3414,'活期存款',1,'2021-04-13 11:25:07'),(31,'4131517661',220,'定期3秒',1,'2021-04-16 11:21:33'),(32,'1133215336',110,'定期3秒',1,'2021-04-16 20:01:41'),(33,'1133215336',110,'定期3秒',1,'2021-04-16 20:02:59');
/*!40000 ALTER TABLE `deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card` varchar(50) NOT NULL,
  `deal` int(11) NOT NULL DEFAULT '0',
  `msg` varchar(50) DEFAULT NULL,
  `deal_time` datetime NOT NULL,
  PRIMARY KEY (`id`,`card`),
  KEY `card_fk` (`card`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'3989441357',100,'定期3秒存款','2020-01-09 00:30:17'),(2,'3989441357',100,'定期3秒存款','2020-01-09 00:32:14'),(3,'3989441357',100,'定期3秒存款','2020-01-09 00:35:04'),(4,'3989441357',100,'定期3秒存款','2020-01-09 00:37:38'),(5,'3989441357',10,'存款','2020-01-09 00:37:55'),(6,'3989441357',100,'存款','2020-01-09 00:38:54'),(7,'3989441357',100,'存款','2020-01-09 00:39:02'),(8,'3989441357',100,'定期3秒存款','2020-01-09 00:44:24'),(9,'3989441357',100,'定期3秒存款','2020-01-09 00:45:27'),(10,'3989441357',100,'定期3秒存款','2020-01-09 00:46:33'),(11,'3989441357',1000,'定期3秒存款','2020-01-09 00:48:41'),(12,'3989441357',100,'定期3秒存款','2020-01-09 00:54:19'),(13,'3989441357',100,'定期3秒存款','2020-01-09 00:59:52'),(14,'3989441357',100,'定期1分存款','2020-01-09 01:14:42'),(15,'0436953948',100,'存款','2020-01-09 01:51:42'),(16,'0436953948',100,'取款','2020-01-09 01:52:58'),(17,'0436953948',100,'转账','2020-01-09 01:53:51'),(18,'3989441357',100,'收款','2020-01-09 01:53:51'),(19,'0436953948',100,'活期存款','2020-01-09 01:54:12'),(20,'0436953948',50,'存款','2020-01-09 01:55:23'),(21,'0436953948',100,'定期1分存款','2020-01-09 01:58:23'),(22,'0436953948',50,'存款','2020-01-09 02:04:25'),(23,'8776028356',100,'存款','2020-01-09 08:17:51'),(24,'8776028356',100,'取款','2020-01-09 08:20:02'),(25,'8776028356',100,'转账','2020-01-09 08:21:10'),(26,'3989441357',100,'收款','2020-01-09 08:21:10'),(27,'8776028356',100,'定期3秒存款','2020-01-09 08:21:40'),(28,'8776028356',10,'存款','2020-01-09 08:23:10'),(29,'8776028356',50,'存款','2020-01-09 08:23:42'),(30,'8776028356',50,'存款','2020-01-09 08:24:56'),(31,'8776028356',200,'定期1分存款','2020-01-09 08:33:07'),(32,'8776028356',100,'存款','2020-01-09 08:34:20'),(33,'8776028356',100,'存款','2020-01-09 08:34:42'),(34,'6840548499',100,'存款','2020-01-09 08:44:52'),(35,'6840548499',100,'定期3秒存款','2020-01-09 08:46:18'),(36,'6840548499',100,'存款','2020-01-09 08:47:58'),(37,'1060117211',200,'存款','2020-01-09 11:15:25'),(38,'1060117211',100,'存款','2020-01-09 11:16:25'),(39,'1060117211',100,'定期3秒存款','2020-01-09 11:17:38'),(40,'7728261527',100,'存款','2020-01-09 11:23:45'),(41,'7728261527',100,'定期3秒存款','2020-01-09 11:25:10'),(42,'6660994586',100,'存款','2020-01-12 23:56:22'),(43,'6660994586',1000,'定期3秒存款','2020-01-13 00:00:46'),(44,'2312105813',100,'存款','2020-01-16 22:35:41'),(45,'2312105813',1000,'定期3秒存款','2020-01-16 22:39:45'),(46,'2312105813',100,'存款','2020-01-16 22:41:38'),(47,'2312105813',1000,'存款','2020-01-16 22:42:09'),(48,'3989441357',100,'定期3秒存款','2020-06-11 16:27:38'),(49,'3989441357',100,'存款','2020-06-11 16:30:06'),(50,'7728261527',1000000,'定期1小时存款','2020-06-11 17:51:17'),(51,'4184392227',100,'存款','2020-06-12 09:45:01'),(52,'4184392227',100,'取款','2020-06-12 09:46:45'),(53,'4184392227',100,'转账','2020-06-12 09:47:23'),(54,'3989441357',100,'收款','2020-06-12 09:47:23'),(55,'3989441357',100,'定期3秒存款','2020-06-12 10:09:27'),(56,'3989441357',100,'存款','2020-06-12 10:10:32'),(57,'3989441357',100,'转账','2020-06-12 10:12:52'),(58,'3989441357 ',100,'收款','2020-06-12 10:12:52'),(59,'3989441357',9,'存款','2020-06-12 10:14:34'),(60,'2940207924',100,'存款','2020-06-12 10:22:37'),(61,'2940207924',100,'取款','2020-06-12 10:23:50'),(62,'2940207924',100,'转账','2020-06-12 10:24:27'),(63,'3989441357',100,'收款','2020-06-12 10:24:27'),(64,'2940207924',100,'定期3秒存款','2020-06-12 10:25:00'),(65,'2940207924',100,'存款','2020-06-12 10:26:24'),(66,'4911850326',100,'定期1分存款','2021-03-05 15:27:03'),(67,'8937997735',100,'存款','2021-03-31 22:59:57'),(68,'8937997735',100,'存款','2021-03-31 23:01:27'),(69,'5508622740',100,'存款','2021-04-01 22:25:00'),(70,'4131517661',500,'存款','2021-04-07 21:27:54'),(71,'4131517661',100,'定期3秒存款','2021-04-07 21:29:50'),(72,'4131517661',1500,'活期存款','2021-04-07 21:31:12'),(73,'4131517661',1782,'存款','2021-04-07 21:32:16'),(74,'4131517661',100,'存款','2021-04-07 21:32:23'),(75,'4131517661',10,'存款','2021-04-07 21:32:28'),(76,'4131517661',1000,'转账','2021-04-07 21:33:46'),(77,'5508622740',1000,'收款','2021-04-07 21:33:46'),(78,'4131517661',100,'定期3秒存款','2021-04-10 17:09:42'),(79,'4131517661',100,'定期3秒存款','2021-04-13 11:02:07'),(80,'4131517661 ',100,'存款','2021-04-13 11:03:34'),(81,'4131517661 ',10,'存款','2021-04-13 11:03:41'),(82,'4131517661',100,'存款','2021-04-13 11:06:09'),(83,'1266773863',5000,'存款','2021-04-13 11:21:36'),(84,'1266773863',8000,'取款','2021-04-13 11:23:18'),(85,'1266773863',1000,'转账','2021-04-13 11:24:21'),(86,'8937997735 ',1000,'收款','2021-04-13 11:24:21'),(87,'1266773863',6000,'活期存款','2021-04-13 11:25:07'),(88,'1266773863',7000,'存款','2021-04-13 11:26:11'),(89,'4131517661',10,'存款','2021-04-14 12:47:47'),(90,'4131517661',50,'存款','2021-04-16 09:17:53'),(91,'4131517661',5,'存款','2021-04-16 09:23:15'),(92,'4131517661',5,'存款','2021-04-16 09:24:45'),(93,'4131517661',5,'存款','2021-04-16 09:27:58'),(94,'4131517661',5,'存款','2021-04-16 09:28:44'),(95,'4131517661',2,'存款','2021-04-16 09:35:01'),(96,'4131517661',2,'存款','2021-04-16 09:37:32'),(97,'4131517661',2,'存款','2021-04-16 09:51:53'),(98,'4131517661',2,'存款','2021-04-16 09:58:43'),(99,'4131517661',2,'存款','2021-04-16 09:59:09'),(100,'4131517661',2,'存款','2021-04-16 10:35:16'),(101,'4131517661',2,'存款','2021-04-16 10:35:30'),(102,'4131517661',2,'存款','2021-04-16 10:38:18'),(103,'4131517661',2,'存款','2021-04-16 10:55:21'),(104,'4131517661',2,'存款','2021-04-16 10:58:27'),(105,'4131517661',2,'存款','2021-04-16 11:07:19'),(106,'4131517661',2,'存款','2021-04-16 11:09:58'),(107,'4131517661',1,'存款','2021-04-16 11:10:17'),(108,'4131517661',2,'存款','2021-04-16 11:11:47'),(109,'4131517661',0,'存款','2021-04-16 11:12:48'),(110,'4131517661',0,'存款','2021-04-16 11:14:20'),(111,'4131517661',500,'定期3秒存款','2021-04-16 11:21:33'),(112,'4131517661',100,'存款','2021-04-16 11:23:05'),(113,'4131517661',50,'存款','2021-04-16 11:25:04'),(114,'4131517661',100,'存款','2021-04-16 12:56:50'),(115,'4131517661',20,'存款','2021-04-16 12:56:58'),(116,'4131517661',20,'存款','2021-04-16 12:59:21'),(117,'4131517661',20,'存款','2021-04-16 13:00:46'),(118,'4131517661',1,'存款','2021-04-16 13:01:08'),(119,'4131517661',19,'存款','2021-04-16 13:07:46'),(120,'1133215336',100,'存款','2021-04-16 18:52:33'),(121,'1133215336',100,'定期3秒存款','2021-04-16 20:01:41'),(122,'1133215336',100,'定期3秒存款','2021-04-16 20:02:59'),(123,'1133215336',100,'取款','2021-04-16 20:03:44'),(124,'1133215336',100,'转账','2021-04-16 20:05:19'),(125,'4131517661',100,'收款','2021-04-16 20:05:19'),(126,'1133215336',100,'定期3秒存款','2021-04-16 20:05:37'),(127,'1133215336',100,'存款','2021-04-16 20:06:44'),(128,'1133215336',10,'存款','2021-04-16 20:06:52'),(129,'4131517661',100,'存款','2021-05-12 21:48:15');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagination`
--

DROP TABLE IF EXISTS `pagination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagination` (
  `page` int(11) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagination`
--

LOCK TABLES `pagination` WRITE;
/*!40000 ALTER TABLE `pagination` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s`
--

DROP TABLE IF EXISTS `s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s` (
  `a` int(11) DEFAULT NULL,
  `c` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s`
--

LOCK TABLES `s` WRITE;
/*!40000 ALTER TABLE `s` DISABLE KEYS */;
/*!40000 ALTER TABLE `s` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `phonenumber` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `identification` varchar(30) NOT NULL,
  `region` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `identification` (`identification`),
  UNIQUE KEY `phonenumber` (`phonenumber`),
  UNIQUE KEY `username` (`username`,`email`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username_2` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','123456','15270706329','10086@qq.com','362123199907030056','江西赣州嘉定区'),(2,'pyd123','123456','10086100102','609615170@qq.com','360722199907030056','浙江杭州上城区'),(5,'pyd1234','123456','10086100105','609615171@qq.com','360722199907030051','浙江杭州上城区'),(6,'lwl123','123456','10086100106','2272062762@qq.com','111111111111111111','浙江杭州上城区'),(7,'lwl1234','123456','10086100107','1002214478@qq.com','362226199804270612','江西宜春袁州区'),(8,'lcy123','123456','10086100108','183917024@qq.com','362201199805270211','浙江杭州上城区'),(9,'wxb123','123456','10086100109','11111@qq.com','362123196710180028','江西赣州信丰县'),(10,'psh123','123456','10086100110','1554606188@qq.com','362123196603090035','江西赣州信丰县'),(11,'llw123','123456','10086100111','100861@qq.com','362226199804270613','浙江杭州上城区'),(12,'zjd123','123456','10086100112','2224940076@qq.com','362227199811103237','浙江杭州上城区'),(13,'xyf123','12345678','15870757785','10086@sina.com','12345678999999999X','江苏南京浦口区'),(14,'dgw123','123456','15270706327','12345678@qq.com','360722199910180038','四川绵阳涪城区'),(16,'wgqwgq','123456','18370312007','2048098145@qq.com','362322154642546512','浙江杭州上城区'),(17,'pyd124','123456','15277682456','123456@cn.com','123456999888777666','浙江杭州上城区'),(20,'潘昱东','123456','15270706328','13766874210@qq.com','360722199907030012','浙江杭州上城区');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-15 20:43:18