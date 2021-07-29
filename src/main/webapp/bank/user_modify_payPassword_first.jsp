<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/psw2.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/layui.css">
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
<title>手机号验证</title>
<style type="text/css"> 
</style>
</head>
<body class="body-item">
     <div class="layout" id="noOp">
     <div class="valform">
         <form id="myForm" class="layui-form layui-form-pane" method="post">
            <h1 align="center" class="HTitle">手机号验证</h1>
            <div class="layui-form-item">
            	<label for="phoneNumber" class="layui-form-label">
            		手机号  <i class="fa fa-mobile" aria-hidden="true"></i>
            	</label>
            	<div class="layui-input-block">
            	<input class="layui-input" style="width:88%" type="text" id="phoneNumber" name="phoneNumber" readonly="readonly" placeholder="请输入11位手机号" value="${loginUser.phonenumber}">
            	</div>
            </div>
            <div class="feedback" id="Ptext">  
            </div>
            <div class="layui-form-item">
            <label for="valCode" class="layui-form-label">
            	验证码&nbsp;&nbsp;<i class="fa fa-key" aria-hidden="true"></i>
            	</label>
            <div class="layui-input-inline">
            <input class="layui-input" type="text" id="valCode" name="valCode" placeHolder="请输入6位验证码">
            </div>
            <div>
              <button id="send" class="layui-btn">发送验证码</button>
            </div>
            </div>
            <div class="layui-form-item" align="center">
            <button class="layui-btn layui-btn-normal" onclick="return CodeSubmit()">确定</button>
            </div>
         </form>
     </div>
     </div>
     <!-- 发送验证码 -->
     <script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
     <script>
     	$("#send").click(function(){
     			$.ajax({
     				type:"POST",
     			   	data:{tel:$("#phoneNumber").val()},
     			   	dataType:"json",
     			   	url:"<%=basePath%>/user/send.do",
     			   	success: function(res){
     			   		console.log(res);
     			   		console.log(typeof(res));
     			   		if(res.code == 0){    			   			
     			   			swal("发送成功,注意查收","","success");
     			   			checkCode(60);
     			   		}
     			   		else{
     			   			console.log(res.data);
     			   			swal("发送失败,注意错误码","","error");
     			   		}
     			   	}
     			});
     		return false;
     	});

     	function checkCode(time){
     		if(time == 0){
     			$('#send').removeAttr("disabled");
     			$('#send').html("重新发送");
     			$('#send').css("background-color","#FFD700");
     		}
     		else{
     			time--;
     			$('#send').attr('disabled',true);
     			$('#send').css('color','#FF8000');
     			$('#send').html(time + "s");
     			setTimeout(function(){
     				checkCode(time);
     			},1000)
     		}
     	}
     	
     	
     	function CodeSubmit(){
     	    $.ajax({
     		   type:"POST",
     		   data:{
     			   phoneNumber:$("#phoneNumber").val(),
     			   inputCode:$("#valCode").val()},
     		   dataType:"json",
     		   url:"<%=basePath%>/user/validate.do",
     		   success:function(res){
     			   if(res){
     				  setTimeout(function(){swal({ 
     					  title: "验证成功，正在加载", 
     					  text: "正在努力跳转中,2秒后自动关闭。", 
     					  timer: 2000, 
     					  showConfirmButton: false 
     					});},0);
     				setTimeout(function(){
     					window.location.href="<%=basePath%>/bank/user_modify_payPassword.jsp";
     					},2000);
     			   }
     			   else{
     				   swal("验证码错误！","","error");
     				   $("#valCode").val("");
     			   }
     		   }
     		});
     		return false;
     	}
     </script>
</body>
</html>