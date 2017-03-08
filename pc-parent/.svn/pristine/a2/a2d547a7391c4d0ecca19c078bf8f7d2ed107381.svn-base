package com.ds.task.betinfo;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import com.ds.common.bet.KeyConfig;
import com.ds.task.tasklist.AbstractTask;

public class GenerateBetTableTask implements KeyConfig, AbstractTask {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final StringBuilder createTableSqlBuffer = new StringBuilder("CREATE TABLE :tableName (")//
			.append("id bigint(20) NOT NULL AUTO_INCREMENT,")//
			.append("bill_no varchar(100) DEFAULT NULL,")//
			.append("username varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,")//
			.append("original_username varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,")//
			.append("game_type varchar(20) DEFAULT NULL,")//
			.append("term bigint(20) DEFAULT NULL,")//
			.append("bet_type varchar(20) DEFAULT NULL,")//
			.append("bet_money decimal(10,2) DEFAULT NULL,")//
			.append("bet_num int(11) DEFAULT NULL,")//
			.append("bet_msg varchar(200) DEFAULT NULL,")//
			.append("pay_off decimal(10,2) DEFAULT NULL,")//
			.append("after_balance decimal(10,2) DEFAULT NULL,")//
			.append("state int(11) DEFAULT NULL ,")//
			.append("win_money_valid decimal(10,2) DEFAULT NULL,")//
			.append("win_money1314 decimal(10,2) DEFAULT NULL,")//
			.append("win_money_expected decimal(10,2) DEFAULT NULL,")//
			.append("bet_odds1314 decimal(10,2) DEFAULT NULL,")//
			.append("bet_odds_expected decimal(10,2) DEFAULT NULL,")//
			.append("table_id int(11) DEFAULT NULL,")//
			.append("site_id int(11) DEFAULT NULL,")//
			.append("create_time timestamp NULL DEFAULT NULL,")//
			.append("update_time timestamp NULL DEFAULT NULL,")//
			.append("PRIMARY KEY (id),")//
			.append("UNIQUE KEY Index_billno (bill_no),")//
			.append("KEY Index_username (username),")//
			.append("KEY Index_original_username (original_username),")//
			.append("KEY Index_term (term),")//
			.append("KEY index_state (state),")//
			.append("KEY index_table_id (table_id),")//
			.append("KEY index_site_id (site_id)")//
			.append(") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;");

	private JdbcTemplate jdbcTemplate;

	private List<String> distinctPlays;

	public GenerateBetTableTask(JdbcTemplate jdbcTemplate, List<String> distinctPlays) {
		this.jdbcTemplate = jdbcTemplate;
		this.distinctPlays = distinctPlays;
	}

	@Override
	public void execute() {
		Date now = new Date();
		logger.info("日期 = {}, 执行", now);
		try {
			List<String> createTableSqls = new ArrayList<>();
			StringBuilder tableNames = new StringBuilder();
			String tableName = null;
			for (String play : distinctPlays) {
				tableName = PREFIX_BET_TABLE + play;
				if (!this.getAllTableName(tableName)) {
					tableNames.append(tableName).append(",");
					createTable(createTableSqls, tableName);
				}
			}
			if (createTableSqls.size() > 0) {
				logger.info("需要建表{}张, 表名分别为 : {}", createTableSqls.size(), tableNames.toString());
				for (int i = 0; i < createTableSqls.size(); i++) {
					try {
						logger.info("正在创建第{}张表", i + 1);
						this.jdbcTemplate.update(createTableSqls.get(i));
						logger.info("创建第{}张表成功", i + 1);
					} catch (Exception e) {
						logger.error("创建第" + i + 1 + "张表异常:", e);
					}
				}
			}
		} catch (Exception e) {
			logger.error("系统生成表错误 : ", e);
		}
	}

	private void createTable(List<String> createTableSqls, String tableName) {
		createTableSqls.add(createTableSqlBuffer.toString().replaceAll(":tableName", tableName));
	}

	private boolean getAllTableName(String tableName) throws Exception {
		Connection conn = this.jdbcTemplate.getDataSource().getConnection();
		ResultSet tabs = null;
		try {
			DatabaseMetaData dbMetaData = conn.getMetaData();
			String[] types = { "TABLE" };
			tabs = dbMetaData.getTables(null, null, tableName, types);
			if (tabs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			tabs.close();
			conn.close();
		}
		return false;
	}

}
