package com.linxf.advert.dataobject;

import lombok.Data;

import javax.persistence.Entity;

/**
 * 广告
 *
 * @Author lintao
 * @Date 2019/3/31
 */
@Entity
@Data
public class Advert {

    Integer del = 0; //是否有效，0有效，1失效
}
