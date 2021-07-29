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
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/psw2.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/layui.css">
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
<c:if test="${msg.equals('modify_success')}">
<script>
setTimeout(function(){swal({ 
	  title: "修改成功，正在加载", 
	  text: "正在努力跳转中,2秒后自动关闭。", 
	  timer: 2000, 
	  showConfirmButton: false 
	});},0);
setTimeout(function(){
	window.location.href="<%=basePath%>/bank/user_information.jsp";
	},2000);
</script>
</c:if>
	<!-- 右 -->
	<body class="body-item">
     <div class="layout" id="noOp">
     <div class="pswform">
         <form id="myForm" class="layui-form layui-form-pane" method="post" action="<%=basePath%>/bank/user_modify_payPassword.do">
            <h1 align="center" class="HTitle">修改支付密码</h1>
            <div class="layui-form-item">
            	<label for="phoneNumber" class="layui-form-label" >
            		手机号&nbsp;&nbsp; <i class="fa fa-mobile" aria-hidden="true"></i>
            	</label>
            	<div class="layui-input-block">
            	<input class="layui-input" style="width:88%" type="text" id="phoneNumber" name="phoneNumber" readonly="readonly" placeholder="请输入11位手机号" value="${loginUser.phonenumber}">
            	</div>
            </div>
            
            <div class="layui-form-item">
            	<label for="card" class="layui-form-label" >
            		银行卡号 <i class="fa fa-credit-card-alt" aria-hidden="true"></i>
            	</label>
            	<div class="layui-input-block">
            	<input class="layui-input" style="width:88%" type="text" id="card" name="card" readonly="readonly" placeholder="请输入11位手机号" value="${loginUser.phonenumber}">
            	</div>
            </div>
                      
            <div class="layui-form-item" style="margin-bottom:0px">
            <label for="valCode" class="layui-form-label">
            	支付密码&nbsp; <i class="fa fa-key" aria-hidden="true"></i>
            	</label>
            <div class="layui-input-inline">
            <input class="layui-input" type="password" id="newPayPassword" name="newPayPassword" placeHolder="请输入6位新支付密码" onblur="checkPayPassword()">
            </div>
            </div>
            <div class="feedback" id="Ptext">  
            </div>
            
            <div class="layui-form-item" style="margin-bottom:0px">
            <label for="valCode" class="layui-form-label">
            	重复密码&nbsp; <i class="fa fa-key" aria-hidden="true"></i>
            	</label>
            <div class="layui-input-inline">
            <input class="layui-input" type="password" id="newPaySurePassword" name="newPaySurePassword" placeHolder="请重复输入6位新支付密码" onblur="checkRepeatPassword()">
            </div>
            </div>
            <div class="feedback" id="rPtext"> 
            </div>
            
            <div class="layui-form-item" align="center">
            <button class="layui-btn layui-btn-normal" onclick="modify()">确定</button>
            </div>
         </form>
     </div>
     </div>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script>
    function checkPayPassword(){
    	var regPassword = new RegExp('^[0-9]{6}$');
    	var newPayPassword = $("#newPayPassword").val();
    	if(!regPassword.test(newPayPassword))
    	$("#Ptext").text("请输入6位数字字符");
    	else{
    	$("#Ptext").text("");
    	}
    }
    function checkRepeatPassword(){
 	 var newPayPassword = document.getElementById("newPayPassword").value;
     var newPaySurePassword = document.getElementById("newPaySurePassword").value;
     if(newPayPassword == newPaySurePassword){
    	 $("#rPtext").text("");
    	 return true;
      }
     else{
    	 $("#rPtext").text("两次输入的密码不一致");
    	 return false;
     } 
     }
    
    function modify(){
    	if(!checkRepeatPassword()){
    		 $("#Ptext").val("");
    		 swal("两次输入的密码不一致","","error");
    		 return;
    	}
   	
    	var form = document.getElementById("myForm");
    	form.submit();
    }
</script>
</body>
</html>
