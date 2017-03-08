package com.ds.betinfo.record.consumer;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import com.ds.entity.RoomConfig;
import com.ds.entity.SiteConfig;
import com.ds.entity.TableConfig;

public class SyncConfigData {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final String dsiteSql = "DELETE FROM pc_site_config";

	private final String droomSql = "DELETE FROM pc_room_config";

	private final String dtableSql = "DELETE FROM pc_table_config";

	private final String siteSql = "SELECT * FROM pc_site_config ";

	private final String roomSql = "SELECT * FROM pc_room_config ";

	private final String tableSql = "SELECT * FROM pc_table_config ";

	private final StringBuffer syncSiteSqlBuffer = new StringBuffer(
			"INSERT INTO pc_site_config(id,site_id, memo, money_url, money_key, transfer_url, ")//
					.append("transfer_hash_code, transfer_keyb, state, create_time, update_time, keyb) VALUES ");
	private final StringBuffer syncRoomSqlBuffer = new StringBuffer(
			"INSERT INTO pc_room_config(id,site_id, state, game_type, memo, memo2, ")//
					.append("create_time,  update_time) VALUES ");
	private final StringBuffer syncTableSqlBuffer = new StringBuffer(
			"INSERT INTO pc_table_config(id,name, room_id, state, level, game_type, ")//
					.append("memo1, memo2, create_time, update_time) VALUES ");
	private JdbcTemplate jdbcTemplate;
	private JdbcTemplate recordJdbcTemplate;

	public SyncConfigData(JdbcTemplate jdbcTemplate, JdbcTemplate recordJdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
		this.recordJdbcTemplate = recordJdbcTemplate;
	}
	
	
	@Transactional
	public void executeTable() {
		try {
			// 删除
			this.recordJdbcTemplate.update(dtableSql);
			List<TableConfig> tableList = this.jdbcTemplate.query(tableSql,
					new BeanPropertyRowMapper<TableConfig>(TableConfig.class));
			if (tableList == null || tableList.size() <= 0) {
				logger.info("{}表不存在数据", "pc_table_config");
			}
			StringBuffer sqlBuffer = new StringBuffer();
			List<Object> paramList = new ArrayList<>();
			TableConfig table = null;
			for (int i = 0; i < tableList.size(); i++) {
				table = tableList.get(i);
				sqlBuffer.append("(?,?,?,?,?,?,?,?,?,?)");
				paramList.add(table.getId());
				paramList.add(table.getName());
				paramList.add(table.getRoomId());
				paramList.add(table.getState());
				paramList.add(table.getLevel());
				paramList.add(table.getGameType());
				paramList.add(table.getMemo1());
				paramList.add(table.getMemo2());
				paramList.add(table.getCreateTime());
				paramList.add(table.getUpdateTime());
				if (i != tableList.size() - 1) {
					sqlBuffer.append(", ");
				}
			}
			Long start = System.currentTimeMillis();
			int count = this.recordJdbcTemplate.update(syncTableSqlBuffer.toString() + sqlBuffer.toString(),
					paramList.toArray(new Object[paramList.size()]));
			logger.info("同步到pc_table_config从表{},总更新条目数={},耗时 = {}ms", "pc_table_config", count,
					System.currentTimeMillis() - start);

		} catch (Exception e) {
			logger.error("execute pc_table_config同步出错 : ", e);
			throw new RuntimeException("execute pc_table_config同步出错");
		}
	}

	@Transactional
	public void executeRoom() {
		try {
			// 删除
			this.recordJdbcTemplate.update(droomSql);
			List<RoomConfig> roomList = this.jdbcTemplate.query(roomSql,
					new BeanPropertyRowMapper<RoomConfig>(RoomConfig.class));
			if (roomList == null || roomList.size() <= 0) {
				logger.info("{}表不存在数据", "pc_room_config");
			}
			StringBuffer sqlBuffer = new StringBuffer();
			List<Object> paramList = new ArrayList<>();
			RoomConfig room = null;
			for (int i = 0; i < roomList.size(); i++) {
				room = roomList.get(i);
				sqlBuffer.append("(?,?,?,?,?,?,?,?)");
				paramList.add(room.getId());
				paramList.add(room.getSiteId());
				paramList.add(room.getState());
				paramList.add(room.getGameType());
				paramList.add(room.getMemo());
				paramList.add(room.getMemo2());
				paramList.add(room.getCreateTime());
				paramList.add(room.getUpdateTime());
				if (i != roomList.size() - 1) {
					sqlBuffer.append(", ");
				}
			}
			Long start = System.currentTimeMillis();
			int count = this.recordJdbcTemplate.update(syncRoomSqlBuffer.toString() + sqlBuffer.toString(),
					paramList.toArray(new Object[paramList.size()]));
			logger.info("同步到pc_room_config从表{},总更新条目数={},耗时 = {}ms", "pc_room_config", count,
					System.currentTimeMillis() - start);

		} catch (Exception e) {
			logger.error("execute pc_room_config同步出错 : ", e);
			throw new RuntimeException("execute pc_room_config同步出错");
		}
	}

	@Transactional
	public void execute() {
		try {
			// 删除
			this.recordJdbcTemplate.update(dsiteSql);
			List<SiteConfig> siteList = this.jdbcTemplate.query(siteSql,
					new BeanPropertyRowMapper<SiteConfig>(SiteConfig.class));
			if (siteList == null || siteList.size() <= 0) {
				logger.info("{}表不存在数据", "pc_site_config");
			}
			StringBuffer sqlBuffer = new StringBuffer();
			List<Object> paramList = new ArrayList<>();
			SiteConfig site = null;
			for (int i = 0; i < siteList.size(); i++) {
				site = siteList.get(i);
				sqlBuffer.append("(?,?,?,?,?,?,?,?,?,?,?,?)");
				paramList.add(site.getId());
				paramList.add(site.getSiteId());
				paramList.add(site.getMemo());
				paramList.add(site.getMoneyUrl());
				paramList.add(site.getMoneyKey());
				paramList.add(site.getTransferUrl());
				paramList.add(site.getTransferHashCode());
				paramList.add(site.getTransferKeyb());
				paramList.add(site.getState());
				paramList.add(site.getCreateTime());
				paramList.add(site.getUpdateTime());
				paramList.add(site.getKeyb());
				if (i != siteList.size() - 1) {
					sqlBuffer.append(", ");
				}
			}
			Long start = System.currentTimeMillis();
			int count = this.recordJdbcTemplate.update(syncSiteSqlBuffer.toString() + sqlBuffer.toString(),
					paramList.toArray(new Object[paramList.size()]));
			logger.info("同步到pc_site_config从表{},总更新条目数={},耗时 = {}ms", "pc_site_config", count,
					System.currentTimeMillis() - start);

		} catch (Exception e) {
			logger.error("execute 同步出错 : ", e);
			throw new RuntimeException("execute 同步出错");
		}
	}

	
}
