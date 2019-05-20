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
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * 查询换乘车车次列表
     *
     * @param name1 出发站
     * @param name2 达到站
     * @return
     */
    @Override
    public List<Map<String, Object>> goChangeRoute(String name1, String name2) {
        List<Map<String, Object>> trainList = new ArrayList<>();//返回结果
        //查询所有包含出发站的列车
        List<String> tidList1 = stationRepository.findTidByName1(name1);
        if (CollectionUtils.isEmpty(tidList1)) return null;
        //查询所有包含到达站的列车
        List<String> tidList2 = stationRepository.findTidByName2(name2);
        if (CollectionUtils.isEmpty(tidList2)) return null;
        if (tidList2.size() > tidList1.size()) {
            tidList2.removeAll(tidList1);
        } else {
            tidList1.removeAll(tidList2);
        }
        //遍历车次
        for (String tid1 : tidList1) {
            //查询该列车的车站信息：用户出发站出发站-终点站
            List<Station> stationList1 = this.filterStationList(tid1, name1, null, new ArrayList<>());
            if (CollectionUtils.isEmpty(stationList1)) continue;
            if (stationList1.get(0).getName2().equals(name2)) continue;// 直达车排除掉
            // 遍历符合到达站条件的车次编号列表
            List<Map<String, Object>> resultList1 = getNeedList(tidList2, tid1, name2, stationList1, name1);
            if (CollectionUtils.isEmpty(resultList1)) continue;
            resultList1.forEach(map1 -> trainList.add(map1));
        }
        return trainList;
    }

    /**
     * 遍历符合到达站条件的车次编号列表
     */
    private List<Map<String, Object>> getNeedList(List<String> tidList2, String tid1, String name2,
                                                  List<Station> stationList1, String name1) {
        List<Map<String, Object>> mapList = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        for (String tid2 : tidList2) {
            if (tid1.equals(tid2)) continue;//排除直达车
            // 根据车次编号获取车站列表信息：列车始发站-用户到达站
            List<Station> stationList2 = this.filterStationList(tid2, null, name2, new ArrayList<>());
            if (CollectionUtils.isEmpty(stationList2)) continue;
            if (stationList2.get(0).getName1().equals(name1)) break;//排除直达车
            // 寻找列车1和列车2的交接点
            String station = this.getChangeStation(stationList1, stationList2);
            if (station == null) continue;
            // 根据编号获取车辆信息
            TrainVo trainVo1 = new TrainVo();
            TrainVo trainVo2 = new TrainVo();
            BeanUtils.copyProperties(trainService.getTrainInfo(tid1), trainVo1);
            BeanUtils.copyProperties(trainService.getTrainInfo(tid2), trainVo2);
            trainVo1.setStationList(stationList1);
            trainVo2.setStationList(stationList2);
            // 返回换乘情况下的换乘车次和换乘车站
            map.put("changeStation", station);// 返回换乘站
            map.put("train1", trainVo1);// 换乘车辆1
            map.put("train2", trainVo2);// 换乘车辆2
            mapList.add(map);
        }
        return mapList;
    }

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
     * 寻找列车1和列车2的交接点--换乘站
     */
    private String getChangeStation(List<Station> stationList1, List<Station> stationList2) {
        for (Station station1 : stationList1) {
            for (Station station2 : stationList2) {
                String sname1 = station1.getName2();
                String sname2 = station2.getName1();
                if (sname1.equals(sname2)) return station1.getName2();
            }
        }
        return null;
    }

}
