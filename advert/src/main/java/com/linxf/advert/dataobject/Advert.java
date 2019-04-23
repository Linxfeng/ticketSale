package com.linxf.advert.dataobject;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Date;

/**
 * 广告
 *
 * @Author lintao
 * @Date 2019/3/31
 */
@Entity
@Data
public class Advert {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String title;//标题

    private String content;//内容

    private Date createTime;//创建时间

    private Integer del = 0; //是否有效，0有效，1失效
}
