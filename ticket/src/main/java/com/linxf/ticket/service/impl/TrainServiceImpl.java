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
import java.util.Optional;
import java.util.stream.Collectors;

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

    /**
     * 获取列车tid列表
     *
     * @return
     */
    @Override
    public List<String> listTid() {
        List<Train> trainList = trainRepository.findAll();
        if (trainList == null || trainList.size() == 0) return null;
        return trainList.stream().map(Train::getTid).collect(Collectors.toList());
    }

    /**
     * 根据tid查询车辆信息
     *
     * @param tid
     * @return
     */
    @Override
    public Train getTrainInfo(String tid) {
        Optional<Train> optional = trainRepository.findById(tid);
        if (!optional.isPresent()) return null;
        return optional.get();
    }

    /**
     * 根据车辆类型查询车辆列表
     *
     * @param trainType
     * @return
     */
    @Override
    public List<Train> listTrainByType(String trainType) {
        return trainRepository.findAllByTrainType(trainType);
    }

    /**
     * 更新车辆信息
     *
     * @param train
     */
    @Override
    public void updateTrainInfo(Train train) {
        trainRepository.save(train);
    }

}
