package com.ds.common.util;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;

public class QueryToolUtil {

	public static PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else {
			sort = new Sort(Direction.ASC, "id");
		}

		return new PageRequest(pageNumber, pageSize, sort);
	}
	
}
