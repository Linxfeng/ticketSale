package com.linxf.ticket.service;

import com.linxf.ticket.dataobject.Train;

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

}
