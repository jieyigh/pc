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
-- Table structure for table `pc_site_config`
--

DROP TABLE IF EXISTS `pc_site_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_site_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `memo` varchar(50) DEFAULT NULL,
  `money_url` varchar(100) DEFAULT NULL COMMENT '钱包中心url',
  `money_key` varchar(50) DEFAULT NULL,
  `transfer_url` varchar(100) DEFAULT NULL COMMENT '转账url',
  `transfer_hash_code` varchar(50) DEFAULT NULL,
  `transfer_keyb` varchar(50) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL COMMENT '50:启用, -50:禁用',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `keyb` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_site_id` (`site_id`),
  KEY `index_state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_site_config`
--

LOCK TABLES `pc_site_config` WRITE;
/*!40000 ALTER TABLE `pc_site_config` DISABLE KEYS */;
INSERT INTO `pc_site_config` VALUES (1,99999,'pc测试站','http://172.25.254.6:9027/kg-money-api','ds_money_key','http://10.0.1.129:19007/dsapi/index','dsggtgjhjk','qqqq',50,'2016-10-18 22:48:55','2016-10-19 02:50:25','qqqq'),(2,99998,'','http://172.25.254.6:9027/kg-money-api','ds_money_key','http://10.0.1.129:19007/dsapi/index','dsggtgjhjk','qqqq',50,'2016-11-10 19:34:57','2016-11-11 07:35:28',NULL),(4,8000,'PC','http://172.25.254.6:9027/kg-money-api','ds_money_key','http://10.0.1.129:19007/dsapi/index','dsggtgjhjk','qqqq',50,'2017-02-22 10:33:45',NULL,'qqqq'),(10,8001,'pc8001',NULL,NULL,NULL,NULL,NULL,50,'2017-03-04 08:55:09',NULL,'qqqq'),(13,8002,'pc8002',NULL,NULL,NULL,NULL,NULL,50,'2017-03-04 08:58:13',NULL,'qqqq'),(16,8003,'pc8003',NULL,NULL,NULL,NULL,NULL,50,'2017-03-04 09:08:48',NULL,'qqqq');
/*!40000 ALTER TABLE `pc_site_config` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-06  5:12:54
