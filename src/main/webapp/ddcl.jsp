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
<link href="js/colorBox/colorbox.css" rel="stylesheet">

<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<%-- <script type="text/javascript" src="${ctx}/js/jquery-1.11.3.min.js"></script> --%>
<link href="js/jui/themes/redmond/jquery-ui-1.8.16.custom.css" rel="stylesheet">
<link href="js/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jui/jquery-ui.min.js"></script>
<script src="${ctx }/js/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx }/js/jquery.outerhtml.js" ></script>
<script type="text/javascript" src="${ctx}/js/workflow.js"></script>
<script type="text/javascript" src="${ctx}/js/colorBox/jquery.colorbox-min.js"></script>


<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath}";

	if(${empty sessionScope.user.id}){
		window.location.href="${ctx}/login.html"
	}
</script>

<script type="text/javascript">
$(function(){
	 $('.trace').click(graphTrace);
	$(".handle_recollect").click(function(){
		var tid = $(this).attr("tid");
		var pid = $(this).attr("name");
		$("#re_collect input[name=tid]").val(tid);
		$("#re_collect input[name=pid]").val(pid);
		$.ajax({
			url:"${ctx}/getProduce.do",
			dataType:"json",
			data:{id:$(this).attr("name")},
			type:"post",
			success:function(data){
				$("#re_collect input[name=proName]").val(data.proName);
				$("#re_collect input[name=proType]").val(data.proType);
				$("#re_collect input[name=proPlace]").val(data.proPlace);
				
				
				$("#re_collect select option").each(function(){
					if($(this).text()==data.proLev){
						$(this).attr("selected","selected");
					}
					
				});
			}
		});
		showBox("#re_collect");
		
	});
	 
	$(".handle").click(function(){
		$.ajax({
			url:"${ctx}/getProduce.do",
			dataType:"json",
			data:{id:$(this).attr("name")},
			type:"post",
			success:function(data){
				$(".proName").text(data.proName);
				$(".proType").text(data.proType);
				$(".proPlace").text(data.proPlace);
				$(".proLev").text(data.proLev);
			}
		});
		
		$("#colorBox form").attr("action","${ctx}/completeReportTask.do?id="+$(this).attr("name"));
		$("#colorBox form input[name=taskId]").val($(this).attr("tid"));
		showBox("#colorBox");
	});
	
	$(".handle_jgry").click(function(){
		var ry = $(this).attr("people");
		console.log(ry+"**");
		if(ry!=""&&ry!=undefined){
			$(".agree").hide();
			$(".reject").hide();
			var pid = $(this).attr("name");
			var tid = $(this).attr("tid");
			$(".save").attr("pid",pid);
			$(".save").attr("tid",tid);
			
		}else{
			$(".save").hide();
		}
		/* 设置为那个节点的审批 */
		var assignee = $(this).attr("assignee");
		$(".agree").attr("assignee",assignee);
		$(".reject").attr("assignee",assignee);
		
		$.ajax({
			url:"${ctx}/getProduce.do",
			data:{id:$(this).attr("name")},
			dataType:"json",
			type:"post",
			success:function(data){
				$(".proName").text(data.proName);
				$(".proType").text(data.proType);
				$(".proPlace").text(data.proPlace);
				$(".proLev").text(data.proLev);
				$(".reportName").text(data.reportName);
				$(".reportReason").text(data.reportReason);
			}
		});
		
		
		$(".agree").attr("tid",$(this).attr("tid"));
		$(".reject").attr("tid",$(this).attr("tid"));
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
		window.location.href="${ctx}/completeTask.do?id="+$(this).attr("tid")+"&assignee="+$(this).attr("assignee")+"&sta=true";
		console.log("agree");
	});
	$(".reject").click(function(){
		window.location.href="${ctx}/completeTask.do?id="+$(this).attr("tid")+"&assignee="+$(this).attr("assignee")+"&sta=false";
	});
	$(".save").click(function(){
		window.location.href="${ctx}/completeSaveFile.do?id="+$(this).attr("tid")+"&pid="+$(this).attr("pid");
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
						<th width="20%">当前节点</th>
						<th width="15%">申请时间</th>
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
							<td><a class="trace" href='#' pid="${pi.id }"
								title="点击查看流程图">${task.name }</a></td>
							<td>${dispatch.applyTime }</td>
							<%--<td><a target="_blank" href='${ctx }/workflow/resource/process-instance?pid=${pi.id }&type=xml'>${task.name }</a></td> --%>
							
							<td>
								<fmt:formatDate value="${task.createTime }" pattern="yyyy-MM-dd HH:mm:ss.S" />
							</td>
							
							<td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V:
									${dispatch.processDefinition.version }</b></td>
							<td>
								<c:if test="${empty task.assignee }">
									<a class="claim"
										href="${ctx }/claimTask.do?id=${task.id}">签收</a>
								</c:if> 
								<c:if test="${not empty task.assignee and sessionScope.user.id=='SBRY'}">
									<a class="handle" name="${dispatch.id}" tid="${task.id }" href="#">办理</a>
								</c:if>
								<c:if test="${not empty task.assignee and sessionScope.user.id=='CJRY'}">
									<a class="handle_recollect" name="${dispatch.id}" tid="${task.id }" href="#">重新采集</a>
								</c:if>
								<c:if test="${not empty task.assignee and sessionScope.user.id=='JGRY'}">
									<a class="handle_jgry" name="${dispatch.id}" tid="${task.id }" href="#" assignee="${task.assignee }">审批</a>
								</c:if>
								<c:if test="${not empty task.assignee and sessionScope.user.id=='SJRY'}">
									<a class="handle_jgry" name="${dispatch.id}" tid="${task.id }" href="#" assignee="${task.assignee }">审批</a>
								</c:if>
								<c:if test="${not empty task.assignee and sessionScope.user.id=='GDRY'}">
									<a class="handle_jgry" people="gdry" name="${dispatch.id}" tid="${task.id }" href="#">归档</a>
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
			采集信息:
				<br>
			产品名称:<span class="proName"></span>
				<br>
			产品类型:<span class="proType"></span>
				<br>
			产  地:<span class="proPlace"></span>
				<br>
			产品等级:<span class="proLev"></span>
				<br>
		
			<form action="" method="post">
			<input type="hidden" name="taskId" value="">
				上报名称：<input type="text" name="reportName">
				上报理由：<input type="text" name="reportReason">
				<input type="submit" value="上报">
			</form>
		</div>
		
		<div  id="colorBox_jgry">
			采集信息:
				<br>
			产品名称:<span class="proName"></span>
				<br>
			产品类型:<span class="proType"></span>
				<br>
			产  地:<span class="proPlace"></span>
				<br>
			产品等级:<span class="proLev"></span>
				<hr>
			上报名称：<span class="reportName"></span>
				<br>
			上报理由：<span class="reportReason"></span>
			<br><br>
			<hr>
			<button class="agree" tid="" assignee="">同意</button>
			<button class="reject" tid="" assignee="">驳回</button>
			<button class="save" tid="" pid="">归档</button>
			
		</div>
		
		<div id="re_collect">
			<form action="${ctx}/completeReCollect.do" method="post">
				<input type="hidden" name="tid" value="">
				<input type="hidden" name="pid" value="">
                    <div class="form_list"><label class="lable_title">产品名称</label><input class="form_input" type="text" name="proName"/></div>
					<div class="form_list"><label class="lable_title">产品类型</label><input class="form_input" type="text" name="proType"/></div>
					<div class="form_list"><label class="lable_title">产&nbsp;&nbsp;地</label><input class="form_input" type="text" name="proPlace"/></div>
					 <div class="form_list"><label class="lable_title">产品等级</label>
                            <select style="width:250px; height:25px; margin-left:15px;" name="proLev">
                              <option selected="selected">初级农产品</option>
                              <option>初级加工农产品</option>
							  <option>优级农产品</option>
                            </select>
                     </div>
               
					</br>
					</br>
                     <div class="form_list"><input type="submit" class="submit" value="&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;"></div>
				</form>
		</div>
		
	</div>
</body>
</html>
