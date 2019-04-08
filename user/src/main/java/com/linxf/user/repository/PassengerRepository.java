package com.linxf.user.repository;

import com.linxf.user.dataobject.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 乘客Dao层
 *
 * @Author lintao
 * @Date 2019/4/7
 */
public interface PassengerRepository extends JpaRepository<Passenger, String> {

    /**
     * 查询用户的乘客列表
     *
     * @param uid 用户id
     * @param del 是否有效，0-有效，1-失效
     * @return
     */
    List<Passenger> findByUidAndDel(String uid, Integer del);

}
