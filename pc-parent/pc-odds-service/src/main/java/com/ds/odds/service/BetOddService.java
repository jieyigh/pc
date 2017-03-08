package com.ds.odds.service;

import java.util.List;

import com.ds.entity.BetOdd;
import com.ds.odds.vo.BetOddParams;

public interface BetOddService {

	public List<BetOdd> getBetOddsByTableId(Integer tableId);

	public List<BetOdd> findByTableId(Integer tableId);

	public List<BetOdd> findAll();
	
	public BetOdd edit(BetOddParams params);
	
	public BetOdd editType(BetOddParams params);

	public List<BetOdd> findByParentIdIsNull();
	
	public List<BetOdd> saveList(List<BetOdd> odds);

}
