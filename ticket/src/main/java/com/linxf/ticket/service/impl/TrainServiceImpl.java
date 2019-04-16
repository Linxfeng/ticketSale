package com.linxf.ticket.service.impl;

import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.dataobject.Train;
import com.linxf.ticket.repository.TrainRepository;
import com.linxf.ticket.service.StationService;
import com.linxf.ticket.service.TrainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

    @Autowired
    private StationService stationService;

    /**
     * 新增车辆
     *
     * @param train
     */
    @Override
    public void addTrain(Train train) {
        trainRepository.save(train);
    }

    /**
     * 新增车辆以及车站列表信息
     *
     * @param train
     * @param stationList
     */
    @Override
    @Transactional
    public void addTrain(Train train, List<Station> stationList) {
        this.addTrain(train);
        if (stationList != null && stationList.size() != 0) {
            stationService.addStationList(stationList);
        }
    }

}
