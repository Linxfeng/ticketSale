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

    /**
     * 根据订单状态-查询用户订单列表
     *
     * @param uid
     * @param orderStatus
     * @return
     */
    @Override
    public List<Order> listOrderByStatus(String uid, Integer orderStatus) {
        return orderRepository.findAllByUidAndOrderStatus(uid, orderStatus);
    }

    /**
     * 根据订单id查询订单信息
     *
     * @param oid
     * @return
     */
    @Override
    public Order findOrderById(String oid) {
        return orderRepository.getOne(oid);
    }
}
