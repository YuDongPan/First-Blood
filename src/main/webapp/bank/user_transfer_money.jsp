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
<c:if test="${msg.equals('receive_card_error')}">
   <script>
       swal("收款卡号不存在或已被冻结","","error");
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
<c:if test="${msg.equals('money_not_enough')}">
   <script>
       swal("余额不足","","error");
   </script> 
</c:if>
<c:if test="${msg.equals('transfer_success')}">
   <script>
       swal("转账成功","","success");
   </script> 
</c:if>
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">转账操作</strong></h1>
		</div>
		
		<div class="save_money" style="margin-top:50px;margin-left:330px;">
			<!-- edit form -->
			<form method="post" class="layui-form layui-form-pane" role="form" id="myForm" action="<%=basePath%>/bank/user_transfer_money.do">
				<div class="layui-form-item" style="margin-top:10px;">
					<label for="account" class="layui-form-label"><strong>付款账户</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:60%" class="form-control" id="saccount"
							readonly="readonly" name="send_card" value="${loginAccount.card}">
					</div>
				</div>
				<div class="layui-form-item" style="margin-top:30px;">
					<label for="money" class="layui-form-label"><strong>余额(元)</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:30%"  class="form-control" name="rest"
							  readonly="readonly" value="${loginAccount.money}">				  
					</div>
				</div>
				<div class="layui-form-item" style="margin-top:30px;">
					<label for="money" class="layui-form-label"><strong>金额(元)</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:30%"  id="money"
							placeholder="请输入转账金额" class="layui-input" style="width:30%" oninput="checkMoney()" name="money"  onblur="checkMoney()"/>
					<div style="color:red; margin-top:20px" id="ck_money"></div>		
					</div>
				</div>
				<div class="layui-form-item" style="margin-top:30px;">
						<label class="layui-form-label"><strong>收款银行</strong></label>
						<div class="layui-input-inline">
							<select name="bankName">
									<option value="农业银行">农业银行</option>
									<option value="工商银行">工商银行</option>
									<option value="中国银行">中国银行</option>
									<option value="建设银行">建设银行</option>
							</select>
						</div>
				</div>
				<div class="layui-form-item" style="margin-top:10px;">
					<label class="layui-form-label"><strong>收款账户</strong></label>
					<div class="layui-input-block">
					<input type="text" class="layui-input" style="width:60%" id="raccount"
							placeholder="请输入收款账户卡号" name="receive_card">
				</div>
				</div>
				
				<div class="layui-form-item" style="margin-top:30px;margin-left:2px">
					<label for="money" class="layui-form-label"><strong>支付密码</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
					<input type="password" class="layui-input" style="width:30%" id="pay_password"
							placeholder="请输入支付密码" name="pay_password" onblur="checkPassword()"/>
					<div style="color:red; margin-top:20px" id="ck_password"></div>		
					</div>
					</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10" style="margin-left:200px;margin-top:30px;">
						<button type="button" class="layui-btn"  onclick="transfer()">立即提交</button>
					</div>
				</div>
			</form>
		</div>
	</div>
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

function transfer() {
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
