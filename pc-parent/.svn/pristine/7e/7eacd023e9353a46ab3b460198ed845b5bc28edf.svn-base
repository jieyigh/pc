package com.ds.betinfo.record.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(Self.class)
@ConfigurationProperties(prefix = "self")
public class Self {

	@Value("${second.datasource.type}")
	private String type;
	@Value("${second.datasource.driver-class-name}")
	private String driverClassName;
	@Value("${second.datasource.url}")
	private String url;
	@Value("${second.datasource.username}")
	private String username;
	@Value("${second.datasource.password}")
	private String password;
	@Value("${second.datasource.connectionProperties}")
	private String connectionProperties;
	@Value("${second.datasource.initialSize}")
	private Integer initialSize;
	@Value("${second.datasource.minIdle}")
	private Integer minIdle;
	@Value("${second.datasource.maxActive}")
	private Integer maxActive;
	@Value("${second.datasource.maxWait}")
	private Integer maxWait;
	@Value("${second.datasource.validationQuery}")
	private String validationQuery;
	@Value("${second.datasource.filters}")
	private String filters;
	@Value("${second.datasource.testWhileIdle}")
	private Boolean testWhileIdle;

	public String getType() {
		return type;
	}

	public String getDriverClassName() {
		return driverClassName;
	}

	public String getUrl() {
		return url;
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public String getConnectionProperties() {
		return connectionProperties;
	}

	public Integer getInitialSize() {
		return initialSize;
	}

	public Integer getMinIdle() {
		return minIdle;
	}

	public Integer getMaxActive() {
		return maxActive;
	}

	public Integer getMaxWait() {
		return maxWait;
	}

	public String getValidationQuery() {
		return validationQuery;
	}

	public String getFilters() {
		return filters;
	}

	public Boolean getTestWhileIdle() {
		return testWhileIdle;
	}

}
