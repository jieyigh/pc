-- MySQL dump 10.15  Distrib 10.0.28-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.0.28-MariaDB-wsrep

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pc_table_config`
--

DROP TABLE IF EXISTS `pc_table_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_table_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL COMMENT '房间号',
  `state` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL COMMENT '1:普通房; 2:高级房; 3:VIP房',
  `game_type` varchar(20) DEFAULT NULL COMMENT 'xy28, keno28',
  `memo1` varchar(20) DEFAULT NULL,
  `memo2` varchar(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_table_config`
--

LOCK TABLES `pc_table_config` WRITE;
/*!40000 ALTER TABLE `pc_table_config` DISABLE KEYS */;
INSERT INTO `pc_table_config` VALUES (1,'普通房1',1,50,1,'xy28','一触千金','PUTONG ROOM','2016-10-19 02:54:28','2017-01-11 21:11:41'),(2,'高级房2',1,50,2,'xy28','火爆开启','GAOJING ROOM','2016-10-19 02:54:30','2017-01-11 21:00:13'),(3,'VIP房3',1,50,3,'xy28','见证奇迹彩金','VIP ROOM','2016-10-19 02:54:33','2017-01-11 21:00:08'),(4,'普通房1',2,50,1,'keno28','好运连连发','PUTONG ROOM','2016-10-19 02:55:12','2017-01-11 19:47:37'),(5,'高级房2',2,50,2,'keno28','优惠大放送','GAOJING ROOM','2016-10-19 02:55:14','2017-01-11 19:47:50'),(6,'VIP房',2,50,3,'keno28','尊享超级特权','VIP ROOM','2016-10-19 02:55:16','2017-01-11 19:48:02'),(7,'普通房',3,50,1,'cq28','一触千金','PUTONG ROOM','2016-10-19 02:54:28',NULL),(8,'高级房',3,50,2,'cq28','火爆开启','GAOJING ROOM','2016-10-19 02:54:30',NULL),(9,'VIP房',3,50,3,'cq28','见证奇迹','VIP ROOM','2016-10-19 02:54:33',NULL),(10,'普通房',4,50,1,'xj28','好运连连发','PUTONG ROOM','2016-10-19 02:55:12','2017-01-11 20:59:19'),(11,'高级房',4,50,2,'xj28','优惠大放送','GAOJING ROOM','2016-10-19 02:55:14',NULL),(12,'VIP房',4,50,3,'xj28','尊享超级特权','VIP ROOM','2016-10-19 02:55:16','2017-01-10 18:54:08'),(16,'普通房',7,50,1,'xy28','asdf','putong','2017-02-22 12:01:18','2017-02-23 05:47:26'),(19,'高级房123',7,-50,2,'keno28','gaoji','GAOJI','2017-02-23 02:03:51','2017-03-03 08:23:13'),(22,'贵宾房',7,-50,1,'xy28','见证奇迹','guibing','2017-02-23 05:57:41','2017-02-27 07:24:00'),(25,'高级房',7,50,2,'xy28','火爆开启','高级','2017-02-23 08:05:20','2017-02-23 08:24:45'),(28,'贵宾房',7,50,3,'xy28','见证奇迹','贵宾','2017-02-23 09:29:22',NULL),(31,'普通房',10,50,1,'keno28','好运连连发','普通','2017-02-23 09:33:37','2017-02-23 09:34:25'),(34,'高级房',10,50,2,'keno28','优惠大放送','高级','2017-02-23 09:34:49',NULL),(37,'贵宾房',10,50,3,'keno28','尊享超级特权','贵宾','2017-02-23 09:35:23',NULL),(40,'普通房',13,50,1,'cq28','一触千金','普通','2017-02-23 09:36:35',NULL),(43,'高级房',13,50,2,'cq28','火爆开启','高级','2017-02-23 09:37:03',NULL),(46,'贵宾房',13,50,3,'cq28','见证奇迹','贵宾','2017-02-23 09:37:40',NULL),(49,'普通房',16,50,1,'xj28','好运连连发','putong','2017-02-25 03:27:39',NULL),(52,'高级房',16,50,2,'xj28','优惠大放送','gaoji','2017-02-25 03:28:22',NULL),(55,'贵宾房',16,50,3,'xj28','尊享超级特权','viproom','2017-02-25 03:30:42',NULL);
/*!40000 ALTER TABLE `pc_table_config` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-06  5:13:35
