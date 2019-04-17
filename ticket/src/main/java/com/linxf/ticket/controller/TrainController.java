package com.linxf.ticket.controller;

import com.linxf.common.utils.TimeUtil;
import com.linxf.common.vo.ResponseVo;
import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.dataobject.Train;
import com.linxf.ticket.service.TrainService;
import com.linxf.ticket.utils.VerifyParamsUtil;
import com.linxf.ticket.vo.TrainVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.sql.Time;
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
                Time endTime = stationList.get(stationList.size()-1).getTime2();
                String driveTime = String.valueOf(TimeUtil.diffHour(startTime, endTime));
                train.setDriveTime(driveTime);//车程耗时，单位：小时
                train.setStationSum(stationList.size()+1);
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
            Train train = trainService.getTrainInfo(tid);
            if (train == null) return ResponseVo.noDataFailed("未查询到该车辆信息");
            return ResponseVo.success("查询成功！", train);
        } catch (Exception e) {
            log.error("TrainController.trainInfo ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }




}
