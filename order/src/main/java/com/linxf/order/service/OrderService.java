package com.linxf.order.service;

import com.linxf.order.dataobject.Order;

import java.util.List;

/**
 * 订单服务
 *
 * @Author lintao
 * @Date 2019/4/27
 */
public interface OrderService {

    /**
     * 创建订单
     *
     * @param order
     */
    void createOrder(Order order);

    /**
     * 查询用户订单列表
     *
     * @param uid
     * @return
     */
    List<Order> listOrderByUid(String uid);
}
