package com.linxf.common.utils;

import java.sql.Time;

/**
 * 时间处理工具类
 *
 * @author lintao
 * @date 2019/4/16
 */
public class TimeUtil {

    /**
     * <p>Title: diffHour</p>
     * <p>Description: 获取两个java.sql.Time之间的相差小时</p>
     * @param begin 开始的时间
     * @param end 结束的时间
     * @return
     */
    public static int diffHour(Time begin, Time end) {
        long i = begin.getTime();
        long j = end.getTime();
        // next day
        if (i > j) {
            j += 86400000l;
        }
        int d = (int) ((i - j) / 3600000l);
        return d = d >= 0 ? d : -d;
    }

}
