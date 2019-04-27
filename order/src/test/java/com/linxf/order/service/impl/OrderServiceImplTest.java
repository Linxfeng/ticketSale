package com.linxf.order.service.impl;
import java.util.Date;
import java.util.List;

import com.linxf.common.utils.UUIDUtil;
import com.linxf.order.OrderApplicationTests;
import com.linxf.order.dataobject.Order;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 订单服务测试用例
 *
 * @Author lintao
 * @Date 2019/4/27
 */
public class OrderServiceImplTest extends OrderApplicationTests {

    @Autowired
    private OrderServiceImpl orderService;

    @Test
    public void createOrder() {
        Order order = new Order();
        order.setOid(UUIDUtil.get16UUID());
        order.setUid("1554086717367104");
        order.setPid("1554645635284698");
        order.setTid("D2262");
        order.setStartStation("上海");
        order.setStartTime(new Date());
        order.setEndStation("苏州");
        order.setEndTime(new Date());
        order.setSeatType(0);
        order.setAmount(0.0D);
        order.setOrderStatus(0);
        order.setCreateTime(new Date());
        order.setUpdateTime(new Date());
        order.setDel(0);
        orderService.createOrder(order);
    }

    @Test
    public void listOrderByUid() {
        List<Order> orderList = orderService.listOrderByUid("1554086717367104");
        if (orderList != null) {
            for (int i = 0; i < orderList.size(); i++) {
                System.out.println(orderList.get(i).toString());
            }
        } else {
            System.out.println("null");
        }
    }

    @Test
    public void listOrderByStatus() {
        List<Order> orderList = orderService.listOrderByStatus("1554086717367104", 0);
        if (orderList != null) {
            for (int i = 0; i < orderList.size(); i++) {
                System.out.println(orderList.get(i).toString());
            }
        } else {
            System.out.println("null");
        }
    }

    @Test
    public void findOrderById() {
        Order order = orderService.findOrderById("1554086717367123");
        System.out.println(order);
    }
}