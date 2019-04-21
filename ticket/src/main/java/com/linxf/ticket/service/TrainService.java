package com.linxf.ticket.service;

import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.dataobject.Train;

import java.util.List;

/**
 * 列车服务
 *
 * @author lintao
 * @date 2019/4/16
 */
public interface TrainService {

    /**
     * 新增车辆
     *
     * @param train
     */
    void addTrain(Train train);

    /**
     * 新增车辆以及车站列表信息
     *
     * @param train
     * @param stationList
     */
    void addTrain(Train train, List<Station> stationList);

    /**
     * 获取列车tid列表
     *
     * @return
     */
    List<String> listTid();

    /**
     * 根据tid查询车辆信息
     *
     * @param tid
     * @return
     */
    Train getTrainInfo(String tid);

    /**
     * 根据车辆类型查询车辆列表
     *
     * @param trainType
     * @return
     */
    List<Train> listTrainByType(String trainType);

    /**
     * 更新车辆信息
     *
     * @param train
     */
    void updateTrainInfo(Train train);
}
