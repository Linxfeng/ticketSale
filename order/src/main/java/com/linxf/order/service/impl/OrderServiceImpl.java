package com.linxf.order.service.impl;

import com.linxf.order.dataobject.Order;
import com.linxf.order.repository.OrderRepository;
import com.linxf.order.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 订单服务
 *
 * @Author lintao
 * @Date 2019/4/27
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    /**
     * 创建订单
     *
     * @param order
     */
    @Override
    public void createOrder(Order order) {
        orderRepository.save(order);
    }

    /**
     * 查询用户订单列表
     *
     * @param uid
     * @return
     */
    @Override
    public List<Order> listOrderByUid(String uid) {
        return orderRepository.findAllByUid(uid);
    }
}
