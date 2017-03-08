package com.ds.repository;

import java.io.Serializable;
import java.util.List;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.Activity;

public interface ActivityRepository extends BaseRepository<Activity, Serializable> {

	List<Activity> findByType(Integer type);

	List<Activity> findBySiteId(Integer siteId);

	Activity findById(Long id);

}
