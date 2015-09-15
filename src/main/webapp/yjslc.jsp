<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>农业行政执法管理系统</title>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<script type="text/javascript">
	if(${empty sessionScope.user.id}){
		window.location.href="${pageContext.request.contextPath}/login.html"
	}

</script>

</head>
<body>
	<div class="inner">
		<div class="daohanglink" style="">
			<span class="daohang"></span> <span>已完成调度</span>
		</div>
		<div class="well-content" style="border: 0px;">
			<table
				class="table table-striped table-bordered table-hover datatable">
				<thead>
					<tr>
						<th >农产品名</th>
						<th >产品类型</th>
						<th >产品产地</th>
						<th >产品等级</th>
						<th >申请时间</th>
						<th >流程启动时间</th>
						<th >流程结束时间</th>
						<th >版本号</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${finishedList }" var="dispatch">
						<c:set var="hpi" value="${dispatch.historicProcessInstance }" />
						<tr id="${dispatch.id }" tid="${task.id }">
							<td>${dispatch.proName }</td>
							<td>${dispatch.proType }</td>
							<td>${dispatch.proPlace }</td>
							<td>${dispatch.proLev }</td>
							<td>${dispatch.applyTime }</td>
							<td>
								<fmt:formatDate value="${hpi.startTime }" pattern="yyyy-MM-dd HH:mm:ss.S" />
							</td>
							<td>
								<fmt:formatDate value="${hpi.endTime }" pattern="yyyy-MM-dd HH:mm:ss.S" />
							</td>
							<td><b title='流程版本号'>V:
									${dispatch.processDefinition.version }</b></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
