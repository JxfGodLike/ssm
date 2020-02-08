package com.example.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import lombok.Data;

@TableName(value = "tb_dept")
@Data
public class DepartmentEntity {
    @TableId
    private Integer id;
    private String name;
}
