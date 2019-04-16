package com.linxf.ticket.repository;

import com.linxf.ticket.dataobject.Station;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 车站Dao层
 *
 * @author lintao
 * @date 2019/4/16
 */
public interface StationRepository extends JpaRepository<Station, String> {
}
