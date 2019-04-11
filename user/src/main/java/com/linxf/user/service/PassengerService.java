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
     * 根据pid查询乘客信息
     * 
     * @param pid
     * @return
     */
    Passenger findPassengerByPid(String pid);

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

    /**
     * 删除乘客-将该乘客设置为无效
     *
     * @param pid
     */
    void deletePassenger(String pid);

    /**
     * 更新乘客信息
     *
     * @param passenger
     */
    void upsatePassenger(Passenger passenger);

}
