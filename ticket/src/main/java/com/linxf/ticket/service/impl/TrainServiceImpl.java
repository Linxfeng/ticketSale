package com.linxf.ticket.service.impl;

import com.linxf.ticket.dataobject.Train;
import com.linxf.ticket.repository.TrainRepository;
import com.linxf.ticket.service.TrainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 车辆服务
 *
 * @author lintao
 * @date 2019/4/16
 */
@Service
public class TrainServiceImpl implements TrainService {

    @Autowired
    private TrainRepository trainRepository;

    /**
     * 新增车辆
     *
     * @param train
     */
    @Override
    public void addTrain(Train train) {
        trainRepository.save(train);
    }

}
