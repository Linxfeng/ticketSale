package com.linxf.ticket.repository;

import com.linxf.ticket.dataobject.Station;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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

    /**
     * 根据出发站查询所有车次列表
     *
     * @param name1
     * @return
     */
    @Query(value = "SELECT DISTINCT tid FROM station WHERE name1=:name1", nativeQuery = true)
    List<String> findTidByName1(@Param("name1") String name1);

    /**
     * 根据到达站查询所有车次列表
     *
     * @param name2
     * @return
     */
    @Query(value = "SELECT DISTINCT tid FROM station WHERE name2=:name2", nativeQuery = true)
    List<String> findTidByName2(@Param("name2") String name2);
}
