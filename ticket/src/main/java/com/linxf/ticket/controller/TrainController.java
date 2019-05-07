package com.linxf.ticket.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.linxf.common.utils.JsonUtil;
import com.linxf.common.utils.RedisCacheUtil;
import com.linxf.common.utils.TimeUtil;
import com.linxf.common.vo.ResponseVo;
import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.dataobject.Train;
import com.linxf.ticket.service.StationService;
import com.linxf.ticket.service.TrainService;
import com.linxf.ticket.utils.VerifyParamsUtil;
import com.linxf.ticket.vo.TrainVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

/**
 * 列车Controller
 *
 * @author lintao
 * @date 2019/4/15
 */
@Slf4j
@RestController
@RequestMapping("/train")
public class TrainController {

    @Autowired
    private TrainService trainService;

    @Autowired
    private StationService stationService;

    @Autowired
    private RedisCacheUtil redisCacheUtil;

    /**
     * 新增车辆
     *
     * @param trainVo
     * @return
     */
    @PostMapping("/addTrain")
    public ResponseVo addTrain(TrainVo trainVo, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            new VerifyParamsUtil().validTrainVo(trainVo);//校验参数
            //封装车辆信息
            Train train = new Train();
            BeanUtils.copyProperties(trainVo, train);
            train.setSaleSum(0);
            train.setDel(0);
            List<Station> stationList = trainVo.getStationList();
            if (stationList != null && stationList.get(0) != null) { //有车站信息
                Time startTime = stationList.get(0).getTime1();
                Time endTime = stationList.get(stationList.size() - 1).getTime2();
                String driveTime = String.valueOf(TimeUtil.diffHour(startTime, endTime));
                train.setDriveTime(driveTime);//车程耗时，单位：小时
                train.setStationSum(stationList.size() + 1);
            } else { //无车站信息
                train.setDriveTime("0");
                train.setStationSum(0);
            }
            //添加车辆及车站信息
            trainService.addTrain(train, stationList);
        } catch (Exception e) {
            log.error("【新增车辆】失败, {}", trainVo);
            log.error("TrainController.addTrain ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        return ResponseVo.success("新增车辆成功！");
    }

    /**
     * 获取车辆tid列表
     *
     * @return
     */
    @GetMapping("/listTid")
    public ResponseVo listTid(HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            List<String> tidList = trainService.listTid();
            if (tidList == null) return ResponseVo.noDataFailed("未查询到车辆信息");
            return ResponseVo.success("查询成功！", tidList);
        } catch (Exception e) {
            log.error("TrainController.listTid ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 根据tid获取车辆信息
     *
     * @param tid
     * @return
     */
    @PostMapping("/trainInfo")
    public ResponseVo trainInfo(String tid, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        Assert.notNull(tid, "参数tid不能为空！");
        try {
            //获取车辆信息
            Train train = trainService.getTrainInfo(tid);
            if (train == null) return ResponseVo.noDataFailed("未查询到该车辆信息");
            //查询该列车的车站列表
            List<Station> stationList = stationService.findListByTid(train.getTid());
            //封装参数，返回vo
            TrainVo trainVo = new TrainVo();
            BeanUtils.copyProperties(train, trainVo);
            trainVo.setStationList(stationList);
            return ResponseVo.success("查询成功！", trainVo);
        } catch (Exception e) {
            log.error("TrainController.trainInfo ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 根据车辆类型查询车辆列表
     *
     * @param trainType
     * @return
     */
    @PostMapping("/listTrainByType")
    public ResponseVo listTrainByType(String trainType, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        Assert.notNull(trainType, "参数不能为空！");
        try {
            List<Train> trainList = trainService.listTrainByType(trainType);
            return ResponseVo.success("查询成功！", trainList);
        } catch (Exception e) {
            log.error("TrainController.listTrainByType ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 修改车辆座位类型
     *
     * @param trainVo
     * @return
     */
    @PostMapping("/updateTrainType")
    public ResponseVo updateTrainType(TrainVo trainVo, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        Assert.notNull(trainVo, "参数不能为空！");
        Assert.notNull(trainVo.getTid(), "参数不能为空！");
        try {
            //获取车辆信息
            Train train = trainService.getTrainInfo(trainVo.getTid());
            if (train == null) return ResponseVo.noDataFailed("未查询到该车辆信息");
            if (!StringUtils.isEmpty(trainVo.getSeatType1()) ||
                    !StringUtils.isEmpty(trainVo.getMoney1())) { // 修改座位类型1
                train.setSeatType1(trainVo.getSeatType1());
                train.setMoney1(trainVo.getMoney1());
            }
            if (!StringUtils.isEmpty(trainVo.getSeatType2()) ||
                    !StringUtils.isEmpty(trainVo.getMoney2())) { // 修改座位类型2
                train.setSeatType2(trainVo.getSeatType2());
                train.setMoney2(trainVo.getMoney2());
            }
            if (!StringUtils.isEmpty(trainVo.getSeatType3()) ||
                    !StringUtils.isEmpty(trainVo.getMoney3())) { // 修改座位类型3
                train.setSeatType3(trainVo.getSeatType3());
                train.setMoney3(trainVo.getMoney3());
            }
            //更新车辆信息
            trainService.updateTrainInfo(train);
            return ResponseVo.success("修改成功！");
        } catch (Exception e) {
            log.error("TrainController.updateTrainType ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 根据出发站和到达站查询直达路线
     *
     * @param name1
     * @param name2
     * @return
     */
    @PostMapping("/goSearch")
    public ResponseVo goSearch(String name1, String name2, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            Assert.notNull(name1, "出发城市不能为空！");
            Assert.notNull(name2, "到达城市不能为空！");

            List<TrainVo> trainList = new ArrayList<>();//返回结果
            String gokey = name1 + "-" + name2 + "-直达";//缓存的key

            // 从缓存中获取直达车列表，若不存在则去数据库查
            String trainList1 = redisCacheUtil.getValue(gokey);
            if (!StringUtils.isEmpty(trainList1) && !"null".equals(trainList1)) {// 缓存中有,从缓存中获取
                trainList = (List<TrainVo>) JsonUtil.jsonToObject(trainList1,
                        new TypeReference<List<TrainVo>>() {
                        });
            } else {// 缓存中没有,从数据库查
                trainList = stationService.goStraightRoute(name1, name2);
                if (trainList == null || trainList.size() == 0)
                    return ResponseVo.noDataFailed("未查询到符合条件的直达路线");
                // 将查询结果存入缓存
                redisCacheUtil.setValue(gokey, JsonUtil.toJson(trainList));
            }
            return ResponseVo.success("查询成功！", trainList);
        } catch (Exception e) {
            log.error("TrainController.goSearch ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }


}
