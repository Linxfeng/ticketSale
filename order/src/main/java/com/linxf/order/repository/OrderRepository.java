package com.linxf.order.repository;

import com.linxf.order.dataobject.Order;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 订单Dao层
 *
 * @Author lintao
 * @Date 2019/4/27
 */
public interface OrderRepository extends JpaRepository<Order, String> {
}
