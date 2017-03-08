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
-- Table structure for table `pc_bet_info_record`
--

DROP TABLE IF EXISTS `pc_bet_info_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL COMMENT '注单编号',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `original_username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `game_type` varchar(20) DEFAULT NULL,
  `term` bigint(20) DEFAULT NULL,
  `bet_type` varchar(20) DEFAULT NULL,
  `bet_money` decimal(10,2) DEFAULT NULL,
  `bet_num` int(11) DEFAULT NULL,
  `bet_msg` varchar(200) DEFAULT NULL,
  `pay_off` decimal(10,2) DEFAULT NULL,
  `after_balance` decimal(10,2) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '1:下注, 2:派彩赢, 3:派彩输, 4:撤销',
  `win_money_valid` decimal(10,2) DEFAULT NULL COMMENT '有效派彩金额',
  `win_money1314` decimal(10,2) DEFAULT NULL COMMENT '13|14派彩金额',
  `win_money_expected` decimal(10,2) DEFAULT NULL COMMENT '理论派彩金额',
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `bet_info_id` bigint(20) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `bet_time` timestamp NULL DEFAULT NULL,
  `payoff_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`),
  KEY `index_original_username` (`original_username`),
  KEY `Index_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=152583942 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_record_bak_2017-02-23`
--

DROP TABLE IF EXISTS `pc_bet_info_record_bak_2017-02-23`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_record_bak_2017-02-23` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `bill_no` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '注单编号',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `original_username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `game_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `term` bigint(20) DEFAULT NULL,
  `bet_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `bet_money` decimal(10,2) DEFAULT NULL,
  `bet_num` int(11) DEFAULT NULL,
  `bet_msg` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `pay_off` decimal(10,2) DEFAULT NULL,
  `after_balance` decimal(10,2) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '1:下注, 2:派彩赢, 3:派彩输, 4:撤销',
  `win_money_valid` decimal(10,2) DEFAULT NULL COMMENT '有效派彩金额',
  `win_money1314` decimal(10,2) DEFAULT NULL COMMENT '13|14派彩金额',
  `win_money_expected` decimal(10,2) DEFAULT NULL COMMENT '理论派彩金额',
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `bet_info_id` bigint(20) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `bet_time` timestamp NULL DEFAULT NULL,
  `payoff_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_record_bak_2017-02-24`
--

DROP TABLE IF EXISTS `pc_bet_info_record_bak_2017-02-24`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_record_bak_2017-02-24` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `bill_no` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '注单编号',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `original_username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `game_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `term` bigint(20) DEFAULT NULL,
  `bet_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `bet_money` decimal(10,2) DEFAULT NULL,
  `bet_num` int(11) DEFAULT NULL,
  `bet_msg` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `pay_off` decimal(10,2) DEFAULT NULL,
  `after_balance` decimal(10,2) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '1:下注, 2:派彩赢, 3:派彩输, 4:撤销',
  `win_money_valid` decimal(10,2) DEFAULT NULL COMMENT '有效派彩金额',
  `win_money1314` decimal(10,2) DEFAULT NULL COMMENT '13|14派彩金额',
  `win_money_expected` decimal(10,2) DEFAULT NULL COMMENT '理论派彩金额',
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `bet_info_id` bigint(20) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `bet_time` timestamp NULL DEFAULT NULL,
  `payoff_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_record_bak_2017-02-25`
--

DROP TABLE IF EXISTS `pc_bet_info_record_bak_2017-02-25`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_record_bak_2017-02-25` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `bill_no` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '注单编号',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `original_username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `game_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `term` bigint(20) DEFAULT NULL,
  `bet_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `bet_money` decimal(10,2) DEFAULT NULL,
  `bet_num` int(11) DEFAULT NULL,
  `bet_msg` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `pay_off` decimal(10,2) DEFAULT NULL,
  `after_balance` decimal(10,2) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '1:下注, 2:派彩赢, 3:派彩输, 4:撤销',
  `win_money_valid` decimal(10,2) DEFAULT NULL COMMENT '有效派彩金额',
  `win_money1314` decimal(10,2) DEFAULT NULL COMMENT '13|14派彩金额',
  `win_money_expected` decimal(10,2) DEFAULT NULL COMMENT '理论派彩金额',
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `bet_info_id` bigint(20) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `bet_time` timestamp NULL DEFAULT NULL,
  `payoff_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_record_bak_2017-02-26`
--

DROP TABLE IF EXISTS `pc_bet_info_record_bak_2017-02-26`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_record_bak_2017-02-26` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `bill_no` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '注单编号',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `original_username` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `game_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `term` bigint(20) DEFAULT NULL,
  `bet_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `bet_money` decimal(10,2) DEFAULT NULL,
  `bet_num` int(11) DEFAULT NULL,
  `bet_msg` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `pay_off` decimal(10,2) DEFAULT NULL,
  `after_balance` decimal(10,2) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '1:下注, 2:派彩赢, 3:派彩输, 4:撤销',
  `win_money_valid` decimal(10,2) DEFAULT NULL COMMENT '有效派彩金额',
  `win_money1314` decimal(10,2) DEFAULT NULL COMMENT '13|14派彩金额',
  `win_money_expected` decimal(10,2) DEFAULT NULL COMMENT '理论派彩金额',
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `bet_info_id` bigint(20) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `bet_time` timestamp NULL DEFAULT NULL,
  `payoff_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_room_config`
--

DROP TABLE IF EXISTS `pc_room_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_room_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `game_type` varchar(20) DEFAULT NULL COMMENT 'xy28,keno28',
  `memo` varchar(100) DEFAULT NULL,
  `memo2` varchar(100) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  UNIQUE KEY `index_site_id` (`site_id`) USING BTREE,
  KEY `index_state` (`state`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `memo1` varchar(50) DEFAULT NULL,
  `memo2` varchar(50) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-06  3:41:10
