package com.linxf.advert.service.impl;

import com.linxf.advert.dataobject.Advert;
import com.linxf.advert.repository.AdvertRepository;
import com.linxf.advert.service.AdvertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @Override
    public Advert getAdvertById(Integer id) {
        Optional<Advert> optional = advertRepository.findById(id);
        if (!optional.isPresent()) return null;
        return optional.get();
    }

    /**
     * 新增公告
     *
     * @param advert
     */
    @Override
    public void addAdvert(Advert advert) {
        advertRepository.save(advert);
    }

    /**
     * 删除某条公告
     *
     * @param id
     */
    @Override
    public void deleteAdvert(Integer id) {
        Advert advert = this.getAdvertById(id);
        advert.setDel(1);
        this.addAdvert(advert);
    }

}
