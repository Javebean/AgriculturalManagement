<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx" />

<script type="text/javascript" src="${ctx}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#deployprocess").click(function(){
		$.ajax({
			url:"${ctx}/deployProcess.do",
			type:"post",
			dataType:"text",
			success:function(data){
				window.location.href="${ctx}/process-list.do";
			},
			error:function(data){
				console.log(data);
			}
			
			
		});
	});
})

</script>

</head>
<body>


<button id="deployprocess">部署流程</button>

<table width="100%" border="1">
		<thead>
			<tr>
				<th>ID</th>
				<th>DID</th>
				<th>名称</th>
				<th>KEY</th>
				<th>版本号</th>
				<th>XML</th>
				<th>图片</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${proDeList}" var="process">
				<tr>
					<td>${process.id }</td>
					<td>${process.deploymentId }</td>
					<td>${process.name }</td>
					<td>${process.key }</td>
					<td>${process.version }</td>
					<td><a target="_blank" href='${ctx }/loadByDeployment.do?deploymentId=${process.deploymentId}&resourceName=${process.resourceName }'>${process.resourceName }</a></td>
					<td><a target="_blank" href='${ctx }/loadByDeployment.do?deploymentId=${process.deploymentId}&resourceName=${process.diagramResourceName }'>${process.diagramResourceName }</a></td>
					<td><a href='${ctx }/deleteProcess.do?deploymentId=${process.deploymentId}'>删除</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>