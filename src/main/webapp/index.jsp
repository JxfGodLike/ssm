<%--
  Created by IntelliJ IDEA.
  User: jxf
  Date: 2020/1/31
  Time: 7:51 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/jquery/jquery.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>


<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" placeholder="EmpName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" checked name="gender" value="M"/>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="F"/>女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="departmentId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="saveEmployee()" class="btn btn-success">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="empEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="edit_name"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_email" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="edit_gender" value="M"/>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="edit_gender" value="F"/>女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="edit_departmentId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="editEmployee($(this).attr('updId'))" class="btn btn-success update">更新</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button onclick="openEmpAddModal()" class="btn btn-success">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                新增
            </button>
            <button onclick="batchDel()" class="btn btn-danger">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                批量删除
            </button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all" /></th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 pageinfo">

        </div>
        <div class="col-md-8">
            <nav aria-label="Page navigation">
                <ul class="pagination">

                </ul>
            </nav>
        </div>
    </div>
    <script>
        let totalPages = 0;//总页数
        let currPage = 0;//当前页数
        let pageSize = 0;//每页条数
        let totalCount = 0;//总条数

        $(function(){
            buildAjax(1);
        });

        function buildAjax(page) {
            $.ajax({
                url: "${APP_PATH}/emps",
                type: 'get',
                dataType: 'json',
                data:{
                    "page": page
                },
                success: function (data) {
                    if(data.code == 0){
                        console.log(data);
                        let result = data.data;
                        $("tbody").empty();
                        $(".pagination").empty();
                        $.each(result.list,function (index,value) {
                            $("tbody").append(`
                                <tr>
                                    <td><input type="checkbox" class="check_item" id=${"${value.id}"} /></td>
                                    <td>${"${value.id}"}</td>
                                    <td>${"${value.name}"}</td>
                                    <td>${"${value.gender == 'M' ? '男' : '女'}"}</td>
                                    <td>${"${value.email}"}</td>
                                    <td>${"${value.departmentName}"}</td>
                                    <td>
                                        <button editId="${"${value.id}"}" class="btn btn-success btn-sm">
                                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                            编辑
                                        </button>
                                        <button delId="${"${value.id}"}" class="btn btn-danger btn-sm">
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                            删除
                                        </button>
                                    </td>
                                </tr>`);
                        });

                        currPage = result.currPage;
                        pageSize = result.pageSize;
                        totalPages = result.totalPages;
                        totalCount = result.totalCount;
                        $(".pageinfo").html(`第${"${result.currPage}"}页，每页${"${result.pageSize}"}条，总共${"${result.totalPage}"}页、${"${result.totalCount}"}条`);
                        $(".pagination").append(`<li class="first"><a>首页</a></li>`);
                        if(result.firstPage){
                            $(".first").addClass("disabled");
                        } else {
                            $(".first").click(function () {
                                buildAjax(1);
                            });
                        }
                        $(".pagination").append(`<li class="prev">
                                                    <a aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>`);
                        if(!result.hasPreviousPage){
                            $(".prev").addClass("disabled");
                        } else {
                            $(".prev").click(function () {
                                buildAjax(result.prePage);
                            });
                        }
                        $.each(result.navigatePageNums,function (index,value) {
                            let $li = $(`<li class="activity"><a>${"${value}"}</a></li>`);
                            if(result.currPage == value){
                                $li.addClass("active");
                            }
                            $(".pagination").append($li);
                            $li.click(function () {
                                buildAjax(value);
                            });
                        });
                        $(".pagination").append(`<li class="next">
                                                    <a aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>`);
                        if(!result.hasNextPage){
                            $(".next").addClass("disabled");
                        } else {
                            $(".next").click(function () {
                                buildAjax(result.nextPage);
                            });
                        }
                        $(".pagination").append(`<li class="last"><a>尾页</a></li>`);
                        if(result.lastPage){
                            $(".last").addClass("disabled");
                        } else {
                            $(".last").click(function () {
                                buildAjax(result.totalPage);
                            });
                        }

                    }
                },
                error: function (data) {
                    console.log(data.msg);
                }
            })
        }

        function openEmpAddModal() {
            $("#empAddModal form")[0].reset();
            $("#empAddModal form *").removeClass("has-error has-success");
            $.ajax({
                url: "${APP_PATH}/depts",
                type: 'get',
                dataType: 'json',
                async: false,
                success: function (data) {
                    console.log(data);
                    if(data.code == 0){
                        let list = data.data;
                        $("select").empty();
                        $.each(list,function (index,value) {
                            $("select").append(`<option value="${"${value.id}"}">${"${value.name}"}</option>`)
                        })
                    }
                },
                error: function (data) {
                    console.log(data.msg)
                }
            });
            $("#empAddModal").modal({
                backdrop: false
            });
        }

        function batchDel() {
            var empNames = [];
            var ids = [];
            $(".check_item:checked").each(function () {
                empNames.push($(this).parents("tr").find("td:eq(2)").html());
                ids.push($(this).attr("id"));
            });
            console.log(ids);
            if(confirm("确认删除["+ empNames +"]吗？")){
                $.ajax({
                    url: "${APP_PATH}/batchEmp",
                    type: "DELETE",
                    dataType: 'json',
                    headers: {
                        'Content-Type': 'application/json;charset=utf-8'
                    },
                    data: JSON.stringify(ids),
                    success: function (data) {
                        if(data.code == 0){
                            alert(data.msg);
                            buildAjax(currPage);
                        }
                    }
                })
            }
        }

        function saveEmployee(){


            let datas = {
                name: $("input[name='name']").val(),
                gender: $("input[name='gender']").val(),
                email: $("input[name='email']").val(),
                departmentId: $("select[name='departmentId']").val(),
            };
            if(!validate()){
                return false;
            }
            $.ajax({
                url: "${APP_PATH}/emp",
                type: 'POST',
                dataType: 'json',
                headers: {
                  'Content-Type': "application/json;charset=utf-8"
                },
                data: JSON.stringify(datas),
                success: function (data) {
                    if(data.code == 0){
                        console.log(data);
                        $("#empAddModal").modal('hide');
                        if(totalPages%10 === 1){
                            totalPages = totalPages + 1;
                        }
                        buildAjax(totalPages);
                    } else {
                        alert(data.msg)
                    }
                },
                error: function (data) {
                    console.log(data.msg)
                }
            })
        }

        function editEmployee(id){
            let datas = {
                id: id,
                name: $("#edit_name").html(),
                gender: $("input[name='edit_gender']").val(),
                email: $("#edit_email").val(),
                departmentId: $("#edit_departmentId").val(),
            };
            $.ajax({
                url: "${APP_PATH}/emp",
                type: 'PUT',
                dataType: 'json',
                headers: {
                    'Content-Type': "application/json;charset=utf-8"
                },
                data: JSON.stringify(datas),
                success: function (data) {
                    if(data.code == 0){
                        console.log(data);
                        $("#empEditModal").modal('hide');
                        buildAjax(currPage);
                    } else {
                        alert(data.msg)
                    }
                },
                error: function (data) {
                    console.log(data.msg)
                }
            })
        }

        function validate() {
            var username = $("input[name='name']").val();
            var email = $("input[name='email']").val();
            $("input[name='name']").parent().removeClass("has-error has-success");
            $("input[name='email']").parent().removeClass("has-error has-success");
            if(username == ''){
                $("input[name='name']").parent().addClass("has-error");
                $("input[name='name']").next("span").html("用户名不能为空");
                return false;
            } else {
                $("input[name='name']").parent().addClass("has-success");
                $("input[name='name']").next("span").html("");
            }
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                $("input[name='email']").parent().addClass("has-error");
                $("input[name='email']").next("span").html("邮箱格式不正确");
                return false;
            } else {
                $("input[name='email']").parent().addClass("has-success");
                $("input[name='email']").next("span").html("");
            }
            return true;
        }

        $(document).on('click','td >button:first-of-type',function () {
            var id = $(this).attr("editId");
            $(".update").attr("updId",id);
            $.ajax({
                url: '${APP_PATH}/emp/' + id,
                type: 'get',
                success: function (data) {
                    if(data.code == 0){
                        console.log(data);
                        var emp = data.data;
                        $("#edit_name").html(emp.name);
                        $("#edit_email").val(emp.email);
                        $("input[name='edit_gender'][value='"+ emp.gender +"']").prop("checked","checked");
                        $.ajax({
                            url: "${APP_PATH}/depts",
                            type: 'get',
                            dataType: 'json',
                            success: function (data) {
                                console.log(data);
                                if(data.code == 0){
                                    let list = data.data;
                                    $("select").empty();
                                    $.each(list,function (index,value) {
                                        $("select").append(`<option value="${"${value.id}"}">${"${value.name}"}</option>`);
                                    });
                                    $("select").val(emp.departmentId);
                                }
                            },
                            error: function (data) {
                                console.log(data.msg)
                            }
                        });
                    }
                }
            });


            $("#empEditModal").modal({
                backdrop: false
            })
        });

        $(document).on('click','td >button:last-of-type',function () {
            var id = $(this).attr("delId");
            var empName = $(this).parents("tr").find("td:eq(2)").html();
            if(confirm("确认删除["+ empName +"]吗？")){
                $.ajax({
                   url: "${APP_PATH}/emp/"+id,
                   type: 'DELETE',
                   success: function (data) {
                       if(data.code == 0){
                           alert(data.msg);
                           buildAjax(currPage);
                       }
                   }
                });
            }

        });

        $("#check_all").click(function () {

            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        $(document).on('click','.check_item',function () {

            $("#check_all").prop("checked",$(".check_item:checked").length === $(".check_item").length);
        })


    </script>

</div>

</body>
</html>
