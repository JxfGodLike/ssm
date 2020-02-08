package com.example.service.impl;

import com.baomidou.mybatisplus.service.IService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.example.dao.EmployeeDao;
import com.example.entity.EmployeeEntity;
import com.example.service.EmployeeService;
import org.springframework.stereotype.Service;

@Service("employeeService")
public class EmployeeServiceImpl extends ServiceImpl<EmployeeDao,EmployeeEntity> implements EmployeeService {
}
