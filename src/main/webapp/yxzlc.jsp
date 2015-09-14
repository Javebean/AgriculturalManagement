<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
<meta charset="utf-8">
<title>农业行政执法管理系统</title>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="js/jui/themes/redmond/jquery-ui-1.8.16.custom.css" rel="stylesheet">
<link href="js/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jui/jquery-ui.min.js"></script>
<script src="${ctx }/js/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx }/js/jquery.outerhtml.js" ></script>
<script type="text/javascript" src="${ctx}/js/workflow.js"></script>

<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath}";
	if(${empty sessionScope.user.id}){
		window.location.href="${ctx}/login.html"
	}
	$(function(){
		$('.trace').click(graphTrace);
		
	}) 

</script>

</head>
<body>
	<div class="inner">
		<div class="daohanglink" style="">
			<span class="daohang"></span> <span>运行中流程</span>
		</div>
		<div class="well-content" style="border: 0px;">
			<table
				class="table table-striped table-bordered table-hover datatable">
				<thead>
					<tr>
						<th width="10%">案件名</th>
						<th width="15%">启动时间</th>
						<th width="20%">当前节点</th>
						<th width="20%">流程状态</th>
						<th width="20%">当前处理人</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${runningList }" var="dispatch">
						<c:set var="task" value="${dispatch.task }" />
						<c:set var="pi" value="${dispatch.processInstance }" />
						<tr id="${dispatch.id }" tid="${task.id }">

							<td>${task.name}</td>
							<td>${dispatch.applyTime}</td>
							<td><a class="trace" href='#' pid="${pi.id }"
								title="点击查看流程图">${task.name }</a></td>

							<td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V:
									${dispatch.processDefinition.version }</b></td>
							<td>${task.assignee }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
