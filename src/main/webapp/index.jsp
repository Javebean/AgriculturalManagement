<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ũҵ����ִ������ϵͳ</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/stylesheet.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="icon/font-awesome.css" rel="stylesheet">
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
				<h1>ũҵ����ִ������ϵͳ</h1>
			</div>
			<div class="login">
				<a href="#"><img src="image/login.png" /></a>
			</div>
			<div class="username">Hi!username</div>
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
				<a href="welcome.html" target="right" onClick="getclassname(this)"><i class="icon-home"></i>&nbsp;&nbsp;��ҳ</a>
				</li>
				<li>
				<a href="caiji.jsp" target="right" onClick="getclassname(this)"><i class="icon-filter"></i>&nbsp;&nbsp;�ɼ�</a>
				</li>
								<li>
				<a href="qdzhdd.jsp" target="right" onClick="getclassname(this)"><i class="icon-pencil"></i>&nbsp;&nbsp;����ָ�ӵ���</a>
				</li>
					<li>
				<a href="ddcl.jsp" target="right" onClick="getclassname(this)"><i class="icon-flag"></i>&nbsp;&nbsp;���ȴ���</a>
				</li>
								<li>
				<a href="yxzlc.jsp" target="right" onClick="getclassname(this)"><i class="icon-fire"></i>&nbsp;&nbsp;����������</a>
				</li>
				<li>
				<a href="yjslc.jsp" target="right" onClick="getclassname(this)"><i class="icon-ok-sign"></i>&nbsp;&nbsp;�ѽ�������</a>
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
