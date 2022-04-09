package com.ssafy.happyhouseproject.config;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ssafy.happyhouseproject.interceptor.ConfirmInterceptor;

//@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	private final List<String> patterns = Arrays.asList("/happyhouse/*", "/admin", "/user/list");

	@Autowired
	private ConfirmInterceptor confirmInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(confirmInterceptor).addPathPatterns(patterns);
	}

}
