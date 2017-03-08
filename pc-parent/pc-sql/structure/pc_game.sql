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
-- Table structure for table `pc_activities`
--

DROP TABLE IF EXISTS `pc_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_activities` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1:亏损送',
  `content` text COMMENT '活动内容:json串',
  `memo` varchar(100) DEFAULT NULL COMMENT '活动备注',
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_activity_user`
--

DROP TABLE IF EXISTS `pc_activity_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_activity_user` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `activity_id` bigint(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `original_username` varchar(50) DEFAULT NULL,
  `loss_money` decimal(18,2) DEFAULT NULL,
  `loss_money_bonus` decimal(18,2) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL COMMENT '1:未发送, 2:已发送',
  `operator` varchar(50) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_activity_id` (`activity_id`),
  KEY `Index_username` (`username`),
  KEY `Index_state` (`state`),
  KEY `idnex_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13403 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_bill`
--

DROP TABLE IF EXISTS `pc_bet_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL COMMENT 'table_id',
  `game_type` varchar(20) DEFAULT NULL,
  `term` bigint(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `bet_msg` text COMMENT '下注信息',
  `bet_play_money` text COMMENT '下注玩法金额',
  `bet_money` decimal(10,2) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_username_term_tableId` (`username`,`table_id`,`term`),
  KEY `index_state` (`state`),
  KEY `index_game_type` (`game_type`),
  KEY `index_term` (`term`)
) ENGINE=InnoDB AUTO_INCREMENT=8296518 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info`
--

DROP TABLE IF EXISTS `pc_bet_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info` (
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
  `bet_odds1314` decimal(10,2) DEFAULT NULL COMMENT '13|14赔率',
  `bet_odds_expected` decimal(10,2) DEFAULT NULL COMMENT '理论赔率',
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_big`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_big`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_big` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309639 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_big_even`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_big_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_big_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309657 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_big_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_big_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_big_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_blue`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_blue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_blue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309690 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_cao`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_cao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_cao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1755 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_even`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309717 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_green`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_green`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_green` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_leopard`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_leopard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_leopard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309573 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_max`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_max`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_max` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_min`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_min`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_min` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309564 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309840 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_pair`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_pair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_pair` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_red`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_red`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_red` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309613 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_small`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_small`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_small` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_small_even`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_small_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_small_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_small_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_small_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_small_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_cq28_straight`
--

DROP TABLE IF EXISTS `pc_bet_info_cq28_straight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_cq28_straight` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2309676 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_big`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_big`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_big` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4568279 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_big_even`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_big_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_big_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2940369 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_big_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_big_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_big_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_blue`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_blue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_blue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4568246 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_cao`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_cao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_cao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1476 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_even`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2940458 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_green`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_green`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_green` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_leopard`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_leopard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_leopard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4568178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_max`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_max`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_max` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_min`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_min`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_min` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4568138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4568273 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_pair`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_pair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_pair` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_red`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_red`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_red` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4568153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_small`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_small`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_small` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_small_even`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_small_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_small_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_small_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_small_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_small_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_keno28_straight`
--

DROP TABLE IF EXISTS `pc_bet_info_keno28_straight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_keno28_straight` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2940327 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_big`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_big`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_big` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_big_even`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_big_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_big_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_big_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_big_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_big_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_blue`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_blue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_blue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287272 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_cao`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_cao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_cao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1605 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_even`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287224 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_green`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_green`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_green` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_leopard`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_leopard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_leopard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_max`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_max`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_max` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_min`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_min`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_min` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287202 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_pair`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_pair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_pair` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_red`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_red`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_red` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287076 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_small`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_small`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_small` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_small_even`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_small_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_small_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_small_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_small_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_small_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xj28_straight`
--

DROP TABLE IF EXISTS `pc_bet_info_xj28_straight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xj28_straight` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2287121 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_big`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_big`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_big` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14970260 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_big_even`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_big_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_big_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6279731 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_big_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_big_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_big_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_blue`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_blue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_blue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14970497 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_cao`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_cao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_cao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2660 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_even`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6279980 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_green`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_green`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_green` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_leopard`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_leopard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_leopard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14970096 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_max`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_max`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_max` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_min`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_min`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_min` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14970131 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14970428 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_pair`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_pair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_pair` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_red`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_red`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_red` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14970176 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_small`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_small`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_small` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_small_even`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_small_even`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_small_even` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_small_odd`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_small_odd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_small_odd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_xy28_straight`
--

