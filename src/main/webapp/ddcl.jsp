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
<link href="js/colorBox/colorbox.css" rel="stylesheet">

<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${ctx}/js/colorBox/jquery.colorbox-min.js"></script>
<script type="text/javascript" src="${ctx}/js/workflow.js"></script>

<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath}";

	if(${empty sessionScope.user.id}){
		window.location.href="${ctx}/login.html"
	}
</script>

<script type="text/javascript">
$(function(){
	 $('.trace').click(graphTrace);
	
	$(".handle").click(function(){
		$("#colorBox form").attr("action","${ctx}/completeReportTask.do?id="+$(this).attr("name"));
		$("#colorBox form input[name=taskId]").val($(this).attr("tid"));
		showBox("#colorBox");
	});
	
	$(".handle_jgry").click(function(){
		$(".agree").attr("tid",$(this).attr("tid"));
		showBox("#colorBox_jgry");
	});
	
	var showBox = function(div){
		$.colorbox({
			inline : true,
			innerWidth:700,
			innerHeight:300,
			speed: 0,
			scrolling:false,
			overlayClose:false,
			opacity:0.8,
			/* 弹窗口的div,这个div是隐藏的 */
			href:div,
			close : "关闭"
		}); 
	}
	
	$(".agree").click(function(){
		window.location.href="${ctx}/completeTask.do?id="+$(this).attr("tid");
		console.log("agree");
	});
	$(".reject").click(function(){
		window.location.href="${ctx}/completeTask.do?id="+$(this).attr("tid");
	});
	
})

</script>

</head>
<body>
	<div class="inner">
		<div class="daohanglink" style="">
			<span class="daohang"></span> <span>调度处理</span>
		</div>
		<div class="well-content" style="border: 0px;">
			<table
				class="table table-striped table-bordered table-hover datatable">
				<thead>
					<tr>
						<th width="10%">案件名</th>
						<th width="15%">申请时间</th>
						<th width="20%">当前节点</th>
						<th width="20%">任务创建时间</th>
						<th width="20%">流程状态</th>
						<th width="20%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${todoList}" var="dispatch">
						<c:set var="task" value="${dispatch.task }" />
						<c:set var="pi" value="${dispatch.processInstance }" />
						
						<tr id="${dispatch.id }" tid="${task.id }">
							<td>${dispatch.proName}</td>
							<td>${dispatch.applyTime }</td>
							<td><a class="trace" href='#' pid="${pi.id }"
								title="点击查看流程图">${task.name }</a></td>
							<%--<td><a target="_blank" href='${ctx }/workflow/resource/process-instance?pid=${pi.id }&type=xml'>${task.name }</a></td> --%>
							<td>${task.createTime }</td>
							<td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V:
									${leave.processDefinition.version }</b></td>
							<td>
								<c:if test="${empty task.assignee }">
									<a class="claim"
										href="${ctx }/claimTask.do?id=${task.id}">签收</a>
								</c:if> 
								<c:if test="${not empty task.assignee and sessionScope.user.id=='SBRY'}">
									<a class="handle" name="${dispatch.id}" tid="${task.id }" href="#">办理</a>
								</c:if>
								<c:if test="${not empty task.assignee and sessionScope.user.id=='JGRY'}">
									<a class="handle_jgry" name="${dispatch.id}" tid="${task.id }" href="#">审批</a>
								</c:if>
								<c:if test="${not empty task.assignee and sessionScope.user.id=='SJRY'}">
									<a class="handle_jgry" name="${dispatch.id}" tid="${task.id }" href="#">审批</a>
								</c:if>
								<c:if test="${not empty task.assignee and sessionScope.user.id=='GDRY'}">
									<a class="handle_jgry" name="${dispatch.id}" tid="${task.id }" href="#">归档</a>
								</c:if>
								
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div style="display: none;">
		<div  id="colorBox">
			<form action="" method="post">
			<input type="hidden" name="taskId" value="">
				上报名称：<input type="text" name="reportName">
				上报理由：<input type="text" name="reportReason">
				<input type="submit" value="上报">
			</form>
		</div>
		
		<div  id="colorBox_jgry">
			<button class="agree" tid="">同意</button>
			<button class="reject" tid="">驳回</button>
		</div>
		
	</div>
</body>
</html>
