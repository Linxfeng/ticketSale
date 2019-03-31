package com.linxf.advert.service.impl;

import com.linxf.advert.dataobject.Advert;
import com.linxf.advert.repository.AdvertRepository;
import com.linxf.advert.service.AdvertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 广告服务
 * @Author lintao
 * @Date 2019/3/31
 */
@Service
public class AdvertServiceImpl implements AdvertService {

    @Autowired
    private AdvertRepository advertRepository;

    /**
     * 查询所有有效/失效广告列表
     * @param del 0-有效,1-失效
     * @return
     */
    @Override
    public List<Advert> getAllAdvert(Integer del) {
        return advertRepository.findAllByDel(del);
    }
}
