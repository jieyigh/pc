/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50128
Source Host           : localhost:3306
Source Database       : pc_game

Target Server Type    : MYSQL
Target Server Version : 50128
File Encoding         : 65001

Date: 2016-09-08 20:31:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `w_activity_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `w_activity_dictionary`;
CREATE TABLE `w_activity_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `calc` varchar(20) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=703 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_activity_dictionary
-- ----------------------------
INSERT INTO `w_activity_dictionary` VALUES ('6', '奖金计算方式', 'bonusCompuseType', '1', '', null);
INSERT INTO `w_activity_dictionary` VALUES ('601', '固定值', 'fixed', '1', '', '6');
INSERT INTO `w_activity_dictionary` VALUES ('602', '按比例', 'percent', '1', '', '6');
INSERT INTO `w_activity_dictionary` VALUES ('7', '活动类型', 'activityType', '1', '', null);
INSERT INTO `w_activity_dictionary` VALUES ('701', '充值送', 'chargeBonus', '1', '', '7');
INSERT INTO `w_activity_dictionary` VALUES ('702', '亏损送', 'lossBonus', '1', '', '7');
INSERT INTO `w_activity_dictionary` VALUES ('404', '每3天一次', 'oneInThreeDay', '1', '3', '4');
INSERT INTO `w_activity_dictionary` VALUES ('1', '充值活动对象', 'chargeActivityObj', '1', '', null);
INSERT INTO `w_activity_dictionary` VALUES ('2', '充值方式', 'chargeWay', '1', '', null);
INSERT INTO `w_activity_dictionary` VALUES ('3', '参加次数', 'joinTimes', '1', '', null);
INSERT INTO `w_activity_dictionary` VALUES ('4', '彩金发放次数', 'sendBonusTimes', '1', '', null);
INSERT INTO `w_activity_dictionary` VALUES ('5', '亏损活动对象', 'lossActivityObj', '1', '', null);
INSERT INTO `w_activity_dictionary` VALUES ('101', '新注册用户', 'newRegisterUser', '1', '', '1');
INSERT INTO `w_activity_dictionary` VALUES ('102', '首次充值', 'firstCharge', '1', '', '1');
INSERT INTO `w_activity_dictionary` VALUES ('103', '活动期内每日首次充值', 'firstChargeInActivity', '1', '', '1');
INSERT INTO `w_activity_dictionary` VALUES ('104', '活动期内循环充值', 'circleChargeInActivity', '1', '', '1');
INSERT INTO `w_activity_dictionary` VALUES ('202', '第三方', 'thirtyPay', '1', '', '2');
INSERT INTO `w_activity_dictionary` VALUES ('203', '网银', 'eBank', '1', '', '2');
INSERT INTO `w_activity_dictionary` VALUES ('204', '支付宝', 'aliPay', '1', '', '2');
INSERT INTO `w_activity_dictionary` VALUES ('205', '微信', 'wechat', '1', '', '2');
INSERT INTO `w_activity_dictionary` VALUES ('206', '财付通', 'tenPay', '1', '', '2');
INSERT INTO `w_activity_dictionary` VALUES ('301', '无限制', 'all', '1', '', '3');
INSERT INTO `w_activity_dictionary` VALUES ('302', '一次', 'one', '1', '', '3');
INSERT INTO `w_activity_dictionary` VALUES ('303', '每天一次', 'oneInDay', '1', '', '3');
INSERT INTO `w_activity_dictionary` VALUES ('304', '每周一次', 'oneInWeek', '1', '', '3');
INSERT INTO `w_activity_dictionary` VALUES ('401', '无限制', 'all', '1', '', '4');
INSERT INTO `w_activity_dictionary` VALUES ('402', '一次', 'one', '1', '', '4');
INSERT INTO `w_activity_dictionary` VALUES ('403', '每天一次', 'oneInDay', '1', '1', '4');
INSERT INTO `w_activity_dictionary` VALUES ('405', '每周一次', 'oneInWeek', '1', '7', '4');
INSERT INTO `w_activity_dictionary` VALUES ('501', '活动期内首次亏损', 'firstLossInActivity', '1', '', '5');
INSERT INTO `w_activity_dictionary` VALUES ('502', '新注册用户首次亏损', 'firstLossByNewRegisUser', '1', '', '5');
INSERT INTO `w_activity_dictionary` VALUES ('201', '无限制', 'all', '1', '', '2');
INSERT INTO `w_activity_dictionary` VALUES ('503', '活动期内每日首次亏损', 'firstLossEvenydayInActivity', '1', '', '5');
INSERT INTO `w_activity_dictionary` VALUES ('504', '活动期内每日亏损', 'lossEveryDayInActivity', '1', null, '5');

-- ----------------------------
-- Table structure for `w_activity_set`
-- ----------------------------
DROP TABLE IF EXISTS `w_activity_set`;
CREATE TABLE `w_activity_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `game_type` varchar(20) DEFAULT NULL,
  `activity_obj` int(11) DEFAULT NULL COMMENT '活动对象类型',
  `charge_type` int(11) DEFAULT NULL COMMENT '充值方式',
  `register_begin_time` timestamp NULL DEFAULT NULL COMMENT '注册开始时间',
  `register_end_time` timestamp NULL DEFAULT NULL COMMENT '注册结束时间',
  `activity_begin_time` timestamp NULL DEFAULT NULL COMMENT '活动开始时间',
  `activity_end_time` timestamp NULL DEFAULT NULL COMMENT '活动结束时间',
  `activity_type` int(11) DEFAULT NULL COMMENT '统计周期单位',
  `bonus_type` int(11) DEFAULT NULL COMMENT '奖金方式',
  `bonus_standard` text COMMENT '奖金规格',
  `join_times` int(11) DEFAULT NULL COMMENT '参加次数',
  `send_bonus_count` int(11) DEFAULT NULL COMMENT '奖金发放次数',
  `lastest_send_bonus_time` timestamp NULL DEFAULT NULL,
  `pre` int(11) DEFAULT NULL COMMENT '是否前置\r\n            1.前置\r\n            0.非前置',
  `auto` int(11) DEFAULT NULL COMMENT '是否自动\r\n            1.提现\r\n            2.手动',
  `enabled` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_activity_set
-- ----------------------------
INSERT INTO `w_activity_set` VALUES ('21', '每日回水', 'xy28', '504', null, '2016-08-04 11:20:26', '2026-07-04 23:59:59', '2009-07-03 00:00:00', '2027-07-10 23:59:59', '702', '602', '[{\"chargeMoney\":20,\"maxBonus\":11111,\"percent\":6},{\"chargeMoney\":5001,\"maxBonus\":11111,\"percent\":8},{\"chargeMoney\":20001,\"maxBonus\":11111,\"percent\":10},{\"chargeMoney\":50001,\"maxBonus\":111111,\"percent\":12}]', '303', null, null, null, '2', '1');

-- ----------------------------
-- Table structure for `w_activity_user`
-- ----------------------------
DROP TABLE IF EXISTS `w_activity_user`;
CREATE TABLE `w_activity_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `bonus` int(11) DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `memo` text,
  `state` int(11) DEFAULT NULL COMMENT '状态\r\n            1:已发送, 2:待审核,3:审核不通过',
  `already_sync` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_activity_user
-- ----------------------------

-- ----------------------------
-- Table structure for `w_ad_notice`
-- ----------------------------
DROP TABLE IF EXISTS `w_ad_notice`;
CREATE TABLE `w_ad_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ad_time` varchar(10) DEFAULT NULL COMMENT '广告时间',
  `ad_desc` varchar(100) DEFAULT NULL COMMENT '广告描述',
  `ad_content` text COMMENT '广告内容',
  `enabled` int(11) DEFAULT NULL COMMENT '0:不启用,1:启用',
  `game_type` varchar(20) DEFAULT NULL COMMENT '游戏类型（xy28:幸运28）',
  `money_digits` int(11) DEFAULT NULL,
  `show_row_digits` int(11) DEFAULT NULL,
  `count_time` int(11) DEFAULT NULL,
  `bill_condition` text COMMENT '条件',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COMMENT='广告通知表';

