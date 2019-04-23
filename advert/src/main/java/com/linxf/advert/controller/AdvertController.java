package com.linxf.advert.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.linxf.advert.dataobject.Advert;
import com.linxf.advert.service.AdvertService;
import com.linxf.advert.utils.VerifyParamsUtil;
import com.linxf.common.utils.JsonUtil;
import com.linxf.common.utils.RedisCacheUtil;
import com.linxf.common.vo.ResponseVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
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
    private static final String ADVERTID = "advert_id_";

    @Autowired
    private AdvertService advertService;

    @Autowired
    private RedisCacheUtil redisCacheUtil;

    /**
     * 查询所有有效公告列表
     */
    @GetMapping("/showAllAdvert")
    public ResponseVo getAllAdvert(HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        List<Advert> advertList = listAdvertFromRedis();
        if (advertList == null || advertList.size() == 0)
            return ResponseVo.noDataFailed("未查询到公告信息！");
        return ResponseVo.success("查询成功", advertList);
    }

    //查询所有有效公告列表
    private List<Advert> listAdvertFromRedis() {
        List<Advert> advertList = null;
        String value = redisCacheUtil.getValue(ADVERTLIST0);//先从缓存中取
        if (StringUtils.isNotBlank(value) && !"null".equals(value)) { //如果缓存中有，则转换为list
            advertList = (List<Advert>) JsonUtil.jsonToObject(value,
                    new TypeReference<List<Advert>>() {
                    });
        } else { //没有没有则查数据库
            advertList = advertService.getAllAdvert(0);
            redisCacheUtil.setValue(ADVERTLIST0, JsonUtil.toJson(advertList));
        }
        return advertList;
    }

    /**
     * 查询单个advert信息
     *
     * @param id
     */
    @PostMapping("/advertInfo")
    public ResponseVo getAdvert(Integer id, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        if (id == null || id == 0)
            return ResponseVo.failed("参数不能为空");
        Advert advert = null;
        String value = redisCacheUtil.getValue(ADVERTID + id);
        if (StringUtils.isNotBlank(value) && !"null".equals(value)) {
            advert = (Advert) JsonUtil.jsonToObject(value, new TypeReference<Advert>() {
            });
        } else {
            advert = advertService.getAdvertById(id);
            redisCacheUtil.setValue(ADVERTID + id, JsonUtil.toJson(advert));
        }
        if (advert == null) return ResponseVo.noDataFailed("未查询到当前公告信息");
        return ResponseVo.success("查询成功", advert);
    }

    /**
     * 新增公告
     *
     * @param advert
     */
    @PostMapping("/addAdvert")
    public ResponseVo addAdvert(Advert advert, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            new VerifyParamsUtil().validAdvert(advert);//校验参数
            advert.setCreateTime(new Date());
            advertService.addAdvert(advert);//新增公告
            //存入缓存
            redisCacheUtil.setValue(ADVERTID + advert.getId(), JsonUtil.toJson(advert));
            redisCacheUtil.remove(ADVERTLIST0);//新增公告，刷新缓存
            return ResponseVo.success("操作成功！");
        } catch (Exception e) {
            log.error("AdvertController.addAdvert ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 查询所有广告列表-包括失效
     */
    @GetMapping("/listAdvert")
    public ResponseVo listAdvert(HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            List<Advert> advertList = listAdvertFromRedis();//查询所有有效公告列表
            List<Advert> advertDelList = advertService.getAllAdvert(1);
            if (advertDelList != null && advertDelList.size() != 0)
                advertList.addAll(advertDelList);
            if (advertList == null || advertList.size() == 0)
                return ResponseVo.noDataFailed("未查询到公告信息！");
            return ResponseVo.success("查询成功", advertList);
        } catch (Exception e) {
            log.error("AdvertController.listAdvert ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 删除某条公告
     *
     * @param id
     */
    @PostMapping("/deleteAdvert")
    public ResponseVo deleteAdvert(Integer id, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            Assert.notNull(id, "参数不能为空！");
            advertService.deleteAdvert(id);
            redisCacheUtil.remove(ADVERTLIST0);//新增公告，刷新缓存
            return ResponseVo.success("操作成功！");
        } catch (Exception e) {
            log.error("AdvertController.deleteAdvert ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

}
