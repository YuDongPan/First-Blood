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
<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
<c:if test="${msg.equals('missed_card')}">
   <script>
       swal("卡号不存在或已被冻结","","warning");
   </script> 
</c:if>
<c:if test="${msg.equals('password_error')}">
     <script>
     swal("密码错误","","error");
     </script>
</c:if>
<c:if test="${msg.equals('old_pay_password_error')}">
   <script>
   swal({
		type:"info",
		title:"提示",
		text:"为了进行相应的操作,您需要先去修改初始支付密码",
		showCancelButton:true,
		confirmButtonText:"现在就去修改密码",
		cancelButtonText:"取消"
		},function(result) {
		if(result){
			window.location.href="<%=basePath%>/bank/user_modify_payPassword_first.jsp";
		}
		});
   </script>
   </c:if>	
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">存款查询</strong></h1>
		</div>
		
		<div class="save_money" style="margin-top:50px;margin-left:320px;">
			<!-- edit form -->
			<form class="layui-form layui-form-pane" method="post" role="form" id="myForm" action="<%=basePath%>/bank/user_query_deposit.do?pageNow=1">
				<div class="layui-form-item" style="margin-top:10px;">
					<label for="account" class="layui-form-label"><strong>查询账户</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:60%" id="account"
							readonly="readonly" name="card" value="${loginAccount.card}">
					</div>
				</div>
				<div class="layui-form-item" style="margin-top:20px;">
					<label for="money" class="layui-form-label"><strong>查询密码</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="password" class="layui-input" style="width:40%" id="pay_password"
							placeholder="请输入支付密码" name="pay_password" onblur="checkPassword()"/>
					<div style="color:red;margin-top:10px" id="ck_password"></div>	
				</div>
	          </div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10" style="margin-left:200px;margin-top:30px;">
						<button type="button" class="layui-btn"  onclick="search()">提交</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
	//支付密码是否为6位
	function isPositivePsw(s) {
		var re = /^[0-9]{6}$/;
		return re.test(s);
	}

	function checkPassword(){
		var input = document.getElementById("pay_password");
		if(!isPositivePsw(input.value)){
			$("#ck_password").text("支付密码为6位正整数");
			return false;
		}
		else if(isPositivePsw(input.value)){
			$("#ck_password").text("");
			return true;
		}
	}

	function search() {
		if (!checkPassword()) {
			$("#password").text("");
			swal("密码格式错误!", "", "error");
			return;
		}
		var form = document.getElementById("myForm");
		form.submit();
	}
</script>
</html>
