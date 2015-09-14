<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
						<th width="10%">启动时间</th>
						<th width="10%">案件名</th>
						<th width="15%">启动时间</th>
						<th width="20%">案件类型</th>
						<th width="20%">案件级别</th>
						<th width="20%">流程启动时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${finishedList }" var="dispatch">
						<c:set var="hpi" value="${dispatch.historicProcessInstance }" />
						<tr id="${dispatch.id }" tid="${task.id }">
							<td>${dispatch.applyTime }</td>
							<td>${dispatch.proName }</td>
							<td>${dispatch.proType }</td>
							<td>${dispatch.proPlace }</td>
							<td>${dispatch.proLev }</td>
							<td>${hpi.startTime }</td>
							<td>${hpi.endTime }</td>
							<td>${hpi.deleteReason }</td>
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
