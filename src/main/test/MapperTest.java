import com.example.dao.DepartmentDao;
import com.example.dao.EmployeeDao;
import com.example.entity.DepartmentEntity;
import com.example.entity.EmployeeEntity;
import com.example.service.DepartmentService;
import com.example.service.EmployeeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    DepartmentService departmentService;

    @Resource
    DepartmentDao departmentDao;

    @Test
    public void testCRUD(){

//        DepartmentEntity departmentEntity = new DepartmentEntity();
//        departmentEntity.setName("天地会");
//        departmentService.insert(departmentEntity);
        List<EmployeeEntity> employeeEntityList = new ArrayList<>();
        for (int i = 0; i < 1000; i++) {
            String uuid = UUID.randomUUID().toString().substring(0,5) + i;
            EmployeeEntity employeeEntity = new EmployeeEntity();
            employeeEntity.setName(uuid);
            employeeEntity.setGender("M");
            employeeEntity.setEmail(uuid+"@qq.com");
            employeeEntity.setDepartmentId(1);

            employeeEntityList.add(employeeEntity);
        }

        employeeService.insertBatch(employeeEntityList);

    }
}
