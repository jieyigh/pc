package com.ds.manager.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.ds.manager.interceptor.ValidInterceptor;

/**
 * 验证拦截器
 * 
 * @author jackson
 *
 */
@Configuration
public class WebAppConfig extends WebMvcConfigurerAdapter {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new ValidInterceptor())//
				.addPathPatterns("/**")//
				.excludePathPatterns("/site/add")//
				.excludePathPatterns("/lottery/edit")//
				.excludePathPatterns("/swagger-ui.html");
		super.addInterceptors(registry);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("swagger-resources")//
				.addResourceLocations("classpath:/META-INF/resources/");
		registry.addResourceHandler("swagger-ui.html")//
				.addResourceLocations("classpath:/META-INF/resources/");
		registry.addResourceHandler("/webjars/**")//
				.addResourceLocations("classpath:/META-INF/resources/webjars/");
	}

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

}
