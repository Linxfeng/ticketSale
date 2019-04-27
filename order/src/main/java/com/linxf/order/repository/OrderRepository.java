package com.linxf.order.repository;

import com.linxf.order.dataobject.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 订单Dao层
 *
 * @Author lintao
 * @Date 2019/4/27
 */
public interface OrderRepository extends JpaRepository<Order, String> {

    /**
     * 根据用户id查询订单列表
     *
     * @param uid
     * @return
     */
    List<Order> findAllByUid(String uid);
}
