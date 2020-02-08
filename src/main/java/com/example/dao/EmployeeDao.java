package com.example.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.example.entity.EmployeeEntity;
import org.apache.ibatis.annotations.Param;

public interface EmployeeDao extends BaseMapper<EmployeeEntity> {


    EmployeeEntity findByName(@Param("name") String name);
}
