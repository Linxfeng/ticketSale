package com.linxf.advert.repository;


import com.linxf.advert.dataobject.Advert;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @Author lintao
 * @Date 2019/3/31
 */
public interface AdvertRepository extends JpaRepository<Advert, Integer> {

    /**
     * 查询所有有效/失效广告列表
     * @param del 0-有效,1-失效
     * @return
     */
    List<Advert> findAllByDel(Integer del);
}
