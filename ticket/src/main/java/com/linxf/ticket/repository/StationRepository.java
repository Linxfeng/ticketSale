package com.linxf.ticket.repository;

import com.linxf.ticket.dataobject.Station;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 车站Dao层
 *
 * @author lintao
 * @date 2019/4/16
 */
public interface StationRepository extends JpaRepository<Station, String> {

    /**
     * 查询某辆列车的车站列表
     *
     * @param tid
     * @return
     */
    List<Station> findAllByTid(String tid);
}
