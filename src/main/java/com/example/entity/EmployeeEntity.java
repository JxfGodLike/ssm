package com.example.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;

@TableName(value = "tb_emp")
@Data
public class EmployeeEntity {

    @TableId
    private Integer id;
    private String name;
    private String gender;
    private String email;
    private Integer departmentId;

    @TableField(exist = false)
    private String departmentName;

}
