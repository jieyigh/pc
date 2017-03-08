package com.ds.odds.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;

import com.ds.common.constants.Constants.NormalState;
import com.ds.common.util.BeanUtil;
import com.ds.entity.BetOdd;
import com.ds.odds.repository.BetOddRepository;
import com.ds.odds.service.BetOddService;
import com.ds.odds.vo.BetOddParams;

@EnableScheduling
@Service
public class BetOddServiceImpl implements BetOddService {

	@Autowired
	private BetOddRepository betOddRepository;
	
	@Override
	public List<BetOdd> getBetOddsByTableId(Integer tableId) {
		return betOddRepository.findByTableId(tableId);
	}

	@Override
	public List<BetOdd> findByTableId(Integer tableId) {
		return betOddRepository.findByTableId(tableId);
	}

	@Override
	public List<BetOdd> findAll() {
		return this.betOddRepository.findAll();
	}

	@Override
	public BetOdd edit(BetOddParams params) {
		if (null == params.getId()) {
			BetOdd e = new BetOdd();
			BeanUtils.copyProperties(params, e);
			e.setTableId(Integer.valueOf(params.getTableId()));
			e.setParentId(Long.valueOf(params.getParentId()));
			e.setEnabled(NormalState.启用.getKey());
			e.setCreateTime(new Date());
			return this.betOddRepository.saveAndFlush(e);
		}

		BetOdd e = this.betOddRepository.findOne(params.getId());

		if (null == e) {
			return null;
		}

		BeanUtil.copyPropertiesIgnoreNull(params, e);
		if (null != params.getTableId()) {
			e.setTableId(Integer.valueOf(params.getTableId()));
		}

		if (null != params.getEnabled()) {
			e.setEnabled(Integer.valueOf(params.getEnabled()));
		}

		if (null != params.getParentId()) {
			e.setParentId(Long.valueOf(params.getParentId()));
		}
		e.setUpdateTime(new Date());
		return betOddRepository.saveAndFlush(e);

	}

	@Override
	public BetOdd editType(BetOddParams params) {
		if (null == params.getId()) {
			BetOdd e = new BetOdd();
			BeanUtils.copyProperties(params, e);
			e.setEnabled(NormalState.启用.getKey());
			e.setCreateTime(new Date());
			return this.betOddRepository.save(e);
		}

		BetOdd e = this.betOddRepository.findOne(params.getId());

		if (null == e) {
			return null;
		}

		BeanUtil.copyPropertiesIgnoreNull(params, e);

		if (null != params.getEnabled()) {
			e.setEnabled(Integer.valueOf(params.getEnabled()));
		}

		e.setUpdateTime(new Date());
		return betOddRepository.saveAndFlush(e);

	}

	@Override
	public List<BetOdd> findByParentIdIsNull() {
		return betOddRepository.findByParentIdIsNull();
	}

	@Override
	public List<BetOdd> saveList(List<BetOdd> odds) {
		return betOddRepository.save(odds);
	}

}
