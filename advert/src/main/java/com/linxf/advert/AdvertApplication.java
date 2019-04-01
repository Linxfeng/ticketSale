package com.linxf.advert;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages={"com.linxf.advert.*", "com.linxf.common.*"})
public class AdvertApplication {

    public static void main(String[] args) {
        SpringApplication.run(AdvertApplication.class, args);
    }

}
