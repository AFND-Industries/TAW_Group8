package com.example.GymWebAppSpring.controller.cliente.config;

import com.example.GymWebAppSpring.controller.cliente.filter.ClientAuthFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ClientFilterConfig {

    @Bean
    public FilterRegistrationBean<ClientAuthFilter> CLientAuthFilter() {
        FilterRegistrationBean<ClientAuthFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new ClientAuthFilter());
        registrationBean.addUrlPatterns("/client/*");
        return registrationBean;
    }
}