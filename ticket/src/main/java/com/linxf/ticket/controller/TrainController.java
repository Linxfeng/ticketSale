package com.linxf.ticket.controller;

import com.linxf.common.vo.ResponseVo;
import com.linxf.ticket.utils.VerifyParamsUtil;
import com.linxf.ticket.vo.TrainVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

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
            //新增车辆
        } catch (Exception e) {
            log.error("【新增车辆】失败, {}", trainVo);
            log.error("TrainController.addTrain ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        return ResponseVo.success("新增车辆成功！");
    }
}
