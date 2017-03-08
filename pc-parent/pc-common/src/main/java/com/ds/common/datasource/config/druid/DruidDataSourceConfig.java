package com.ds.common.datasource.config.druid;

import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.alibaba.druid.pool.DruidDataSource;

@EnableTransactionManagement
@Configuration
@EnableJpaRepositories("com.ds")
public class DruidDataSourceConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Value("${spring.datasource.driver-class-name}")
	private String driverClassName;

	@Value("${spring.datasource.url}")
	private String url;

	@Value("${spring.datasource.username}")
	private String username;

	@Value("${spring.datasource.password}")
	private String password;

	// 通过connectProperties属性来打开mergeSql功能；慢SQL记录
	@Value("${spring.datasource.connectionProperties}")
	private String connectionProperties;

	@Value("${spring.datasource.initialSize}")
	private int initialSize;

	@Value("${spring.datasource.minIdle}")
	private int minIdle;

	@Value("${spring.datasource.maxActive}")
	private int maxActive;

	@Value("${spring.datasource.maxWait}")
	private int maxWait; // 配置获取连接等待超时的时间

	@Value("${spring.datasource.validationQuery}")
	private String validationQuery;

	@Value("${spring.datasource.filters}")
	private String filters; // 配置监控统计拦截的filters，去掉后监控界面sql无法统计，'wall'用于防火墙

	@Value("${spring.datasource.testWhileIdle}")
	private boolean testWhileIdle;

	@Value("${spring.datasource.removeAbandoned}")
	private Boolean removeAbandoned;

	@Value("${spring.datasource.removeAbandonedTimeout}")
	private Integer removeAbandonedTimeout;

	@Value("${spring.datasource.logAbandoned}")
	private Boolean logAbandoned;

	@Value("${spring.datasource.time-between-eviction-runs-millis:60000}")
	private Long timeBetweenEvictionRunsMillis; // 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒 

	@Value("${spring.jpa.properties.hibernate.show_sql}")
	private String showSql;

	@Value("${spring.jpa.properties.hibernate.connection.autoReconnect:true}")
	private String autoReconnect;

	@Value("${spring.jpa.properties.hibernate.connection.autoReconnectForPools:true}")
	private String autoReconnectForPools;

	@Value("${spring.jpa.properties.hibernate.connection.is-connection-validation-required:true}")
	private String connectionValidRequired;

	@Bean
	@Primary
	public DataSource dataSource() {
		DruidDataSource dataSource = new DruidDataSource();
		dataSource.setDriverClassName(this.driverClassName);
		dataSource.setUrl(this.url);
		dataSource.setUsername(this.username);
		dataSource.setPassword(this.password);
		dataSource.setConnectionProperties(this.connectionProperties);
//		dataSource.setConnectionProperties("config.decrypt=false");
		dataSource.setInitialSize(this.initialSize);
		dataSource.setMinIdle(this.minIdle);
		dataSource.setMaxActive(this.maxActive);
		dataSource.setMaxWait(this.maxWait);
		dataSource.setValidationQuery(this.validationQuery);
		dataSource.setTestWhileIdle(this.testWhileIdle);
		if (this.removeAbandoned != null) {
			dataSource.setRemoveAbandoned(this.removeAbandoned);
		}
		if (this.removeAbandonedTimeout != null && this.removeAbandonedTimeout != 0) {
			dataSource.setRemoveAbandonedTimeout(this.removeAbandonedTimeout);
		}
		if (this.logAbandoned != null) {
			dataSource.setLogAbandoned(this.logAbandoned);
		}
		dataSource.setTimeBetweenEvictionRunsMillis(this.timeBetweenEvictionRunsMillis);
		try {
			dataSource.setFilters(filters);
			dataSource.init();
		} catch (SQLException e) {
			logger.error("druid configuration initialization filter", e);
		}
		return dataSource;
	}

	@Bean
	@ConditionalOnMissingBean(PlatformTransactionManager.class)
	public PlatformTransactionManager transactionManager() {
		JpaTransactionManager tx = new JpaTransactionManager();
		tx.setDataSource(dataSource());
		return tx;
	}

	@ConditionalOnMissingBean(PlatformTransactionManager.class)
	@Configuration
	@EnableTransactionManagement
	protected static class TransactionManagementConfiguration {

	}

	@Bean("jdbcTemplate")
	@Primary
	public JdbcTemplate jdbcTemplate() {
		JdbcTemplate jdbcTemplate = new JdbcTemplate();
		jdbcTemplate.setDataSource(dataSource());
		return jdbcTemplate;
	}

	@Bean
	LocalContainerEntityManagerFactoryBean entityManagerFactory(DataSource dataSource, Environment env) {
		LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
		entityManagerFactoryBean.setDataSource(dataSource);
		entityManagerFactoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
		entityManagerFactoryBean.setPackagesToScan("com.ds.entity", "com.ds.*.entity");

		Properties jpaProperties = new Properties();

		// jpaProperties.put("hibernate.dialect",
		// env.getRequiredProperty("hibernate.dialect"));
		// jpaProperties.put("hibernate.hbm2ddl.auto",
		// env.getRequiredProperty("hibernate.hbm2ddl.auto"));
		jpaProperties.put("hibernate.show_sql", showSql);
		jpaProperties.put("hibernate.format_sql", "false");
		jpaProperties.put("hibernate.dialect", "org.hibernate.dialect.MySQL5InnoDBDialect");
		jpaProperties.put("hibernate.connection.release_mode", "after_transaction");
		jpaProperties.put("hibernate.connection.handling_mode", "DELAYED_ACQUISITION_AND_HOLD");
		
		
		jpaProperties.put("connection.autoReconnect", autoReconnect);
		jpaProperties.put("connection.autoReconnectForPools", autoReconnectForPools);
		jpaProperties.put("connection.autoReconnect", connectionValidRequired);
		
		//		 jpaProperties.put("connectionProperties", "config.decrypt=false");

		entityManagerFactoryBean.setJpaProperties(jpaProperties);

		return entityManagerFactoryBean;
	}

}
