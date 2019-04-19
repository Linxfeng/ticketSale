package com.linxf.ticket.repository;

import com.linxf.ticket.dataobject.Train;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 车辆Dao层
 *
 * @author lintao
 * @date 2019/4/16
 */
public interface TrainRepository extends JpaRepository<Train, String> {

    /**
     * 根据车辆类型查询车辆列表
     *
     * @param trainType
     * @return
     */
    List<Train> findAllByTrainType(String trainType);
}
