package com.example.GymWebAppSpring.controller.entrenador.crud.config;

import com.example.GymWebAppSpring.controller.entrenador.crud.filter.TrainerAuthFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<TrainerAuthFilter> trainerAuthFilter() {
        FilterRegistrationBean<TrainerAuthFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new TrainerAuthFilter());
        registrationBean.addUrlPatterns("/entrenador/rutinas/*");
        return registrationBean;
    }
}