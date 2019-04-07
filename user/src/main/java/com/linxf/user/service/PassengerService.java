package com.linxf.user.service;

import com.linxf.user.dataobject.Passenger;

/**
 * 乘客信息服务
 *
 * @Author lintao
 * @Date 2019/4/7
 */
public interface PassengerService {

    /**
     * 根据乘客信息查询
     *
     * @param passenger
     * @return
     */
    Passenger findPassenger(Passenger passenger);
}
