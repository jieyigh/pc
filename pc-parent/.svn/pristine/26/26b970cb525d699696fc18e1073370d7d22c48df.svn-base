package com.ds.room.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ds.common.constants.Constants.NormalState;
import com.ds.common.util.BeanUtil;
import com.ds.entity.RoomConfig;
import com.ds.room.repository.RoomConfigRepository;
import com.ds.room.service.RoomConfigService;
import com.ds.room.vo.RoomConfigParams;

@Service
public class RoomConfigServiceImpl implements RoomConfigService {

	@Autowired
	private RoomConfigRepository roomConfigRepository;
	
	
	
	@Override
	public List<RoomConfig> findBySiteIdAndGameType(Integer siteId, String gameType) {
		return roomConfigRepository.findBySiteIdAndGameType(siteId, gameType);
	}

	@Override
	public List<RoomConfig> findBySiteId(Integer siteId) {
		return roomConfigRepository.findBySiteId(siteId);
	}

	@Override
	public List<RoomConfig> findByGameType(String gameType) {
		return roomConfigRepository.findByGameType(gameType);
	}

	@Override
	public RoomConfig update(RoomConfig room) {
		RoomConfig e = roomConfigRepository.findOne(room.getId());
		e.setSiteId(room.getSiteId());
		e.setGameType(room.getGameType());
		e.setMemo(room.getMemo());
		e.setUpdateTime(new Date());
		return this.roomConfigRepository.saveAndFlush(e);
	}

	@Override
	public RoomConfig save(RoomConfig room) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	@Override
	public RoomConfig edit(RoomConfigParams params) {
		if(null == params.getId()){
			RoomConfig e = new RoomConfig();
			BeanUtils.copyProperties(params, e);
			e.setSiteId(Integer.valueOf(params.getSiteId()));
			e.setState(NormalState.启用.getKey());
			e.setCreateTime(new Date());
			return this.roomConfigRepository.save(e);
		}
		
		RoomConfig e = this.roomConfigRepository.findOne(params.getId());
		
		if(null == e){
			return null;
		}
		
		BeanUtil.copyPropertiesIgnoreNull(params, e);
		if(null != params.getSiteId()){
			e.setSiteId(Integer.valueOf(params.getSiteId()));
		}
		if(null != params.getState()){
			e.setState(Integer.valueOf(params.getState()));
		}
		e.setUpdateTime(new Date());
		return roomConfigRepository.saveAndFlush(e);
	}

}
