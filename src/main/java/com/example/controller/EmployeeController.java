package com.example.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.example.common.utils.PageUtils;
import com.example.common.utils.R;
import com.example.entity.EmployeeEntity;
import com.example.service.DepartmentService;
import com.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


@RestController
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/emps")
    public R getEmpList(
            @RequestParam(value = "page",defaultValue = "1") Integer page){
        Page<EmployeeEntity> employeeEntityPage = employeeService.selectPage(new Page<>(page, 10));
        employeeEntityPage.getRecords().forEach(e ->{
            e.setDepartmentName(departmentService.selectById(e.getDepartmentId()).getName());
        });
        return R.ok(new PageUtils(employeeEntityPage,10));
    }
    @PostMapping("/emp")
    public R save(@RequestBody EmployeeEntity employeeEntity){

        EmployeeEntity employeeEntity1 = employeeService.selectOne(new EntityWrapper<EmployeeEntity>()
                .eq("name",employeeEntity.getName()));
        if(employeeEntity1!=null){
            return R.error("用户名已存在，请重新输入");
        }
        employeeService.insert(employeeEntity);
        return R.ok();
    }

    @GetMapping("emp/{id}")
    public R getEmp(@PathVariable("id") Integer id){
        EmployeeEntity employeeEntity = employeeService.selectById(id);
        return R.ok(employeeEntity);
    }

    @PutMapping("/emp")
    public R updateEmp(@RequestBody EmployeeEntity formEntity){

        employeeService.updateById(formEntity);
        return R.ok();
    }

    @DeleteMapping("/emp/{id}")
    public R delEmp(@PathVariable("id") Integer id){
        employeeService.deleteById(id);
        return R.ok("删除成功");
    }

    @DeleteMapping("/batchEmp")
    public R batchDelEmp(@RequestBody Integer[] ids){
        employeeService.deleteBatchIds(Arrays.asList(ids));
        return R.ok("删除成功");
    }



//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "page",defaultValue = "1") Integer page, Model model){
//        Page<EmployeeEntity> employeeEntityPage = employeeService.selectPage(new Page<>(page, 10));
//
//        model.addAttribute("pageInfo", new PageUtils(employeeEntityPage,10));
//
//        return "list";
//    }
}
