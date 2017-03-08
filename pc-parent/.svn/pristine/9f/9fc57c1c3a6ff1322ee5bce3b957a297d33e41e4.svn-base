package com.ds.redis.provider.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.ds.common.constants.Constants;
import com.ds.entity.RoomConfig;
import com.ds.entity.SiteConfig;
import com.ds.entity.TableConfig;
import com.ds.room.repository.RoomConfigRepository;
import com.ds.room.repository.SiteConfigRepository;
import com.ds.room.repository.TableConfigRepository;
import com.ds.room.vo.RoomConfigVo;
import com.ds.room.vo.SiteConfigVo;
import com.ds.room.vo.TableConfigVo;

@Service
public class SiteConfigCache {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SiteConfigRepository siteConfigRepository;
	
	@Autowired
	private RoomConfigRepository roomConfigRepository;
	
	@Autowired
	private TableConfigRepository tableConfigRepository;
	
	public Map<Integer, List<TableConfigVo>> cacheTablesMap(){
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT a.id,a.create_time as createTime,a.game_type as gameType,") //
		.append("a.memo1,a.memo2,a.room_id as roomId,a.state,a.update_time as updateTime,")//
		.append("b.site_id as siteId,a.level FROM pc_table_config a INNER JOIN pc_room_config b ON a.room_id=b.id");
		List<TableConfigVo> tables = this.jdbcTemplate.query(sql.toString(), new BeanPropertyRowMapper<TableConfigVo>(TableConfigVo.class));
		Map<Integer, List<TableConfigVo>> tablesMap = new HashMap<>();
		for (TableConfigVo table : tables) {
			// 1.初始化tablesMap
			List<TableConfigVo> list = tablesMap.get(table.getSiteId());
			if (list == null) {
				list = new ArrayList<>();
				tablesMap.put(table.getSiteId(), list);
			}
			list.add(table);
		}
		return tablesMap;
	}
	
	
	public Map<Integer, SiteConfigVo> cacheRoomMap(){
		Map<Integer, SiteConfigVo> roomMap = new HashMap<>();
		// 保存房间(树状)
		List<SiteConfig> sites = siteConfigRepository.findAll();
		for (SiteConfig site : sites) {
			roomMap.put(site.getSiteId(), this.findBySiteId(site.getSiteId()));
		}
		return roomMap;
	}
	
	public SiteConfigVo findBySiteId(Integer siteId) {
		SiteConfigVo site = new SiteConfigVo();
		List<SiteConfig> sites = siteConfigRepository.findBySiteId(siteId);
		if (null == sites || sites.isEmpty()) {
			return null;
		}
		SiteConfig siteA = sites.get(0);
		BeanUtils.copyProperties(siteA, site);
		site.setRooms(this.getRoomVos(site.getSiteId()));
		return site;
	}
	
	private List<RoomConfigVo> getRoomVos(Integer siteId) {
		List<RoomConfigVo> roomVos = new ArrayList<>();
		List<RoomConfig> rooms = roomConfigRepository.findBySiteIdAndState(siteId,Constants.NormalState.启用.getKey());
		for (RoomConfig room : rooms) {
			RoomConfigVo e = new RoomConfigVo();
			BeanUtils.copyProperties(room, e);
			e.setTables(this.getTableVos(e.getId()));
			roomVos.add(e);
		}
		return roomVos;

	}
	
	private List<TableConfigVo> getTableVos(Integer roomId) {
		List<TableConfigVo> tableVos = new ArrayList<>();
		List<TableConfig> tables = tableConfigRepository.findByRoomIdAndState(roomId,Constants.NormalState.启用.getKey());
		for (TableConfig table : tables) {
			TableConfigVo tableVo = new TableConfigVo();
			BeanUtils.copyProperties(table, tableVo);
			tableVos.add(tableVo);
		}
		return tableVos;
	}

}
