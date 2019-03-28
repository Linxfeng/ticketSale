package com.linxf.user.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

/**
 * redis缓存工具类
 *
 * @author lintao
 * @date 2019/3/28
 */
@Component
public class RedisCacheUtil {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    public void setValue(String key, String value){
        stringRedisTemplate.opsForValue().set(key, value);
    }

    public String getValue(String key){
        return stringRedisTemplate.opsForValue().get(key);
    }

}
