package com.ds.betinfo.record.datasource;

import java.sql.SQLException;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

import com.alibaba.druid.pool.DruidDataSource;
import com.ds.betinfo.record.config.Self;
import com.ds.betinfo.record.key.KeyConfig;

@Configuration
public class DynamicDataSource implements KeyConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "dataSource")
	private DataSource dataSource;

	@Autowired
	private Self self;

	@Bean(DATASOURCE_99999)
	public DataSource dataSourceBy99999() {
		DruidDataSource dataSource = new DruidDataSource();
		dataSource.setDriverClassName(this.self.getDriverClassName());
		dataSource.setUrl(this.self.getUrl());
		dataSource.setUsername(this.self.getUsername());
		dataSource.setPassword(this.self.getPassword());
		dataSource.setConnectionProperties(this.self.getConnectionProperties());
		dataSource.setInitialSize(this.self.getInitialSize());
		dataSource.setMinIdle(this.self.getMinIdle());
		dataSource.setMaxActive(this.self.getMaxActive());
		dataSource.setMaxWait(this.self.getMaxWait());
		dataSource.setValidationQuery(this.self.getValidationQuery());
		dataSource.setTestWhileIdle(this.self.getTestWhileIdle());
		//		if (this.dataSource99999.getre != null) {
		//			dataSource.setRemoveAbandoned(this.removeAbandoned);
		//		}
		//		if (this.removeAbandonedTimeout != null && this.removeAbandonedTimeout != 0) {
		//			dataSource.setRemoveAbandonedTimeout(this.removeAbandonedTimeout);
		//		}
		//		if (this.logAbandoned != null) {
		//			dataSource.setLogAbandoned(this.logAbandoned);
		//		}
		try {
			dataSource.setFilters(self.getFilters());
		} catch (SQLException e) {
			logger.error("druid configuration initialization filter", e);
		}
		return dataSource;
	}

	@Bean("recordJdbcTemplate")
	public JdbcTemplate recordJdbcTemplate() {
		return new JdbcTemplate(dataSourceBy99999());
	}

}
