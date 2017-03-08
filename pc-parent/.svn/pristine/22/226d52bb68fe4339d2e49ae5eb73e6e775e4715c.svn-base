package com.ds.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
//		http.authorizeRequests().anyRequest().not();
//		http.authorizeRequests()//
//				.antMatchers("/*", "/*").permitAll();// 设置对/和/login不拦截
//				.anyRequest().authenticated()//
//				.and()//
//				.formLogin()//
//				.loginPage("/login")// 设置登录路径/login
//				.defaultSuccessUrl("/chat")// 设置登录成功跳转/chat
//				.permitAll()//
//				.and()//
//				.logout()//
//				.permitAll();
		http.csrf().disable();
	}

//	@Override
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		auth.inMemoryAuthentication()//
//				.withUser("zhiwei").password("zhiwei").roles("USER")//
//				.and()//
//				.withUser("test").password("test").roles("USER");
//	}

}
