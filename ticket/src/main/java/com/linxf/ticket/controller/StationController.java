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

}
