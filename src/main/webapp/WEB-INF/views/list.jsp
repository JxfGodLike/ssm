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
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-success">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                    新增
                </button>
                <button class="btn btn-danger">
                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                    批量删除
                </button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.id}</td>
                            <td>${emp.name}</td>
                            <td>${emp.gender == "M" ? "男" : "女"}</td>
                            <td>${emp.email}</td>
                            <td>${emp.departmentId}</td>
                            <td>
                                <button class="btn btn-success btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                第${pageInfo.currPage}页，每页${pageInfo.pageSize}条，总共${pageInfo.totalPage}页、${pageInfo.totalCount}条
            </div>
            <div class="col-md-8">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/emps?page=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?page=${pageInfo.prePage}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatePageNums}" var="pageNumber">
                            <c:if test="${pageNumber == pageInfo.currPage}">
                                <li class="active"><a href="#">${pageNumber}</a></li>
                            </c:if>
                            <c:if test="${pageNumber != pageInfo.currPage}">
                                <li><a href="${APP_PATH}/emps?page=${pageNumber}">${pageNumber}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?page=${pageInfo.nextPage}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <li><a href="${APP_PATH}/emps?page=${pageInfo.totalPage}">尾页</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>

</body>
</html>
