package com.linxf.advert.service.impl;

import com.linxf.advert.AdvertApplicationTests;
import com.linxf.advert.dataobject.Advert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

public class AdvertServiceImplTest extends AdvertApplicationTests {

    @Autowired
    private AdvertServiceImpl advertService;

    @Test
    public void addAdvert() {
        Advert advert = new Advert();
        advert.setTitle("标题");
        advert.setContent("内容");
        advert.setCreateTime(new Date());
        Advert advert1 = advertService.addAdvert(advert);
        System.out.println(advert1);
    }
}