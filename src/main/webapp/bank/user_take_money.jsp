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
 <c:if test="${msg=='yes' }">
       <script type="text/javascript">
        swal("取款成功!","","success");
        </script>
        </c:if>
       <c:if test="${msg=='no1' }">
       <script type="text/javascript">
        swal("余额不足,请重新操作!","","error");
        </script>
        </c:if>   
        <c:if test="${msg=='no2' }">
       <script type="text/javascript">
        swal("支付密码错误!请重试!","","error");
        </script>
        </c:if>	
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">取款操作</strong></h1>
		</div>
		<div id="search" style="margin-left: 320px;">
			<form name="myForm" class="layui-form layui-form-pane" action="<%=basePath%>/bank/user_take_money.do" method="post">
				<div class="layui-form-item">
					<label for="userName" class="layui-form-label">用户名</label>
					<div class="layui-input-block"> 
					<input type="text" class="layui-input" style="width:60%" name="userName" value="${loginUsername}" style="border: none;" readonly />
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">银行卡号</label>
					<div class="layui-input-block">
					<input class="layui-input" style="width:60%" type="text" name="card" value="${loginAccount.card}" readonly="readonly" /> 
				    </div>
				</div>
				<div class="layui-form-item">	
					<label class="layui-form-label">余额</label>
					<div class="layui-input-inline">
					<input type="text" class="layui-input" name="residual" value="${loginAccount.money}" placeholder="请输入存款金额" readonly="readonly" /> 
					</div>				
				</div>
				<div class="layui-form-item">	
					<label class="layui-form-label">取款金额</label>
					<div class="layui-input-block">
					<input type="text" class="layui-input" style="width:27.5%" name="money" id="money" placeholder="请输入取款金额"  onblur="checkMoney()"/> 
					</div>
					<div style="color:red" id="ck_money"></div>	
				</div>
				<div class="layui-form-item"> 
					<label class="layui-form-label">密码</label>
					<div class="layui-input-block">
					<input type="password" class="layui-input" style="width:40%" placeholder="请输入密码" name="pay_password" id="pay_password"  onblur="checkPassword()"/>
					</div>
					<div style="color:red" id="ck_password"></div>				
				</div>
				<div style="margin-left: 200px">
					<button class="layui-btn" onclick="save()">提交</button>
				</div>
			</form>
		</div>
		</div>
	
</body>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script>

//是否为正整数 
function isPositiveNum(s) {
	var re = /^[0-9]*[1-9][0-9]*$/;
	return re.test(s);
}
//支付密码是否为6位
function isPositivePsw(s) {
	var re = /^[0-9]{6}$/;
	return re.test(s);
}
function checkMoney() {
	var input = document.getElementById("money");
	if (input.value == "")
		return false;
	if (!isPositiveNum(input.value)) {
		$("#ck_money").text("请输入正整数");
		return false;
	} else {
		$("#ck_money").text("");
		return true;
	}
}

function checkPassword() {
	var input = document.getElementById("pay_password");
	if (!isPositivePsw(input.value)) {
		$("#ck_password").text("支付密码为6位正整数");
		return false;
	} else if (isPositivePsw(input.value)) {
		$("#ck_password").text("");
		return true;
	}
}

function take() {
	if (!checkMoney()) {
		swal("请输入合法金额!", "", "error");
		return;
	}
	if (!checkPassword()) {
		swal("密码格式错误", "", "error");
		return;
	}
	var form = document.getElementById("myForm");
	form.submit();
}
</script>
</html>