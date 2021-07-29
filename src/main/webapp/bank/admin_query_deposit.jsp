<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>银行管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main_raw.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/layui.css">
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/CSS" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
<c:if test="${msg.equals('missed_card')}">
   <script>
       swal("卡号不存在或已被冻结","","warning");
   </script> 
</c:if>
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">存款查询</strong></h1>
		</div>
		
		<div class="save_money" style="margin-top:80px;margin-left:320px;">
			<!-- edit form -->
			<form class="layui-form layui-form-pane" method="post" role="form" id="myForm" action="<%=basePath%>/bank/admin_deposit_list.jsp">
			<div class="layui-form-item" style="margin-top:20px;">
					<label for="money" class="layui-form-label"><strong>查询密码</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="password" class="layui-input" style="width:60%" id="password"
							placeholder="请输入管理员密码" name="pay_password" onblur="checkPassword()">
                    </div>
					<div style="color: red; margin-top:20px;margin-left:140px" id="ck_password"></div>		
	       </div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10" style="margin-left:200px;margin-top:30px;">
						<button type="button" class="layui-btn"  onclick="search()">立即提交</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
	function checkPassword(){
		  var adminPsw = "<%=session.getAttribute("adminPsw")%>";
		  var elMsg = document.getElementById('ck_password');     
		  var elPassword = document.getElementById('password');
		  var password = elPassword.value;
		  var regPassword = new RegExp('^[0-9]{6}$');
		  if (!regPassword.test(password)) {                   
		    elMsg.textContent = '管理员密码为6位正整数'; 
		    return false;
		  }  
		  else if(password != adminPsw){
			  elMsg.textContent = '';
			  return false;
		  }
		  else {                                              
		    elMsg.textContent = '';
		    return true;
		  }
	}

	function search() {
		if (!checkPassword()) {
			$("#password").val("");
			swal("密码错误!", "", "error");
			return;
		}
		var form = document.getElementById("myForm");
		form.submit();
	}
	
</script>
</html>
