package com.linxf.ticket.controller;

import com.linxf.common.vo.ResponseVo;
import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.service.StationService;
import com.linxf.ticket.vo.TrainVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 车站管理
 *
 * @author lintao
 * @date 2019/4/22
 */
@Slf4j
@RestController
@RequestMapping("/station")
public class StationController {

    @Autowired
    private StationService stationService;

    /**
     * 根据tid查询车站列表信息
     *
     * @param tid
     * @return
     */
    @PostMapping("/stationInfo")
    public ResponseVo stationInfo(String tid, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            Assert.notNull(tid, "参数不能为空！");
            List<Station> stationList = stationService.findListByTid(tid);
            if (stationList == null || stationList.size() == 0)
                return ResponseVo.noDataFailed("未查询到该列车的站点信息！");
            TrainVo trainVo = new TrainVo();
            trainVo.setStationList(stationList);
            return ResponseVo.success("查询成功！", trainVo);
        } catch (Exception e) {
            log.error("StationController.stationInfo ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 修改车站信息
     *
     * @param trainVo
     * @return
     */
    @PostMapping("/updateStation")
    public ResponseVo updateStation(TrainVo trainVo, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            Assert.notNull(trainVo, "参数不能为空！");
            Assert.notNull(trainVo.getStationList(), "参数不能为空！");
            List<Station> stationList = trainVo.getStationList();
            for (Station station : stationList) { //车站列表逐条更新
                if (!StringUtils.isEmpty(station.getId())) {
                    //先查出该条车站信息
                    Station stationNew = stationService.findStationById(station.getId());
                    if (stationNew == null)
                        return ResponseVo.noDataFailed("未查询到该列车的站点信息！");
                    if (station.getName1() != null)
                        stationNew.setName1(station.getName1());
                    if (station.getTime1() != null)
                        stationNew.setTime1(station.getTime1());
                    if (station.getName2() != null)
                        stationNew.setName2(station.getName2());
                    if (station.getTime2() != null)
                        stationNew.setTime2(station.getTime2());
                    if (station.getTicket() != null)
                        stationNew.setTicket(station.getTicket());
                    if (station.getMoney() != null)
                        stationNew.setMoney(station.getMoney());
                    //修改该条车站的信息
                    stationService.updateStationInfo(stationNew);
                }
            }
            return ResponseVo.success("操作成功！");
        } catch (Exception e) {
            log.error("StationController.updateStation ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

}
