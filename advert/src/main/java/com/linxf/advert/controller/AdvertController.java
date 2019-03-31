package com.linxf.advert.controller;

import com.linxf.advert.dataobject.Advert;
import com.linxf.advert.service.AdvertService;
import com.linxf.common.utils.RedisCacheUtil;
import com.linxf.common.vo.ResponseVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @Author lintao
 * @Date 2019/3/31
 */
@Slf4j
@RestController
@RequestMapping("/advert")
public class AdvertController {

    @Autowired
    private AdvertService advertService;

    @Autowired
    private RedisCacheUtil redisCacheUtil;

    @GetMapping("/showAllAdvert")
    public ResponseVo getAllAdvert() {
        List<Advert> advertList = null;
        //先从缓存中取
        String value = redisCacheUtil.getValue("");
        if (StringUtils.isBlank(value)) { //如果缓存中没有泽查数据库
            advertList = advertService.getAllAdvert(0);
        }
        return ResponseVo.success("查询成功", advertList);
    }
}
