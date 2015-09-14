<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>农业行政执法管理系统</title>
    <link href="css/index.css" rel="stylesheet">
<script type="text/javascript">
	if(${empty sessionScope.user.id}){
		window.location.href="${pageContext.request.contextPath}/login.html"
	}

</script>
  </head>
  <body>
   <div>
      <div class="inner">
            <div  class="daohanglink"style="">
                <span class="daohang"></span>
                <span>采集信息</span>
			</div>
			<div>
				<form action="${pageContext.request.contextPath}/startProcess.do" method="post">
                    <div class="form_list"><label class="lable_title">产品名称</label><input class="form_input" type="text" name="proName"/></div>
					<div class="form_list"><label class="lable_title">产品类型</label><input class="form_input" type="text" name="proType"/></div>
					<div class="form_list"><label class="lable_title">产&nbsp;&nbsp;地</label><input class="form_input" type="text" name="proPlace"/></div>
					 <div class="form_list"><label class="lable_title">产品等级</label>
                            <select style="width:250px; height:25px; margin-left:15px;" name="proLev">
                              <option>初级农产品</option>
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
	</div>
  </body>
</html>

