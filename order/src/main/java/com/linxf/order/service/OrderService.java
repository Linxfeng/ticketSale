package com.linxf.order.service;

import com.linxf.order.dataobject.Order;

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

}
