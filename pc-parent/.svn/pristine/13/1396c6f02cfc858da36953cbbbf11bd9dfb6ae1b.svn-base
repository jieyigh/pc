package com.ds.record.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ds.common.repository.BaseRepository;
import com.ds.record.entity.BetInfoRecord;

public interface BetInfoRecordRepository extends BaseRepository<BetInfoRecord, Serializable> {

	@Query(value = "select t.* from pc_bet_info_record t where t.table_id in ?1 and t.id > ?2 limit ?3", nativeQuery = true)
	public List<BetInfoRecord> getBetInfos(List<Integer> tableIds, Long id, Integer num);

	@Query(value = "select t.* from pc_bet_info_record t where t.table_id=?1 and t.id > ?2 limit ?3", nativeQuery = true)
	public List<BetInfoRecord> get100BetInfos(Integer tableId, Long id, Integer num);

	@Query(value = "SELECT a.id FROM pc_table_config a LEFT JOIN pc_room_config b ON a.room_id=b.id WHERE b.site_id=?1", nativeQuery = true)
	public List<Integer> getTableIdsBySiteId(Integer siteId);

}
