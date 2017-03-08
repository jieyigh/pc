package com.ds.room.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ds.common.constants.Constants.NormalState;
import com.ds.common.util.BeanUtil;
import com.ds.entity.SiteConfig;
import com.ds.room.repository.SiteConfigRepository;
import com.ds.room.service.SiteConfigService;
import com.ds.room.service.TableConfigService;
import com.ds.room.vo.RoomConfigVo;
import com.ds.room.vo.SiteConfigParams;
import com.ds.room.vo.SiteConfigVo;
import com.ds.room.vo.TableConfigResult;
import com.ds.room.vo.TableConfigVo;

@EnableScheduling
@Service
public class SiteConfigServiceImpl implements SiteConfigService {

	@Autowired
	private SiteConfigRepository siteConfigRepository;

	@Autowired
	private TableConfigService tableConfigService;

	

	@Override
	public List<SiteConfig> findAll() {
		return siteConfigRepository.findAll();
	}

	@Transactional
	@Override
	public SiteConfig save(SiteConfig site) {
		site.setCreateTime(new Date());
		return siteConfigRepository.save(site);
	}

	@Transactional
	@Override
	public SiteConfig edit(SiteConfig site) {
		if (null == site.getId()) {
			site.setCreateTime(new Date());
			return siteConfigRepository.save(site);
		}

		SiteConfig e = siteConfigRepository.findOne(site.getId());
		BeanUtil.copyPropertiesIgnoreNull(site, e);
		e.setUpdateTime(new Date());
		return siteConfigRepository.saveAndFlush(e);
	}

	@Override
	public SiteConfigVo findBySiteIdOne(Integer siteId) {
		List<TableConfigResult> results = this.tableConfigService.getTableConfigResultBySiteId(siteId);

		if (null == results || results.isEmpty()) {
			return null;
		}

		Map<Integer, Map<Integer, RoomConfigVo>> roomMap = new HashMap<>();
		Map<Integer, Map<Integer, TableConfigVo>> tableMap = new HashMap<>();

		List<RoomConfigVo> rooms = new ArrayList<RoomConfigVo>();

		SiteConfigVo siteConfigVo = new SiteConfigVo();

		siteConfigVo.setSiteId(siteId);

		for (TableConfigResult result : results) {

			siteConfigVo.setMemo(result.getSiteMemo());
			siteConfigVo.setState(result.getSiteState());

			Map<Integer, RoomConfigVo> room2Map = roomMap.get(result.getSiteId());
			if (room2Map == null) {
				room2Map = new HashMap<>();
				roomMap.put(result.getSiteId(), room2Map);
			}

			RoomConfigVo room = room2Map.get(result.getRoomId());
			if (null == room) {
				room = new RoomConfigVo();
				room.setId(result.getRoomId());
				room.setState(result.getRoomState());
				room.setMemo(result.getRoomMemo());
				room.setMemo2(result.getRoomMemo2());
				room.setSiteId(siteId);
				room.setGameType(result.getGameType());
				room2Map.put(result.getRoomId(), room);
			}

			Map<Integer, TableConfigVo> table2Map = tableMap.get(result.getRoomId());
			if (null == table2Map) {
				table2Map = new HashMap<>();
				tableMap.put(result.getRoomId(), table2Map);
			}

			TableConfigVo table = table2Map.get(result.getId());
			if (null == table) {
				table = new TableConfigVo();
				table.setId(result.getId());
				table.setGameType(result.getGameType());
				table.setMemo1(result.getMemo1());
				table.setMemo2(result.getMemo2());
				table.setName(result.getName());
				table.setLevel(result.getLevel());
				table.setState(result.getTableState());
				table.setRoomId(result.getRoomId());
				table.setSiteId(siteId);
				table2Map.put(result.getId(), table);
			}

		}
		Map<Integer, RoomConfigVo> room2Map = roomMap.get(siteId);
		Iterator<Integer> roomKeys = room2Map.keySet().iterator();
		while (roomKeys.hasNext()) {
			Integer key = roomKeys.next();
			List<TableConfigVo> tables = new ArrayList<TableConfigVo>();
			Map<Integer, TableConfigVo> table2Map = tableMap.get(key);
			Iterator<Integer> tableKeys = table2Map.keySet().iterator();
			while (tableKeys.hasNext()) {
				Integer keyB = tableKeys.next();
				tables.add(table2Map.get(keyB));
			}
			RoomConfigVo roomConfigVo = room2Map.get(key);
			roomConfigVo.setTables(tables);
			rooms.add(roomConfigVo);
		}
		siteConfigVo.setRooms(rooms);

		return siteConfigVo;

	}

	@Transactional
	@Override
	public SiteConfig edit(SiteConfigParams params) {
		if (null == params.getId()) {
			SiteConfig e = new SiteConfig();
			BeanUtils.copyProperties(params, e);
			e.setSiteId(Integer.valueOf(params.getSiteId()));
			e.setState(NormalState.启用.getKey());
			e.setCreateTime(new Date());
			return this.siteConfigRepository.save(e);
		}

		SiteConfig e = this.siteConfigRepository.findOne(params.getId());

		if (null == e) {
			return null;
		}

		BeanUtil.copyPropertiesIgnoreNull(params, e);
		if (null != params.getSiteId()) {
			e.setSiteId(Integer.valueOf(params.getSiteId()));
		}

		if (null != params.getState()) {
			e.setState(Integer.valueOf(params.getState()));
		}

		e.setUpdateTime(new Date());
		return siteConfigRepository.saveAndFlush(e);

	}

	@Override
	public List<SiteConfig> findBySiteId(Integer siteId) {
		return siteConfigRepository.findBySiteId(siteId);
	}

}
