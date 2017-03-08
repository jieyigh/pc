package com.ds.odds.repository;

import java.io.Serializable;
import java.util.List;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.BetOdd;

public interface BetOddRepository extends BaseRepository<BetOdd, Serializable> {

	public List<BetOdd> findByTableId(Integer tableId);

	public List<BetOdd> findByParentId(Long parentId);
	
	public List<BetOdd> findByParentIdIsNull();

}