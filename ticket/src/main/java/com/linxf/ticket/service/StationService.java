package com.linxf.ticket.service;

import com.linxf.ticket.dataobject.Station;

import java.util.List;

/**
 * 车站服务
 *
 * @author lintao
 * @date 2019/4/16
 */
public interface StationService {

    /**
     * 新增车站
     *
     * @param station
     */
    void addStation(Station station);

    /**
     * 添加车站列表
     *
     * @param stationList
     */
    void addStationList(List<Station> stationList);

    /**
     * 查询某辆列车的车站列表
     *
     * @param tid
     * @return
     */
    List<Station> findListByTid(String tid);
}
