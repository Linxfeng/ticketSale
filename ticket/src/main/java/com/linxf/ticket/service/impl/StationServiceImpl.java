package com.linxf.ticket.service.impl;

import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.dataobject.Train;
import com.linxf.ticket.repository.StationRepository;
import com.linxf.ticket.service.StationService;
import com.linxf.ticket.service.TrainService;
import com.linxf.ticket.vo.TrainVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.List;

/**
 * @author lintao
 * @date 2019/4/16
 */
@Service
public class StationServiceImpl implements StationService {

    @Autowired
    private StationRepository stationRepository;

    @Autowired
    private TrainService trainService;

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
    public List<TrainVo> goStraightRoute(String name1, String name2) {
        List<TrainVo> trainList = new ArrayList<>();//返回结果
        //先查询所有包含始发站的列车
        List<String> tidList1 = stationRepository.findTidByName1(name1);
        for (String tid : tidList1) {
            //查询该列车的车站信息：出发站-到达站
            List<Station> stationList = this.filterStationList(tid, name1, name2, new ArrayList<>());
            if (stationList == null || stationList.size() == 0) return null;
            //获取车辆信息，封装返回参数
            Train train = trainService.getTrainInfo(tid);
            TrainVo trainVo = new TrainVo();
            BeanUtils.copyProperties(train, trainVo);
            //计算区间车程-时间差
            Long hour = (stationList.get(stationList.size() - 1).getTime2().getTime()
                    - stationList.get(0).getTime1().getTime());
            Long lev = 3600000l;//毫秒级转换为小时级，保留一位小数
            trainVo.setDriveTime(String.format("%.1f", (hour.doubleValue() / lev.doubleValue())));
            trainVo.setStationSum(stationList.size());
            trainVo.setStationList(stationList);
            trainList.add(trainVo);
        }
        return trainList;
    }

    /**
     * 递归调用，查找车站列表：出发站-到达站
     */
//    private List<Station> findStationList(String tid, String name1, String name2, List<Station> stationList) {
//        Station station = stationRepository.findByTidAndName1(tid, name1);
//        if (station == null) return null;
//        stationList.add(station);//符合条件的车站列表
//        if (name2.equals(station.getName2()))
//            return stationList;
//        //递归调用，找到所有符合条件的车站
//        return this.findStationList(tid, station.getName2(), name2, stationList);
//    }

    /**
     * 递归调用，查找车站列表：
     * 1、用户出发站-车辆终点站
     * 2、车辆始发站-用户到达站
     * 3、用户出发站-用户到达站
     */
    private List<Station> filterStationList(String tid, String name1, String name2, List<Station> stationList) {
        Station station = null;
        if (name2 == null) station = stationRepository.findByTidAndName1(tid, name1);//1、用户出发站-车辆终点站
        if (name1 == null) station = stationRepository.findByTidAndName2(tid, name2);//2、车辆始发站-用户到达站
        //3、用户出发站-用户到达站
        if (name1 != null && name2 != null) station = stationRepository.findByTidAndName1(tid, name1);
        if (station == null) return stationList;
        stationList.add(station);//符合条件的车站列表
        if (name1 != null && name2 != null && name2.equals(station.getName2())) return stationList;
        //递归调用，找到所有符合条件的车站
        if (name2 == null) name1 = station.getName2();//1、用户出发站-车辆终点站
        if (name1 == null) name2 = station.getName1();//2、车辆始发站-用户到达站
        if (name1 != null && name2 != null) name1 = station.getName2();//3、用户出发站-用户到达站
        return this.filterStationList(tid, name1, name2, stationList);
    }

    /**
     * 查询换乘车车次列表
     *
     * @param name1 出发站
     * @param name2 达到站
     * @return
     */
    @Override
    public List<TrainVo> goChangeRoute(String name1, String name2) {
        List<TrainVo> trainList = new ArrayList<>();//返回结果
        //查询所有包含出发站的列车
        List<String> tidList1 = stationRepository.findTidByName1(name1);
        //查询所有包含到达站的列车
        List<String> tidList2 = stationRepository.findTidByName2(name2);

        for (String tid : tidList1) {//出发站车站列表
            //查询该列车的车站信息：出发站-到达站
            List<Station> stationList1 = this.filterStationList(tid, name1, name2, new ArrayList<>());
        }
        for (String tid : tidList2) {//到达站车站列表
            //查询该列车的车站信息：出发站-到达站
            List<Station> stationList2 = this.filterStationList(tid, name1, name2, new ArrayList<>());
        }
        return trainList;
    }
}
