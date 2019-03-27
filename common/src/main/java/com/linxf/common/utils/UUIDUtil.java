package com.linxf.common.utils;

import java.util.Random;
import java.util.UUID;

/**
 * 生成唯一uuid的工具类
 *
 * @author lintao
 * @date 2019/3/27
 */
public class UUIDUtil {

    /**
     * 生成唯一的16位kuy
     * 格式: 13位时间戳+3位随机数，纯数字
     */
    public static synchronized String get16UUID() {
        Random random = new Random();
        int number = random.nextInt(900) + 100;
        return System.currentTimeMillis() + String.valueOf(number);
    }

    /**
     * 生成唯一的32位uuid
     * 格式: d39b37b98606404cad9077ae29884330
     */
    public static String get32UUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }

}