-- ----------------------------
-- Records of w_ad_notice
-- ----------------------------
INSERT INTO `w_ad_notice` VALUES ('1', '-60', '下一期前一分钟广告', '★距离封盘还有60秒★\\n请抓紧时间下注\\n一切下注以庄家显示为准\\n财务不会主动加好友\\n主动加好友的都是骗子\\n各位老板请注意\\n★如遇炸群★不吃★不赔\\n┉┉┉┉┉┉┉┉┉┉┉\\n即日起玩家尽量不要哈注\\n(哈玩法),因有的哈注系\\n统会不识别，全部以核\\n对账单为准，如有未在\\n核对账单中就是无效，\\n给广大玩家带来的不便\\n请大家谅解，谢谢\\n', '1', 'xy28', null, null, '60', null);
INSERT INTO `w_ad_notice` VALUES ('2', '-50', '下一期前50秒广告', '', '1', 'xy28', null, null, '30', null);
INSERT INTO `w_ad_notice` VALUES ('3', '-30', '下一期前30秒封盘时间', '★★★★ 封盘★★★★\\n┉┉┉┉┉┉┉┉┉┉┉\\n奖期:{当前奖期}\\n停止下注 网络以庄家为准\\n┉┉┉┉┉┉┉┉┉┉┉\\n先上分后喊查\\n喊查格式例子:查宝1000\\n不接受【微信红包】上分\\n庄家有通知上分或者提示\\n有效下注方能生效，否则\\n只杀不赔\\n【超额下注】一律视为\\n无效不以提醒\\n如因下注格式不规范而\\n产生的错账只杀不赔\\n注单含有任何符号,只杀不赔\\n注单少于10元，只杀不赔\\n重复下注,注单相互叠加\\n相同的下注最好是写加\\n同行相同下注方式默认\\n最后一个\\n网络一切注单显示以庄\\n家为准无需纠结，请知悉\\n┉┉┉┉┉┉┉┉┉┉┉\\n【封盘】下的注单一律\\n无效，无需纠结！\\n┉┉┉┉┉┉┉┉┉┉┉\\n开奖网址：\\n{www.pc588.com/pc28}\\n{www.pc9777.com}\\n复制在浏览器上打开连接', '1', 'xy28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('4', '-25', '核对账单数据', '当前奖期:{当前奖期},\\n有效下注用户数据:\\n{下注数据}', '1', 'xy28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('5', '-20', '白场广告1', '★★公司游戏规则★★\\n① 本群玩法\\n② 优惠活动\\n③ 本群赔率\\n④ 上下分格式\\n⑤ 如何下注\\n⑥ 公平、公正 无法作弊\\n\\n公司无反组合、杀组合下\\n注限制，玩家请随意下注\\n，玩家点击管理/帐房的\\n朋友圈相册查看规则。', '1', 'xy28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('6', '-15', '白场广告2', '★★★本群赔率★★★\\n大小单双赔率2倍\\n开13,14赔率1.85倍\\n大单小双赔率4.1倍\\n小单大双赔率4倍\\n开13,14赔率2.5倍\\n极大、极小赔15倍\\n顺子(正顺/倒顺)50倍\\n豹子赔70倍\\n\\n单点赔率\\n00   27 赔500倍\\n01   26 赔200倍\\n02   25 赔100倍\\n03   24 赔60  倍\\n04   23 赔45  倍\\n05   22 赔30  倍\\n06   21 赔25  倍\\n07   20 赔20  倍\\n08   19 赔18  倍\\n09   18 赔16  倍\\n10 11 16 17赔13倍\\n12 13 14 15赔12倍\\n以上倍率含本金\\n重要提示：每个玩家帐户\\n每期最高派彩上限30万，\\n超过部分不赔。\\n', '1', 'xy28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('7', '-10', '白场广告3', '★★★投注限额★★★\\n大小单双单注限额30000\\n组合单注限额      20000\\n极大极小单注限额5000\\n单点数字单注限额5000\\n单注最低投注限额10\\n单点数字最低投注30', '1', 'xy28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('8', '-5', '白场广告4', '', '1', 'xy28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('9', '0', '转换下一期', '★★★优惠活动★★★\n①玩家上分送2.0%\n②输分20即可获得回水\n③拉人福利2888.88元\n④举报有奖\n详情请查阅朋友圈图片\n开奖中.......', '1', 'xy28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('10', '31', '发送上一期账单', '{当前奖期}期:\\n{当前号码}{分开发}上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n{收益}\\n┉┉┉┉┉┉┉┉┉┉┉{分开发}★★★会员余额★★★ \\n在线人数:{在线人数}\\n账面总额:{账面总额}\\n┉┉┉┉┉┉┉┉┉┉┉\\n{账单}\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n{分开发}近 15 期开奖号码：{近15期号码}', '1', 'xy28', '6', '2', null, '{\"lessThanMoney\":100,\"noBetTerm\":2,\"state\":50}');
INSERT INTO `w_ad_notice` VALUES ('101', '-60', '下一期前一分钟广告', '@all\\n★距离封盘还有60秒★\\n请抓紧时间下注\\n★如遇炸群★不吃★不赔', '1', 'keno28', null, null, '60', null);
INSERT INTO `w_ad_notice` VALUES ('102', '-50', '下一期前50秒广告', '', '1', 'keno28', null, null, '30', null);
INSERT INTO `w_ad_notice` VALUES ('103', '-30', '下一期前30秒封盘时间', '@all\\n★★★★ 封盘★★★★\\n┉┉┉┉┉┉┉┉┉┉┉\\n奖期:{当前奖期}\\n停止下注 网络以庄家为准\\n┉┉┉┉┉┉┉┉┉┉┉\\n开奖网址：\\n{www.pc588.com/pc28}\\n{www.pc1777.com/pc28}\\n复制在浏览器上打开连接', '1', 'keno28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('104', '-25', '核对账单数据', '@all 当前奖期:{当前奖期},有效下注用户数据:\\n{下注数据}\\n===============\\n各位老板请看好核对账单，下注一律以核对账单为准', '1', 'keno28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('105', '-20', '白场广告1', '@all ★★公司游戏规则★★\\n① 本群玩法\\n② 优惠活动\\n③ 本群赔率\\n④ 上下分格式\\n⑤ 如何下注\\n⑥ 公平、公正 无法作弊', '1', 'keno28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('106', '-15', '白场广告2', '@all★★★本群赔率★★★\\n投注大小单双各项最高30000封顶，最低10元；\\n①大、小、单、双赔率2倍(含本金)\\n②小双、大单赔率4.1倍(含本金)\\n③单点赔率12倍(含本金)\\n④极大，极小赔率15倍(含本金)\\n注：如不清楚可私聊管理(jiebao2233)或帐房(jbgl358)', '1', 'keno28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('107', '-10', '白场广告3', '@all★★★优惠活动★★★\\n①玩家上分送2.0%\\n②输分20即可获得回水\\n③拉人福利2888.88元\\n④举报有奖', '1', 'keno28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('108', '-5', '白场广告4', '@all★★★本群赔率★★★\\n大小单双单注限额30000\\n组合单注限额20000\\n极大极小单注限额5000\\n单点数字单注限额5000\\n单注最低投注限额10\\n单点数字单注最低投注30\\n大小单双赔率2倍，开13,14赔率1.85倍\\n大单小双赔率4.1倍\\n小单大双赔率4倍，开13,14赔率2.5倍\\n顺子赔率80倍，豹子赔率50倍\\n00,27赔率500倍\\n其他单点数字赔率12倍\\n极大极小赔率15倍', '1', 'keno28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('109', '0', '转换下一期', '@当前{当前奖期}期!近 15 期：{近15期号码}', '1', 'keno28', null, null, null, null);
INSERT INTO `w_ad_notice` VALUES ('110', '31', '发送上一期账单', '@all ★★★账单★★★ \\n在线人数:{在线人数}\\n账面总额:{账面总额}\\n当前奖期:{当前奖期}\\n当前号码:{当前号码}\\n┉┉┉┉┉┉┉┉┉┉┉\\n{账单}\\n┉┉┉┉┉┉┉┉┉┉┉\\n上期收益：\\n{收益}\\n┉┉┉┉┉┉┉┉┉┉┉\\n遇系统网络卡顿以庄家注单为准', '1', 'keno28', '6', '2', null, '{\"state\":-50}');

-- ----------------------------
-- Table structure for `w_add_reduce_money_notice`
-- ----------------------------
DROP TABLE IF EXISTS `w_add_reduce_money_notice`;
CREATE TABLE `w_add_reduce_money_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `money` int(11) DEFAULT NULL COMMENT '上下分的金额',
  `state` int(11) DEFAULT NULL COMMENT '状态:（0未发送, 1已发送）',
  `type` int(11) DEFAULT NULL COMMENT '类型(1:成功上分,2:成功通知,3:拒绝上分:4:拒绝下分,8:人工封盘,10:余额不足,15:充值送, 16:亏损送, 20:系统撤单,\r\n            21:系统账单,100:系统开始,101:系统关闭)',
  `operater` varchar(50) DEFAULT NULL COMMENT '操作者',
  `msg` text COMMENT '消息',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `nickname` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `delay_seconds` int(11) DEFAULT NULL COMMENT '延迟秒数',
  `term` bigint(12) DEFAULT NULL,
  `game_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3005 DEFAULT CHARSET=utf8 COMMENT='上下分通知表';

-- ----------------------------
-- Records of w_add_reduce_money_notice
-- ----------------------------
INSERT INTO `w_add_reduce_money_notice` VALUES ('2428', '8000', '1', '1', 'ceshi1234', '上8000成功,当前积分:8000', '2016-09-07 15:13:10', '2016-09-07 15:13:10', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2429', '-500', '1', '2', 'ceshi1234', '下-500成功,当前积分:6500', '2016-09-07 15:14:03', '2016-09-07 15:14:03', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2430', '-600', '1', '2', 'ceshi1234', '下-600成功,当前积分:6500', '2016-09-07 15:14:03', '2016-09-07 15:14:03', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2431', '-500', '1', '4', 'ceshi1234', '下-500失败,当前积分:6000', '2016-09-07 15:14:27', '2016-09-07 15:14:27', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2432', null, '1', '21', 'ceshi1234', '779900期:\\n4 + 2 + 7 = 13(小单)', '2016-09-07 15:15:08', '2016-09-07 15:15:09', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2433', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:-900<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:15:08', '2016-09-07 15:15:10', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2434', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:006000\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦006000 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:15:08', '2016-09-07 15:15:11', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2435', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13_suffix_open_prizing', '2016-09-07 15:15:08', '2016-09-07 15:15:12', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2436', null, '1', '21', 'ceshi1234', '779901期:\\n2 + 5 + 4 = 11(小单)', '2016-09-07 15:20:18', '2016-09-07 15:20:19', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2437', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:20:18', '2016-09-07 15:20:20', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2438', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:006000\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦006000 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:20:18', '2016-09-07 15:20:21', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2439', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11_suffix_open_prizing', '2016-09-07 15:20:18', '2016-09-07 15:20:22', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2440', null, '1', '101', 'ceshi1234', '系统开启,当前期:779902', '2016-09-07 15:22:32', '2016-09-07 15:22:33', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2441', null, '1', '21', 'ceshi1234', '779901期:\\n2 + 5 + 4 = 11(小单)', '2016-09-07 15:22:37', '2016-09-07 15:22:38', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2442', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:22:37', '2016-09-07 15:22:39', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2443', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:006000\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦006000 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:22:37', '2016-09-07 15:22:40', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2444', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11_suffix_open_prizing', '2016-09-07 15:22:37', '2016-09-07 15:22:41', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2445', null, '1', '21', 'ceshi1234', '779902期:\\n0 + 4 + 8 = 12(小双)', '2016-09-07 15:25:07', '2016-09-07 15:25:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2446', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:25:07', '2016-09-07 15:25:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2447', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:006000\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦006000 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:25:07', '2016-09-07 15:25:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2448', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12_suffix_open_prizing', '2016-09-07 15:25:07', '2016-09-07 15:25:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2449', null, '1', '21', 'ceshi1234', '779903期:\\n8 + 5 + 3 = 16(大双)', '2016-09-07 15:30:17', '2016-09-07 15:30:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2450', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:+500<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:30:17', '2016-09-07 15:30:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2451', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:006500\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦006500 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:30:17', '2016-09-07 15:30:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2452', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16_suffix_open_prizing', '2016-09-07 15:30:17', '2016-09-07 15:30:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2453', null, '1', '21', 'ceshi1234', '779904期:\\n4 + 3 + 2 = 9(小单, 顺子)', '2016-09-07 15:35:07', '2016-09-07 15:35:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2454', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:35:07', '2016-09-07 15:35:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2455', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:006500\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦006500 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:35:07', '2016-09-07 15:35:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2456', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9_suffix_open_prizing', '2016-09-07 15:35:07', '2016-09-07 15:35:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2457', '1000', '1', '1', 'ceshi1234', '上1000成功,当前积分:7100', '2016-09-07 15:37:58', '2016-09-07 15:37:59', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2458', '1000', '1', '3', 'ceshi1234', '上1000失败,当前积分:7100', '2016-09-07 15:38:16', '2016-09-07 15:38:17', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2459', '-100', '1', '2', 'ceshi1234', '下-100成功,当前积分:7000', '2016-09-07 15:38:48', '2016-09-07 15:38:49', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2460', '-100', '1', '4', 'ceshi1234', '下-100失败,当前积分:7000', '2016-09-07 15:38:59', '2016-09-07 15:38:59', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2461', '-100', '1', '4', 'ceshi1234', '下-100失败,当前积分:7000', '2016-09-07 15:39:22', '2016-09-07 15:39:22', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2462', null, '1', '21', 'ceshi1234', '779905期:\\n4 + 5 + 1 = 10(小双)', '2016-09-07 15:40:17', '2016-09-07 15:40:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2463', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:+400<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:40:17', '2016-09-07 15:40:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2464', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:007800\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦007800 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:40:17', '2016-09-07 15:40:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2465', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10_suffix_open_prizing', '2016-09-07 15:40:17', '2016-09-07 15:40:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2466', '-800', '1', '2', 'ceshi1234', '下-800成功,当前积分:7000', '2016-09-07 15:42:23', '2016-09-07 15:42:23', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2467', '-800', '1', '4', 'ceshi1234', '下-800失败,当前积分:7000', '2016-09-07 15:42:33', '2016-09-07 15:42:34', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2468', '-800', '1', '2', 'ceshi1234', '下-800成功,当前积分:6000', '2016-09-07 15:42:46', '2016-09-07 15:42:47', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2469', '-200', '1', '2', 'ceshi1234', '下-200成功,当前积分:6000', '2016-09-07 15:42:46', '2016-09-07 15:42:47', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2470', '-800', '1', '4', 'ceshi1234', '下-800失败,当前积分:5800', '2016-09-07 15:43:02', '2016-09-07 15:43:02', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2471', '-200', '1', '4', 'ceshi1234', '下-200失败,当前积分:6000', '2016-09-07 15:43:02', '2016-09-07 15:43:02', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2472', null, '1', '21', 'ceshi1234', '779906期:\\n2 + 6 + 4 = 12(小双)', '2016-09-07 15:45:07', '2016-09-07 15:45:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2473', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:45:07', '2016-09-07 15:45:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2474', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:007000\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦007000 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:45:07', '2016-09-07 15:45:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2475', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12_suffix_open_prizing', '2016-09-07 15:45:07', '2016-09-07 15:45:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2476', null, '1', '21', 'ceshi1234', '779907期:\\n9 + 1 + 8 = 18(大双)', '2016-09-07 15:50:17', '2016-09-07 15:50:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2477', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:50:17', '2016-09-07 15:50:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2478', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:1\\n账面总额:003000\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦003000 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:50:17', '2016-09-07 15:50:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2479', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18_suffix_open_prizing', '2016-09-07 15:50:17', '2016-09-07 15:50:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2480', '1000', '1', '1', 'ceshi1234', '上1000成功,当前积分:4000', '2016-09-07 15:50:26', '2016-09-07 15:50:27', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2481', '-5000', '1', '2', 'ceshi1234', '下-5000成功,当前积分:4000', '2016-09-07 15:50:26', '2016-09-07 15:50:27', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2482', '8000', '1', '1', 'ceshi1234', '上8000成功,当前积分:8000', '2016-09-07 15:52:03', '2016-09-07 15:52:04', '11111111', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2483', null, '1', '21', 'ceshi1234', '779908期:\\n6 + 1 + 6 = 13(小单)', '2016-09-07 15:55:18', '2016-09-07 15:55:19', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2484', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 15:55:18', '2016-09-07 15:55:20', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2485', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:012000\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 15:55:18', '2016-09-07 15:55:21', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2486', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13_suffix_open_prizing', '2016-09-07 15:55:18', '2016-09-07 15:55:22', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2487', null, '1', '21', 'ceshi1234', '779909期:\\n8+3+1=12(小双)', '2016-09-07 16:00:28', '2016-09-07 16:00:29', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2488', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:00:28', '2016-09-07 16:00:30', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2489', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:012000\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:00:28', '2016-09-07 16:00:31', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2490', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13 12_suffix_open_prizing', '2016-09-07 16:00:28', '2016-09-07 16:00:32', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2491', '2000', '1', '1', 'ceshi1234', '上2000成功,当前积分:2000', '2016-09-07 16:03:31', '2016-09-07 16:03:32', '555678', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2492', null, '1', '21', 'ceshi1234', '779910期:\\n1 + 1 + 3 = 5(小单)', '2016-09-07 16:05:08', '2016-09-07 16:05:09', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2493', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:05:08', '2016-09-07 16:05:10', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2494', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:014000\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678002000 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:05:08', '2016-09-07 16:05:11', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2495', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13 12 5_suffix_open_prizing', '2016-09-07 16:05:08', '2016-09-07 16:05:12', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2496', null, '1', '21', 'ceshi1234', '779911期:\\n4 + 9 + 2 = 15(大单)', '2016-09-07 16:10:08', '2016-09-07 16:10:09', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2497', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n555678:-190<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:10:08', '2016-09-07 16:10:10', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2498', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:10:08', '2016-09-07 16:10:11', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2499', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13 12 5 15_suffix_open_prizing', '2016-09-07 16:10:08', '2016-09-07 16:10:12', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2500', null, '1', '21', 'ceshi1234', '779912期:\\n7 + 0 + 2 = 9(小单)', '2016-09-07 16:15:08', '2016-09-07 16:15:09', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2501', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:15:08', '2016-09-07 16:15:10', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2502', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:15:08', '2016-09-07 16:15:11', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2503', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13 12 5 15 9_suffix_open_prizing', '2016-09-07 16:15:08', '2016-09-07 16:15:12', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2504', null, '1', '101', 'ceshi1234', '系统开启,当前期:779913', '2016-09-07 16:18:09', '2016-09-07 16:18:10', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2505', null, '1', '21', 'ceshi1234', '779912期:\\n7 + 0 + 2 = 9(小单)', '2016-09-07 16:18:18', '2016-09-07 16:18:19', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2506', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:18:18', '2016-09-07 16:18:20', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2507', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:18:18', '2016-09-07 16:18:21', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2508', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13 12 5 15 9_suffix_open_prizing', '2016-09-07 16:18:18', '2016-09-07 16:18:22', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2509', null, '1', '101', 'ceshi1234', '系统开启,当前期:779914', '2016-09-07 16:20:04', '2016-09-07 16:20:04', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2510', null, '1', '21', 'ceshi1234', '779913期:\\n5 + 3 + 7 = 15(大单)', '2016-09-07 16:20:18', '2016-09-07 16:20:19', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2511', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:20:18', '2016-09-07 16:20:20', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2512', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:20:18', '2016-09-07 16:20:21', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2513', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13 12 5 15 9 15_suffix_open_prizing', '2016-09-07 16:20:18', '2016-09-07 16:20:22', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2514', null, '1', '101', 'ceshi1234', '系统开启,当前期:779914', '2016-09-07 16:21:27', '2016-09-07 16:21:28', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2515', null, '1', '21', 'ceshi1234', '779913期:\\n5 + 3 + 7 = 15(大单)', '2016-09-07 16:21:32', '2016-09-07 16:21:33', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2516', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:21:32', '2016-09-07 16:21:34', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2517', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:21:32', '2016-09-07 16:21:35', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2518', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 13 11 12 16 9 10 12 18 13 12 5 15 9 15_suffix_open_prizing', '2016-09-07 16:21:32', '2016-09-07 16:21:36', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2519', null, '1', '21', 'ceshi1234', '779914期:\\n8 + 1 + 8 = 17(大单)', '2016-09-07 16:25:12', '2016-09-07 16:25:13', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2520', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:25:12', '2016-09-07 16:25:14', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2521', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:25:12', '2016-09-07 16:25:15', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2522', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：13 11 12 16 9 10 12 18 13 12 5 15 9 15 17_suffix_open_prizing', '2016-09-07 16:25:12', '2016-09-07 16:25:16', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2523', null, '1', '21', 'ceshi1234', '779915期:\\n8 + 8 + 4 = 20(大双)', '2016-09-07 16:30:22', '2016-09-07 16:30:23', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2524', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:30:22', '2016-09-07 16:30:24', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2525', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:30:22', '2016-09-07 16:30:25', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2526', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 12 16 9 10 12 18 13 12 5 15 9 15 17 20_suffix_open_prizing', '2016-09-07 16:30:22', '2016-09-07 16:30:26', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2527', null, '1', '21', 'ceshi1234', '779916期:\\n1 + 7 + 8 = 16(大双)', '2016-09-07 16:35:12', '2016-09-07 16:35:13', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2528', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:35:12', '2016-09-07 16:35:14', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2529', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:35:12', '2016-09-07 16:35:15', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2530', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 16 9 10 12 18 13 12 5 15 9 15 17 20 16_suffix_open_prizing', '2016-09-07 16:35:12', '2016-09-07 16:35:16', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2531', null, '1', '21', 'ceshi1234', '779917期:\\n7 + 7 + 8 = 22(大双)', '2016-09-07 16:40:13', '2016-09-07 16:40:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2532', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:40:13', '2016-09-07 16:40:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2533', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:40:13', '2016-09-07 16:40:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2534', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：16 9 10 12 18 13 12 5 15 9 15 17 20 16 22_suffix_open_prizing', '2016-09-07 16:40:13', '2016-09-07 16:40:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2535', null, '1', '21', 'ceshi1234', '779918期:\\n4 + 9 + 6 = 19(大单)', '2016-09-07 16:45:13', '2016-09-07 16:45:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2536', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:45:13', '2016-09-07 16:45:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2537', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:45:13', '2016-09-07 16:45:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2538', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：9 10 12 18 13 12 5 15 9 15 17 20 16 22 19_suffix_open_prizing', '2016-09-07 16:45:13', '2016-09-07 16:45:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2539', null, '1', '21', 'ceshi1234', '779919期:\\n2 + 8 + 6 = 16(大双)', '2016-09-07 16:50:13', '2016-09-07 16:50:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2540', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 16:50:13', '2016-09-07 16:50:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2541', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 16:50:13', '2016-09-07 16:50:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2542', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：10 12 18 13 12 5 15 9 15 17 20 16 22 19 16_suffix_open_prizing', '2016-09-07 16:50:13', '2016-09-07 16:50:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2543', null, '1', '101', 'ceshi1234', '系统开启,当前期:779930', '2016-09-07 17:43:34', '2016-09-07 17:43:34', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2544', null, '1', '21', 'ceshi1234', '779929期:\\n2+7+6=15(大单)', '2016-09-07 17:43:45', '2016-09-07 17:43:46', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2545', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 17:43:45', '2016-09-07 17:43:47', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2546', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 17:43:45', '2016-09-07 17:43:48', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2547', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 18 13 12 5 15 9 15 17 20 16 22 19 16 15_suffix_open_prizing', '2016-09-07 17:43:45', '2016-09-07 17:43:49', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2548', null, '1', '21', 'ceshi1234', '779930期:\\n9 + 3 + 0 = 12(小双)', '2016-09-07 17:45:05', '2016-09-07 17:45:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2549', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 17:45:05', '2016-09-07 17:45:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2550', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 17:45:05', '2016-09-07 17:45:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2551', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：18 13 12 5 15 9 15 17 20 16 22 19 16 15 12_suffix_open_prizing', '2016-09-07 17:45:05', '2016-09-07 17:45:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2552', null, '1', '21', 'ceshi1234', '779931期:\\n1 + 4 + 9 = 14(大双)', '2016-09-07 17:50:15', '2016-09-07 17:50:16', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2553', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 17:50:15', '2016-09-07 17:50:17', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2554', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 17:50:15', '2016-09-07 17:50:18', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2555', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：13 12 5 15 9 15 17 20 16 22 19 16 15 12 14_suffix_open_prizing', '2016-09-07 17:50:15', '2016-09-07 17:50:19', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2556', null, '1', '101', 'ceshi1234', '系统开启,当前期:779932', '2016-09-07 17:52:12', '2016-09-07 17:52:12', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2557', null, '1', '21', 'ceshi1234', '779931期:\\n1 + 4 + 9 = 14(大双)', '2016-09-07 17:52:15', '2016-09-07 17:52:16', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2558', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 17:52:15', '2016-09-07 17:52:17', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2559', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 17:52:15', '2016-09-07 17:52:18', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2560', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：13 12 5 15 9 15 17 20 16 22 19 16 15 12 14_suffix_open_prizing', '2016-09-07 17:52:15', '2016-09-07 17:52:19', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2561', null, '1', '101', 'ceshi1234', '系统开启,当前期:779933', '2016-09-07 17:55:16', '2016-09-07 17:55:17', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2562', null, '1', '21', 'ceshi1234', '779932期:\\n3 + 3 + 3 = 9(小单, 豹子)', '2016-09-07 17:55:23', '2016-09-07 17:55:24', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2563', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 17:55:23', '2016-09-07 17:55:25', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2564', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013810\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001810 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 17:55:23', '2016-09-07 17:55:26', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2565', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 5 15 9 15 17 20 16 22 19 16 15 12 14 9_suffix_open_prizing', '2016-09-07 17:55:23', '2016-09-07 17:55:27', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2566', null, '1', '101', 'ceshi1234', '系统开启,当前期:779934', '2016-09-07 18:00:28', '2016-09-07 18:00:29', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2567', null, '1', '21', 'ceshi1234', '779934期:\\n9 + 8 + 9 = 26(大双, 极大)', '2016-09-07 18:05:12', '2016-09-07 18:05:13', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2568', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n555678:+100<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:05:12', '2016-09-07 18:05:14', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2569', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013910\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 摩弦004000<br>555678001910 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:05:12', '2016-09-07 18:05:15', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2570', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 9 15 17 20 16 22 19 16 15 12 14 9 9 26_suffix_open_prizing', '2016-09-07 18:05:12', '2016-09-07 18:05:16', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2571', '2000', '1', '1', 'ceshi1234', '上2000成功,当前积分:2000', '2016-09-07 18:06:41', '2016-09-07 18:06:42', '555678', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2572', '-3000', '1', '4', 'ceshi1234', '下-3000失败,当前积分:4000', '2016-09-07 18:07:19', '2016-09-07 18:07:20', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2573', '5000', '1', '3', 'ceshi1234', '上5000失败,当前积分:4000', '2016-09-07 18:07:19', '2016-09-07 18:07:20', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2574', '-3880', '1', '2', 'ceshi1234', '下-3880成功,当前积分:20', '2016-09-07 18:07:44', '2016-09-07 18:07:44', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2575', '-100', '1', '2', 'ceshi1234', '下-100成功,当前积分:20', '2016-09-07 18:07:44', '2016-09-07 18:07:44', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2576', null, '1', '21', 'ceshi1234', '779935期:\\n8 + 5 + 4 = 17(大单)', '2016-09-07 18:10:12', '2016-09-07 18:10:13', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2577', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n555678:+1910<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:10:12', '2016-09-07 18:10:14', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2578', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013840\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>摩弦000020 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:10:12', '2016-09-07 18:10:15', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2579', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：9 15 17 20 16 22 19 16 15 12 14 9 9 26 17_suffix_open_prizing', '2016-09-07 18:10:12', '2016-09-07 18:10:16', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2580', null, '1', '21', 'ceshi1234', '779936期:\\n4 + 2 + 2 = 8(小双)', '2016-09-07 18:15:12', '2016-09-07 18:15:13', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2581', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:15:12', '2016-09-07 18:15:14', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2582', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:013840\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>摩弦000020 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:15:12', '2016-09-07 18:15:15', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2583', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 17 20 16 22 19 16 15 12 14 9 9 26 17 8_suffix_open_prizing', '2016-09-07 18:15:12', '2016-09-07 18:15:16', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2584', null, '1', '21', 'ceshi1234', '779937期:\\n6 + 4 + 9 = 19(大单)', '2016-09-07 18:20:12', '2016-09-07 18:20:13', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2585', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:20:12', '2016-09-07 18:20:14', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2586', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:20:12', '2016-09-07 18:20:15', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2587', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 20 16 22 19 16 15 12 14 9 9 26 17 8 19_suffix_open_prizing', '2016-09-07 18:20:12', '2016-09-07 18:20:16', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2588', null, '1', '21', 'ceshi1234', '779938期:\\n5 + 0 + 7 = 12(小双)', '2016-09-07 18:25:12', '2016-09-07 18:25:13', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2589', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:25:12', '2016-09-07 18:25:14', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2590', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:25:12', '2016-09-07 18:25:15', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2591', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：20 16 22 19 16 15 12 14 9 9 26 17 8 19 12_suffix_open_prizing', '2016-09-07 18:25:12', '2016-09-07 18:25:16', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2592', null, '1', '21', 'ceshi1234', '779939期:\\n5 + 0 + 7 = 12(小双)', '2016-09-07 18:30:23', '2016-09-07 18:30:24', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2593', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:30:23', '2016-09-07 18:30:25', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2594', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:30:23', '2016-09-07 18:30:26', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2595', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：16 22 19 16 15 12 14 9 9 26 17 8 19 12 12_suffix_open_prizing', '2016-09-07 18:30:23', '2016-09-07 18:30:27', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2596', null, '1', '21', 'ceshi1234', '779940期:\\n9 + 2 + 5 = 16(大双)', '2016-09-07 18:35:13', '2016-09-07 18:35:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2597', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:35:13', '2016-09-07 18:35:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2598', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:35:13', '2016-09-07 18:35:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2599', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：22 19 16 15 12 14 9 9 26 17 8 19 12 12 16_suffix_open_prizing', '2016-09-07 18:35:13', '2016-09-07 18:35:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2600', null, '1', '21', 'ceshi1234', '779941期:\\n7 + 7 + 1 = 15(大单)', '2016-09-07 18:40:13', '2016-09-07 18:40:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2601', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:40:13', '2016-09-07 18:40:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2602', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:40:13', '2016-09-07 18:40:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2603', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 16 15 12 14 9 9 26 17 8 19 12 12 16 15_suffix_open_prizing', '2016-09-07 18:40:13', '2016-09-07 18:40:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2604', null, '1', '21', 'ceshi1234', '779942期:\\n9 + 5 + 1 = 15(大单)', '2016-09-07 18:45:13', '2016-09-07 18:45:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2605', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:45:13', '2016-09-07 18:45:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2606', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:45:13', '2016-09-07 18:45:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2607', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：16 15 12 14 9 9 26 17 8 19 12 12 16 15 15_suffix_open_prizing', '2016-09-07 18:45:13', '2016-09-07 18:45:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2608', null, '1', '21', 'ceshi1234', '779943期:\\n2 + 1 + 3 = 6(小双)', '2016-09-07 18:50:13', '2016-09-07 18:50:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2609', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:50:13', '2016-09-07 18:50:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2610', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:50:13', '2016-09-07 18:50:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2611', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 12 14 9 9 26 17 8 19 12 12 16 15 15 6_suffix_open_prizing', '2016-09-07 18:50:13', '2016-09-07 18:50:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2612', null, '1', '21', 'ceshi1234', '779944期:\\n8 + 3 + 4 = 15(大单)', '2016-09-07 18:55:03', '2016-09-07 18:55:04', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2613', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 18:55:03', '2016-09-07 18:55:05', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2614', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 18:55:03', '2016-09-07 18:55:06', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2615', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 14 9 9 26 17 8 19 12 12 16 15 15 6 15_suffix_open_prizing', '2016-09-07 18:55:03', '2016-09-07 18:55:07', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2616', null, '1', '21', 'ceshi1234', '779945期:\\n7 + 0 + 1 = 8(小双)', '2016-09-07 19:00:13', '2016-09-07 19:00:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2617', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:00:13', '2016-09-07 19:00:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2618', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:00:13', '2016-09-07 19:00:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2619', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：14 9 9 26 17 8 19 12 12 16 15 15 6 15 8_suffix_open_prizing', '2016-09-07 19:00:13', '2016-09-07 19:00:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2620', null, '1', '21', 'ceshi1234', '779946期:\\n8 + 2 + 1 = 11(小单)', '2016-09-07 19:05:03', '2016-09-07 19:05:04', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2621', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:05:03', '2016-09-07 19:05:05', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2622', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:05:03', '2016-09-07 19:05:06', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2623', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：9 9 26 17 8 19 12 12 16 15 15 6 15 8 11_suffix_open_prizing', '2016-09-07 19:05:03', '2016-09-07 19:05:07', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2624', null, '1', '21', 'ceshi1234', '779947期:\\n7 + 0 + 6 = 13(小单)', '2016-09-07 19:10:13', '2016-09-07 19:10:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2625', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:10:13', '2016-09-07 19:10:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2626', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:10:13', '2016-09-07 19:10:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2627', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：9 26 17 8 19 12 12 16 15 15 6 15 8 11 13_suffix_open_prizing', '2016-09-07 19:10:13', '2016-09-07 19:10:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2628', null, '1', '21', 'ceshi1234', '779948期:\\n5 + 6 + 1 = 12(小双)', '2016-09-07 19:15:13', '2016-09-07 19:15:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2629', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:15:13', '2016-09-07 19:15:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2630', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:15:13', '2016-09-07 19:15:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2631', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：26 17 8 19 12 12 16 15 15 6 15 8 11 13 12_suffix_open_prizing', '2016-09-07 19:15:13', '2016-09-07 19:15:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2632', null, '1', '21', 'ceshi1234', '779949期:\\n4 + 0 + 1 = 5(小单)', '2016-09-07 19:20:13', '2016-09-07 19:20:14', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2633', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:20:13', '2016-09-07 19:20:15', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2634', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:20:13', '2016-09-07 19:20:16', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2635', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 8 19 12 12 16 15 15 6 15 8 11 13 12 5_suffix_open_prizing', '2016-09-07 19:20:13', '2016-09-07 19:20:17', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2636', null, '1', '21', 'ceshi1234', '779950期:\\n1 + 6 + 3 = 10(小双)', '2016-09-07 19:25:03', '2016-09-07 19:25:04', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2637', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:25:03', '2016-09-07 19:25:05', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2638', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:25:03', '2016-09-07 19:25:06', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2639', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：8 19 12 12 16 15 15 6 15 8 11 13 12 5 10_suffix_open_prizing', '2016-09-07 19:25:03', '2016-09-07 19:25:07', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2640', null, '1', '21', 'ceshi1234', '779951期:\\n1 + 4 + 7 = 12(小双)', '2016-09-07 19:30:14', '2016-09-07 19:30:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2641', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:30:14', '2016-09-07 19:30:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2642', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:30:14', '2016-09-07 19:30:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2643', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 12 12 16 15 15 6 15 8 11 13 12 5 10 12_suffix_open_prizing', '2016-09-07 19:30:14', '2016-09-07 19:30:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2644', null, '1', '21', 'ceshi1234', '779952期:\\n4 + 6 + 7 = 17(大单)', '2016-09-07 19:35:04', '2016-09-07 19:35:05', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2645', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:35:04', '2016-09-07 19:35:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2646', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:35:04', '2016-09-07 19:35:07', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2647', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 12 16 15 15 6 15 8 11 13 12 5 10 12 17_suffix_open_prizing', '2016-09-07 19:35:04', '2016-09-07 19:35:08', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2648', null, '1', '21', 'ceshi1234', '779953期:\\n7 + 2 + 0 = 9(小单)', '2016-09-07 19:40:14', '2016-09-07 19:40:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2649', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:40:14', '2016-09-07 19:40:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2650', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:40:14', '2016-09-07 19:40:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2651', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 16 15 15 6 15 8 11 13 12 5 10 12 17 9_suffix_open_prizing', '2016-09-07 19:40:14', '2016-09-07 19:40:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2652', null, '1', '21', 'ceshi1234', '779954期:\\n9 + 7 + 1 = 17(大单)', '2016-09-07 19:45:04', '2016-09-07 19:45:05', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2653', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:45:04', '2016-09-07 19:45:06', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2654', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:45:04', '2016-09-07 19:45:07', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2655', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：16 15 15 6 15 8 11 13 12 5 10 12 17 9 17_suffix_open_prizing', '2016-09-07 19:45:04', '2016-09-07 19:45:08', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2656', null, '1', '21', 'ceshi1234', '779955期:\\n9 + 6 + 2 = 17(大单)', '2016-09-07 19:50:14', '2016-09-07 19:50:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2657', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:50:14', '2016-09-07 19:50:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2658', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:50:14', '2016-09-07 19:50:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2659', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 15 6 15 8 11 13 12 5 10 12 17 9 17 17_suffix_open_prizing', '2016-09-07 19:50:14', '2016-09-07 19:50:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2660', null, '1', '21', 'ceshi1234', '779956期:\\n4 + 4 + 9 = 17(大单)', '2016-09-07 19:55:04', '2016-09-07 19:55:05', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2661', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 19:55:04', '2016-09-07 19:55:06', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2662', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 19:55:04', '2016-09-07 19:55:07', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2663', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 6 15 8 11 13 12 5 10 12 17 9 17 17 17_suffix_open_prizing', '2016-09-07 19:55:04', '2016-09-07 19:55:08', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2664', null, '1', '21', 'ceshi1234', '779957期:\\n9 + 6 + 8 = 23(大单, 极大)', '2016-09-07 20:00:14', '2016-09-07 20:00:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2665', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:00:14', '2016-09-07 20:00:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2666', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:00:14', '2016-09-07 20:00:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2667', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：6 15 8 11 13 12 5 10 12 17 9 17 17 17 23_suffix_open_prizing', '2016-09-07 20:00:14', '2016-09-07 20:00:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2668', null, '1', '21', 'ceshi1234', '779958期:\\n8 + 1 + 9 = 18(大双)', '2016-09-07 20:05:14', '2016-09-07 20:05:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2669', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:05:14', '2016-09-07 20:05:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2670', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:05:14', '2016-09-07 20:05:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2671', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 8 11 13 12 5 10 12 17 9 17 17 17 23 18_suffix_open_prizing', '2016-09-07 20:05:14', '2016-09-07 20:05:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2672', null, '1', '21', 'ceshi1234', '779959期:\\n2 + 1 + 7 = 10(小双)', '2016-09-07 20:10:24', '2016-09-07 20:10:25', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2673', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:10:24', '2016-09-07 20:10:26', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2674', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:10:24', '2016-09-07 20:10:27', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2675', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：8 11 13 12 5 10 12 17 9 17 17 17 23 18 10_suffix_open_prizing', '2016-09-07 20:10:24', '2016-09-07 20:10:28', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2676', null, '1', '21', 'ceshi1234', '779960期:\\n4 + 7 + 7 = 18(大双)', '2016-09-07 20:15:14', '2016-09-07 20:15:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2677', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:15:14', '2016-09-07 20:15:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2678', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:15:14', '2016-09-07 20:15:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2679', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 13 12 5 10 12 17 9 17 17 17 23 18 10 18_suffix_open_prizing', '2016-09-07 20:15:14', '2016-09-07 20:15:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2680', null, '1', '21', 'ceshi1234', '779961期:\\n1 + 8 + 5 = 14(大双)', '2016-09-07 20:20:04', '2016-09-07 20:20:05', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2681', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:20:04', '2016-09-07 20:20:06', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2682', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:20:04', '2016-09-07 20:20:07', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2683', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：13 12 5 10 12 17 9 17 17 17 23 18 10 18 14_suffix_open_prizing', '2016-09-07 20:20:04', '2016-09-07 20:20:08', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2684', null, '1', '21', 'ceshi1234', '779962期:\\n5 + 4 + 2 = 11(小单)', '2016-09-07 20:25:04', '2016-09-07 20:25:05', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2685', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:25:04', '2016-09-07 20:25:06', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2686', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:25:04', '2016-09-07 20:25:07', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2687', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 5 10 12 17 9 17 17 17 23 18 10 18 14 11_suffix_open_prizing', '2016-09-07 20:25:04', '2016-09-07 20:25:08', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2688', null, '1', '21', 'ceshi1234', '779963期:\\n5 + 4 + 8 = 17(大单)', '2016-09-07 20:30:04', '2016-09-07 20:30:05', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2689', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:30:04', '2016-09-07 20:30:06', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2690', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:30:04', '2016-09-07 20:30:07', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2691', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：5 10 12 17 9 17 17 17 23 18 10 18 14 11 17_suffix_open_prizing', '2016-09-07 20:30:04', '2016-09-07 20:30:08', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2692', null, '1', '21', 'ceshi1234', '779964期:\\n2 + 4 + 4 = 10(小双)', '2016-09-07 20:35:05', '2016-09-07 20:35:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2693', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:35:05', '2016-09-07 20:35:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2694', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:35:05', '2016-09-07 20:35:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2695', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：10 12 17 9 17 17 17 23 18 10 18 14 11 17 10_suffix_open_prizing', '2016-09-07 20:35:05', '2016-09-07 20:35:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2696', null, '1', '21', 'ceshi1234', '779965期:\\n9 + 1 + 3 = 13(小单)', '2016-09-07 20:40:05', '2016-09-07 20:40:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2697', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:40:05', '2016-09-07 20:40:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2698', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:40:05', '2016-09-07 20:40:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2699', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 17 9 17 17 17 23 18 10 18 14 11 17 10 13_suffix_open_prizing', '2016-09-07 20:40:05', '2016-09-07 20:40:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2700', null, '1', '21', 'ceshi1234', '779966期:\\n4 + 8 + 2 = 14(大双)', '2016-09-07 20:45:05', '2016-09-07 20:45:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2701', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:45:05', '2016-09-07 20:45:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2702', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:45:05', '2016-09-07 20:45:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2703', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 9 17 17 17 23 18 10 18 14 11 17 10 13 14_suffix_open_prizing', '2016-09-07 20:45:05', '2016-09-07 20:45:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2704', null, '1', '21', 'ceshi1234', '779967期:\\n1 + 0 + 5 = 6(小双)', '2016-09-07 20:50:15', '2016-09-07 20:50:16', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2705', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:50:15', '2016-09-07 20:50:17', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2706', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:50:15', '2016-09-07 20:50:18', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2707', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：9 17 17 17 23 18 10 18 14 11 17 10 13 14 6_suffix_open_prizing', '2016-09-07 20:50:15', '2016-09-07 20:50:19', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2708', null, '1', '21', 'ceshi1234', '779968期:\\n9 + 2 + 7 = 18(大双)', '2016-09-07 20:55:05', '2016-09-07 20:55:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2709', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 20:55:05', '2016-09-07 20:55:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2710', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 20:55:05', '2016-09-07 20:55:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2711', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 17 17 23 18 10 18 14 11 17 10 13 14 6 18_suffix_open_prizing', '2016-09-07 20:55:05', '2016-09-07 20:55:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2712', null, '1', '21', 'ceshi1234', '779969期:\\n6 + 0 + 5 = 11(小单)', '2016-09-07 21:00:15', '2016-09-07 21:00:16', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2713', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:00:15', '2016-09-07 21:00:17', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2714', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:00:15', '2016-09-07 21:00:18', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2715', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 17 23 18 10 18 14 11 17 10 13 14 6 18 11_suffix_open_prizing', '2016-09-07 21:00:15', '2016-09-07 21:00:19', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2716', null, '1', '21', 'ceshi1234', '779970期:\\n6 + 7 + 0 = 13(小单)', '2016-09-07 21:05:05', '2016-09-07 21:05:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2717', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:05:05', '2016-09-07 21:05:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2718', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:05:05', '2016-09-07 21:05:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2719', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 23 18 10 18 14 11 17 10 13 14 6 18 11 13_suffix_open_prizing', '2016-09-07 21:05:05', '2016-09-07 21:05:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2720', null, '1', '21', 'ceshi1234', '779971期:\\n3+8+8=19(大单)', '2016-09-07 21:10:25', '2016-09-07 21:10:26', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2721', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:10:25', '2016-09-07 21:10:27', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2722', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:10:25', '2016-09-07 21:10:28', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2723', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：23 18 10 18 14 11 17 10 13 14 6 18 11 13 19_suffix_open_prizing', '2016-09-07 21:10:25', '2016-09-07 21:10:29', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2724', null, '1', '21', 'ceshi1234', '779972期:\\n6 + 9 + 8 = 23(大单, 极大)', '2016-09-07 21:15:05', '2016-09-07 21:15:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2725', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:15:05', '2016-09-07 21:15:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2726', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:15:05', '2016-09-07 21:15:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2727', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：18 10 18 14 11 17 10 13 14 6 18 11 13 19 23_suffix_open_prizing', '2016-09-07 21:15:05', '2016-09-07 21:15:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2728', null, '1', '21', 'ceshi1234', '779973期:\\n5 + 2 + 6 = 13(小单)', '2016-09-07 21:20:25', '2016-09-07 21:20:26', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2729', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:20:25', '2016-09-07 21:20:27', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2730', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:20:25', '2016-09-07 21:20:28', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2731', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：10 18 14 11 17 10 13 14 6 18 11 13 19 23 13_suffix_open_prizing', '2016-09-07 21:20:25', '2016-09-07 21:20:29', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2732', null, '1', '21', 'ceshi1234', '779974期:\\n1 + 1 + 0 = 2(小双, 极小)', '2016-09-07 21:25:05', '2016-09-07 21:25:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2733', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:25:05', '2016-09-07 21:25:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2734', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:25:05', '2016-09-07 21:25:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2735', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：18 14 11 17 10 13 14 6 18 11 13 19 23 13 2_suffix_open_prizing', '2016-09-07 21:25:05', '2016-09-07 21:25:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2736', null, '1', '21', 'ceshi1234', '779975期:\\n2 + 4 + 2 = 8(小双)', '2016-09-07 21:30:25', '2016-09-07 21:30:26', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2737', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:30:25', '2016-09-07 21:30:27', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2738', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:30:25', '2016-09-07 21:30:28', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2739', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：14 11 17 10 13 14 6 18 11 13 19 23 13 2 8_suffix_open_prizing', '2016-09-07 21:30:25', '2016-09-07 21:30:29', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2740', null, '1', '21', 'ceshi1234', '779976期:\\n1 + 4 + 2 = 7(小单)', '2016-09-07 21:35:05', '2016-09-07 21:35:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2741', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:35:05', '2016-09-07 21:35:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2742', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:35:05', '2016-09-07 21:35:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2743', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 17 10 13 14 6 18 11 13 19 23 13 2 8 7_suffix_open_prizing', '2016-09-07 21:35:05', '2016-09-07 21:35:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2744', null, '1', '21', 'ceshi1234', '779977期:\\n7 + 6 + 8 = 21(大单)', '2016-09-07 21:40:26', '2016-09-07 21:40:27', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2745', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:40:26', '2016-09-07 21:40:28', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2746', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:40:26', '2016-09-07 21:40:29', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2747', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 10 13 14 6 18 11 13 19 23 13 2 8 7 21_suffix_open_prizing', '2016-09-07 21:40:26', '2016-09-07 21:40:30', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2748', null, '1', '21', 'ceshi1234', '779978期:\\n9 + 3 + 5 = 17(大单)', '2016-09-07 21:45:06', '2016-09-07 21:45:07', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2749', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:45:06', '2016-09-07 21:45:08', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2750', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:45:06', '2016-09-07 21:45:09', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2751', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：10 13 14 6 18 11 13 19 23 13 2 8 7 21 17_suffix_open_prizing', '2016-09-07 21:45:06', '2016-09-07 21:45:10', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2752', null, '1', '21', 'ceshi1234', '779979期:\\n6 + 3 + 3 = 12(小双)', '2016-09-07 21:50:16', '2016-09-07 21:50:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2753', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:50:16', '2016-09-07 21:50:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2754', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:50:16', '2016-09-07 21:50:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2755', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：13 14 6 18 11 13 19 23 13 2 8 7 21 17 12_suffix_open_prizing', '2016-09-07 21:50:16', '2016-09-07 21:50:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2756', null, '1', '21', 'ceshi1234', '779980期:\\n2 + 7 + 2 = 11(小单)', '2016-09-07 21:55:06', '2016-09-07 21:55:07', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2757', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 21:55:06', '2016-09-07 21:55:08', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2758', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 21:55:06', '2016-09-07 21:55:09', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2759', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：14 6 18 11 13 19 23 13 2 8 7 21 17 12 11_suffix_open_prizing', '2016-09-07 21:55:06', '2016-09-07 21:55:10', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2760', null, '1', '21', 'ceshi1234', '779981期:\\n1+4+6=11(小单)', '2016-09-07 22:00:26', '2016-09-07 22:00:27', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2761', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:00:26', '2016-09-07 22:00:28', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2762', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:00:26', '2016-09-07 22:00:29', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2763', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：6 18 11 13 19 23 13 2 8 7 21 17 12 11 11_suffix_open_prizing', '2016-09-07 22:00:26', '2016-09-07 22:00:30', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2764', null, '1', '21', 'ceshi1234', '779982期:\\n5 + 5 + 9 = 19(大单)', '2016-09-07 22:05:06', '2016-09-07 22:05:07', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2765', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:05:06', '2016-09-07 22:05:08', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2766', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:05:06', '2016-09-07 22:05:09', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2767', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：18 11 13 19 23 13 2 8 7 21 17 12 11 11 19_suffix_open_prizing', '2016-09-07 22:05:06', '2016-09-07 22:05:10', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2768', null, '1', '21', 'ceshi1234', '779983期:\\n7 + 6 + 8 = 21(大单)', '2016-09-07 22:10:16', '2016-09-07 22:10:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2769', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:10:16', '2016-09-07 22:10:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2770', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:10:16', '2016-09-07 22:10:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2771', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 13 19 23 13 2 8 7 21 17 12 11 11 19 21_suffix_open_prizing', '2016-09-07 22:10:16', '2016-09-07 22:10:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2772', null, '1', '21', 'ceshi1234', '779984期:\\n1 + 5 + 6 = 12(小双)', '2016-09-07 22:15:06', '2016-09-07 22:15:07', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2773', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:15:06', '2016-09-07 22:15:08', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2774', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:15:06', '2016-09-07 22:15:09', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2775', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：13 19 23 13 2 8 7 21 17 12 11 11 19 21 12_suffix_open_prizing', '2016-09-07 22:15:06', '2016-09-07 22:15:10', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2776', null, '1', '21', 'ceshi1234', '779985期:\\n9 + 2 + 7 = 18(大双)', '2016-09-07 22:20:16', '2016-09-07 22:20:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2777', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:20:16', '2016-09-07 22:20:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2778', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:20:16', '2016-09-07 22:20:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2779', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 23 13 2 8 7 21 17 12 11 11 19 21 12 18_suffix_open_prizing', '2016-09-07 22:20:16', '2016-09-07 22:20:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2780', null, '1', '21', 'ceshi1234', '779986期:\\n0 + 5 + 1 = 6(小双)', '2016-09-07 22:25:16', '2016-09-07 22:25:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2781', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:25:16', '2016-09-07 22:25:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2782', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:25:16', '2016-09-07 22:25:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2783', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：23 13 2 8 7 21 17 12 11 11 19 21 12 18 6_suffix_open_prizing', '2016-09-07 22:25:16', '2016-09-07 22:25:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2784', null, '1', '21', 'ceshi1234', '779987期:\\n2 + 8 + 5 = 15(大单)', '2016-09-07 22:30:16', '2016-09-07 22:30:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2785', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:30:16', '2016-09-07 22:30:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2786', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:30:16', '2016-09-07 22:30:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2787', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：13 2 8 7 21 17 12 11 11 19 21 12 18 6 15_suffix_open_prizing', '2016-09-07 22:30:16', '2016-09-07 22:30:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2788', null, '1', '21', 'ceshi1234', '779988期:\\n9 + 7 + 2 = 18(大双)', '2016-09-07 22:35:06', '2016-09-07 22:35:07', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2789', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:35:06', '2016-09-07 22:35:08', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2790', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:35:06', '2016-09-07 22:35:09', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2791', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：2 8 7 21 17 12 11 11 19 21 12 18 6 15 18_suffix_open_prizing', '2016-09-07 22:35:06', '2016-09-07 22:35:10', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2792', null, '1', '21', 'ceshi1234', '779989期:\\n8 + 5 + 9 = 22(大双)', '2016-09-07 22:40:16', '2016-09-07 22:40:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2793', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:40:16', '2016-09-07 22:40:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2794', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:40:16', '2016-09-07 22:40:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2795', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：8 7 21 17 12 11 11 19 21 12 18 6 15 18 22_suffix_open_prizing', '2016-09-07 22:40:16', '2016-09-07 22:40:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2796', null, '1', '21', 'ceshi1234', '779990期:\\n3 + 1 + 8 = 12(小双)', '2016-09-07 22:45:16', '2016-09-07 22:45:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2797', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:45:16', '2016-09-07 22:45:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2798', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:45:16', '2016-09-07 22:45:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2799', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：7 21 17 12 11 11 19 21 12 18 6 15 18 22 12_suffix_open_prizing', '2016-09-07 22:45:16', '2016-09-07 22:45:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2800', null, '1', '21', 'ceshi1234', '779991期:\\n7 + 7 + 1 = 15(大单)', '2016-09-07 22:50:16', '2016-09-07 22:50:17', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2801', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:50:16', '2016-09-07 22:50:18', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2802', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:50:16', '2016-09-07 22:50:19', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2803', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 17 12 11 11 19 21 12 18 6 15 18 22 12 15_suffix_open_prizing', '2016-09-07 22:50:16', '2016-09-07 22:50:20', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2804', null, '1', '21', 'ceshi1234', '779992期:\\n1 + 8 + 5 = 14(大双)', '2016-09-07 22:55:07', '2016-09-07 22:55:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2805', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 22:55:07', '2016-09-07 22:55:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2806', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 22:55:07', '2016-09-07 22:55:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2807', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：17 12 11 11 19 21 12 18 6 15 18 22 12 15 14_suffix_open_prizing', '2016-09-07 22:55:07', '2016-09-07 22:55:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2808', null, '1', '21', 'ceshi1234', '779993期:\\n0 + 0 + 2 = 2(小双, 极小)', '2016-09-07 23:00:17', '2016-09-07 23:00:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2809', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:00:17', '2016-09-07 23:00:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2810', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:00:17', '2016-09-07 23:00:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2811', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 11 11 19 21 12 18 6 15 18 22 12 15 14 2_suffix_open_prizing', '2016-09-07 23:00:17', '2016-09-07 23:00:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2812', null, '1', '21', 'ceshi1234', '779994期:\\n7 + 6 + 2 = 15(大单)', '2016-09-07 23:05:07', '2016-09-07 23:05:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2813', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:05:07', '2016-09-07 23:05:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2814', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:05:07', '2016-09-07 23:05:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2815', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 11 19 21 12 18 6 15 18 22 12 15 14 2 15_suffix_open_prizing', '2016-09-07 23:05:07', '2016-09-07 23:05:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2816', null, '1', '21', 'ceshi1234', '779995期:\\n7 + 1 + 2 = 10(小双)', '2016-09-07 23:10:17', '2016-09-07 23:10:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2817', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:10:17', '2016-09-07 23:10:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2818', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:10:17', '2016-09-07 23:10:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2819', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 19 21 12 18 6 15 18 22 12 15 14 2 15 10_suffix_open_prizing', '2016-09-07 23:10:17', '2016-09-07 23:10:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2820', null, '1', '21', 'ceshi1234', '779996期:\\n7 + 5 + 2 = 14(大双)', '2016-09-07 23:15:07', '2016-09-07 23:15:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2821', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:15:07', '2016-09-07 23:15:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2822', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:15:07', '2016-09-07 23:15:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2823', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 21 12 18 6 15 18 22 12 15 14 2 15 10 14_suffix_open_prizing', '2016-09-07 23:15:07', '2016-09-07 23:15:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2824', null, '1', '21', 'ceshi1234', '779997期:\\n6 + 3 + 2 = 11(小单)', '2016-09-07 23:20:17', '2016-09-07 23:20:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2825', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:20:17', '2016-09-07 23:20:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2826', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:20:17', '2016-09-07 23:20:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2827', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：21 12 18 6 15 18 22 12 15 14 2 15 10 14 11_suffix_open_prizing', '2016-09-07 23:20:17', '2016-09-07 23:20:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2828', null, '1', '21', 'ceshi1234', '779998期:\\n6 + 9 + 7 = 22(大双)', '2016-09-07 23:25:17', '2016-09-07 23:25:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2829', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:25:17', '2016-09-07 23:25:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2830', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:25:17', '2016-09-07 23:25:22', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2831', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 18 6 15 18 22 12 15 14 2 15 10 14 11 22_suffix_open_prizing', '2016-09-07 23:25:17', '2016-09-07 23:25:22', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2832', null, '1', '21', 'ceshi1234', '779999期:\\n6 + 4 + 0 = 10(小双)', '2016-09-07 23:30:17', '2016-09-07 23:30:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2833', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:30:17', '2016-09-07 23:30:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2834', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:30:17', '2016-09-07 23:30:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2835', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：18 6 15 18 22 12 15 14 2 15 10 14 11 22 10_suffix_open_prizing', '2016-09-07 23:30:17', '2016-09-07 23:30:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2836', null, '1', '21', 'ceshi1234', '780000期:\\n2 + 7 + 6 = 15(大单)', '2016-09-07 23:35:27', '2016-09-07 23:35:28', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2837', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:35:27', '2016-09-07 23:35:35', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2838', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:35:27', '2016-09-07 23:35:35', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2839', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：6 15 18 22 12 15 14 2 15 10 14 11 22 10 15_suffix_open_prizing', '2016-09-07 23:35:27', '2016-09-07 23:35:35', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2840', null, '1', '21', 'ceshi1234', '780001期:\\n6 + 3 + 9 = 18(大双)', '2016-09-07 23:40:17', '2016-09-07 23:40:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2841', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:40:17', '2016-09-07 23:40:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2842', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:40:17', '2016-09-07 23:40:22', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2843', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 18 22 12 15 14 2 15 10 14 11 22 10 15 18_suffix_open_prizing', '2016-09-07 23:40:17', '2016-09-07 23:40:22', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2844', null, '1', '21', 'ceshi1234', '780002期:\\n6 + 4 + 4 = 14(大双)', '2016-09-07 23:45:07', '2016-09-07 23:45:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2845', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:45:07', '2016-09-07 23:45:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2846', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:45:07', '2016-09-07 23:45:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2847', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：18 22 12 15 14 2 15 10 14 11 22 10 15 18 14_suffix_open_prizing', '2016-09-07 23:45:07', '2016-09-07 23:45:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2848', null, '1', '21', 'ceshi1234', '780003期:\\n1 + 6 + 1 = 8(小双)', '2016-09-07 23:50:07', '2016-09-07 23:50:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2849', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:50:07', '2016-09-07 23:50:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2850', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:50:07', '2016-09-07 23:50:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2851', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：22 12 15 14 2 15 10 14 11 22 10 15 18 14 8_suffix_open_prizing', '2016-09-07 23:50:07', '2016-09-07 23:50:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2852', null, '1', '21', 'ceshi1234', '780004期:\\n3 + 7 + 9 = 19(大单)', '2016-09-07 23:55:07', '2016-09-07 23:55:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2853', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-07 23:55:07', '2016-09-07 23:55:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2854', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-07 23:55:07', '2016-09-07 23:55:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2855', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 15 14 2 15 10 14 11 22 10 15 18 14 8 19_suffix_open_prizing', '2016-09-07 23:55:07', '2016-09-07 23:55:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2856', null, '1', '101', 'ceshi1234', '系统开启,当前期:780013', '2016-09-08 09:42:40', '2016-09-08 09:42:40', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2857', null, '1', '21', 'ceshi1234', '780012期:\\n8+7+1=16(大双)', '2016-09-08 09:42:47', '2016-09-08 09:42:48', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2858', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 09:42:47', '2016-09-08 09:42:49', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2859', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 09:42:47', '2016-09-08 09:42:50', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2860', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 14 2 15 10 14 11 22 10 15 18 14 8 19 16_suffix_open_prizing', '2016-09-08 09:42:47', '2016-09-08 09:42:51', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2861', null, '1', '21', 'ceshi1234', '780013期:\\n2 + 7 + 6 = 15(大单)', '2016-09-08 09:45:07', '2016-09-08 09:45:08', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2862', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 09:45:07', '2016-09-08 09:45:09', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2863', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 09:45:07', '2016-09-08 09:45:10', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2864', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：14 2 15 10 14 11 22 10 15 18 14 8 19 16 15_suffix_open_prizing', '2016-09-08 09:45:07', '2016-09-08 09:45:11', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2865', null, '1', '21', 'ceshi1234', '780014期:\\n5 + 9 + 0 = 14(大双)', '2016-09-08 09:50:17', '2016-09-08 09:50:18', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2866', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 09:50:17', '2016-09-08 09:50:19', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2867', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 09:50:17', '2016-09-08 09:50:20', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2868', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：2 15 10 14 11 22 10 15 18 14 8 19 16 15 14_suffix_open_prizing', '2016-09-08 09:50:17', '2016-09-08 09:50:21', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2869', null, '1', '101', 'ceshi1234', '系统开启,当前期:780019', '2016-09-08 10:13:58', '2016-09-08 10:13:58', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2870', null, '1', '21', 'ceshi1234', '780018期:\\n6 + 1 + 5 = 12(小双)', '2016-09-08 10:14:05', '2016-09-08 10:14:06', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2871', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:14:05', '2016-09-08 10:14:07', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2872', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:14:05', '2016-09-08 10:14:08', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2873', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 10 14 11 22 10 15 18 14 8 19 16 15 14 12_suffix_open_prizing', '2016-09-08 10:14:05', '2016-09-08 10:14:09', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2874', null, '1', '21', 'ceshi1234', '780019期:\\n9 + 0 + 7 = 16(大双)', '2016-09-08 10:15:06', '2016-09-08 10:15:07', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2875', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:15:06', '2016-09-08 10:15:08', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2876', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:15:06', '2016-09-08 10:15:09', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2877', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：10 14 11 22 10 15 18 14 8 19 16 15 14 12 16_suffix_open_prizing', '2016-09-08 10:15:06', '2016-09-08 10:15:10', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2878', null, '1', '101', 'ceshi1234', '系统开启,当前期:780021', '2016-09-08 10:23:52', '2016-09-08 10:23:52', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2879', null, '1', '21', 'ceshi1234', '780020期:\\n9+1+2=12(小双)', '2016-09-08 10:24:00', '2016-09-08 10:24:01', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2880', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:24:00', '2016-09-08 10:24:02', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2881', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:24:00', '2016-09-08 10:24:03', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2882', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：14 11 22 10 15 18 14 8 19 16 15 14 12 16 12_suffix_open_prizing', '2016-09-08 10:24:00', '2016-09-08 10:24:04', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2883', null, '1', '21', 'ceshi1234', '780021期:\\n4 + 6 + 1 = 11(小单)', '2016-09-08 10:25:10', '2016-09-08 10:25:11', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2884', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:25:10', '2016-09-08 10:25:12', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2885', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:25:10', '2016-09-08 10:25:13', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2886', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 22 10 15 18 14 8 19 16 15 14 12 16 12 11_suffix_open_prizing', '2016-09-08 10:25:10', '2016-09-08 10:25:14', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2887', null, '1', '21', 'ceshi1234', '780022期:\\n4 + 3 + 9 = 16(大双)', '2016-09-08 10:30:10', '2016-09-08 10:30:11', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2888', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:30:10', '2016-09-08 10:30:12', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2889', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:30:10', '2016-09-08 10:30:13', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2890', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：22 10 15 18 14 8 19 16 15 14 12 16 12 11 16_suffix_open_prizing', '2016-09-08 10:30:10', '2016-09-08 10:30:14', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2891', null, '1', '21', 'ceshi1234', '780023期:\\n5 + 2 + 8 = 15(大单)', '2016-09-08 10:35:10', '2016-09-08 10:35:11', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2892', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:35:10', '2016-09-08 10:35:12', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2893', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:35:10', '2016-09-08 10:35:13', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2894', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：10 15 18 14 8 19 16 15 14 12 16 12 11 16 15_suffix_open_prizing', '2016-09-08 10:35:10', '2016-09-08 10:35:14', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2895', null, '1', '21', 'ceshi1234', '780024期:\\n7 + 0 + 1 = 8(小双)', '2016-09-08 10:40:21', '2016-09-08 10:40:22', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2896', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:40:21', '2016-09-08 10:40:23', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2897', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:40:21', '2016-09-08 10:40:24', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2898', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 18 14 8 19 16 15 14 12 16 12 11 16 15 8_suffix_open_prizing', '2016-09-08 10:40:21', '2016-09-08 10:40:25', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2899', null, '1', '21', 'ceshi1234', '780025期:\\n8 + 5 + 8 = 21(大单)', '2016-09-08 10:45:11', '2016-09-08 10:45:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2900', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:45:11', '2016-09-08 10:45:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2901', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:45:11', '2016-09-08 10:45:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2902', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：18 14 8 19 16 15 14 12 16 12 11 16 15 8 21_suffix_open_prizing', '2016-09-08 10:45:11', '2016-09-08 10:45:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2903', null, '1', '21', 'ceshi1234', '780026期:\\n8+0+5=13(小单)', '2016-09-08 10:50:21', '2016-09-08 10:50:22', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2904', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:50:21', '2016-09-08 10:50:23', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2905', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:50:21', '2016-09-08 10:50:24', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2906', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：14 8 19 16 15 14 12 16 12 11 16 15 8 21 13_suffix_open_prizing', '2016-09-08 10:50:21', '2016-09-08 10:50:25', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2907', null, '1', '21', 'ceshi1234', '780027期:\\n8 + 4 + 6 = 18(大双)', '2016-09-08 10:55:11', '2016-09-08 10:55:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2908', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 10:55:11', '2016-09-08 10:55:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2909', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 10:55:11', '2016-09-08 10:55:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2910', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：8 19 16 15 14 12 16 12 11 16 15 8 21 13 18_suffix_open_prizing', '2016-09-08 10:55:11', '2016-09-08 10:55:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2911', null, '1', '21', 'ceshi1234', '780028期:\\n5 + 3 + 6 = 14(大双)', '2016-09-08 11:00:11', '2016-09-08 11:00:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2912', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 11:00:11', '2016-09-08 11:00:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2913', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 11:00:11', '2016-09-08 11:00:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2914', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 16 15 14 12 16 12 11 16 15 8 21 13 18 14_suffix_open_prizing', '2016-09-08 11:00:11', '2016-09-08 11:00:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2915', null, '1', '101', 'ceshi1234', '系统开启,当前期:780030', '2016-09-08 11:07:21', '2016-09-08 11:07:21', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2916', null, '1', '21', 'ceshi1234', '780029期:\\n4+3+0=7(小单)', '2016-09-08 11:07:34', '2016-09-08 11:07:35', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2917', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 11:07:34', '2016-09-08 11:07:36', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2918', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 11:07:34', '2016-09-08 11:07:37', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2919', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：16 15 14 12 16 12 11 16 15 8 21 13 18 14 7_suffix_open_prizing', '2016-09-08 11:07:34', '2016-09-08 11:07:38', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2920', null, '1', '21', 'ceshi1234', '780030期:\\n8 + 5 + 2 = 15(大单)', '2016-09-08 11:10:14', '2016-09-08 11:10:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2921', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 11:10:14', '2016-09-08 11:10:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2922', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 11:10:14', '2016-09-08 11:10:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2923', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：15 14 12 16 12 11 16 15 8 21 13 18 14 7 15_suffix_open_prizing', '2016-09-08 11:10:14', '2016-09-08 11:10:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2924', null, '1', '21', 'ceshi1234', '780031期:\\n8 + 4 + 0 = 12(小双)', '2016-09-08 11:15:14', '2016-09-08 11:15:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2925', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 11:15:14', '2016-09-08 11:15:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2926', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 11:15:14', '2016-09-08 11:15:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2927', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：14 12 16 12 11 16 15 8 21 13 18 14 7 15 12_suffix_open_prizing', '2016-09-08 11:15:14', '2016-09-08 11:15:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2928', null, '1', '21', 'ceshi1234', '780032期:\\n9 + 4 + 9 = 22(大双)', '2016-09-08 11:20:14', '2016-09-08 11:20:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2929', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 11:20:14', '2016-09-08 11:20:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2930', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 11:20:14', '2016-09-08 11:20:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2931', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 16 12 11 16 15 8 21 13 18 14 7 15 12 22_suffix_open_prizing', '2016-09-08 11:20:14', '2016-09-08 11:20:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2932', null, '1', '21', 'ceshi1234', '780033期:\\n2 + 7 + 9 = 18(大双)', '2016-09-08 11:25:14', '2016-09-08 11:25:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2933', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 11:25:14', '2016-09-08 11:25:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2934', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 11:25:14', '2016-09-08 11:25:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2935', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：16 12 11 16 15 8 21 13 18 14 7 15 12 22 18_suffix_open_prizing', '2016-09-08 11:25:14', '2016-09-08 11:25:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2936', null, '1', '101', 'ceshi1234', '系统开启,当前期:780055', '2016-09-08 13:14:40', '2016-09-08 13:14:40', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2937', null, '1', '21', 'ceshi1234', '780054期:\\n0+7+5=12(小双)', '2016-09-08 13:14:48', '2016-09-08 13:14:49', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2938', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 13:14:48', '2016-09-08 13:14:50', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2939', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 13:14:48', '2016-09-08 13:14:51', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2940', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：12 11 16 15 8 21 13 18 14 7 15 12 22 18 12_suffix_open_prizing', '2016-09-08 13:14:48', '2016-09-08 13:14:53', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2941', null, '1', '21', 'ceshi1234', '780055期:\\n5 + 2 + 2 = 9(小单)', '2016-09-08 13:15:18', '2016-09-08 13:15:19', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2942', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 13:15:18', '2016-09-08 13:15:21', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2943', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 13:15:18', '2016-09-08 13:15:21', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2944', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 16 15 8 21 13 18 14 7 15 12 22 18 12 9_suffix_open_prizing', '2016-09-08 13:15:18', '2016-09-08 13:15:23', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2945', null, '1', '101', 'ceshi1234', '系统开启,当前期:780056', '2016-09-08 13:18:53', '2016-09-08 13:18:54', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2946', null, '1', '21', 'ceshi1234', '780055期:\\n5 + 2 + 2 = 9(小单)', '2016-09-08 13:18:55', '2016-09-08 13:18:56', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2947', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 13:18:55', '2016-09-08 13:18:57', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2948', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:2\\n账面总额:013820\\n┉┉┉┉┉┉┉┉┉┉┉\\n11111111008000 555678005820<br>\\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 13:18:55', '2016-09-08 13:18:58', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2949', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：11 16 15 8 21 13 18 14 7 15 12 22 18 12 9_suffix_open_prizing', '2016-09-08 13:18:55', '2016-09-08 13:18:59', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2950', '80000', '1', '1', 'ceshi1234', '上80000成功,当前积分:80000', '2016-09-08 13:19:40', '2016-09-08 13:19:40', '摩弦', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2951', null, '1', '101', 'ceshi1234', '系统开启,当前期:2042811', '2016-09-08 13:24:44', '2016-09-08 13:24:45', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2952', null, '1', '101', 'ceshi1234', '系统开启,当前期:780091', '2016-09-08 16:14:17', '2016-09-08 16:14:18', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2953', null, '1', '21', 'ceshi1234', '780056期:\\n6+5+5=16(大双)', '2016-09-08 16:14:30', '2016-09-08 16:14:31', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2954', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:+20<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 16:14:30', '2016-09-08 16:14:32', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2955', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:093760\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦079940 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 16:14:30', '2016-09-08 16:14:33', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2956', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：16 15 8 21 13 18 14 7 15 12 22 18 12 9 16_suffix_open_prizing', '2016-09-08 16:14:30', '2016-09-08 16:14:34', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2957', null, '1', '21', 'ceshi1234', '780091期:\\n9 + 4 + 2 = 15(大单)', '2016-09-08 16:15:10', '2016-09-08 16:15:11', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2958', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:+100<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 16:15:10', '2016-09-08 16:15:12', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2959', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:093960\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦080140 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 16:15:10', '2016-09-08 16:15:13', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2960', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：8 21 13 18 14 7 15 12 22 18 12 9 16 8 15_suffix_open_prizing', '2016-09-08 16:15:10', '2016-09-08 16:15:14', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2961', null, '1', '101', 'ceshi1234', '系统开启,当前期:780102', '2016-09-08 17:05:58', '2016-09-08 17:05:59', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2962', null, '1', '21', 'ceshi1234', '780101期:\\n5+1+0=6(小双)', '2016-09-08 17:06:04', '2016-09-08 17:06:05', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2963', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:06:04', '2016-09-08 17:06:06', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2964', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:093960\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦080140 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:06:04', '2016-09-08 17:06:07', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2965', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：6_suffix_open_prizing', '2016-09-08 17:06:04', '2016-09-08 17:06:08', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2966', null, '1', '21', 'ceshi1234', '780102期:\\n8 + 2 + 3 = 13(小单)', '2016-09-08 17:10:14', '2016-09-08 17:10:15', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2967', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:10:14', '2016-09-08 17:10:16', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2968', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:093960\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦080140 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:10:14', '2016-09-08 17:10:17', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2969', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：6 13_suffix_open_prizing', '2016-09-08 17:10:14', '2016-09-08 17:10:18', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2970', null, '1', '101', 'ceshi1234', '系统开启,当前期:780104', '2016-09-08 17:16:27', '2016-09-08 17:16:27', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2971', null, '1', '21', 'ceshi1234', '780104期:\\n6 + 8 + 4 = 18(大双)', '2016-09-08 17:20:11', '2016-09-08 17:20:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2972', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:-900<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:20:11', '2016-09-08 17:20:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2973', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:093060\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦079240 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:20:11', '2016-09-08 17:20:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2974', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 18_suffix_open_prizing', '2016-09-08 17:20:11', '2016-09-08 17:20:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2975', null, '1', '21', 'ceshi1234', '780105期:\\n2 + 6 + 4 = 12(小双)', '2016-09-08 17:25:11', '2016-09-08 17:25:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2976', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:-600<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:25:11', '2016-09-08 17:25:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2977', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:092460\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦078640 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:25:11', '2016-09-08 17:25:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2978', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 18 12_suffix_open_prizing', '2016-09-08 17:25:11', '2016-09-08 17:25:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2979', null, '1', '21', 'ceshi1234', '780106期:\\n2 + 1 + 6 = 9(小单)', '2016-09-08 17:30:11', '2016-09-08 17:30:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2980', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:30:11', '2016-09-08 17:30:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2981', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:092460\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦078640 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:30:11', '2016-09-08 17:30:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2982', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 18 12 9_suffix_open_prizing', '2016-09-08 17:30:11', '2016-09-08 17:30:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2983', null, '1', '21', 'ceshi1234', '780107期:\\n3 + 3 + 0 = 6(小双)', '2016-09-08 17:35:11', '2016-09-08 17:35:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2984', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:0<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:35:11', '2016-09-08 17:35:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2985', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:092460\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦078640 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:35:11', '2016-09-08 17:35:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2986', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 18 12 9 6_suffix_open_prizing', '2016-09-08 17:35:11', '2016-09-08 17:35:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2987', null, '1', '21', 'ceshi1234', '780108期:\\n0 + 6 + 4 = 10(小双)', '2016-09-08 17:40:11', '2016-09-08 17:40:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2988', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:40:11', '2016-09-08 17:40:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2989', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:092460\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦078640 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:40:11', '2016-09-08 17:40:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2990', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 18 12 9 6 10_suffix_open_prizing', '2016-09-08 17:40:11', '2016-09-08 17:40:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2991', null, '1', '21', 'ceshi1234', '780109期:\\n7 + 5 + 1 = 13(小单)', '2016-09-08 17:45:11', '2016-09-08 17:45:12', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2992', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:+110<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 17:45:11', '2016-09-08 17:45:13', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2993', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:092570\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦078750 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 17:45:11', '2016-09-08 17:45:14', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2994', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：19 18 12 9 6 10 13_suffix_open_prizing', '2016-09-08 17:45:11', '2016-09-08 17:45:15', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2995', null, '1', '101', 'ceshi1234', '系统开启,当前期:780113', '2016-09-08 18:04:24', '2016-09-08 18:04:24', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2996', null, '1', '101', 'ceshi1234', '系统开启,当前期:780135', '2016-09-08 19:54:36', '2016-09-08 19:54:37', 'Yj', null, null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2997', null, '1', '21', 'ceshi1234', '780110期:\\n3+9+1=13(小单)', '2016-09-08 19:54:45', '2016-09-08 19:54:46', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2998', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦:-60<br>\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 19:54:45', '2016-09-08 19:54:47', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('2999', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:092510\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦078690 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 19:54:45', '2016-09-08 19:54:48', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('3000', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：_suffix_open_prizing', '2016-09-08 19:54:45', '2016-09-08 19:54:49', null, '4', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('3001', null, '1', '21', 'ceshi1234', '780135期:\\n7 + 7 + 7 = 21(大单, 豹子)', '2016-09-08 19:55:15', '2016-09-08 19:55:16', null, '1', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('3002', null, '1', '21', 'ceshi1234', '上期收益：\\n┉┉┉┉┉┉┉┉┉┉┉\\n\\n┉┉┉┉┉┉┉┉┉┉┉', '2016-09-08 19:55:15', '2016-09-08 19:55:17', null, '2', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('3003', null, '1', '21', 'ceshi1234', '★★★会员余额★★★ \\n在线人数:3\\n账面总额:092510\\n┉┉┉┉┉┉┉┉┉┉┉\\n摩弦078690 11111111008000<br>555678005820 \\n┉┉┉┉┉┉┉┉┉┉┉\\n※※※开 始 下 注※※※\\n账单前下注无效\\n以核对注单为准\\n遇系统网络卡顿\\n以庄家注单为准\\n\\n※转账请先确认最新账号※\\n宝号：13020165182淋淋\\n微信：账房JBGL358\\n\\n#主动加你的都是骗子#\\n#请大家注意谨防受骗#\\n#本公司分群“老虎城”#\\n', '2016-09-08 19:55:15', '2016-09-08 19:55:18', null, '3', null, null);
INSERT INTO `w_add_reduce_money_notice` VALUES ('3004', null, '1', '21', 'ceshi1234', '近 15 期开奖号码：24 21_suffix_open_prizing', '2016-09-08 19:55:15', '2016-09-08 19:55:19', null, '4', null, null);

-- ----------------------------
-- Table structure for `w_bet_info`
-- ----------------------------
DROP TABLE IF EXISTS `w_bet_info`;
CREATE TABLE `w_bet_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nickname` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `uin` varchar(50) DEFAULT NULL COMMENT '微信uin',
  `game_type` varchar(20) DEFAULT NULL COMMENT '游戏类型（xy28：幸运28）',
  `operater` varchar(50) DEFAULT NULL COMMENT '操作者',
  `term` bigint(20) DEFAULT NULL COMMENT '期数',
  `bet_type` varchar(20) DEFAULT NULL COMMENT '下注类型：【大("big"),小("small"),单("odd"),双("even"),大单("big_odd"),小单("small_odd"),大双("big_even"),小双("smal_even"),极大("max"),极小("min"),草("cao");】',
  `bet_mount` int(11) DEFAULT NULL COMMENT '下注金额',
  `bet_number` varchar(50) DEFAULT NULL COMMENT '下注号码:极大为23-27,极小为0-4',
  `bet_msg` varchar(500) DEFAULT NULL COMMENT '下注信息',
  `pay_off` int(11) DEFAULT NULL COMMENT '派彩',
  `after_balance` int(11) DEFAULT NULL COMMENT '下注后金额',
  `state` int(11) DEFAULT NULL COMMENT '状态（1:下注, 2:派彩赢, 3:派彩输, 4:撤销）',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `odds1` varchar(255) DEFAULT NULL COMMENT '赔率1',
  `odds2` varchar(255) DEFAULT NULL COMMENT '赔率2',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=312 DEFAULT CHARSET=utf8 COMMENT='下注信息表';

-- ----------------------------
-- Records of w_bet_info
-- ----------------------------
INSERT INTO `w_bet_info` VALUES ('253', '摩弦', null, 'xy28', 'ceshi1234', '779900', 'big', '400', null, '大400', '0', '6000', '2', '2016-09-07 15:13:52', '2016-09-07 15:15:08', null, null);
INSERT INTO `w_bet_info` VALUES ('254', '摩弦', null, 'xy28', 'ceshi1234', '779900', 'big', '500', null, '大500', '0', '6000', '2', '2016-09-07 15:14:18', '2016-09-07 15:15:08', null, null);
INSERT INTO `w_bet_info` VALUES ('255', '摩弦', null, 'xy28', 'ceshi1234', '779903', 'big', '500', null, '大500', '1000', '6500', '2', '2016-09-07 15:26:25', '2016-09-07 15:30:17', '补单数据', null);
INSERT INTO `w_bet_info` VALUES ('256', '摩弦', null, 'xy28', 'ceshi1234', '779905', 'big', '100', null, '大100', null, '6400', '4', '2016-09-07 15:35:49', null, null, null);
INSERT INTO `w_bet_info` VALUES ('257', '摩弦', null, 'xy28', 'ceshi1234', '779905', 'big', '300', null, '大300', null, '6100', '4', '2016-09-07 15:35:52', null, null, null);
INSERT INTO `w_bet_info` VALUES ('258', '摩弦', null, 'xy28', 'ceshi1234', '779905', 'cancel', '400', null, '取消', null, '6500', '1001', '2016-09-07 15:36:04', null, null, null);
INSERT INTO `w_bet_info` VALUES ('259', '摩弦', null, 'xy28', 'ceshi1234', '779905', 'big', '300', null, '大300', null, '6200', '4', '2016-09-07 15:37:01', null, null, null);
INSERT INTO `w_bet_info` VALUES ('260', '摩弦', null, 'xy28', 'ceshi1234', '779905', 'big', '400', null, '大400', null, '5800', '4', '2016-09-07 15:37:03', null, null, null);
INSERT INTO `w_bet_info` VALUES ('261', '摩弦', null, 'xy28', 'ceshi1234', '779905', 'edit', '700', null, '改小400', null, '6500', '1001', '2016-09-07 15:37:22', null, null, null);
INSERT INTO `w_bet_info` VALUES ('262', '摩弦', null, 'xy28', 'ceshi1234', '779905', 'small', '400', null, '小400', '800', '7800', '2', '2016-09-07 15:37:22', '2016-09-07 15:40:17', null, null);
INSERT INTO `w_bet_info` VALUES ('263', '555678', null, 'xy28', 'ceshi1234', '779911', 'big', '100', null, '大100', '200', '1810', '2', '2016-09-07 16:05:41', '2016-09-07 16:10:08', null, null);
INSERT INTO `w_bet_info` VALUES ('264', '555678', null, 'xy28', 'ceshi1234', '779911', 'small', '200', null, '小200', '0', '1810', '2', '2016-09-07 16:05:41', '2016-09-07 16:10:08', null, null);
INSERT INTO `w_bet_info` VALUES ('265', '555678', null, 'xy28', 'ceshi1234', '779911', 'cao', '90', '12', '12.90', '0', '1810', '2', '2016-09-07 16:05:41', '2016-09-07 16:10:08', null, null);
INSERT INTO `w_bet_info` VALUES ('266', '555678', null, 'xy28', 'ceshi1234', '779934', 'big', '100', null, '大100', '200', '1910', '2', '2016-09-07 18:00:40', '2016-09-07 18:05:12', null, null);
INSERT INTO `w_bet_info` VALUES ('267', '555678', null, 'xy28', 'ceshi1234', '779935', 'all', '0', null, '大20大哈', null, '1910', '1002', '2016-09-07 18:05:46', null, null, null);
INSERT INTO `w_bet_info` VALUES ('268', '555678', null, 'xy28', 'ceshi1234', '779935', 'big', '20', null, '大20', null, '1890', '4', '2016-09-07 18:05:46', null, null, null);
INSERT INTO `w_bet_info` VALUES ('269', '555678', null, 'xy28', 'ceshi1234', '779935', 'all', '0', null, '大20哈大', null, '1910', '1002', '2016-09-07 18:06:06', null, null, null);
INSERT INTO `w_bet_info` VALUES ('270', '555678', null, 'xy28', 'ceshi1234', '779935', 'big', '20', null, '大20', null, '1890', '4', '2016-09-07 18:06:06', null, null, null);
INSERT INTO `w_bet_info` VALUES ('271', '555678', null, 'xy28', 'ceshi1234', '779935', 'all', '0', null, '大1910哈达', null, '1910', '1002', '2016-09-07 18:06:18', null, null, null);
INSERT INTO `w_bet_info` VALUES ('272', '555678', null, 'xy28', 'ceshi1234', '779935', 'big', '1910', null, '大1910', '3820', '5820', '2', '2016-09-07 18:06:18', '2016-09-07 18:10:12', null, null);
INSERT INTO `w_bet_info` VALUES ('273', '555678', null, 'xy28', 'ceshi1234', '779935', 'all', '0', null, '大2000哈大', null, '2000', '1002', '2016-09-07 18:06:45', null, null, null);
INSERT INTO `w_bet_info` VALUES ('274', '555678', null, 'xy28', 'ceshi1234', '779935', 'all', '0', null, '大20哈大', null, '2000', '1002', '2016-09-07 18:07:32', null, null, null);
INSERT INTO `w_bet_info` VALUES ('275', '555678', null, 'xy28', 'ceshi1234', '779935', 'big', '20', null, '大20', null, '1980', '4', '2016-09-07 18:07:32', null, null, null);
INSERT INTO `w_bet_info` VALUES ('276', '摩弦', null, 'xy28', 'ceshi1234', '779935', 'all', '0', null, '大20大哈', null, '20', '1002', '2016-09-07 18:07:57', null, null, null);
INSERT INTO `w_bet_info` VALUES ('277', '摩弦', null, 'xy28', 'ceshi1234', '779935', 'big', '20', null, '大20', null, '0', '4', '2016-09-07 18:07:57', null, null, null);
INSERT INTO `w_bet_info` VALUES ('278', '摩弦', null, 'xy28', 'ceshi1234', '780056', 'big', '20', null, '大20', '40', '79940', '2', '2016-09-08 13:19:27', '2016-09-08 16:14:30', null, null);
INSERT INTO `w_bet_info` VALUES ('279', '摩弦', null, 'xy28', 'ceshi1234', '780091', 'big', '100', null, '大100', '200', '80140', '2', '2016-09-08 16:14:28', '2016-09-08 16:15:10', null, null);
INSERT INTO `w_bet_info` VALUES ('280', '摩弦', null, 'xy28', 'ceshi1234', '780104', 'big', '200', null, '大200', '400', '79040', '2', '2016-09-08 17:16:40', '2016-09-08 17:20:11', null, null);
INSERT INTO `w_bet_info` VALUES ('281', '摩弦', null, 'xy28', 'ceshi1234', '780104', 'small', '100', null, '小100', '0', '79040', '2', '2016-09-08 17:16:48', '2016-09-08 17:20:11', null, null);
INSERT INTO `w_bet_info` VALUES ('282', '摩弦', null, 'xy28', 'ceshi1234', '780104', 'big', '100', null, '大100', '200', '79240', '2', '2016-09-08 17:17:37', '2016-09-08 17:20:11', null, null);
INSERT INTO `w_bet_info` VALUES ('283', '摩弦', null, 'xy28', 'ceshi1234', '780104', 'small', '300', null, '小300', '0', '79240', '2', '2016-09-08 17:17:40', '2016-09-08 17:20:11', null, null);
INSERT INTO `w_bet_info` VALUES ('284', '摩弦', null, 'xy28', 'ceshi1234', '780104', 'cao', '200', '1', '1草200', '0', '79240', '2', '2016-09-08 17:17:46', '2016-09-08 17:20:11', null, null);
INSERT INTO `w_bet_info` VALUES ('285', '摩弦', null, 'xy28', 'ceshi1234', '780104', 'cao', '100', '3', '3草100', '0', '79240', '2', '2016-09-08 17:17:52', '2016-09-08 17:20:11', null, null);
INSERT INTO `w_bet_info` VALUES ('286', '摩弦', null, 'xy28', 'ceshi1234', '780104', 'cao', '500', '4', '4草500', '0', '79240', '2', '2016-09-08 17:17:57', '2016-09-08 17:20:11', null, null);
INSERT INTO `w_bet_info` VALUES ('287', '摩弦', null, 'xy28', 'ceshi1234', '780105', 'big', '100', null, '大100', '0', '78040', '2', '2016-09-08 17:20:57', '2016-09-08 17:25:11', null, null);
INSERT INTO `w_bet_info` VALUES ('288', '摩弦', null, 'xy28', 'ceshi1234', '780105', 'small', '300', null, '小300', '600', '78640', '2', '2016-09-08 17:20:59', '2016-09-08 17:25:11', null, null);
INSERT INTO `w_bet_info` VALUES ('289', '摩弦', null, 'xy28', 'ceshi1234', '780105', 'cao', '200', '1', '1草200', '0', '78640', '2', '2016-09-08 17:21:08', '2016-09-08 17:25:11', null, null);
INSERT INTO `w_bet_info` VALUES ('290', '摩弦', null, 'xy28', 'ceshi1234', '780105', 'cao', '100', '3', '3草100', '0', '78640', '2', '2016-09-08 17:21:09', '2016-09-08 17:25:11', null, null);
INSERT INTO `w_bet_info` VALUES ('291', '摩弦', null, 'xy28', 'ceshi1234', '780105', 'cao', '500', '4', '4草500', '0', '78640', '2', '2016-09-08 17:21:17', '2016-09-08 17:25:11', null, null);
INSERT INTO `w_bet_info` VALUES ('292', '摩弦', null, 'xy28', 'ceshi1234', '780107', 'even', '100', null, '双100', '200', '78640', '2', '2016-09-08 17:33:46', '2016-09-08 17:35:11', null, null);
INSERT INTO `w_bet_info` VALUES ('293', '摩弦', null, 'xy28', 'ceshi1234', '780107', 'big', '100', null, '大100', '0', '78640', '2', '2016-09-08 17:34:29', '2016-09-08 17:35:11', null, null);
INSERT INTO `w_bet_info` VALUES ('294', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'small', '100', null, '小100', '185', '77825', '2', '2016-09-08 17:41:44', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('295', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'odd', '100', null, '单100', '185', '78010', '2', '2016-09-08 17:41:49', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('296', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'even', '100', null, '双100', '0', '78010', '2', '2016-09-08 17:41:56', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('297', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'small', '100', null, '小100', '185', '78195', '2', '2016-09-08 17:42:51', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('298', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'odd', '100', null, '单100', '185', '78380', '2', '2016-09-08 17:42:57', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('299', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'even', '100', null, '双100', '0', '78380', '2', '2016-09-08 17:43:03', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('300', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'big', '100', null, '大100', '0', '78380', '2', '2016-09-08 17:43:46', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('301', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'small', '100', null, '小100', '185', '78565', '2', '2016-09-08 17:43:51', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('302', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'odd', '100', null, '单100', '185', '78750', '2', '2016-09-08 17:43:58', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('303', '摩弦', null, 'xy28', 'ceshi1234', '780109', 'even', '100', null, '双100', '0', '78750', '2', '2016-09-08 17:44:04', '2016-09-08 17:45:11', null, null);
INSERT INTO `w_bet_info` VALUES ('304', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'big', '100', null, '大100', '0', '77950', '2', '2016-09-08 17:45:47', '2016-09-08 19:54:45', null, null);
INSERT INTO `w_bet_info` VALUES ('305', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'small', '100', null, '小100', '185', '78135', '2', '2016-09-08 17:45:53', '2016-09-08 19:54:45', null, null);
INSERT INTO `w_bet_info` VALUES ('306', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'odd', '100', null, '单100', '185', '78320', '2', '2016-09-08 17:45:59', '2016-09-08 19:54:45', null, null);
INSERT INTO `w_bet_info` VALUES ('307', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'even', '100', null, '双100', '0', '78320', '2', '2016-09-08 17:46:06', '2016-09-08 19:54:45', null, null);
INSERT INTO `w_bet_info` VALUES ('308', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'big', '100', null, '大100', '0', '78320', '2', '2016-09-08 17:46:47', '2016-09-08 19:54:45', null, null);
INSERT INTO `w_bet_info` VALUES ('309', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'small', '100', null, '小100', '185', '78505', '2', '2016-09-08 17:46:54', '2016-09-08 19:54:45', null, null);
INSERT INTO `w_bet_info` VALUES ('310', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'odd', '100', null, '单100', '185', '78690', '2', '2016-09-08 17:47:00', '2016-09-08 19:54:45', null, null);
INSERT INTO `w_bet_info` VALUES ('311', '摩弦', null, 'xy28', 'ceshi1234', '780110', 'even', '100', null, '双100', '0', '78690', '2', '2016-09-08 17:47:07', '2016-09-08 19:54:45', null, null);

-- ----------------------------
-- Table structure for `w_bet_key_word_new`
-- ----------------------------
DROP TABLE IF EXISTS `w_bet_key_word_new`;
CREATE TABLE `w_bet_key_word_new` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_type` varchar(20) DEFAULT NULL,
  `play_name` varchar(200) DEFAULT NULL,
  `play_key_word` varchar(200) DEFAULT NULL,
  `play_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_bet_key_word_new
-- ----------------------------
INSERT INTO `w_bet_key_word_new` VALUES ('1', 'xy28', '单', '单', 'odd');
INSERT INTO `w_bet_key_word_new` VALUES ('2', 'xy28', '双', '双', 'even');
INSERT INTO `w_bet_key_word_new` VALUES ('3', 'xy28', '大', '大', 'big');
INSERT INTO `w_bet_key_word_new` VALUES ('4', 'xy28', '小', '小|x', 'small');
INSERT INTO `w_bet_key_word_new` VALUES ('5', 'xy28', '大单', '大单', 'big_odd');
INSERT INTO `w_bet_key_word_new` VALUES ('6', 'xy28', '小单', '小单', 'small_odd');
INSERT INTO `w_bet_key_word_new` VALUES ('7', 'xy28', '大双', '大双', 'big_even');
INSERT INTO `w_bet_key_word_new` VALUES ('8', 'xy28', '小双', '小双', 'small_even');
INSERT INTO `w_bet_key_word_new` VALUES ('9', 'xy28', '草', '草|操|艹|cao|.|点', 'cao');
INSERT INTO `w_bet_key_word_new` VALUES ('10', 'xy28', '查', '查宝|查微|查|查支付|查微信', 'add');
INSERT INTO `w_bet_key_word_new` VALUES ('11', 'xy28', '回', '回宝|回微|回|回支付|回微信', 'reduce');
INSERT INTO `w_bet_key_word_new` VALUES ('12', 'xy28', '极大', '极大', 'max');
INSERT INTO `w_bet_key_word_new` VALUES ('13', 'xy28', '极小', '极小', 'min');
INSERT INTO `w_bet_key_word_new` VALUES ('14', 'xy28', '梭哈', '哈|梭|梭哈', 'all');
INSERT INTO `w_bet_key_word_new` VALUES ('15', 'xy28', '改', '改', 'edit');
INSERT INTO `w_bet_key_word_new` VALUES ('16', 'xy28', '取消', '取消', 'cancel');
INSERT INTO `w_bet_key_word_new` VALUES ('17', 'xy28', '顺子', '顺子|顺', 'straight');
INSERT INTO `w_bet_key_word_new` VALUES ('18', 'xy28', '豹子', '豹子|豹', 'leopard');
INSERT INTO `w_bet_key_word_new` VALUES ('101', 'keno28', '单', '单', 'odd');
INSERT INTO `w_bet_key_word_new` VALUES ('102', 'keno28', '双', '双', 'even');
INSERT INTO `w_bet_key_word_new` VALUES ('103', 'keno28', '大', '大', 'big');
INSERT INTO `w_bet_key_word_new` VALUES ('104', 'keno28', '小', '小', 'small');
INSERT INTO `w_bet_key_word_new` VALUES ('105', 'keno28', '大单', '大单', 'big_odd');
INSERT INTO `w_bet_key_word_new` VALUES ('106', 'keno28', '小单', '小单', 'small_odd');
INSERT INTO `w_bet_key_word_new` VALUES ('107', 'keno28', '大双', '大双', 'big_even');
INSERT INTO `w_bet_key_word_new` VALUES ('108', 'keno28', '小双', '小双', 'small_even');
INSERT INTO `w_bet_key_word_new` VALUES ('109', 'keno28', '草', '草|操|艹|cao|.|点', 'cao');
INSERT INTO `w_bet_key_word_new` VALUES ('110', 'keno28', '查', '查宝|查微|查', 'add');
INSERT INTO `w_bet_key_word_new` VALUES ('111', 'keno28', '回', '回宝|回微|回', 'reduce');
INSERT INTO `w_bet_key_word_new` VALUES ('112', 'keno28', '极大', '极大', 'max');
INSERT INTO `w_bet_key_word_new` VALUES ('113', 'keno28', '极小', '极小', 'min');
INSERT INTO `w_bet_key_word_new` VALUES ('114', 'keno28', '梭哈', '哈|梭|梭哈', 'all');
INSERT INTO `w_bet_key_word_new` VALUES ('115', 'keno28', '改', '改', 'edit');
INSERT INTO `w_bet_key_word_new` VALUES ('116', 'keno28', '取消', '取消', 'cancel');
INSERT INTO `w_bet_key_word_new` VALUES ('117', 'keno28', '顺子', '顺子|顺', 'straight');
INSERT INTO `w_bet_key_word_new` VALUES ('118', 'keno28', '豹子', '豹子|豹', 'leopard');
INSERT INTO `w_bet_key_word_new` VALUES ('19', 'xy28', '全回', '全回', 'reduce_all');
INSERT INTO `w_bet_key_word_new` VALUES ('119', 'keno28', '全回', '全回', 'reduce_all');

-- ----------------------------
-- Table structure for `w_bet_odds_new`
-- ----------------------------
DROP TABLE IF EXISTS `w_bet_odds_new`;
CREATE TABLE `w_bet_odds_new` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `game_type` varchar(50) DEFAULT NULL,
  `play` varchar(50) DEFAULT NULL COMMENT '1.大小单双 2.单点数字 3.极大极小 4.组合',
  `type` varchar(50) DEFAULT NULL,
  `enabled` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_bet_odds_new
-- ----------------------------
INSERT INTO `w_bet_odds_new` VALUES ('1', '大小单双', '', '', 'dxds', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('2', '极大极小', '', '', 'jdjx', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('3', '单点数字', '', '', 'sing', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('4', '组合', '', '', 'compuse', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('5', '大', 'xy28', '2', 'big', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('6', '小', 'xy28', '2', 'small', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('7', '单', 'xy28', '2', 'odd', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('8', '双', 'xy28', '2', 'even', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('9', '极大', 'xy28', '15', 'max', '50', '2');
INSERT INTO `w_bet_odds_new` VALUES ('10', '极小', 'xy28', '15', 'min', '50', '2');
INSERT INTO `w_bet_odds_new` VALUES ('11', '0单点', 'xy28', '500', '0', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('12', '1单点', 'xy28', '200', '1', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('13', '2单点', 'xy28', '100', '2', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('14', '3单点', 'xy28', '60', '3', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('15', '4单点', 'xy28', '45', '4', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('16', '5单点', 'xy28', '30', '5', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('17', '6单点', 'xy28', '25', '6', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('18', '7单点', 'xy28', '20', '7', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('19', '8单点', 'xy28', '18', '8', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('20', '9单点', 'xy28', '16', '9', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('21', '10单点', 'xy28', '13', '10', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('22', '11单点', 'xy28', '13', '11', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('23', '12单点', 'xy28', '12', '12', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('24', '13单点', 'xy28', '12', '13', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('25', '14单点', 'xy28', '12', '14', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('26', '15单点', 'xy28', '12', '15', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('27', '16单点', 'xy28', '13', '16', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('28', '17单点', 'xy28', '13', '17', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('29', '18单点', 'xy28', '16', '18', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('30', '19单点', 'xy28', '18', '19', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('31', '20单点', 'xy28', '20', '20', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('32', '21单点', 'xy28', '25', '21', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('33', '22单点', 'xy28', '30', '22', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('34', '23单点', 'xy28', '45', '23', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('35', '24单点', 'xy28', '60', '24', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('36', '25单点', 'xy28', '100', '25', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('37', '26单点', 'xy28', '200', '26', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('38', '27单点', 'xy28', '500', '27', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('39', '28单点', 'xy28', '1', '28', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('40', '大单', 'xy28', '4.2', 'big_odd', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('41', '大双', 'xy28', '4', 'big_even', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('42', '小单', 'xy28', '4', 'small_odd', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('43', '小双', 'xy28', '4.2', 'small_even', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('44', '1314大小单双', '', '', '1314dxds', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('46', '13小', 'xy28', '1.85', '13_small', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('47', '13单', 'xy28', '1.85', '13_odd', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('49', '1314组合', '', '', '1314compuse', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('50', '13小单', 'xy28', '2.5', '13_small_odd', '50', '49');
INSERT INTO `w_bet_odds_new` VALUES ('51', '14大双', 'xy28', '2.5', '14_big_even', '50', '49');
INSERT INTO `w_bet_odds_new` VALUES ('52', '条件1314大小单双', '', '30000', '1314dxds_condition', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('53', '14大', 'xy28', '1', '14_big', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('54', '13小', 'xy28', '1', '13_small', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('55', '13单', 'xy28', '1', '13_odd', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('56', '14双', 'xy28', '1', '14_even', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('57', '条件1314组合1', '', '20000', '1314compuse_condition_1', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('58', '13小单', 'xy28', '1', '13_small_odd', '50', '57');
INSERT INTO `w_bet_odds_new` VALUES ('59', '14大双', 'xy28', '1', '14_big_even', '50', '57');
INSERT INTO `w_bet_odds_new` VALUES ('45', '14大', 'xy28', '1.85', '14_big', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('48', '14双', 'xy28', '1.85', '14_even', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('60', '条件1314组合2', '', '99999', '1314compuse_condition_2', '-50', null);
INSERT INTO `w_bet_odds_new` VALUES ('61', '13小单', 'xy28', '1', '13_small_odd', '50', '60');
INSERT INTO `w_bet_odds_new` VALUES ('62', '14大双', 'xy28', '1', '14_big_even', '50', '60');
INSERT INTO `w_bet_odds_new` VALUES ('63', '下注限额', '', '', 'bet_odds', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('64', '单注最高投注限额', 'xy28', '20000', 'sing_max', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('65', '单注最低投注限额', 'xy28', '10', 'sing_min', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('66', '总注最高投注限额', 'xy28', '50000', 'total_max', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('67', '特殊玩法', '', '', 'special', '50', null);
INSERT INTO `w_bet_odds_new` VALUES ('68', '顺子', 'xy28', '50', 'straight', '50', '67');
INSERT INTO `w_bet_odds_new` VALUES ('69', '豹子', 'xy28', '70', 'leopard', '50', '67');
INSERT INTO `w_bet_odds_new` VALUES ('70', '大', 'keno28', '2', 'big', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('71', '小', 'keno28', '2', 'small', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('72', '单', 'keno28', '2', 'odd', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('73', '双', 'keno28', '2', 'even', '50', '1');
INSERT INTO `w_bet_odds_new` VALUES ('74', '极大', 'keno28', '15', 'max', '50', '2');
INSERT INTO `w_bet_odds_new` VALUES ('75', '极小', 'keno28', '15', 'min', '50', '2');
INSERT INTO `w_bet_odds_new` VALUES ('76', '0单点', 'keno28', '500', '0', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('77', '1单点', 'keno28', '200', '1', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('78', '2单点', 'keno28', '100', '2', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('79', '3单点', 'keno28', '60', '3', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('80', '4单点', 'keno28', '45', '4', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('81', '5单点', 'keno28', '30', '5', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('82', '6单点', 'keno28', '25', '6', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('83', '7单点', 'keno28', '20', '7', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('84', '8单点', 'keno28', '18', '8', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('85', '9单点', 'keno28', '16', '9', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('86', '10单点', 'keno28', '13', '10', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('87', '11单点', 'keno28', '13', '11', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('88', '12单点', 'keno28', '12', '12', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('89', '13单点', 'keno28', '12', '13', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('90', '14单点', 'keno28', '12', '14', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('91', '15单点', 'keno28', '12', '15', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('92', '16单点', 'keno28', '13', '16', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('93', '17单点', 'keno28', '13', '17', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('94', '18单点', 'keno28', '16', '18', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('95', '19单点', 'keno28', '18', '19', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('96', '20单点', 'keno28', '20', '20', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('97', '21单点', 'keno28', '25', '21', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('98', '22单点', 'keno28', '30', '22', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('99', '23单点', 'keno28', '45', '23', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('100', '24单点', 'keno28', '60', '24', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('101', '25单点', 'keno28', '100', '25', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('102', '26单点', 'keno28', '200', '26', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('103', '27单点', 'keno28', '500', '27', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('104', '28单点', 'keno28', '1', '28', '50', '3');
INSERT INTO `w_bet_odds_new` VALUES ('105', '大单', 'keno28', '4.2', 'big_odd', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('106', '大双', 'keno28', '4', 'big_even', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('107', '小单', 'keno28', '4', 'small_odd', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('108', '小双', 'keno28', '4.2', 'small_even', '50', '4');
INSERT INTO `w_bet_odds_new` VALUES ('109', '14大', 'keno28', '1.85', '14_big', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('113', '13小单', 'keno28', '2.5', '13_small_odd', '50', '49');
INSERT INTO `w_bet_odds_new` VALUES ('114', '14大双', 'keno28', '2.5', '14_big_even', '50', '49');
INSERT INTO `w_bet_odds_new` VALUES ('115', '14大', 'keno28', '1', '14_big', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('116', '13小', 'keno28', '1', '13_small', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('117', '13单', 'keno28', '1', '13_odd', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('118', '14双', 'keno28', '1', '14_even', '50', '52');
INSERT INTO `w_bet_odds_new` VALUES ('119', '13小单', 'keno28', '1', '13_small_odd', '50', '57');
INSERT INTO `w_bet_odds_new` VALUES ('120', '14大双', 'keno28', '1', '14_big_even', '50', '57');
INSERT INTO `w_bet_odds_new` VALUES ('121', '13小单', 'keno28', '1', '13_small_odd', '50', '60');
INSERT INTO `w_bet_odds_new` VALUES ('122', '14大双', 'keno28', '1', '14_big_even', '50', '60');
INSERT INTO `w_bet_odds_new` VALUES ('123', '单注最高投注限额', 'keno28', '30000', 'sing_max', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('124', '单注最低投注限额', 'keno28', '10', 'sing_min', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('125', '总注最高投注限额', 'keno28', '50000', 'total_max', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('126', '顺子', 'keno28', '50', 'straight', '50', '67');
INSERT INTO `w_bet_odds_new` VALUES ('127', '豹子', 'keno28', '70', 'leopard', '50', '67');
INSERT INTO `w_bet_odds_new` VALUES ('110', '13小', 'keno28', '1.85', '13_small', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('111', '13单', 'keno28', '1.85', '13_odd', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('112', '14双', 'keno28', '1.85', '14_even', '50', '44');
INSERT INTO `w_bet_odds_new` VALUES ('128', '单点数字最高限额', 'xy28', '5000', 'sing_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('129', '单点数字最高限额', 'keno28', '5000', 'sing_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('130', '单点数字最低限额', 'xy28', '30', 'sing_min_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('131', '单点数字最低限额', 'keno28', '30', 'sing_min_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('132', '大小单双单注最高限额', 'xy28', '5000', 'dxds_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('133', '大小单双单注最高限额', 'keno28', '20000', 'dxds_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('134', '组合单注最高限额', 'xy28', '10000', 'compuse_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('135', '组合单注最高限额', 'keno28', '20000', 'compuse_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('136', '极大极小单注最高限额', 'xy28', '5000', 'max_min_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('137', '极大极小单注最高限额', 'keno28', '5000', 'max_min_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('138', '顺子单注限额', 'xy28', '1300', 'straight_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('139', '豹子单注限额', 'xy28', '1300', 'leopard_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('140', '顺子单注限额', 'keno28', '2200', 'straight_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('141', '豹子单注限额', 'keno28', '2200', 'leopard_max_money', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('142', '单点数字单局最高限额', 'xy28', '2100', 'sing_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('143', '单点数字单局最高限额', 'keno28', '33000', 'sing_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('144', '大小单双单局最高限额', 'xy28', '2100', 'dxds_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('145', '大小单双单局最高限额', 'keno28', '33000', 'dxds_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('146', '组合单局限额', 'xy28', '2100', 'compuse_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('147', '组合单局限额', 'keno28', '33000', 'compuse_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('148', '顺子单局限额', 'xy28', '2100', 'straight_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('149', '顺子单局限额', 'keno28', '33000', 'straight_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('150', '豹子单局限额', 'xy28', '2100', 'leopard_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('151', '豹子单局限额', 'keno28', '33000', 'leopard_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('152', '极大极小单注限额', 'xy28', '2100', 'max_min_max_money_single', '50', '63');
INSERT INTO `w_bet_odds_new` VALUES ('153', '极大极小单注限额', 'keno28', '33000', 'max_min_max_money_single', '50', '63');

-- ----------------------------
-- Table structure for `w_bill`
-- ----------------------------
DROP TABLE IF EXISTS `w_bill`;
CREATE TABLE `w_bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` int(11) DEFAULT NULL COMMENT '幸运号码',
  `game_type` char(10) DEFAULT NULL,
  `nickname` varchar(100) DEFAULT NULL COMMENT '微信昵称',
  `term` bigint(20) DEFAULT NULL COMMENT '期数',
  `bet_details` mediumtext COMMENT '投注详情',
  `bet_amount` int(11) DEFAULT NULL COMMENT '投注额',
  `after_bet_money` int(11) DEFAULT NULL COMMENT '账户余额',
  `profit_loss` int(11) DEFAULT NULL COMMENT '盈亏',
  `state` int(11) DEFAULT NULL COMMENT '状态（1:下注, 2:派彩, 4:撤销）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `sing_bet_count` int(11) DEFAULT NULL,
  `sing_bet_amount` int(11) DEFAULT NULL,
  `compuse_bet_count` int(11) DEFAULT NULL,
  `compuse_bet_amount` int(11) DEFAULT NULL,
  `max_min_bet_count` int(11) DEFAULT NULL,
  `max_min_bet_amount` int(11) DEFAULT NULL,
  `straight_bet_count` int(11) DEFAULT NULL,
  `straight_bet_amount` int(11) DEFAULT NULL,
  `leopard_bet_count` int(11) DEFAULT NULL,
  `leopard_bet_amount` int(11) DEFAULT NULL,
  `recharge_change_state` varchar(200) DEFAULT NULL,
  `game_change_state` varchar(200) DEFAULT NULL,
  `not_settle_state` varchar(200) DEFAULT NULL,
  `profit_loss_state` varchar(200) DEFAULT NULL,
  `include_compuse` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='账单';

-- ----------------------------
-- Records of w_bill
-- ----------------------------
INSERT INTO `w_bill` VALUES ('80', '13', 'xy28', '摩弦', '779900', '大400,大500', '900', '6000', '-900', '2', '2016-09-07 15:14:35', '2016-09-07 15:15:08', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('81', '16', 'xy28', '摩弦', '779903', '大500', '500', '6500', '500', '2', '2016-09-07 15:30:17', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('82', '10', 'xy28', '摩弦', '779905', '小400', '400', '7800', '400', '2', '2016-09-07 15:39:35', '2016-09-07 15:40:17', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('83', '15', 'xy28', '555678', '779911', '大100,小200,12.90', '390', '1810', '-190', '2', '2016-09-07 16:09:35', '2016-09-07 16:10:08', '1', '90', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('84', '26', 'xy28', '555678', '779934', '大100', '100', '1910', '100', '2', '2016-09-07 18:04:35', '2016-09-07 18:05:12', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('85', '17', 'xy28', '555678', '779935', '大1910', '1910', '5820', '1910', '2', '2016-09-07 18:09:35', '2016-09-07 18:10:12', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('86', '16', 'xy28', '摩弦', '780056', '大20', '20', '79940', '20', '2', '2016-09-08 13:19:35', '2016-09-08 16:14:30', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('87', '15', 'xy28', '摩弦', '780091', '大100', '100', '80140', '100', '2', '2016-09-08 16:14:35', '2016-09-08 16:15:10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('88', '18', 'xy28', '摩弦', '780104', '大200,小100,大100,小300,1草200,3草100,4草500', '1500', '79240', '-900', '2', '2016-09-08 17:19:35', '2016-09-08 17:20:11', '3', '800', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('89', '12', 'xy28', '摩弦', '780105', '大100,小300,1草200,3草100,4草500', '1200', '78640', '-600', '2', '2016-09-08 17:24:35', '2016-09-08 17:25:11', '3', '800', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('90', '6', 'xy28', '摩弦', '780107', '双100,大100', '200', '78640', '0', '2', '2016-09-08 17:34:35', '2016-09-08 17:35:11', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('91', '13', 'xy28', '摩弦', '780109', '小100,单100,双100,小100,单100,双100,大100,小100,单100,双100', '1000', '78750', '110', '2', '2016-09-08 17:44:35', '2016-09-08 17:45:11', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');
INSERT INTO `w_bill` VALUES ('92', '13', 'xy28', '摩弦', '780110', '大100,小100,单100,双100,大100,小100,单100,双100', '800', '78690', '-60', '2', '2016-09-08 19:54:45', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, null, null, null, '0');

-- ----------------------------
-- Table structure for `w_customer_msg`
-- ----------------------------
DROP TABLE IF EXISTS `w_customer_msg`;
CREATE TABLE `w_customer_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1:系统指令, 2:自定义指令',
  `answer` text,
  `state` int(11) DEFAULT NULL COMMENT '1:启用, 2:弃用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_customer_msg
-- ----------------------------
INSERT INTO `w_customer_msg` VALUES ('8', '期数', '1', '', '1');
INSERT INTO `w_customer_msg` VALUES ('9', '账单', '1', '', '1');
INSERT INTO `w_customer_msg` VALUES ('10', '开奖号码', '1', '', '1');
INSERT INTO `w_customer_msg` VALUES ('11', '历史数据', '1', '', '1');
INSERT INTO `w_customer_msg` VALUES ('12', '在线人数', '1', '', '1');
INSERT INTO `w_customer_msg` VALUES ('13', '账面总额', '1', '', '1');
INSERT INTO `w_customer_msg` VALUES ('14', '开奖网址', '1', 'http://cb881.com', '1');
INSERT INTO `w_customer_msg` VALUES ('15', '开奖时间', '1', '', '1');
INSERT INTO `w_customer_msg` VALUES ('16', '上分', '1', null, '1');
INSERT INTO `w_customer_msg` VALUES ('17', '拉人', '1', null, '1');

-- ----------------------------
-- Table structure for `w_loss_bonus`
-- ----------------------------
DROP TABLE IF EXISTS `w_loss_bonus`;
CREATE TABLE `w_loss_bonus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '1:可用, 2:不可用',
  `type` varchar(255) DEFAULT NULL COMMENT 'less_than_term:下注不到多少期无回水\r\n            less_than_term_no_compuse:下注不到多少期,无组合无回水\r\n            more_than_term_with_no_compuse:下注达到多少期,连续多少期无组合无回水\r\n            compuse_percenrt_in_total_bet:所有组合下注额占总下注额的百分比以下无回水\r\n            less_than_sing_man_min_total_coun',
  `condition1` int(11) DEFAULT NULL,
  `condition2` int(11) DEFAULT NULL,
  `activity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=308 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_loss_bonus
-- ----------------------------
INSERT INTO `w_loss_bonus` VALUES ('63', '下注不到多少期,无组合无回水', '2', 'less_than_term_no_compuse', null, null, '21');
INSERT INTO `w_loss_bonus` VALUES ('64', '下注达到多少期,连续多少期无组合无回水', '2', 'more_than_term_with_no_compuse', null, null, '21');
INSERT INTO `w_loss_bonus` VALUES ('65', '下注不到多少期无回水', '1', 'less_than_term', '5', null, '21');
INSERT INTO `w_loss_bonus` VALUES ('66', '所有组合下注额占总下注额的百分比以下无回水', '1', 'compuse_percenrt_in_total_bet', '20', null, '21');
INSERT INTO `w_loss_bonus` VALUES ('67', '单点极大极小下注次数小于多少期无回水', '2', 'less_than_sing_man_min_total_count', null, null, '21');

-- ----------------------------
-- Table structure for `w_lottery_result`
-- ----------------------------
DROP TABLE IF EXISTS `w_lottery_result`;
CREATE TABLE `w_lottery_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `game_type` varchar(20) DEFAULT NULL,
  `term` varchar(20) DEFAULT NULL,
  `close_time` varchar(50) DEFAULT NULL,
  `open_time` varchar(50) DEFAULT NULL,
  `original_number` varchar(200) DEFAULT NULL,
  `lottery_number` varchar(200) DEFAULT NULL,
  `lucky_number` int(11) DEFAULT NULL,
  `number` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1686 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_lottery_result
-- ----------------------------
INSERT INTO `w_lottery_result` VALUES ('1549', 'xy28', '779899', '2016-09-07 15:09:30', '15:12:34', '8,9,4', 'http://cp.360.cn/,360彩票', '21', '8 + 9 + 4 = 21', '2016-09-07 15:12:34', '2016-09-07 15:13:00');
INSERT INTO `w_lottery_result` VALUES ('1550', 'xy28', '779900', '2016-09-07 15:14:30', '15:15:07', '4,2,7', 'http://cp.360.cn/,360彩票', '13', '4 + 2 + 7 = 13', '2016-09-07 15:15:07', '2016-09-07 15:16:00');
INSERT INTO `w_lottery_result` VALUES ('1551', 'xy28', '779901', '2016-09-07 15:19:30', '15:20:08', '2,5,4', 'http://cp.360.cn/,360彩票', '11', '2 + 5 + 4 = 11', '2016-09-07 15:20:08', '2016-09-07 15:22:00');
INSERT INTO `w_lottery_result` VALUES ('1552', 'xy28', '779902', '2016-09-07 15:24:30', '15:25:03', '0,4,8', 'http://cp.360.cn/,360彩票', '12', '0 + 4 + 8 = 12', '2016-09-07 15:25:03', '2016-09-07 15:26:00');
INSERT INTO `w_lottery_result` VALUES ('1553', 'xy28', '779903', '2016-09-07 15:29:30', '15:30:08', '8,5,3', 'http://cp.360.cn/,360彩票', '16', '8 + 5 + 3 = 16', '2016-09-07 15:30:08', '2016-09-07 15:31:00');
INSERT INTO `w_lottery_result` VALUES ('1554', 'xy28', '779904', '2016-09-07 15:34:30', '15:35:03', '4,3,2', 'http://cp.360.cn/,360彩票', '9', '4 + 3 + 2 = 9', '2016-09-07 15:35:03', '2016-09-07 15:36:00');
INSERT INTO `w_lottery_result` VALUES ('1555', 'xy28', '779905', '2016-09-07 15:39:30', '15:40:08', '4,5,1', 'http://cp.360.cn/,360彩票', '10', '4 + 5 + 1 = 10', '2016-09-07 15:40:08', '2016-09-07 15:41:00');
INSERT INTO `w_lottery_result` VALUES ('1556', 'xy28', '779906', '2016-09-07 15:44:30', '15:45:03', '2,6,4', 'http://cp.360.cn/,360彩票', '12', '2 + 6 + 4 = 12', '2016-09-07 15:45:03', '2016-09-07 15:46:00');
INSERT INTO `w_lottery_result` VALUES ('1557', 'xy28', '779907', '2016-09-07 15:49:30', '15:50:08', '9,1,8', 'http://cp.360.cn/,360彩票', '18', '9 + 1 + 8 = 18', '2016-09-07 15:50:08', '2016-09-07 15:51:06');
INSERT INTO `w_lottery_result` VALUES ('1558', 'xy28', '779908', '2016-09-07 15:54:30', '15:55:08', '6,1,6', 'http://cp.360.cn/,360彩票', '13', '6 + 1 + 6 = 13', '2016-09-07 15:55:08', '2016-09-07 15:56:00');
INSERT INTO `w_lottery_result` VALUES ('1559', 'xy28', '779909', '2016-09-07 15:59:30', '16:00:22', '8,3,1', 'http://pc588.com,幸运28蛋蛋28', '12', '8+3+1=12', '2016-09-07 16:00:22', '2016-09-07 16:01:01');
INSERT INTO `w_lottery_result` VALUES ('1560', 'xy28', '779910', '2016-09-07 16:04:30', '16:05:03', '1,1,3', 'http://cp.360.cn/,360彩票', '5', '1 + 1 + 3 = 5', '2016-09-07 16:05:03', '2016-09-07 16:06:01');
INSERT INTO `w_lottery_result` VALUES ('1561', 'xy28', '779911', '2016-09-07 16:09:30', '16:10:08', '4,9,2', 'http://cp.360.cn/,360彩票', '15', '4 + 9 + 2 = 15', '2016-09-07 16:10:08', '2016-09-07 16:11:00');
INSERT INTO `w_lottery_result` VALUES ('1562', 'xy28', '779912', '2016-09-07 16:14:30', '16:15:03', '7,0,2', 'http://cp.360.cn/,360彩票', '9', '7 + 0 + 2 = 9', '2016-09-07 16:15:03', '2016-09-07 16:16:00');
INSERT INTO `w_lottery_result` VALUES ('1563', 'xy28', '779913', '2016-09-07 16:19:30', '16:20:09', '5,3,7', 'http://cp.360.cn/,360彩票', '15', '5 + 3 + 7 = 15', '2016-09-07 16:20:09', '2016-09-07 16:22:00');
INSERT INTO `w_lottery_result` VALUES ('1564', 'xy28', '779914', '2016-09-07 16:24:30', '16:25:03', '8,1,8', 'http://cp.360.cn/,360彩票', '17', '8 + 1 + 8 = 17', '2016-09-07 16:25:03', '2016-09-07 16:26:00');
INSERT INTO `w_lottery_result` VALUES ('1565', 'xy28', '779915', '2016-09-07 16:29:30', '16:30:13', '8,8,4', 'http://cp.360.cn/,360彩票', '20', '8 + 8 + 4 = 20', '2016-09-07 16:30:13', '2016-09-07 16:31:00');
INSERT INTO `w_lottery_result` VALUES ('1566', 'xy28', '779916', '2016-09-07 16:34:30', '16:35:03', '1,7,8', 'http://cp.360.cn/,360彩票', '16', '1 + 7 + 8 = 16', '2016-09-07 16:35:03', '2016-09-07 16:36:00');
INSERT INTO `w_lottery_result` VALUES ('1567', 'xy28', '779917', '2016-09-07 16:39:30', '16:40:08', '7,7,8', 'http://cp.360.cn/,360彩票', '22', '7 + 7 + 8 = 22', '2016-09-07 16:40:08', '2016-09-07 16:41:00');
INSERT INTO `w_lottery_result` VALUES ('1568', 'xy28', '779918', '2016-09-07 16:44:30', '16:45:03', '4,9,6', 'http://cp.360.cn/,360彩票', '19', '4 + 9 + 6 = 19', '2016-09-07 16:45:03', '2016-09-07 16:46:00');
INSERT INTO `w_lottery_result` VALUES ('1569', 'xy28', '779919', '2016-09-07 16:49:30', '16:50:08', '2,8,6', 'http://cp.360.cn/,360彩票', '16', '2 + 8 + 6 = 16', '2016-09-07 16:50:08', '2016-09-07 16:51:04');
INSERT INTO `w_lottery_result` VALUES ('1570', 'xy28', '779929', '2016-09-07 17:39:30', '17:43:35', '2,7,6', 'http://pc588.com,幸运28蛋蛋28', '15', '2+7+6=15', '2016-09-07 17:43:35', '2016-09-07 17:44:02');
INSERT INTO `w_lottery_result` VALUES ('1571', 'xy28', '779930', '2016-09-07 17:44:30', '17:45:04', '9,3,0', 'http://cp.360.cn/,360彩票', '12', '9 + 3 + 0 = 12', '2016-09-07 17:45:04', '2016-09-07 17:46:00');
INSERT INTO `w_lottery_result` VALUES ('1572', 'xy28', '779931', '2016-09-07 17:49:30', '17:50:11', '1,4,9', 'http://cp.360.cn/,360彩票', '14', '1 + 4 + 9 = 14', '2016-09-07 17:50:11', '2016-09-07 17:51:00');
INSERT INTO `w_lottery_result` VALUES ('1573', 'xy28', '779932', '2016-09-07 17:54:30', '17:55:19', '3,3,3', 'http://cp.360.cn/,360彩票', '9', '3 + 3 + 3 = 9', '2016-09-07 17:55:19', '2016-09-07 18:01:00');
INSERT INTO `w_lottery_result` VALUES ('1574', 'xy28', '779933', '2016-09-07 17:59:30', '18:00:32', '3,5,1', 'http://pc588.com,幸运28蛋蛋28', '9', '3+5+1=9', '2016-09-07 18:00:32', '2016-09-07 18:01:00');
INSERT INTO `w_lottery_result` VALUES ('1575', 'xy28', '779934', '2016-09-07 18:04:30', '18:05:03', '9,8,9', 'http://cp.360.cn/,360彩票', '26', '9 + 8 + 9 = 26', '2016-09-07 18:05:03', '2016-09-07 18:06:00');
INSERT INTO `w_lottery_result` VALUES ('1576', 'xy28', '779935', '2016-09-07 18:09:30', '18:10:03', '8,5,4', 'http://cp.360.cn/,360彩票', '17', '8 + 5 + 4 = 17', '2016-09-07 18:10:03', '2016-09-07 18:11:04');
INSERT INTO `w_lottery_result` VALUES ('1577', 'xy28', '779936', '2016-09-07 18:14:30', '18:15:03', '4,2,2', 'http://cp.360.cn/,360彩票', '8', '4 + 2 + 2 = 8', '2016-09-07 18:15:03', '2016-09-07 18:16:00');
INSERT INTO `w_lottery_result` VALUES ('1578', 'xy28', '779937', '2016-09-07 18:19:30', '18:20:03', '6,4,9', 'http://cp.360.cn/,360彩票', '19', '6 + 4 + 9 = 19', '2016-09-07 18:20:03', '2016-09-07 18:21:00');
INSERT INTO `w_lottery_result` VALUES ('1579', 'xy28', '779938', '2016-09-07 18:24:30', '18:25:03', '5,0,7', 'http://cp.360.cn/,360彩票', '12', '5 + 0 + 7 = 12', '2016-09-07 18:25:03', '2016-09-07 18:26:00');
INSERT INTO `w_lottery_result` VALUES ('1580', 'xy28', '779939', '2016-09-07 18:29:30', '18:30:18', '5,0,7', 'http://cp.360.cn/,360彩票', '12', '5 + 0 + 7 = 12', '2016-09-07 18:30:18', '2016-09-07 18:31:00');
INSERT INTO `w_lottery_result` VALUES ('1581', 'xy28', '779940', '2016-09-07 18:34:30', '18:35:03', '9,2,5', 'http://cp.360.cn/,360彩票', '16', '9 + 2 + 5 = 16', '2016-09-07 18:35:03', '2016-09-07 18:36:00');
INSERT INTO `w_lottery_result` VALUES ('1582', 'xy28', '779941', '2016-09-07 18:39:30', '18:40:08', '7,7,1', 'http://cp.360.cn/,360彩票', '15', '7 + 7 + 1 = 15', '2016-09-07 18:40:08', '2016-09-07 18:41:00');
INSERT INTO `w_lottery_result` VALUES ('1583', 'xy28', '779942', '2016-09-07 18:44:30', '18:45:08', '9,5,1', 'http://cp.360.cn/,360彩票', '15', '9 + 5 + 1 = 15', '2016-09-07 18:45:08', '2016-09-07 18:46:00');
INSERT INTO `w_lottery_result` VALUES ('1584', 'xy28', '779943', '2016-09-07 18:49:30', '18:50:08', '2,1,3', 'http://cp.360.cn/,360彩票', '6', '2 + 1 + 3 = 6', '2016-09-07 18:50:08', '2016-09-07 18:51:00');
INSERT INTO `w_lottery_result` VALUES ('1585', 'xy28', '779944', '2016-09-07 18:54:30', '18:55:03', '8,3,4', 'http://cp.360.cn/,360彩票', '15', '8 + 3 + 4 = 15', '2016-09-07 18:55:03', '2016-09-07 18:56:00');
INSERT INTO `w_lottery_result` VALUES ('1586', 'xy28', '779945', '2016-09-07 18:59:30', '19:00:13', '7,0,1', 'http://cp.360.cn/,360彩票', '8', '7 + 0 + 1 = 8', '2016-09-07 19:00:13', '2016-09-07 19:01:00');
INSERT INTO `w_lottery_result` VALUES ('1587', 'xy28', '779946', '2016-09-07 19:04:30', '19:05:03', '8,2,1', 'http://cp.360.cn/,360彩票', '11', '8 + 2 + 1 = 11', '2016-09-07 19:05:03', '2016-09-07 19:06:00');
INSERT INTO `w_lottery_result` VALUES ('1588', 'xy28', '779947', '2016-09-07 19:09:30', '19:10:08', '7,0,6', 'http://cp.360.cn/,360彩票', '13', '7 + 0 + 6 = 13', '2016-09-07 19:10:08', '2016-09-07 19:11:00');
INSERT INTO `w_lottery_result` VALUES ('1589', 'xy28', '779948', '2016-09-07 19:14:30', '19:15:04', '5,6,1', 'http://cp.360.cn/,360彩票', '12', '5 + 6 + 1 = 12', '2016-09-07 19:15:04', '2016-09-07 19:16:00');
INSERT INTO `w_lottery_result` VALUES ('1590', 'xy28', '779949', '2016-09-07 19:19:30', '19:20:08', '4,0,1', 'http://cp.360.cn/,360彩票', '5', '4 + 0 + 1 = 5', '2016-09-07 19:20:08', '2016-09-07 19:21:00');
INSERT INTO `w_lottery_result` VALUES ('1591', 'xy28', '779950', '2016-09-07 19:24:30', '19:25:03', '1,6,3', 'http://cp.360.cn/,360彩票', '10', '1 + 6 + 3 = 10', '2016-09-07 19:25:03', '2016-09-07 19:26:00');
INSERT INTO `w_lottery_result` VALUES ('1592', 'xy28', '779951', '2016-09-07 19:29:30', '19:30:08', '1,4,7', 'http://cp.360.cn/,360彩票', '12', '1 + 4 + 7 = 12', '2016-09-07 19:30:08', '2016-09-07 19:31:00');
INSERT INTO `w_lottery_result` VALUES ('1593', 'xy28', '779952', '2016-09-07 19:34:30', '19:35:03', '4,6,7', 'http://cp.360.cn/,360彩票', '17', '4 + 6 + 7 = 17', '2016-09-07 19:35:03', '2016-09-07 19:36:00');
INSERT INTO `w_lottery_result` VALUES ('1594', 'xy28', '779953', '2016-09-07 19:39:30', '19:40:06', '7,2,0', 'http://cp.360.cn/,360彩票', '9', '7 + 2 + 0 = 9', '2016-09-07 19:40:06', '2016-09-07 19:41:00');
INSERT INTO `w_lottery_result` VALUES ('1595', 'xy28', '779954', '2016-09-07 19:44:30', '19:45:03', '9,7,1', 'http://cp.360.cn/,360彩票', '17', '9 + 7 + 1 = 17', '2016-09-07 19:45:03', '2016-09-07 19:46:00');
INSERT INTO `w_lottery_result` VALUES ('1596', 'xy28', '779955', '2016-09-07 19:49:30', '19:50:08', '9,6,2', 'http://cp.360.cn/,360彩票', '17', '9 + 6 + 2 = 17', '2016-09-07 19:50:08', '2016-09-07 19:51:00');
INSERT INTO `w_lottery_result` VALUES ('1597', 'xy28', '779956', '2016-09-07 19:54:30', '19:55:03', '4,4,9', 'http://cp.360.cn/,360彩票', '17', '4 + 4 + 9 = 17', '2016-09-07 19:55:03', '2016-09-07 19:56:00');
INSERT INTO `w_lottery_result` VALUES ('1598', 'xy28', '779957', '2016-09-07 19:59:30', '20:00:08', '9,6,8', 'http://cp.360.cn/,360彩票', '23', '9 + 6 + 8 = 23', '2016-09-07 20:00:08', '2016-09-07 20:01:00');
INSERT INTO `w_lottery_result` VALUES ('1599', 'xy28', '779958', '2016-09-07 20:04:30', '20:05:06', '8,1,9', 'http://cp.360.cn/,360彩票', '18', '8 + 1 + 9 = 18', '2016-09-07 20:05:06', '2016-09-07 20:06:00');
INSERT INTO `w_lottery_result` VALUES ('1600', 'xy28', '779959', '2016-09-07 20:09:30', '20:10:18', '2,1,7', 'http://cp.360.cn/,360彩票', '10', '2 + 1 + 7 = 10', '2016-09-07 20:10:18', '2016-09-07 20:11:00');
INSERT INTO `w_lottery_result` VALUES ('1601', 'xy28', '779960', '2016-09-07 20:14:30', '20:15:11', '4,7,7', 'http://cp.360.cn/,360彩票', '18', '4 + 7 + 7 = 18', '2016-09-07 20:15:11', '2016-09-07 20:16:00');
INSERT INTO `w_lottery_result` VALUES ('1602', 'xy28', '779961', '2016-09-07 20:19:30', '20:20:03', '1,8,5', 'http://cp.360.cn/,360彩票', '14', '1 + 8 + 5 = 14', '2016-09-07 20:20:03', '2016-09-07 20:21:00');
INSERT INTO `w_lottery_result` VALUES ('1603', 'xy28', '779962', '2016-09-07 20:24:30', '20:25:03', '5,4,2', 'http://cp.360.cn/,360彩票', '11', '5 + 4 + 2 = 11', '2016-09-07 20:25:03', '2016-09-07 20:26:00');
INSERT INTO `w_lottery_result` VALUES ('1604', 'xy28', '779963', '2016-09-07 20:29:30', '20:30:03', '5,4,8', 'http://cp.360.cn/,360彩票', '17', '5 + 4 + 8 = 17', '2016-09-07 20:30:03', '2016-09-07 20:31:00');
INSERT INTO `w_lottery_result` VALUES ('1605', 'xy28', '779964', '2016-09-07 20:34:30', '20:35:03', '2,4,4', 'http://cp.360.cn/,360彩票', '10', '2 + 4 + 4 = 10', '2016-09-07 20:35:03', '2016-09-07 20:36:00');
INSERT INTO `w_lottery_result` VALUES ('1606', 'xy28', '779965', '2016-09-07 20:39:30', '20:40:03', '9,1,3', 'http://cp.360.cn/,360彩票', '13', '9 + 1 + 3 = 13', '2016-09-07 20:40:03', '2016-09-07 20:41:00');
INSERT INTO `w_lottery_result` VALUES ('1607', 'xy28', '779966', '2016-09-07 20:44:30', '20:45:03', '4,8,2', 'http://cp.360.cn/,360彩票', '14', '4 + 8 + 2 = 14', '2016-09-07 20:45:03', '2016-09-07 20:46:00');
INSERT INTO `w_lottery_result` VALUES ('1608', 'xy28', '779967', '2016-09-07 20:49:30', '20:50:13', '1,0,5', 'http://cp.360.cn/,360彩票', '6', '1 + 0 + 5 = 6', '2016-09-07 20:50:13', '2016-09-07 20:51:00');
INSERT INTO `w_lottery_result` VALUES ('1609', 'xy28', '779968', '2016-09-07 20:54:30', '20:55:03', '9,2,7', 'http://cp.360.cn/,360彩票', '18', '9 + 2 + 7 = 18', '2016-09-07 20:55:03', '2016-09-07 20:56:00');
INSERT INTO `w_lottery_result` VALUES ('1610', 'xy28', '779969', '2016-09-07 20:59:30', '21:00:13', '6,0,5', 'http://cp.360.cn/,360彩票', '11', '6 + 0 + 5 = 11', '2016-09-07 21:00:13', '2016-09-07 21:01:00');
INSERT INTO `w_lottery_result` VALUES ('1611', 'xy28', '779970', '2016-09-07 21:04:30', '21:05:03', '6,7,0', 'http://cp.360.cn/,360彩票', '13', '6 + 7 + 0 = 13', '2016-09-07 21:05:03', '2016-09-07 21:06:00');
INSERT INTO `w_lottery_result` VALUES ('1612', 'xy28', '779971', '2016-09-07 21:09:30', '21:10:17', '3,8,8', 'http://,幸运28AG', '19', '3+8+8=19', '2016-09-07 21:10:17', '2016-09-07 21:11:00');
INSERT INTO `w_lottery_result` VALUES ('1613', 'xy28', '779972', '2016-09-07 21:14:30', '21:15:03', '6,9,8', 'http://cp.360.cn/,360彩票', '23', '6 + 9 + 8 = 23', '2016-09-07 21:15:03', '2016-09-07 21:16:00');
INSERT INTO `w_lottery_result` VALUES ('1614', 'xy28', '779973', '2016-09-07 21:19:30', '21:20:18', '5,2,6', 'http://cp.360.cn/,360彩票', '13', '5 + 2 + 6 = 13', '2016-09-07 21:20:18', '2016-09-07 21:21:00');
INSERT INTO `w_lottery_result` VALUES ('1615', 'xy28', '779974', '2016-09-07 21:24:30', '21:25:03', '1,1,0', 'http://cp.360.cn/,360彩票', '2', '1 + 1 + 0 = 2', '2016-09-07 21:25:03', '2016-09-07 21:26:00');
INSERT INTO `w_lottery_result` VALUES ('1616', 'xy28', '779975', '2016-09-07 21:29:30', '21:30:23', '2,4,2', 'http://cp.360.cn/,360彩票', '8', '2 + 4 + 2 = 8', '2016-09-07 21:30:23', '2016-09-07 21:31:00');
INSERT INTO `w_lottery_result` VALUES ('1617', 'xy28', '779976', '2016-09-07 21:34:30', '21:35:03', '1,4,2', 'http://cp.360.cn/,360彩票', '7', '1 + 4 + 2 = 7', '2016-09-07 21:35:03', '2016-09-07 21:36:00');
INSERT INTO `w_lottery_result` VALUES ('1618', 'xy28', '779977', '2016-09-07 21:39:30', '21:40:18', '7,6,8', 'http://cp.360.cn/,360彩票', '21', '7 + 6 + 8 = 21', '2016-09-07 21:40:18', '2016-09-07 21:41:00');
INSERT INTO `w_lottery_result` VALUES ('1619', 'xy28', '779978', '2016-09-07 21:44:30', '21:45:03', '9,3,5', 'http://cp.360.cn/,360彩票', '17', '9 + 3 + 5 = 17', '2016-09-07 21:45:03', '2016-09-07 21:46:00');
INSERT INTO `w_lottery_result` VALUES ('1620', 'xy28', '779979', '2016-09-07 21:49:30', '21:50:08', '6,3,3', 'http://cp.360.cn/,360彩票', '12', '6 + 3 + 3 = 12', '2016-09-07 21:50:08', '2016-09-07 21:51:00');
INSERT INTO `w_lottery_result` VALUES ('1621', 'xy28', '779980', '2016-09-07 21:54:30', '21:55:03', '2,7,2', 'http://cp.360.cn/,360彩票', '11', '2 + 7 + 2 = 11', '2016-09-07 21:55:03', '2016-09-07 21:56:00');
INSERT INTO `w_lottery_result` VALUES ('1622', 'xy28', '779981', '2016-09-07 21:59:30', '22:00:22', '1,4,6', 'http://pc588.com,幸运28蛋蛋28', '11', '1+4+6=11', '2016-09-07 22:00:22', '2016-09-07 22:01:00');
INSERT INTO `w_lottery_result` VALUES ('1623', 'xy28', '779982', '2016-09-07 22:04:30', '22:05:03', '5,5,9', 'http://cp.360.cn/,360彩票', '19', '5 + 5 + 9 = 19', '2016-09-07 22:05:03', '2016-09-07 22:06:00');
INSERT INTO `w_lottery_result` VALUES ('1624', 'xy28', '779983', '2016-09-07 22:09:30', '22:10:08', '7,6,8', 'http://cp.360.cn/,360彩票', '21', '7 + 6 + 8 = 21', '2016-09-07 22:10:08', '2016-09-07 22:11:00');
INSERT INTO `w_lottery_result` VALUES ('1625', 'xy28', '779984', '2016-09-07 22:14:30', '22:15:03', '1,5,6', 'http://cp.360.cn/,360彩票', '12', '1 + 5 + 6 = 12', '2016-09-07 22:15:03', '2016-09-07 22:16:00');
INSERT INTO `w_lottery_result` VALUES ('1626', 'xy28', '779985', '2016-09-07 22:19:30', '22:20:08', '9,2,7', 'http://cp.360.cn/,360彩票', '18', '9 + 2 + 7 = 18', '2016-09-07 22:20:08', '2016-09-07 22:21:00');
INSERT INTO `w_lottery_result` VALUES ('1627', 'xy28', '779986', '2016-09-07 22:24:30', '22:25:06', '0,5,1', 'http://cp.360.cn/,360彩票', '6', '0 + 5 + 1 = 6', '2016-09-07 22:25:06', '2016-09-07 22:26:00');
INSERT INTO `w_lottery_result` VALUES ('1628', 'xy28', '779987', '2016-09-07 22:29:30', '22:30:08', '2,8,5', 'http://cp.360.cn/,360彩票', '15', '2 + 8 + 5 = 15', '2016-09-07 22:30:08', '2016-09-07 22:31:00');
INSERT INTO `w_lottery_result` VALUES ('1629', 'xy28', '779988', '2016-09-07 22:34:30', '22:35:03', '9,7,2', 'http://cp.360.cn/,360彩票', '18', '9 + 7 + 2 = 18', '2016-09-07 22:35:03', '2016-09-07 22:36:00');
INSERT INTO `w_lottery_result` VALUES ('1630', 'xy28', '779989', '2016-09-07 22:39:30', '22:40:08', '8,5,9', 'http://cp.360.cn/,360彩票', '22', '8 + 5 + 9 = 22', '2016-09-07 22:40:08', '2016-09-07 22:41:00');
INSERT INTO `w_lottery_result` VALUES ('1631', 'xy28', '779990', '2016-09-07 22:44:30', '22:45:08', '3,1,8', 'http://cp.360.cn/,360彩票', '12', '3 + 1 + 8 = 12', '2016-09-07 22:45:08', '2016-09-07 22:46:00');
INSERT INTO `w_lottery_result` VALUES ('1632', 'xy28', '779991', '2016-09-07 22:49:30', '22:50:08', '7,7,1', 'http://cp.360.cn/,360彩票', '15', '7 + 7 + 1 = 15', '2016-09-07 22:50:08', '2016-09-07 22:51:00');
INSERT INTO `w_lottery_result` VALUES ('1633', 'xy28', '779992', '2016-09-07 22:54:30', '22:55:03', '1,8,5', 'http://cp.360.cn/,360彩票', '14', '1 + 8 + 5 = 14', '2016-09-07 22:55:03', '2016-09-07 22:56:00');
INSERT INTO `w_lottery_result` VALUES ('1634', 'xy28', '779993', '2016-09-07 22:59:30', '23:00:09', '0,0,2', 'http://cp.360.cn/,360彩票', '2', '0 + 0 + 2 = 2', '2016-09-07 23:00:09', '2016-09-07 23:01:00');
INSERT INTO `w_lottery_result` VALUES ('1635', 'xy28', '779994', '2016-09-07 23:04:30', '23:05:03', '7,6,2', 'http://cp.360.cn/,360彩票', '15', '7 + 6 + 2 = 15', '2016-09-07 23:05:03', '2016-09-07 23:06:00');
INSERT INTO `w_lottery_result` VALUES ('1636', 'xy28', '779995', '2016-09-07 23:09:30', '23:10:08', '7,1,2', 'http://cp.360.cn/,360彩票', '10', '7 + 1 + 2 = 10', '2016-09-07 23:10:08', '2016-09-07 23:11:00');
INSERT INTO `w_lottery_result` VALUES ('1637', 'xy28', '779996', '2016-09-07 23:14:30', '23:15:03', '7,5,2', 'http://cp.360.cn/,360彩票', '14', '7 + 5 + 2 = 14', '2016-09-07 23:15:03', '2016-09-07 23:16:00');
INSERT INTO `w_lottery_result` VALUES ('1638', 'xy28', '779997', '2016-09-07 23:19:30', '23:20:08', '6,3,2', 'http://cp.360.cn/,360彩票', '11', '6 + 3 + 2 = 11', '2016-09-07 23:20:08', '2016-09-07 23:21:00');
INSERT INTO `w_lottery_result` VALUES ('1639', 'xy28', '779998', '2016-09-07 23:24:30', '23:25:09', '6,9,7', 'http://cp.360.cn/,360彩票', '22', '6 + 9 + 7 = 22', '2016-09-07 23:25:09', '2016-09-07 23:29:00');
INSERT INTO `w_lottery_result` VALUES ('1640', 'xy28', '779999', '2016-09-07 23:29:30', '23:30:08', '6,4,0', 'http://cp.360.cn/,360彩票', '10', '6 + 4 + 0 = 10', '2016-09-07 23:30:08', '2016-09-07 23:31:00');
INSERT INTO `w_lottery_result` VALUES ('1641', 'xy28', '780000', '2016-09-07 23:34:30', '23:35:18', '2,7,6', 'http://cp.360.cn/,360彩票', '15', '2 + 7 + 6 = 15', '2016-09-07 23:35:18', '2016-09-07 23:44:00');
INSERT INTO `w_lottery_result` VALUES ('1642', 'xy28', '780001', '2016-09-07 23:39:30', '23:40:08', '6,3,9', 'http://cp.360.cn/,360彩票', '18', '6 + 3 + 9 = 18', '2016-09-07 23:40:08', '2016-09-07 23:44:00');
INSERT INTO `w_lottery_result` VALUES ('1643', 'xy28', '780002', '2016-09-07 23:44:30', '23:45:04', '6,4,4', 'http://cp.360.cn/,360彩票', '14', '6 + 4 + 4 = 14', '2016-09-07 23:45:04', '2016-09-07 23:46:00');
INSERT INTO `w_lottery_result` VALUES ('1644', 'xy28', '780003', '2016-09-07 23:49:30', '23:50:03', '1,6,1', 'http://cp.360.cn/,360彩票', '8', '1 + 6 + 1 = 8', '2016-09-07 23:50:03', '2016-09-07 23:51:00');
INSERT INTO `w_lottery_result` VALUES ('1645', 'xy28', '780004', '2016-09-07 23:54:30', '23:55:03', '3,7,9', 'http://cp.360.cn/,360彩票', '19', '3 + 7 + 9 = 19', '2016-09-07 23:55:03', '2016-09-07 23:56:00');
INSERT INTO `w_lottery_result` VALUES ('1646', 'xy28', '780012', '2016-09-08 09:39:30', '09:42:42', '8,7,1', 'http://pc588.com,幸运28蛋蛋28', '16', '8+7+1=16', '2016-09-08 09:42:42', '2016-09-08 09:43:00');
INSERT INTO `w_lottery_result` VALUES ('1647', 'xy28', '780013', '2016-09-08 09:44:30', '09:45:03', '2,7,6', 'http://cp.360.cn/,360彩票', '15', '2 + 7 + 6 = 15', '2016-09-08 09:45:03', '2016-09-08 09:46:01');
INSERT INTO `w_lottery_result` VALUES ('1648', 'xy28', '780014', '2016-09-08 09:49:30', '09:50:13', '5,9,0', 'http://cp.360.cn/,360彩票', '14', '5 + 9 + 0 = 14', '2016-09-08 09:50:13', '2016-09-08 09:51:00');
INSERT INTO `w_lottery_result` VALUES ('1649', 'xy28', '780018', '2016-09-08 10:09:30', '10:14:02', '6,1,5', 'http://cp.360.cn/,360彩票', '12', '6 + 1 + 5 = 12', '2016-09-08 10:14:02', '2016-09-08 10:15:00');
INSERT INTO `w_lottery_result` VALUES ('1650', 'xy28', '780019', '2016-09-08 10:14:30', '10:15:02', '9,0,7', 'http://cp.360.cn/,360彩票', '16', '9 + 0 + 7 = 16', '2016-09-08 10:15:02', '2016-09-08 10:24:00');
INSERT INTO `w_lottery_result` VALUES ('1651', 'xy28', '780020', '2016-09-08 10:19:30', '10:23:55', '9,1,2', 'http://pc588.com,幸运28蛋蛋28', '12', '9+1+2=12', '2016-09-08 10:23:55', '2016-09-08 10:24:00');
INSERT INTO `w_lottery_result` VALUES ('1652', 'xy28', '780021', '2016-09-08 10:24:30', '10:25:06', '4,6,1', 'http://cp.360.cn/,360彩票', '11', '4 + 6 + 1 = 11', '2016-09-08 10:25:06', '2016-09-08 10:26:04');
INSERT INTO `w_lottery_result` VALUES ('1653', 'xy28', '780022', '2016-09-08 10:29:30', '10:30:07', '4,3,9', 'http://cp.360.cn/,360彩票', '16', '4 + 3 + 9 = 16', '2016-09-08 10:30:07', '2016-09-08 10:31:00');
INSERT INTO `w_lottery_result` VALUES ('1654', 'xy28', '780023', '2016-09-08 10:34:30', '10:35:06', '5,2,8', 'http://cp.360.cn/,360彩票', '15', '5 + 2 + 8 = 15', '2016-09-08 10:35:06', '2016-09-08 10:36:00');
INSERT INTO `w_lottery_result` VALUES ('1655', 'xy28', '780024', '2016-09-08 10:39:30', '10:40:11', '7,0,1', 'http://cp.360.cn/,360彩票', '8', '7 + 0 + 1 = 8', '2016-09-08 10:40:11', '2016-09-08 10:41:00');
INSERT INTO `w_lottery_result` VALUES ('1656', 'xy28', '780025', '2016-09-08 10:44:30', '10:45:01', '8,5,8', 'http://cp.360.cn/,360彩票', '21', '8 + 5 + 8 = 21', '2016-09-08 10:45:01', '2016-09-08 10:46:00');
INSERT INTO `w_lottery_result` VALUES ('1657', 'xy28', '780026', '2016-09-08 10:49:30', '10:50:15', '8,0,5', 'http://pc588.com,幸运28蛋蛋28', '13', '8+0+5=13', '2016-09-08 10:50:15', '2016-09-08 10:51:00');
INSERT INTO `w_lottery_result` VALUES ('1658', 'xy28', '780027', '2016-09-08 10:54:30', '10:55:06', '8,4,6', 'http://cp.360.cn/,360彩票', '18', '8 + 4 + 6 = 18', '2016-09-08 10:55:06', '2016-09-08 10:56:00');
INSERT INTO `w_lottery_result` VALUES ('1659', 'xy28', '780028', '2016-09-08 10:59:30', '11:00:11', '5,3,6', 'http://cp.360.cn/,360彩票', '14', '5 + 3 + 6 = 14', '2016-09-08 11:00:11', '2016-09-08 11:01:00');
INSERT INTO `w_lottery_result` VALUES ('1660', 'xy28', '780029', '2016-09-08 11:04:30', '11:07:24', '4,3,0', 'http://pc588.com,幸运28蛋蛋28', '7', '4+3+0=7', '2016-09-08 11:07:24', '2016-09-08 11:08:01');
INSERT INTO `w_lottery_result` VALUES ('1661', 'xy28', '780030', '2016-09-08 11:09:30', '11:10:09', '8,5,2', 'http://cp.360.cn/,360彩票', '15', '8 + 5 + 2 = 15', '2016-09-08 11:10:09', '2016-09-08 11:11:00');
INSERT INTO `w_lottery_result` VALUES ('1662', 'xy28', '780031', '2016-09-08 11:14:30', '11:15:10', '8,4,0', 'http://cp.360.cn/,360彩票', '12', '8 + 4 + 0 = 12', '2016-09-08 11:15:10', '2016-09-08 11:16:00');
INSERT INTO `w_lottery_result` VALUES ('1663', 'xy28', '780032', '2016-09-08 11:19:30', '11:20:10', '9,4,9', 'http://cp.360.cn/,360彩票', '22', '9 + 4 + 9 = 22', '2016-09-08 11:20:10', '2016-09-08 11:21:04');
INSERT INTO `w_lottery_result` VALUES ('1664', 'xy28', '780033', '2016-09-08 11:24:30', '11:25:05', '2,7,9', 'http://cp.360.cn/,360彩票', '18', '2 + 7 + 9 = 18', '2016-09-08 11:25:05', '2016-09-08 13:15:00');
INSERT INTO `w_lottery_result` VALUES ('1665', 'xy28', '780054', '2016-09-08 13:09:30', '13:14:44', '0,7,5', 'http://pc588.com,幸运28蛋蛋28', '12', '0+7+5=12', '2016-09-08 13:14:44', '2016-09-08 13:15:00');
INSERT INTO `w_lottery_result` VALUES ('1666', 'xy28', '780055', '2016-09-08 13:14:30', '13:15:10', '5,2,2', 'http://cp.360.cn/,360彩票', '9', '5 + 2 + 2 = 9', '2016-09-08 13:15:10', '2016-09-08 13:19:00');
INSERT INTO `w_lottery_result` VALUES ('1667', 'keno28', '2042810', '2016-09-08 13:23:30', '13:24:46', '6,9,0', 'www.agpc28.com,加拿大28AG', '15', '6+9+0=15', '2016-09-08 13:24:46', '2016-09-08 13:25:00');
INSERT INTO `w_lottery_result` VALUES ('1668', 'keno28', '2042811', '2016-09-08 13:27:00', '13:27:36', '3,9,5', 'http://pc588.com/jnd28/, PC588', '17', '3+9+5 = 17', '2016-09-08 13:27:36', '2016-09-08 13:28:00');
INSERT INTO `w_lottery_result` VALUES ('1669', 'keno28', '2042812', '2016-09-08 13:30:30', '13:31:06', '2,7,5', 'http://pc588.com/jnd28/, PC588', '14', '2+7+5 = 14', '2016-09-08 13:31:06', '2016-09-08 13:32:05');
INSERT INTO `w_lottery_result` VALUES ('1670', 'keno28', '2042813', '2016-09-08 13:34:00', '13:34:36', '3,2,7', 'http://pc588.com/jnd28/, PC588', '12', '3+2+7 = 12', '2016-09-08 13:34:36', '2016-09-08 13:35:00');
INSERT INTO `w_lottery_result` VALUES ('1671', 'xy28', '780056', '2016-09-08 13:19:30', '16:14:20', '6,5,5', 'http://pc588.com,幸运28蛋蛋28', '16', '6+5+5=16', '2016-09-08 16:14:20', '2016-09-08 16:15:04');
INSERT INTO `w_lottery_result` VALUES ('1672', 'xy28', '780090', '2016-09-08 16:09:30', '16:14:35', '5,3,0', 'http://pc588.com,幸运28蛋蛋28', '8', '5+3+0=8', '2016-09-08 16:14:35', '2016-09-08 16:15:04');
INSERT INTO `w_lottery_result` VALUES ('1673', 'xy28', '780091', '2016-09-08 16:14:30', '16:15:06', '9,4,2', 'http://cp.360.cn/,360彩票', '15', '9 + 4 + 2 = 15', '2016-09-08 16:15:06', '2016-09-08 17:06:00');
INSERT INTO `w_lottery_result` VALUES ('1674', 'xy28', '780101', '2016-09-08 17:04:30', '17:05:59', '5,1,0', 'http://pc588.com,幸运28蛋蛋28', '6', '5+1+0=6', '2016-09-08 17:05:59', '2016-09-08 17:06:00');
INSERT INTO `w_lottery_result` VALUES ('1675', 'xy28', '780102', '2016-09-08 17:09:30', '17:10:09', '8,2,3', 'http://cp.360.cn/,360彩票', '13', '8 + 2 + 3 = 13', '2016-09-08 17:10:09', '2016-09-08 17:11:00');
INSERT INTO `w_lottery_result` VALUES ('1676', 'xy28', '780103', '2016-09-08 17:14:30', '17:16:31', '3,8,8', 'http://pc588.com,幸运28蛋蛋28', '19', '3+8+8=19', '2016-09-08 17:16:31', '2016-09-08 17:17:00');
INSERT INTO `w_lottery_result` VALUES ('1677', 'xy28', '780104', '2016-09-08 17:19:30', '17:20:07', '6,8,4', 'http://cp.360.cn/,360彩票', '18', '6 + 8 + 4 = 18', '2016-09-08 17:20:07', '2016-09-08 17:21:04');
INSERT INTO `w_lottery_result` VALUES ('1678', 'xy28', '780105', '2016-09-08 17:24:30', '17:25:08', '2,6,4', 'http://cp.360.cn/,360彩票', '12', '2 + 6 + 4 = 12', '2016-09-08 17:25:08', '2016-09-08 17:26:00');
INSERT INTO `w_lottery_result` VALUES ('1679', 'xy28', '780106', '2016-09-08 17:29:30', '17:30:11', '2,1,6', 'http://cp.360.cn/,360彩票', '9', '2 + 1 + 6 = 9', '2016-09-08 17:30:11', '2016-09-08 17:31:00');
INSERT INTO `w_lottery_result` VALUES ('1680', 'xy28', '780107', '2016-09-08 17:34:30', '17:35:07', '3,3,0', 'http://cp.360.cn/,360彩票', '6', '3 + 3 + 0 = 6', '2016-09-08 17:35:07', '2016-09-08 17:36:00');
INSERT INTO `w_lottery_result` VALUES ('1681', 'xy28', '780108', '2016-09-08 17:39:30', '17:40:06', '0,6,4', 'http://cp.360.cn/,360彩票', '10', '0 + 6 + 4 = 10', '2016-09-08 17:40:06', '2016-09-08 17:41:00');
INSERT INTO `w_lottery_result` VALUES ('1682', 'xy28', '780109', '2016-09-08 17:44:30', '17:45:06', '7,5,1', 'http://cp.360.cn/,360彩票', '13', '7 + 5 + 1 = 13', '2016-09-08 17:45:06', '2016-09-08 17:46:00');
INSERT INTO `w_lottery_result` VALUES ('1683', 'xy28', '780110', '2016-09-08 17:49:30', '18:04:24', '3,9,1', 'http://pc588.com,幸运28蛋蛋28', '13', '3+9+1=13', '2016-09-08 18:04:24', '2016-09-08 19:55:04');
INSERT INTO `w_lottery_result` VALUES ('1684', 'xy28', '780134', '2016-09-08 19:49:30', '19:54:55', '6,9,9', 'http://pc588.com,幸运28蛋蛋28', '24', '6+9+9=24', '2016-09-08 19:54:55', '2016-09-08 19:55:04');
INSERT INTO `w_lottery_result` VALUES ('1685', 'xy28', '780135', '2016-09-08 19:54:30', '19:55:06', '7,7,7', 'http://cp.360.cn/,360彩票', '21', '7 + 7 + 7 = 21', '2016-09-08 19:55:06', '2016-09-08 19:57:04');

-- ----------------------------
-- Table structure for `w_money`
-- ----------------------------
DROP TABLE IF EXISTS `w_money`;
CREATE TABLE `w_money` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uin` varchar(50) DEFAULT NULL COMMENT '微信uin',
  `nickname` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `phone` varchar(50) DEFAULT NULL,
  `money` int(11) DEFAULT NULL COMMENT '金额',
  `bank_card` varchar(50) DEFAULT NULL COMMENT '银行卡',
  `bank_card_type` int(11) DEFAULT NULL COMMENT '银行卡类型',
  `qq_number` varchar(50) DEFAULT NULL COMMENT 'qq号',
  `wechat_number` varchar(50) DEFAULT NULL COMMENT '微信号',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `memo` varchar(500) DEFAULT NULL COMMENT '备注',
  `agent_name` varchar(50) DEFAULT NULL COMMENT '所属代理',
  `type` int(11) DEFAULT NULL COMMENT '用户类型（1:真实用户,0:测试用户,2:信誉用户）',
  `enabled` int(11) DEFAULT NULL COMMENT '是否启用(1:启用,0:弃用)',
  `agent` int(11) DEFAULT NULL COMMENT '1: 代理, 2:非代理',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='微信钱包';

-- ----------------------------
-- Records of w_money
-- ----------------------------
INSERT INTO `w_money` VALUES ('15', null, '摩弦', null, '78690', null, null, null, null, null, '99', '2016-09-07 15:13:10', '2016-09-08 19:54:45', null, 'ceshi1234', '1', '1', '1');
INSERT INTO `w_money` VALUES ('16', null, '11111111', null, '8000', null, null, null, null, null, '0', '2016-09-07 15:52:03', '2016-09-07 16:05:38', null, '摩弦', '1', '1', '1');
INSERT INTO `w_money` VALUES ('17', null, '555678', null, '5820', null, null, null, null, null, '15', '2016-09-07 16:03:31', '2016-09-07 18:10:12', null, '11111111', '1', '1', '2');

-- ----------------------------
-- Table structure for `w_money_log`
-- ----------------------------
DROP TABLE IF EXISTS `w_money_log`;
CREATE TABLE `w_money_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nickname` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `uin` varchar(50) DEFAULT NULL COMMENT '微信uin',
  `game_type` varchar(20) DEFAULT NULL,
  `trans_money` int(11) DEFAULT NULL COMMENT '转账金额',
  `after_trans_money` int(11) DEFAULT NULL COMMENT '转账后金额',
  `state` int(11) DEFAULT NULL COMMENT '状态:\r\n            {\r\n            下注(1),\r\n            派彩(2),\r\n            撤销(4),\r\n            上分申请(0),\r\n            人工上分申请(5),\r\n            余额不足(20), //统一下分申请才会出现余额不足\r\n            下分申请(10),\r\n            同意下分(100),\r\n            拒绝下分(-100),\r\n            同意上分(',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `memo` varchar(100) DEFAULT NULL COMMENT '备注',
  `msg` varchar(100) DEFAULT NULL COMMENT '消息',
  `bet_id` int(11) DEFAULT NULL COMMENT '下注id',
  `operater` varchar(50) DEFAULT NULL COMMENT '操作者',
  `ip` varchar(50) DEFAULT NULL,
  `recharge_change_state` varchar(200) DEFAULT NULL,
  `recharge_withdraw_state` varchar(200) DEFAULT NULL,
  `already_sync` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=800 DEFAULT CHARSET=utf8 COMMENT='微信钱包日志';

-- ----------------------------
-- Records of w_money_log
-- ----------------------------
INSERT INTO `w_money_log` VALUES ('674', '摩弦', null, 'xy28', '8000', '8000', '50', '2016-09-06 15:12:46', null, '上分数据', '查8000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('675', '摩弦', null, 'xy28', '500', '7500', '100', '2016-09-07 15:13:28', null, '下分数据', '回500', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('676', '摩弦', null, 'xy28', '600', '6900', '100', '2016-09-07 15:13:31', null, '下分数据', '回600', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('677', '摩弦', null, 'xy28', '400', '6500', '1', '2016-09-07 15:13:52', null, '下注数据', '大400', '253', 'ceshi1234', '49.150.1.163', null, null, '1');
INSERT INTO `w_money_log` VALUES ('678', '摩弦', null, 'xy28', '500', '6000', '-100', '2016-09-07 15:14:16', null, '下分数据', '回500', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('679', '摩弦', null, 'xy28', '500', '5500', '1', '2016-09-07 15:14:18', null, '下注数据', '大500', '254', 'ceshi1234', '49.150.1.163', null, null, '1');
INSERT INTO `w_money_log` VALUES ('680', '摩弦', null, 'xy28', '0', '6000', '2', '2016-09-07 15:15:08', null, '派彩数据', '派彩金额数据', '253', 'ceshi1234', '49.150.1.163', null, null, '1');
INSERT INTO `w_money_log` VALUES ('681', '摩弦', null, 'xy28', '0', '6000', '2', '2016-09-07 15:15:08', null, '派彩数据', '派彩金额数据', '254', 'ceshi1234', '49.150.1.163', null, null, '1');
INSERT INTO `w_money_log` VALUES ('682', '摩弦', null, 'xy28', '500', '5500', '-1', '2016-09-07 15:26:25', null, '补单数据', '大500', '255', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('683', '摩弦', null, 'xy28', '1000', '6500', '2', '2016-09-07 15:30:17', null, '派彩数据', '派彩金额数据', '255', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('684', '摩弦', null, 'xy28', '100', '6400', '1', '2016-09-07 15:35:49', null, '下注数据', '大100', '256', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('685', '摩弦', null, 'xy28', '300', '6100', '1', '2016-09-07 15:35:52', null, '下注数据', '大300', '257', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('686', '摩弦', null, 'xy28', '400', '6500', '4', '2016-09-07 15:36:04', null, '取消数据', '取消', '258', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('687', '摩弦', null, 'xy28', '300', '6200', '1', '2016-09-07 15:37:01', null, '下注数据', '大300', '259', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('688', '摩弦', null, 'xy28', '400', '5800', '1', '2016-09-07 15:37:03', null, '下注数据', '大400', '260', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('689', '摩弦', null, 'xy28', '700', '6500', '4', '2016-09-07 15:37:22', null, '改单数据', '改小400', '261', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('690', '摩弦', null, 'xy28', '400', '6100', '1', '2016-09-07 15:37:22', null, '下注数据', '小400', '262', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('691', '摩弦', null, 'xy28', '1000', '7100', '50', '2016-09-07 15:37:51', null, '上分数据', '查1000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('692', '摩弦', null, 'xy28', '1000', '7100', '-50', '2016-09-07 15:38:11', null, '上分数据', '查1000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('693', '摩弦', null, 'xy28', '100', '7000', '100', '2016-09-07 15:38:44', null, '下分数据', '回100', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('694', '摩弦', null, 'xy28', '100', '7000', '-100', '2016-09-07 15:38:56', null, '下分数据', '回100', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('695', '摩弦', null, 'xy28', '100', '7000', '-100', '2016-09-07 15:39:17', null, '下分数据', '回100', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('696', '摩弦', null, 'xy28', '800', '7800', '2', '2016-09-07 15:40:17', null, '派彩数据', '派彩金额数据', '262', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('697', '摩弦', null, 'xy28', '800', '7000', '100', '2016-09-07 15:42:12', null, '下分数据', '回800', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('698', '摩弦', null, 'xy28', '800', '7000', '-100', '2016-09-07 15:42:31', null, '下分数据', '回800', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('699', '摩弦', null, 'xy28', '800', '6200', '100', '2016-09-07 15:42:42', null, '下分数据', '回800', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('700', '摩弦', null, 'xy28', '200', '6000', '100', '2016-09-07 15:42:44', null, '下分数据', '回200', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('701', '摩弦', null, 'xy28', '800', '5800', '-100', '2016-09-07 15:42:59', null, '下分数据', '回800', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('702', '摩弦', null, 'xy28', '200', '6000', '-100', '2016-09-07 15:42:59', null, '下分数据', '回200', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('703', '摩弦', null, null, '1000', '7000', '500', '2016-09-07 15:45:00', null, '充值补账', '充值补账', null, 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('704', '摩弦', null, null, '500', '7500', '400', '2016-09-07 15:47:01', null, '理赔充值', '理赔充值', null, 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('705', '摩弦', null, null, '500', '8000', '300', '2016-09-07 15:47:14', null, '优惠充值', '优惠充值', null, 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('706', '摩弦', null, null, '1000', '7000', '600', '2016-09-07 15:47:27', null, '人工扣减', '人工扣减', null, 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('707', '摩弦', null, null, '1000', '8000', '350', '2016-09-07 15:47:48', null, '人工增加', '人工增加', null, 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('708', '摩弦', null, 'xy28', '1000', '4000', '50', '2016-09-07 15:48:12', null, '上分数据', '查1000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('709', '摩弦', null, 'xy28', '5000', '3000', '100', '2016-09-07 15:48:17', null, '下分数据', '回5000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('710', '11111111', null, 'xy28', '8000', '8000', '50', '2016-09-08 15:52:01', null, '上分数据', '查8000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('711', '555678', null, 'xy28', '2000', '2000', '50', '2016-09-07 16:03:26', null, '上分数据', '查2000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('712', '555678', null, 'xy28', '100', '1900', '1', '2016-09-07 16:05:41', null, '下注数据', '大100', '263', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('713', '555678', null, 'xy28', '200', '1700', '1', '2016-09-07 16:05:41', null, '下注数据', '小200', '264', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('714', '555678', null, 'xy28', '90', '1610', '1', '2016-09-07 16:05:41', null, '下注数据', '12.90', '265', 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('715', '555678', null, 'xy28', '200', '1810', '2', '2016-09-07 16:10:08', null, '派彩数据', '派彩金额数据', '263', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('716', '555678', null, 'xy28', '0', '1810', '2', '2016-09-07 16:10:08', null, '派彩数据', '派彩金额数据', '264', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('717', '555678', null, 'xy28', '0', '1810', '2', '2016-09-07 16:10:08', null, '派彩数据', '派彩金额数据', '265', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('718', '555678', null, 'xy28', '100', '1710', '1', '2016-09-07 18:00:40', null, '下注数据', '大100', '266', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('719', '555678', null, 'xy28', '200', '1910', '2', '2016-09-07 18:05:12', null, '派彩数据', '派彩金额数据', '266', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('720', '555678', null, 'xy28', '20', '1890', '1', '2016-09-07 18:05:46', null, '下注数据', '大20', '268', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('721', '555678', null, 'xy28', '20', '1890', '1', '2016-09-07 18:06:06', null, '下注数据', '大20', '270', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('722', '555678', null, 'xy28', '1910', '0', '1', '2016-09-07 18:06:18', null, '下注数据', '大1910', '272', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('723', '555678', null, 'xy28', '2000', '2000', '50', '2016-09-07 18:06:37', null, '上分数据', '查2000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('724', '摩弦', null, 'xy28', '3000', '4000', '-100', '2016-09-07 18:07:12', null, '下分数据', '回3000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('725', '摩弦', null, 'xy28', '5000', null, '-50', '2016-09-07 18:07:16', null, '上分数据', '查5000', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('726', '555678', null, 'xy28', '20', '1980', '1', '2016-09-07 18:07:32', null, '下注数据', '大20', '275', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('727', '摩弦', null, 'xy28', '3880', '120', '100', '2016-09-07 18:07:35', null, '下分数据', '回3880', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('728', '摩弦', null, 'xy28', '100', '20', '100', '2016-09-07 18:07:42', null, '下分数据', '回100', null, 'ceshi1234', null, null, null, '1');
INSERT INTO `w_money_log` VALUES ('729', '摩弦', null, 'xy28', '20', '0', '1', '2016-09-07 18:07:57', null, '下注数据', '大20', '277', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('730', '555678', null, 'xy28', '3820', '5820', '2', '2016-09-07 18:10:12', null, '派彩数据', '派彩金额数据', '272', 'ceshi1234', '112.206.86.43', null, null, '1');
INSERT INTO `w_money_log` VALUES ('731', '摩弦', null, 'xy28', '20', '0', '1', '2016-09-08 13:19:27', '2016-09-08 13:19:27', '下注数据', '大20', '278', 'ceshi1234', '49.150.1.163', null, null, null);
INSERT INTO `w_money_log` VALUES ('732', '摩弦', null, 'xy28', '80000', '80000', '50', '2016-09-08 13:19:35', '2016-09-08 13:19:40', '上分数据', '查80000', null, 'ceshi1234', null, null, null, null);
INSERT INTO `w_money_log` VALUES ('733', '摩弦', null, 'xy28', '100', '79900', '1', '2016-09-08 16:14:28', '2016-09-08 16:14:28', '下注数据', '大100', '279', 'ceshi1234', '49.150.1.163', null, null, null);
INSERT INTO `w_money_log` VALUES ('734', '摩弦', null, 'xy28', '40', '79940', '2', '2016-09-08 16:14:30', '2016-09-08 16:14:30', '派彩数据', '派彩金额数据', '278', 'ceshi1234', '49.150.1.163', null, null, null);
INSERT INTO `w_money_log` VALUES ('735', '摩弦', null, 'xy28', '200', '80140', '2', '2016-09-08 16:15:10', '2016-09-08 16:15:10', '派彩数据', '派彩金额数据', '279', 'ceshi1234', '49.150.1.163', null, null, null);
INSERT INTO `w_money_log` VALUES ('736', '摩弦', null, 'xy28', '200', '79940', '1', '2016-09-08 17:16:40', '2016-09-08 17:16:40', '下注数据', '大200', '280', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('737', '摩弦', null, 'xy28', '100', '79840', '1', '2016-09-08 17:16:48', '2016-09-08 17:16:48', '下注数据', '小100', '281', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('738', '摩弦', null, 'xy28', '100', '79740', '1', '2016-09-08 17:17:37', '2016-09-08 17:17:37', '下注数据', '大100', '282', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('739', '摩弦', null, 'xy28', '300', '79440', '1', '2016-09-08 17:17:40', '2016-09-08 17:17:40', '下注数据', '小300', '283', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('740', '摩弦', null, 'xy28', '200', '79240', '1', '2016-09-08 17:17:46', '2016-09-08 17:17:46', '下注数据', '1草200', '284', 'ceshi1234', null, null, null, null);
INSERT INTO `w_money_log` VALUES ('741', '摩弦', null, 'xy28', '100', '79140', '1', '2016-09-08 17:17:52', '2016-09-08 17:17:52', '下注数据', '3草100', '285', 'ceshi1234', null, null, null, null);
INSERT INTO `w_money_log` VALUES ('742', '摩弦', null, 'xy28', '500', '78640', '1', '2016-09-08 17:17:57', '2016-09-08 17:17:57', '下注数据', '4草500', '286', 'ceshi1234', null, null, null, null);
INSERT INTO `w_money_log` VALUES ('743', '摩弦', null, 'xy28', '400', '79040', '2', '2016-09-08 17:20:11', '2016-09-08 17:20:11', '派彩数据', '派彩金额数据', '280', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('744', '摩弦', null, 'xy28', '0', '79040', '2', '2016-09-08 17:20:11', '2016-09-08 17:20:11', '派彩数据', '派彩金额数据', '281', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('745', '摩弦', null, 'xy28', '200', '79240', '2', '2016-09-08 17:20:11', '2016-09-08 17:20:11', '派彩数据', '派彩金额数据', '282', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('746', '摩弦', null, 'xy28', '0', '79240', '2', '2016-09-08 17:20:11', '2016-09-08 17:20:11', '派彩数据', '派彩金额数据', '283', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('747', '摩弦', null, 'xy28', '0', '79240', '2', '2016-09-08 17:20:11', '2016-09-08 17:20:11', '派彩数据', '派彩金额数据', '284', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('748', '摩弦', null, 'xy28', '0', '79240', '2', '2016-09-08 17:20:11', '2016-09-08 17:20:11', '派彩数据', '派彩金额数据', '285', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('749', '摩弦', null, 'xy28', '0', '79240', '2', '2016-09-08 17:20:11', '2016-09-08 17:20:11', '派彩数据', '派彩金额数据', '286', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('750', '摩弦', null, 'xy28', '100', '79140', '1', '2016-09-08 17:20:57', '2016-09-08 17:20:57', '下注数据', '大100', '287', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('751', '摩弦', null, 'xy28', '300', '78840', '1', '2016-09-08 17:20:59', '2016-09-08 17:20:59', '下注数据', '小300', '288', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('752', '摩弦', null, 'xy28', '200', '78640', '1', '2016-09-08 17:21:08', '2016-09-08 17:21:08', '下注数据', '1草200', '289', 'ceshi1234', null, null, null, null);
INSERT INTO `w_money_log` VALUES ('753', '摩弦', null, 'xy28', '100', '78540', '1', '2016-09-08 17:21:09', '2016-09-08 17:21:09', '下注数据', '3草100', '290', 'ceshi1234', null, null, null, null);
INSERT INTO `w_money_log` VALUES ('754', '摩弦', null, 'xy28', '500', '78040', '1', '2016-09-08 17:21:17', '2016-09-08 17:21:17', '下注数据', '4草500', '291', 'ceshi1234', null, null, null, null);
INSERT INTO `w_money_log` VALUES ('755', '摩弦', null, 'xy28', '0', '78040', '2', '2016-09-08 17:25:11', '2016-09-08 17:25:11', '派彩数据', '派彩金额数据', '287', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('756', '摩弦', null, 'xy28', '600', '78640', '2', '2016-09-08 17:25:11', '2016-09-08 17:25:11', '派彩数据', '派彩金额数据', '288', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('757', '摩弦', null, 'xy28', '0', '78640', '2', '2016-09-08 17:25:11', '2016-09-08 17:25:11', '派彩数据', '派彩金额数据', '289', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('758', '摩弦', null, 'xy28', '0', '78640', '2', '2016-09-08 17:25:11', '2016-09-08 17:25:11', '派彩数据', '派彩金额数据', '290', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('759', '摩弦', null, 'xy28', '0', '78640', '2', '2016-09-08 17:25:11', '2016-09-08 17:25:11', '派彩数据', '派彩金额数据', '291', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('760', '摩弦', null, 'xy28', '100', '78540', '1', '2016-09-08 17:33:46', '2016-09-08 17:33:46', '下注数据', '双100', '292', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('761', '摩弦', null, 'xy28', '100', '78440', '1', '2016-09-08 17:34:29', '2016-09-08 17:34:29', '下注数据', '大100', '293', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('762', '摩弦', null, 'xy28', '200', '78640', '2', '2016-09-08 17:35:11', '2016-09-08 17:35:11', '派彩数据', '派彩金额数据', '292', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('763', '摩弦', null, 'xy28', '0', '78640', '2', '2016-09-08 17:35:11', '2016-09-08 17:35:11', '派彩数据', '派彩金额数据', '293', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('764', '摩弦', null, 'xy28', '100', '78540', '1', '2016-09-08 17:41:44', '2016-09-08 17:41:44', '下注数据', '小100', '294', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('765', '摩弦', null, 'xy28', '100', '78440', '1', '2016-09-08 17:41:49', '2016-09-08 17:41:49', '下注数据', '单100', '295', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('766', '摩弦', null, 'xy28', '100', '78340', '1', '2016-09-08 17:41:56', '2016-09-08 17:41:56', '下注数据', '双100', '296', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('767', '摩弦', null, 'xy28', '100', '78240', '1', '2016-09-08 17:42:51', '2016-09-08 17:42:51', '下注数据', '小100', '297', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('768', '摩弦', null, 'xy28', '100', '78140', '1', '2016-09-08 17:42:57', '2016-09-08 17:42:57', '下注数据', '单100', '298', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('769', '摩弦', null, 'xy28', '100', '78040', '1', '2016-09-08 17:43:03', '2016-09-08 17:43:03', '下注数据', '双100', '299', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('770', '摩弦', null, 'xy28', '100', '77940', '1', '2016-09-08 17:43:46', '2016-09-08 17:43:46', '下注数据', '大100', '300', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('771', '摩弦', null, 'xy28', '100', '77840', '1', '2016-09-08 17:43:51', '2016-09-08 17:43:51', '下注数据', '小100', '301', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('772', '摩弦', null, 'xy28', '100', '77740', '1', '2016-09-08 17:43:58', '2016-09-08 17:43:58', '下注数据', '单100', '302', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('773', '摩弦', null, 'xy28', '100', '77640', '1', '2016-09-08 17:44:04', '2016-09-08 17:44:04', '下注数据', '双100', '303', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('774', '摩弦', null, 'xy28', '185', '77825', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '294', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('775', '摩弦', null, 'xy28', '185', '78010', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '295', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('776', '摩弦', null, 'xy28', '0', '78010', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '296', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('777', '摩弦', null, 'xy28', '185', '78195', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '297', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('778', '摩弦', null, 'xy28', '185', '78380', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '298', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('779', '摩弦', null, 'xy28', '0', '78380', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '299', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('780', '摩弦', null, 'xy28', '0', '78380', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '300', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('781', '摩弦', null, 'xy28', '185', '78565', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '301', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('782', '摩弦', null, 'xy28', '185', '78750', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '302', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('783', '摩弦', null, 'xy28', '0', '78750', '2', '2016-09-08 17:45:11', '2016-09-08 17:45:11', '派彩数据', '派彩金额数据', '303', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('784', '摩弦', null, 'xy28', '100', '78650', '1', '2016-09-08 17:45:47', '2016-09-08 17:45:47', '下注数据', '大100', '304', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('785', '摩弦', null, 'xy28', '100', '78550', '1', '2016-09-08 17:45:53', '2016-09-08 17:45:53', '下注数据', '小100', '305', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('786', '摩弦', null, 'xy28', '100', '78450', '1', '2016-09-08 17:45:59', '2016-09-08 17:45:59', '下注数据', '单100', '306', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('787', '摩弦', null, 'xy28', '100', '78350', '1', '2016-09-08 17:46:06', '2016-09-08 17:46:06', '下注数据', '双100', '307', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('788', '摩弦', null, 'xy28', '100', '78250', '1', '2016-09-08 17:46:47', '2016-09-08 17:46:47', '下注数据', '大100', '308', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('789', '摩弦', null, 'xy28', '100', '78150', '1', '2016-09-08 17:46:54', '2016-09-08 17:46:54', '下注数据', '小100', '309', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('790', '摩弦', null, 'xy28', '100', '78050', '1', '2016-09-08 17:47:00', '2016-09-08 17:47:00', '下注数据', '单100', '310', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('791', '摩弦', null, 'xy28', '100', '77950', '1', '2016-09-08 17:47:07', '2016-09-08 17:47:07', '下注数据', '双100', '311', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('792', '摩弦', null, 'xy28', '0', '77950', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '304', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('793', '摩弦', null, 'xy28', '185', '78135', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '305', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('794', '摩弦', null, 'xy28', '185', '78320', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '306', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('795', '摩弦', null, 'xy28', '0', '78320', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '307', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('796', '摩弦', null, 'xy28', '0', '78320', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '308', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('797', '摩弦', null, 'xy28', '185', '78505', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '309', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('798', '摩弦', null, 'xy28', '185', '78690', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '310', 'ceshi1234', '112.206.86.43', null, null, null);
INSERT INTO `w_money_log` VALUES ('799', '摩弦', null, 'xy28', '0', '78690', '2', '2016-09-08 19:54:45', '2016-09-08 19:54:45', '派彩数据', '派彩金额数据', '311', 'ceshi1234', '112.206.86.43', null, null, null);

-- ----------------------------
-- Table structure for `w_total_statistics`
-- ----------------------------
DROP TABLE IF EXISTS `w_total_statistics`;
CREATE TABLE `w_total_statistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `total_members` int(11) DEFAULT NULL COMMENT '总人数',
  `total_balance` double(20,4) DEFAULT NULL COMMENT '总余额',
  `total_bet` double(20,4) DEFAULT NULL COMMENT '总投注',
  `total_profit_loss` double(20,4) DEFAULT NULL COMMENT '总盈亏',
  `total_recharge` double(20,4) DEFAULT NULL COMMENT '总充值',
  `total_withdraw` double(20,4) DEFAULT NULL COMMENT '总提现',
  `current_close_time` varchar(50) DEFAULT NULL,
  `previous_number` varchar(100) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='总统计';

-- ----------------------------
-- Records of w_total_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for `w_user`
-- ----------------------------
DROP TABLE IF EXISTS `w_user`;
CREATE TABLE `w_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `nickname` varchar(100) DEFAULT NULL COMMENT '微信昵称',
  `user_name` varchar(200) DEFAULT NULL COMMENT '用户名',
  `real_name` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `wechat_number` varchar(50) DEFAULT NULL COMMENT '微信号',
  `qq_number` varchar(50) DEFAULT NULL COMMENT 'qq号',
  `tel_number` varchar(15) DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `client_id` int(11) DEFAULT NULL,
  `bank_num` varchar(200) DEFAULT NULL,
  `bank_type` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of w_user
-- ----------------------------
INSERT INTO `w_user` VALUES ('1', 'abc123', 'abc123', '打个报告', '25d55ad283aa400af464c76d713c07ad', '12345678', '98765412', '13119523833', '456@qq.com', null, null, '2016-07-15 14:25:18', '1', '25', '123456789987654321');
INSERT INTO `w_user` VALUES ('2', 'test01', 'test01', 'test01', 'f97b6ec32544b5e6dfbd459cca60edef', '13911111111', '13911111111', '13911111111', 'test01@gmail.com', null, null, '2016-07-27 16:38:50', '1', '43', '13911111111');
INSERT INTO `w_user` VALUES ('3', 'test04', 'test04', '13944444444', 'f97b6ec32544b5e6dfbd459cca60edef', '13944444444', '13944444444', '13944444444', 'test04@gmail.com', null, null, '2016-08-13 13:09:09', '1', '35', '13944444444');
INSERT INTO `w_user` VALUES ('4', 'bbb123', 'bbb123', '烦得很', '25d55ad283aa400af464c76d713c07ad', '895642', '96385214', '13119523111', '34@126.com', null, null, '2016-08-29 14:31:04', '3', '17', '123456987987654321');
INSERT INTO `w_user` VALUES ('5', 'ceshi1234', 'ceshi1234', '返回', 'b4af804009cb036a4ccdc33431ef9ac9', '963852', '963852', '13119523111', '12@126.com', null, null, '2016-09-08 20:28:29', '7000101', '31', '12345678998765432');
