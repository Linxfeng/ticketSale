package com.linxf.user.repository;

import com.linxf.user.dataobject.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 乘客Dao层
 *
 * @Author lintao
 * @Date 2019/4/7
 */
public interface PassengerRepository extends JpaRepository<Passenger, String> {

}
