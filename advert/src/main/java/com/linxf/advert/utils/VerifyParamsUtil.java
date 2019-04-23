package com.linxf.advert.utils;

import com.linxf.advert.dataobject.Advert;
import org.springframework.util.Assert;

/**
 * 校验参数工具类
 *
 * @author lintao
 * @date 2019/4/23
 */
public class VerifyParamsUtil {

    /**
     * 校验公告表单参数
     */
    public void validAdvert(Advert advert) {
        Assert.notNull(advert, "参数不能为空！");
        Assert.notNull(advert.getTitle(), "公告标题不能为空！");
        Assert.notNull(advert.getContent(), "公告内容不能为空！");
    }

}
