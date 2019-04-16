package com.linxf.ticket.repository;

import com.linxf.ticket.dataobject.Train;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 车辆Dao层
 *
 * @author lintao
 * @date 2019/4/16
 */
public interface TrainRepository extends JpaRepository<Train, String> {
}
