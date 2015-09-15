<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>农业行政执法管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/stylesheet.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="icon/font-awesome.css" rel="stylesheet">
<script type="text/javascript">
	if(${empty sessionScope.user.id}){
		window.location.href="${pageContext.request.contextPath}/login.html"
	}

</script>
<script type="text/javascript">
	function getclassname(obj) {
		if (document.getElementsByClassName('link_onclick').length == 0) {
			obj.className = 'link_onclick';
			obj.id = 'link_onclick';
		} else {
			var obj1 = document.getElementById('link_onclick');
			obj1.className = '111';
			obj1.id = '1';
			obj.className = 'link_onclick';
			obj.id = 'link_onclick';
		}
	}
	
	$(function(){
		console.log("${group.id}");
		var groupId = "${group.id}";
		if(groupId=="collector"){
			$("a[name=deal]").hide();
		}else{
			$("a[name=deploy]").hide();
			$("a[name=startPro]").hide();
		}
		
		/* $("a[name=deploy]").click(function(){
			$.post("process-list.do");
			return false;
		}); */
		
	})
</script>
	<style>
	body
	{
		overflow-x:hidden;
		overflow-y:auto;
	}
	body,html
	{
	height:100%;
	margin:0; 
	}
	</style>

</head>
<body>
	<header class="dark_grey">
		<div class="top">
			<div class="logo">
				<h1>农业行政执法管理系统</h1>
			</div>
			<div class="login">
				<a href="logout.do"><img src="image/login.png" /></a>
			</div>
			<div class="username">欢迎您：${user.id }</div>
			<div class="user" id="logout">
				<img src="image/user.png" />
			</div>
		</div>
	</header>
	
	<div id="main_navigation" class="dark_navigation">
		
			<ul class="main">
				<li>
				<a></a>
				</li>

				<li>
				<a href="welcome.html" target="right" onClick="getclassname(this)"><i class="icon-home"></i>&nbsp;&nbsp;首页</a>
				</li>
				<li>
				<a name="deploy" href="process-list.do" target="right" onClick="getclassname(this)"><i class="icon-filter"></i>&nbsp;&nbsp;部署流程</a>
				</li>
				<li>
				<a name="startPro" href="caiji.jsp" target="right" onClick="getclassname(this)"><i class="icon-filter"></i>&nbsp;&nbsp;启动指挥调度</a>
				</li>
				
				<!-- <li>
					<a href="qdzhdd.jsp" target="right" onClick="getclassname(this)"><i class="icon-pencil"></i>&nbsp;&nbsp;启动指挥调度</a>
				</li> -->
				
					<li>
				<a name="deal" href="findtodoTasks.do" target="right" onClick="getclassname(this)"><i class="icon-flag"></i>&nbsp;&nbsp;调度处理</a>
				</li>
								<li>
				<a href="findRunningProcessInstaces.do" target="right" onClick="getclassname(this)"><i class="icon-fire"></i>&nbsp;&nbsp;运行中流程</a>
				</li>
				<li>
				<a href="findFinishedProcessInstaces.do" target="right" onClick="getclassname(this)"><i class="icon-ok-sign"></i>&nbsp;&nbsp;已结束流程</a>
				</li>
			</ul>
	
	</div>
	
	<div class="content">
		<iframe class="inner_navigation1" name="right" src="welcome.html"
			right="0px" frameborder="0" width="100%" scrolling="auto"
			height="100%";>
		</iframe>
	</div>

</body>
</html>
