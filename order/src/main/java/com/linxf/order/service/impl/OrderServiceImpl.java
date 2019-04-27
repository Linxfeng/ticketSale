package com.linxf.order.service.impl;

import com.linxf.order.dataobject.Order;
import com.linxf.order.repository.OrderRepository;
import com.linxf.order.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

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

    /**
     * 取消订单
     *
     * @param oid
     */
    @Override
    public void cancelOrder(String oid) {
        Order order = this.findOrderById(oid);
        Assert.isTrue(order != null, "未查询到该订单");
        order.setDel(1);
        orderRepository.save(order);
    }

    /**
     * 更新订单状态
     *
     * @param oid
     * @param orderStatus
     */
    @Override
    public void updateOrderStatus(String oid, Integer orderStatus) {
        Order order = this.findOrderById(oid);
        Assert.isTrue(order != null, "未查询到该订单");
        order.setOrderStatus(orderStatus);
        orderRepository.save(order);
    }
}
