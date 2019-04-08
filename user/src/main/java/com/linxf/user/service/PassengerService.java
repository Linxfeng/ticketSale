package com.linxf.user.service;

import com.linxf.user.dataobject.Passenger;

import java.util.List;

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

    /**
     * 新增乘客
     *
     * @param passenger
     */
    void createPassenger(Passenger passenger);

    /**
     * 查询用户下[有效]乘客列表
     *
     * @param uid 用户id
     * @return
     */
    List<Passenger> listPassenger(String uid);

}
