package com.ds.room.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.TableConfig;

public interface TableConfigRepository extends BaseRepository<TableConfig, Serializable> {

	public List<TableConfig> findByRoomId(Integer roomId);
	
	public List<TableConfig> findByRoomIdAndState(Integer roomId,Integer state);

	@Query(value = "SELECT a.* FROM pc_table_config a LEFT JOIN pc_room_config b ON a.room_id=b.id WHERE b.site_id=?1", nativeQuery = true)
	public List<TableConfig> getTablesBySiteId(Integer siteId);

	@Query(value = "SELECT a.id FROM pc_table_config a LEFT JOIN pc_room_config b ON a.room_id=b.id WHERE b.site_id=?1", nativeQuery = true)
	public List<Integer> getTableIdsBySiteId(Integer siteId);

	
	@Modifying
	@Query(value = "INSERT INTO pc_bet_limit(name,play,type,enabled,table_id,create_time,update_time) "
			+ "SELECT name,play,type,enabled,?1,create_time,update_time FROM pc_bet_limit WHERE table_id = 0", nativeQuery = true)
	public Integer createBetLimit(Integer tableId);

	@Modifying
	@Query(value = "INSERT INTO pc_bet_odds(name,play,type,enabled,table_id,create_time,update_time,parent_id) "
			+ "SELECT name,play,type,enabled,?1,create_time,update_time,parent_id FROM pc_bet_odds WHERE table_id = 0", nativeQuery = true)
	public Integer createBetOdds(Integer tableId);

}