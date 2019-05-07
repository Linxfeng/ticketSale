package com.linxf.ticket.service.impl;

import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.repository.StationRepository;
import com.linxf.ticket.service.StationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;

/**
 * @author lintao
 * @date 2019/4/16
 */
@Service
public class StationServiceImpl implements StationService {

    @Autowired
    private StationRepository stationRepository;

    /**
     * 新增车站
     *
     * @param station
     */
    @Override
    public void addStation(Station station) {
        stationRepository.save(station);
    }

    /**
     * 添加车站列表
     *
     * @param stationList
     */
    @Override
    @Transactional
    public void addStationList(List<Station> stationList) {
        Assert.notNull(stationList, "车站列表不能为空！");
        Assert.notNull(stationList.get(0), "车站列表不能为空！");
        for (Station station : stationList) {
            this.addStation(station);
        }
    }

    /**
     * 查询某辆列车的车站列表
     *
     * @param tid
     * @return
     */
    @Override
    public List<Station> findListByTid(String tid) {
        return stationRepository.findAllByTid(tid);
    }

    /**
     * 修改单条车站信息
     *
     * @param station
     */
    @Override
    public void updateStationInfo(Station station) {
        stationRepository.save(station);
    }

    /**
     * 根据车站id查询单条车站信息
     *
     * @param id
     * @return
     */
    @Override
    public Station findStationById(String id) {
        return stationRepository.getOne(id);
    }

    /**
     * 查询直达车车次列表
     *
     * @param name1 出发站
     * @param name2 达到站
     * @return
     */
    @Override
    public List<String> goStraightRoute(String name1, String name2) {
        //先查询所有包含始发站的列车
        List<String> tidList1 = stationRepository.findTidByName1(name1);
        //先查询所有包含达到站的列车
        List<String> tidList2 = stationRepository.findTidByName2(name2);
        //求交集
        tidList1.retainAll(tidList2);
        return tidList1;
    }

    /**
     * 查询换乘车车次列表
     *
     * @param name1 出发站
     * @param name2 达到站
     * @return
     */
    @Override
    public List<String> goChangeRoute(String name1, String name2) {
        return null;
    }
}
