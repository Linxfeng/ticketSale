package com.linxf.advert.repository;

import com.linxf.advert.AdvertApplicationTests;
import com.linxf.advert.dataobject.Advert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class AdvertRepositoryTest extends AdvertApplicationTests {

    @Autowired
    private AdvertRepository advertRepository;

    @Test
    public void findAllByDel() {
        //查询所有有效/失效广告列表
        List<Advert> advertList0 = advertRepository.findAllByDel(0);
        List<Advert> advertList1 = advertRepository.findAllByDel(1);
        System.out.println();
    }

}