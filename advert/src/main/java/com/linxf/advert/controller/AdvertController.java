package com.linxf.advert.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.linxf.advert.dataobject.Advert;
import com.linxf.advert.service.AdvertService;
import com.linxf.common.utils.JsonUtil;
import com.linxf.common.utils.RedisCacheUtil;
import com.linxf.common.vo.ResponseVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @Author lintao
 * @Date 2019/3/31
 */
@Slf4j
@RestController
@RequestMapping("/advert")
public class AdvertController {

    private static final String ADVERTLIST0 = "advertList0";
    private static final String ADVERTLIST1 = "advertList1";
    private static final String ADVERTID = "advert_id_";

    @Autowired
    private AdvertService advertService;

    @Autowired
    private RedisCacheUtil redisCacheUtil;

    /**
     * 查询所有有效广告列表
     */
    @GetMapping("/showAllAdvert")
    public ResponseVo getAllAdvert(HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        List<Advert> advertList = null;
        //先从缓存中取
        String value = redisCacheUtil.getValue(ADVERTLIST0);
        //如果缓存中有，则转换为list，若没有没有则查数据库
        if (StringUtils.isNotBlank(value)) {
            advertList = (List<Advert>) JsonUtil.jsonToObject(value,
                    new TypeReference<List<Advert>>() {});
        } else {
            advertList = advertService.getAllAdvert(0);
            redisCacheUtil.setValue(ADVERTLIST0, JsonUtil.toJson(advertList));
        }
        return ResponseVo.success("查询成功", advertList);
    }

    /**
     * 查询单个advert信息
     * @param id
     */
    @PostMapping("/advertInfo")
    public ResponseVo getAdvert(Integer id, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        if (id == null || id == 0)
            return ResponseVo.failed("参数不能为空");
        Advert advert = null;
        String value = redisCacheUtil.getValue(ADVERTID+id);
        if (StringUtils.isNotBlank(value)) {
            advert = (Advert) JsonUtil.jsonToObject(value, new TypeReference<Advert>() {});
        } else {
            advert = advertService.getAdvertById(id);
            redisCacheUtil.setValue(ADVERTID+id, JsonUtil.toJson(advert));
        }
        if (advert == null) return ResponseVo.noDataFailed("未查询到当前公告信息");
        return ResponseVo.success("查询成功", advert);
    }

}
