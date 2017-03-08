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
-- Table structure for table `pc_bet_play`
--

DROP TABLE IF EXISTS `pc_bet_play`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_play` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `game_type` varchar(20) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_game_type` (`game_type`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc_bet_play`
--

LOCK TABLES `pc_bet_play` WRITE;
/*!40000 ALTER TABLE `pc_bet_play` DISABLE KEYS */;
INSERT INTO `pc_bet_play` VALUES (1,'单','odd','xy28',NULL,NULL),(2,'双','even','xy28',NULL,NULL),(3,'大','big','xy28',NULL,NULL),(4,'小','small','xy28',NULL,NULL),(5,'大单','big_odd','xy28',NULL,NULL),(6,'小单','small_odd','xy28',NULL,NULL),(7,'大双','big_even','xy28',NULL,NULL),(8,'小双','small_even','xy28',NULL,NULL),(9,'单点','cao','xy28',0,27),(10,'极大','max','xy28',NULL,NULL),(11,'极小','min','xy28',NULL,NULL),(12,'顺子','straight','xy28',NULL,NULL),(13,'豹子','leopard','xy28',NULL,NULL),(14,'红波','red','xy28',NULL,NULL),(15,'蓝波','blue','xy28',NULL,NULL),(16,'绿波','green','xy28',NULL,NULL),(101,'单','odd','keno28',NULL,NULL),(102,'双','even','keno28',NULL,NULL),(103,'大','big','keno28',NULL,NULL),(104,'小','small','keno28',NULL,NULL),(105,'大单','big_odd','keno28',NULL,NULL),(106,'小单','small_odd','keno28',NULL,NULL),(107,'大双','big_even','keno28',NULL,NULL),(108,'小双','small_even','keno28',NULL,NULL),(109,'单点','cao','keno28',0,27),(110,'极大','max','keno28',NULL,NULL),(111,'极小','min','keno28',NULL,NULL),(112,'顺子','straight','keno28',NULL,NULL),(113,'豹子','leopard','keno28',NULL,NULL),(114,'红波','red','keno28',NULL,NULL),(115,'蓝波','blue','keno28',NULL,NULL),(116,'绿波','green','keno28',NULL,NULL),(201,'单','odd','cq28',NULL,NULL),(202,'双','even','cq28',NULL,NULL),(203,'大','big','cq28',NULL,NULL),(204,'小','small','cq28',NULL,NULL),(205,'大单','big_odd','cq28',NULL,NULL),(206,'小单','small_odd','cq28',NULL,NULL),(207,'大双','big_even','cq28',NULL,NULL),(208,'小双','small_even','cq28',NULL,NULL),(209,'单点','cao','cq28',0,27),(210,'极大','max','cq28',NULL,NULL),(211,'极小','min','cq28',NULL,NULL),(212,'顺子','straight','cq28',NULL,NULL),(213,'豹子','leopard','cq28',NULL,NULL),(214,'红波','red','cq28',NULL,NULL),(215,'蓝波','blue','cq28',NULL,NULL),(216,'绿波','green','cq28',NULL,NULL),(301,'单','odd','xj28',NULL,NULL),(302,'双','even','xj28',NULL,NULL),(303,'大','big','xj28',NULL,NULL),(304,'小','small','xj28',NULL,NULL),(305,'大单','big_odd','xj28',NULL,NULL),(306,'小单','small_odd','xj28',NULL,NULL),(307,'大双','big_even','xj28',NULL,NULL),(308,'小双','small_even','xj28',NULL,NULL),(309,'单点','cao','xj28',0,27),(310,'极大','max','xj28',NULL,NULL),(311,'极小','min','xj28',NULL,NULL),(312,'顺子','straight','xj28',NULL,NULL),(313,'豹子','leopard','xj28',NULL,NULL),(314,'红波','red','xj28',NULL,NULL),(315,'蓝波','blue','xj28',NULL,NULL),(316,'绿波','green','xj28',NULL,NULL),(318,'对子','pair','xy28',NULL,NULL),(321,'对子','pair','keno28',NULL,NULL),(324,'对子','pair','cq28',NULL,NULL),(327,'对子','pair','xj28',NULL,NULL);
/*!40000 ALTER TABLE `pc_bet_play` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-06  5:14:09
