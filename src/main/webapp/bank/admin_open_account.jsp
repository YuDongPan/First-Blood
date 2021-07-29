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
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap-responsive.min.css">
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/CSS" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
	<!-- 右 -->
	<div class="content" style="background: white">
		<div class="header">
			<h1 class="page-title" align="center"><strong class="am-text-primary am-text-lg">开户操作</strong></h1>
		</div>

		<div style="margin-top: 50px; margin-left: 320px;">
			<!-- edit form -->
			<form id="myForm" class="layui-form layui-form-pane" method="post"
				action="<%=basePath%>/bank/admin_open_account.do">

				<div class="layui-form-item" style="margin-top: 10px;">
					<label class="layui-form-label"><strong>持卡人姓名</strong></label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:30%" id="username"
							placeholder="请输入持卡人姓名" name="username" onblur="checkUsername()">
					</div>
					<div style="color: red; margin-left: 120px" id="Utext"></div>
				</div>
				
				<div class="layui-form-item" style="margin-top: 30px;">
					<label class="layui-form-label"><strong>身份证号</strong></label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:70%" id="identification"
							placeholder="请输入持卡人身份证号" name="identification"
							onblur="checkIdentification()">
					</div>
					<div style="color: red; margin-left: 120px" id="Itext"></div>
				</div>
				
				<div class="layui-form-item" style="margin-top: 30px;">
					<label  class="layui-form-label"><strong>支付密码</strong></label>
					<div class="layui-input-block">
						<input type="password" class="layui-input" style="width:30%" id="pay_password"
							placeholder="请输入银行卡支付密码" name="old_pay_password"
							onblur="checkPayPassword()">
					</div>
					<div style="color: red; margin-left: 120px" id="PPtext"></div>
				</div>
				
				<div class="layui-form-item" style="margin-top: 30px;">
					<label class="layui-form-label"><strong>预存金额</strong></label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:30%" id="money"
							placeholder="请输入预存金额" oninput="checkMoney()" name="money"
							onblur="checkMoney()">
					</div>
					<div style="color: red; margin-left: 120px" id="Mtext"></div>
				</div>

				<div class="layui-form-item" style="margin-top: 30px;">
					<label class="layui-form-label"><strong>持卡人性别</strong></label>
					<div class="layui-input-block">
						<input type="radio" name="sex" value="男" title="男"/>
						<input type="radio" name="sex" value="女" title="女"/>
						<input type="radio" name="sex" value="保密" title="保密"/>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10"
						style="margin-left: 100px; margin-top: 30px;">
						<button type="button" class="layui-btn"
							style="margin-left: 80px; color: white; background: blue;" onclick="checkAll()">提交</button>
					</div>
			<c:if test="${msg.equals('ok')}">
			<script>
			 swal("开户成功!", "您的银行卡号为:${card}", "success");
			</script>
		</c:if>
		</div>
		</form>
		</div>
		</div>
		<c:if test="${msg.equals('error')}">
			<script>
				swal("开户失败","","error");
			</script>
		</c:if>
		<c:if test="${msg.equals('adderror')}">
			<script>
				swal("此用户已开户!","","error");
			</script>
		</c:if>
		<c:if test="${msg.equals('usererror')}">
			<script>
				swal("此用户没有账号或身份证错误，请先注册!","","error");
			</script>
		</c:if>
</body>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script src="<%=basePath%>/js/layui.js"></script>
<script>
layui.use('form', function(){
  var form = layui.form;
  
  //各种基于事件的操作，下面会有进一步介绍
});
</script>
<script type="text/javascript">
var ckUsername = false;
var ckIdentification = false;
var ckPayPassword = false;
var ckMoney = false;
function checkUsername(){
	//用户名:6-20位字符
    var elMsg = document.getElementById('Utext');     
    var elUsername = document.getElementById('username');
    var username = elUsername.value;
    var regUsername = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
    if (!regUsername.test(username)) {                   
      elMsg.textContent = '用户名仅支持由中英文字符、数字、下划线组成的字符串'; 
      ckUsername = false;
    } else {                                              
      elMsg.textContent = '';
      ckUsername = true;
    }
}
function checkIdentification(){
	//身份证号:18位数字或17位数字+X
   var elMsg = document.getElementById('Itext');     
   var elUsername = document.getElementById('identification');
   var username = elUsername.value;
   var regUsername = new RegExp('^[0-9]{17}[0-9X]$');
   if (!regUsername.test(username)) {                   
     elMsg.textContent = '请输入18位数字或最后一位为X'; 
     ckIdentifiaction = false;
   } else {                                              
     elMsg.textContent = '';  
     ckIdentification = true;
   }
}
function checkPayPassword(){
  //支付密码,6位数字
  var elMsg = document.getElementById('PPtext');     
  var elPassword = document.getElementById('pay_password');
  var password = elPassword.value;
  var regPassword = new RegExp('^[0-9]{6}$');
  if (!regPassword.test(password)) {                   
    elMsg.textContent = '请输入6位数字'; 
    ckPayPassword = false;
  } else {                                              
    elMsg.textContent = '';
    ckPayPassword = true;
  }
}

function checkMoney(){
  //余额,3-6位正整数
  var elMsg = document.getElementById('Mtext');     
  var elPassword = document.getElementById('money');
  var password = elPassword.value;
  var regPassword = new RegExp('^[0-9]{3,6}$');
  if (!regPassword.test(password)) {                   
    elMsg.textContent = '请输入3-6位正整数'; 
    ckMoney = false;
  } else {                                              
    elMsg.textContent = '';
    ckMoney = true;
  }
}
function checkAll(){
	if(ckUsername && ckIdentification && ckPayPassword && ckMoney){
		$("#myForm").submit();
	}
	else{
		swal("请输入正确的开户信息","","error");
	}
}
</script>
</html>
