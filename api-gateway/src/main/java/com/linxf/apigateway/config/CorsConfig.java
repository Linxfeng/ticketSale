package com.linxf.apigateway.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.Arrays;

/**
 * 跨域配置
 * C - Cross  O - Origin  R - Resource  S - Sharing
 * 在被调用的跨域方法或类上，加注解@CrossOrigin(allowCredentials = "true")
 * --在这里做统一配置后，则不需要在被调用方加注解了
 * @author lintao
 * @date 2019/3/26
 */
@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter() {
        final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        final CorsConfiguration config = new CorsConfiguration();

        config.setAllowCredentials(true);//是否支持cookie跨域
        config.setAllowedOrigins(Arrays.asList("*")); //放原始域，如http:www.a.com
        config.setAllowedHeaders(Arrays.asList("*")); //允许跨域的头
        config.setAllowedMethods(Arrays.asList("*")); //方法，GET,POST
        config.setMaxAge(300l); //缓存时间(秒)：在该时间段内，相同的跨域请求不再进行检查

        source.registerCorsConfiguration("/**", config); //对哪些域下进行配置，/**是所有
        return new CorsFilter(source);
    }

}
