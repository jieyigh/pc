package com.ds.redis.provider.common;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.ds.common.task.UrlConfigVo;

@Service
public class UrlConfigCache {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<UrlConfigVo> cacheUrlConfigByTableId() {
		try {
			StringBuilder sqlBuffer = new StringBuilder();
			sqlBuffer.append("SELECT t.id tableId, s.site_id siteId, money_url moneyUrl,money_key moneyKey, ")//
					.append("transfer_url transferUrl, transfer_hash_code transferHashCode, transfer_keyb transferKeyb, s.keyb keyb, ")//
					.append("t.game_type gameType ") // 后面扩展
					.append("FROM pc_table_config t ")//
					.append("LEFT JOIN pc_room_config r ON t.room_id = r.id ")//
					.append("LEFT JOIN pc_site_config s ON r.site_id = s.site_id ");
			return this.jdbcTemplate.query(sqlBuffer.toString(), new BeanPropertyRowMapper<UrlConfigVo>(UrlConfigVo.class));
		} catch (Exception e) {
			logger.error("CommonTask init 出错 : ", e);
		}
		return null;
	}

}
