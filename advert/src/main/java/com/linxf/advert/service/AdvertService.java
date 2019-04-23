package com.linxf.advert.service;

import com.linxf.advert.dataobject.Advert;

import java.util.List;

/**
 * @Author lintao
 * @Date 2019/3/31
 */
public interface AdvertService {

    /**
     * 查询所有有效/失效广告列表
     * @param del 0-有效,1-失效
     * @return
     */
    List<Advert> getAllAdvert(Integer del);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    Advert getAdvertById(Integer id);

    /**
     * 新增公告
     *
     * @param advert
     * @return
     */
    Advert addAdvert(Advert advert);
}
