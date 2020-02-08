package com.example.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.example.common.utils.R;
import com.example.entity.DepartmentEntity;
import com.example.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;
    @RequestMapping("/depts")
    public R list(){
        List<DepartmentEntity> list = departmentService.selectList(new EntityWrapper<DepartmentEntity>());
        return R.ok(list);
    }
}
