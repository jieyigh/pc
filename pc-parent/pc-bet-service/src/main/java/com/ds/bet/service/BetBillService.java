package com.ds.bet.service;

import java.util.List;

import com.ds.bet.vo.TodoOpenVo;

/**
 * 账单
 * 
 * @author jackson
 *
 */
public interface BetBillService {

	List<TodoOpenVo> findTermByState(Integer state);

	void updateStateByTerm(String gameType, Long term, Integer state);

	
}