DROP TABLE IF EXISTS `pc_bet_info_xy28_straight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_xy28_straight` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_no` varchar(100) DEFAULT NULL,
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
  `state` int(11) DEFAULT NULL,
  `win_money_valid` decimal(10,2) DEFAULT NULL,
  `win_money1314` decimal(10,2) DEFAULT NULL,
  `win_money_expected` decimal(10,2) DEFAULT NULL,
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_billno` (`bill_no`),
  KEY `Index_username` (`username`),
  KEY `Index_original_username` (`original_username`),
  KEY `Index_term` (`term`),
  KEY `index_state` (`state`),
  KEY `index_table_id` (`table_id`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6279561 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_info_yesterday`
--

DROP TABLE IF EXISTS `pc_bet_info_yesterday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_info_yesterday` (
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
  `bet_odds1314` decimal(10,2) DEFAULT NULL,
  `bet_odds_expected` decimal(10,2) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=161500274 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_limit`
--

DROP TABLE IF EXISTS `pc_bet_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_limit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `game_type` varchar(50) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `sing_play_limit` text,
  `type` varchar(50) DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_table_id` (`table_id`),
  KEY `Index_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1463 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_bet_odds`
--

DROP TABLE IF EXISTS `pc_bet_odds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_bet_odds` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `play` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4550 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `pc_game_type`
--

DROP TABLE IF EXISTS `pc_game_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_game_type` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '50:启用,-50:弃用',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_log`
--

DROP TABLE IF EXISTS `pc_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL,
  `http_method` varchar(20) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `class_method` varchar(200) DEFAULT NULL,
  `args` text,
  `response` text,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=743 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_lottery_result`
--

DROP TABLE IF EXISTS `pc_lottery_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_lottery_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `game_type` varchar(20) DEFAULT NULL COMMENT 'xy28, keno28',
  `term` bigint(20) DEFAULT NULL COMMENT '期数',
  `close_time` timestamp NULL DEFAULT NULL COMMENT '封盘时间',
  `open_time` timestamp NULL DEFAULT NULL COMMENT '开奖时间',
  `original_num` varchar(20) DEFAULT NULL COMMENT '原始号码',
  `open_url` varchar(100) DEFAULT NULL COMMENT '开奖地址',
  `lucky_num` int(11) DEFAULT NULL COMMENT '幸运号码',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_type_term` (`game_type`,`term`)
) ENGINE=InnoDB AUTO_INCREMENT=88440 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_pay_off_record`
--

DROP TABLE IF EXISTS `pc_pay_off_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_pay_off_record` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(11) DEFAULT NULL,
  `term` bigint(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `resullt_state` int(11) DEFAULT NULL COMMENT '10000:成功, 10001:部分成功, 其他:失败',
  `result_msg` text,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30165 DEFAULT CHARSET=utf8;
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
  `memo2` varchar(20) DEFAULT NULL,
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
  UNIQUE KEY `index_site_id` (`site_id`),
  KEY `index_state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
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
  `memo1` varchar(20) DEFAULT NULL,
  `memo2` varchar(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pc_transfer_record`
--

DROP TABLE IF EXISTS `pc_transfer_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pc_transfer_record` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `term` bigint(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `original_username` varchar(50) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL COMMENT 'IN:转入 OUT: 转出',
  `bill_no` varchar(100) DEFAULT NULL,
  `result_state` varchar(20) DEFAULT NULL COMMENT '10000:成功, 10001:部分成功, 其他:失败',
  `result_msg` text,
  `transfer_type` tinyint(4) DEFAULT NULL COMMENT '1: 下注, 2:派彩, 3:亏损送',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_billno` (`bill_no`),
  KEY `index_transfer_type` (`transfer_type`),
  KEY `index_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31438593 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-06  3:40:36
