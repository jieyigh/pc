package com.ds.limit.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.BetLimit;

public interface BetLimitRepository extends BaseRepository<BetLimit, Serializable> {

	public List<BetLimit> findByTableId(Integer tableId);
	
	@Query(value = "SELECT a.* FROM pc_bet_limit a INNER JOIN (SELECT a.* FROM pc_table_config a INNER JOIN pc_room_config b ON a.room_id=b.id WHERE b.site_id=?1) b ON a.table_id = b.id ", nativeQuery = true)
	public List<BetLimit> findBySiteId(Integer siteId);
}