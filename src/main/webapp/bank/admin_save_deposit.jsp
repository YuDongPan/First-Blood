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
<c:if test="${msg.equals('admin_save_deposit_success')}">
    <c:if test="${income != null}">
    <script>
    var save_money = '${save_money}';
    var income = '${income}';
    swal("存款成功","本次存款" + save_money + "元\n" + "预计收入:" + income + "元","success");
    </script>
    </c:if>
    <c:if test="${rate != null}">
    <script>
    var save_money = '${save_money}';
    var rate = '${rate}';
    swal("存款成功","本次存款" + save_money + "元\n" + "预计收入:" + rate + "元" + "(秒利率:9%)","success");
    </script>
    </c:if> 
</c:if>

<c:if test="${msg.equals('admin_save_deposit_failed')}">
    <script>swal("存款失败","","error");</script>
</c:if>
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">存款操作</strong></h1>
		</div>
		
		<div class="save_money" style="margin-top:50px;margin-left:320px;">
			<!-- edit form -->
			<form class="layui-form layui-form-pane" method="post" role="form" id="myForm" action="<%=basePath%>/bank/admin_save_deposit.do">
				<div class="layui-form-item" style="margin-top:10px;">
					<label for="account" class="layui-form-label"><strong>存款账户</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input" style="width:60%" id="account" 
						placeholder="请输入存款卡号" name="card">
					</div>
				</div>
				<div class="layui-form-item" style="margin-top:30px;">
					<label for="money" class="layui-form-label"><strong>金额(元)</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" id="money"
							placeholder="请输入存款金额" oninput="checkMoney()" name="money">
							<label id = "ckm"></label>
					</div>
				</div>
				<div class="layui-form-item" style="margin-top:30px;">
						<label class="layui-form-label"><strong>收款银行</strong>&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<div class="layui-input-inline">
							<select name="bankName" >
									<option value="农业银行">农业银行</option>
									<option value="工商银行">工商银行</option>
									<option value="中国银行">中国银行</option>
									<option value="建设银行">建设银行</option>
							</select>
						</div>
					</div>
				<div class="layui-form-item" style="margin-top:30px;">
					<label class="layui-form-label"><strong>存款方式</strong></label>
					<div class="layui-input-block">
						<input name="way" type="radio"  value="定期3秒" title="定期3秒"/>
						<input name="way" type="radio"  value="定期1分" title="定期1分"/>			
						<input name="way" type="radio"  value="定期1小时" title="定期1小时"/>
					</div>
					<div class="layui-form-block">
					<input name="way" type="radio" value="活期存款" title="活期存款"/>
					</div>
	             </div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10" style="margin-left:200px;margin-top:30px;">
						<button type="button" class="layui-btn"  onclick="save()">提交</button>
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
	function isChecked(){
		var way = $('input:radio[name="way"]:checked').val();
		if(way == null) return false;
		return true;
	}
	//是否为正整数 
	function isPositiveNum(s){ 
    	var re = /^[0-9]*[1-9][0-9]*$/;  
    	return re.test(s);  
	} 
	
	function checkMoney() {
		var input = document.getElementById("money");
		var ck = document.getElementById("ckm");
		if(input.value == "")return false;
		if(!isPositiveNum(input.value)) {
			ck.innerHTML="&nbsp;&nbsp;&nbsp;请输入正整数!";
			ck.style.color="red";
			return false;
		} else {
			ck.innerHTML="";
			return true;
		}
	}
		
	function save(){
	if(!checkMoney()) {
		swal("请输入合法金额!","","error");
		return;	
	}
	if(!isChecked()){
		swal("请先选择存款方式","","error");
		return;
	}
	var form = document.getElementById("myForm");
	form.submit();
	}
</script>
</html>
