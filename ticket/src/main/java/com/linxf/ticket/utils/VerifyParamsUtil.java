package com.linxf.ticket.utils;

import com.linxf.common.utils.UUIDUtil;
import com.linxf.ticket.dataobject.Station;
import com.linxf.ticket.vo.TrainVo;
import org.springframework.util.Assert;

import java.util.List;

/**
 * 校验参数工具类
 *
 * @author lintao
 * @date 2019/4/15
 */
public class VerifyParamsUtil {

    /**
     * 校验车辆信息vo表单
     */
    public void validTrainVo(TrainVo trainVo) {
        Assert.notNull(trainVo, "参数不能为空！");
        Assert.notNull(trainVo.getTid(), "车辆编号不能为空！");
        Assert.notNull(trainVo.getTrainType(), "车辆类型不能为空！");
        //校验车站列表信息-这里顺便把id赋值进去
        List<Station> stationList = trainVo.getStationList();
        if (stationList != null && stationList.size()>0) {
            for (Station station : stationList) {
                Assert.notNull(station.getName1(), "出发站点不能为空！");
                Assert.notNull(station.getTime1(), "出发时间不能为空！");
                Assert.notNull(station.getName2(), "抵达站点不能为空！");
                Assert.notNull(station.getTime2(), "抵达时间不能为空！");
                station.setId(UUIDUtil.get16UUID());
                station.setTid(trainVo.getTid());
            }
        }
    }

}
