package com.example.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.example.entity.DepartmentEntity;
import org.apache.ibatis.annotations.Param;

public interface DepartmentDao extends BaseMapper<DepartmentEntity> {

    DepartmentEntity findByName(@Param("name") String name);
}
