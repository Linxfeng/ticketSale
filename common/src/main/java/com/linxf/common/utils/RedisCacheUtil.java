package com.linxf.common.utils;

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

    public String getValue(String key) {
        return stringRedisTemplate.opsForValue().get(key);
    }

    /**
     * 为key生成32位uuid并set到redis中，返回该uuid
     *
     * @param key
     * @return uuid
     */
    public String setAndReturnUUID(String key) {
        String value = UUIDUtil.get32UUID();
        stringRedisTemplate.opsForValue().set(key, value);
        return value;
    }

    /**
     * 根据key删除一个缓存值
     *
     * @param key
     */
    public void remove(String key) {
        stringRedisTemplate.delete(key);
    }

}
