<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
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
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/layui.css">
<link rel="stylesheet" type="text/css"
	href="../css/bootstrap-responsive.min.css">
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/CSS"
	href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
<script src="<%=basePath%>/js/showtime.js"></script>
</head>
<body>
	<!-- 右 -->
	<div class="content" style="background: white">
		<div class="header">
			<h1 class="page-title" align="center"><strong class="am-text-primary am-text-lg">账户挂失</strong></h1>
		</div>
		<div class="save_money" style="margin-top: 50px; margin-left: 340px;">
			<!-- edit form -->
			<form class="layui-form layui-form-pane" role="form" id="myform" method="post"
				action="<%=basePath%>/bank/admin_cancel_account.do">

				<div class="layui-form-item" style="margin-top: 10px;">
					<label for="account" class="layui-form-label"><strong>挂失账户</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:60%" id="card"
							placeholder="请输入挂失账户卡号" name="card" onblur="checkCard()">
						<div style="color: red; margin-top:20px" id="Ctext"></div>
					</div>
				</div>
				<div class="layui-form-item" style="margin-top: 30px;">
					<label for="password" class="layui-form-label"><strong>密码</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="password" class="layui-input" style="width:40%" id="password"
							placeholder="请输入操作员密码" name="password" onblur="checkPassword()">
						<div style="color: red; margin-top:20px" id="ck_password"></div>	
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10"
						style="margin-left: 80px; margin-top: 40px;">
						<button type="button" class="layui-btn" onclick="cancle()"
							style="margin-left: 120px;">挂失</button>
					</div>
				</div>
			</form>
		</div>
		</div>
		<c:if test="${msg.equals('ok')}">
			<script>
				swal("挂失成功!", "您的新卡号为:${account_msg.card }", "success");
			</script>
			<div class="showText"
				style="height: 300px; color: red; margin-left: 490px;"><br><br>
				<p>新卡号：${account_msg.card }</p><br>
				<p>姓名：${account_msg.username }</p><br>
				<p>余额：${account_msg.money }</p><br>
				<p>PS:支付密码不变</p>
			</div>
		</c:if>
		<c:if test="${msg.equals('accounterror')}">
			<script>
				swal("账户不存在或已挂失!", "", "error");
			</script>
		</c:if>
		<c:if test="${msg.equals('passworderror')}">
			<script>
				swal("密码错误!", "", "error");
			</script>
		</c:if>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
	function cancle() {
		if(!checkPassword()){
			$("#password").val("")
			swal("密码错误","","error");	
			return;
		}
		var form = document.getElementById("myform");
		form.submit();
	}
	
	function checkCard(){
		$.ajax({
	        type: "POST",
	        url:"<%=basePath%>/bank/checkCard.do",
	        data:{
	            card:$("#card").val(),
	        },
	        dataType:"json",
	        success: function(data) {
	        	  if(data.msg_card == "ok"){
	                $("#Ctext").text("");
	                 }
	           else if(data.msg_card == "error"){
	                $("#Ctext").text("该卡号不存在或已被挂失");
	            }
	        }
	    });
	}
	function checkPassword(){
		  var adminPsw = "<%=session.getAttribute("adminPsw")%>";
		  var elMsg = document.getElementById('ck_password');     
		  var elPassword = document.getElementById('password');
		  var password = elPassword.value;
		  var regPassword = new RegExp('^[0-9]{6}$');
		  if (!regPassword.test(password)) {                   
		    elMsg.textContent = '操作员密码为6位正整数'; 
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
</script>
</html>
