package com.ds.bet.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.ds.bet.repository.BetBillRepository;
import com.ds.bet.service.BetBillService;
import com.ds.bet.vo.TodoOpenVo;

@Service
public class BetBillServiceImpl implements BetBillService {

	@Autowired
	private BetBillRepository betBillRepository;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<TodoOpenVo> findTermByState(Integer state) {
		return this.jdbcTemplate.query("SELECT game_type gameType, term FROM pc_bet_bill WHERE state = ? GROUP BY game_type, term", //
				new Object[] { state }, new BeanPropertyRowMapper<TodoOpenVo>(TodoOpenVo.class));
	}

	@Override
	public void updateStateByTerm(String gameType, Long term, Integer state) {
		Date now = new Date();
		this.betBillRepository.updateStateByTerm(gameType, term, state, now);
	}

}
