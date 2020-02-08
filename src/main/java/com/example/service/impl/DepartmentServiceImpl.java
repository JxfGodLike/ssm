package com.example.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.example.dao.DepartmentDao;
import com.example.entity.DepartmentEntity;
import com.example.service.DepartmentService;
import org.springframework.stereotype.Service;

@Service("departmentService")
public class DepartmentServiceImpl extends ServiceImpl<DepartmentDao, DepartmentEntity> implements DepartmentService {
}
