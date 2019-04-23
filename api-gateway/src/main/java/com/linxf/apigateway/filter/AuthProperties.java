package com.linxf.apigateway.filter;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 鉴权过滤器配置
 *
 * @author lintao
 * @date 2019/4/23
 */
@Configuration
@ConfigurationProperties("auth")
@EnableConfigurationProperties(AuthProperties.class)
public class AuthProperties {

    /**
     * 需要鉴权过滤的url集合
     */
    private String[] url = new String[]{};

    public String[] getUrl() {
        return url;
    }

    public void setUrl(String[] url) {
        this.url = url;
    }

}

