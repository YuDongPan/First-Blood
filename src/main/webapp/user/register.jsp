<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en" ng-app>
<head>
<meta charset="utf-8">
<title>用户注册</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="<%=basePath%>/css/layui.css" type="text/css" >
<link rel="stylesheet" href="<%=basePath%>/css/main_raw.css" type="text/css">
<link rel="stylesheet" href="<%=basePath%>/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="<%=basePath%>/css/bootstrap-responsive.min.css" type="text/css"> 
<link rel="stylesheet" href="<%=basePath%>/css/register.css" type="text/css">
<link rel="stylesheet" href="<%=basePath%>/css/font-awesome.min.css" type="text/css">
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
	<c:if test="${msg.equals('isExistUsername')}">
	   <script>swal("该手机号已存在","","error");</script>
	</c:if>
    <c:if test="${msg.equals('isExistUsername')}">
       <script>swal("该用户名已存在","","error");</script>
    </c:if>
    <c:if test="${msg.equals('isExistEmail')}">
        <script>swal("该电子邮箱已被使用","","error");</script>
    </c:if>
    <c:if test="${msg.equals('registerSuccess')}">
    <script>
    setTimeout(function(){swal({ 
		  title: "注册成功，正在加载", 
		  text: "正在努力跳转中,2秒后自动关闭。", 
		  timer: 2000, 
		  showConfirmButton: false 
		});},0);
	setTimeout(function(){window.location.href="<%=basePath%>/login.jsp";},2000);
	</script>
</c:if>
<div class="container" id="in">
    <form name="myForm" class="layui-form form-signin " ng-submit="save()" ng-controller="loginController" action="<%=basePath%>/user/register.do" method="post">
        <h1 align="center" class="headingStyle">用户注册</h1>
        <!-- 用户名 -->
        <div class="layui-form-item bdAdd">
            <div class="icon-style">
            	<i class="fa fa-user" aria-hidden="true"></i>
            </div>
        	<div class="input-style">
        		<input id="username" type="text"  class="input-block-level inputArea" placeholder="用户名"  ng-model="userName" required name="userName" onblur="checkUsername()">
        	</div>
        </div>
        <div class="regFeedback"  id="Utext"></div>
         <!-- 密码 -->
        <div class="layui-form-item bdAdd">
            <div class="icon-style">
            	<i class="fa fa-lock" aria-hidden="true"></i>
            </div>
            <div class="input-style">
	        <input id="password" type="password" class="input-block-level inputArea" placeholder="密码" ng-model="passWord" required name="passWord" onblur="checkPassword()">
            </div>
        </div>
        <div class="regFeedback"  id="Ptext"></div>
         <!-- 重复密码 -->
        <div class="layui-form-item bdAdd">
            <div class="icon-style">
            	<i class="fa fa-lock" aria-hidden="true"></i>
            </div>
            <div class="input-style">
	        <input id="repassword" type="password" class="input-block-level inputArea" placeholder="重复密码" ng-model="repassWord" required name="repassWord"  onblur="checkRePassword()">
            </div>
        </div>
        <div class="regFeedback"  id="rPtext"></div>
         <!-- 手机号 -->
        <div class="layui-form-item bdAdd">
            <div class="icon-style">
            	<i class="fa fa-phone" aria-hidden="true"></i>
            </div>
            <div class="input-style">
	       	<input id="phonenumber" type="text" class="input-block-level inputArea" placeholder="手机号" id="phoneNumber" ng-model="phoneNumber" required name="phoneNumber"  onblur="checkPhoneNumber()">
            </div>
        </div>
        <div class="regFeedback"  id="Ttext"></div>
         <!-- 电子邮箱 -->
        <div class="layui-form-item bdAdd">
        	<div class="icon-style">
            	<i class="fa fa-envelope" aria-hidden="true"></i> 
            </div>
            <div class="input-style">
	        <input id="email" type="text" class="input-block-level inputArea" placeholder="邮箱" required name="email" onblur="checkEmail()" >
            </div>
        </div>
        <div class="regFeedback" id="Etext"></div> 
         <!-- 身份证号 -->
        <div class="layui-form-item bdAdd">
            <div class="icon-style">
            	<i class="fa fa-id-card" aria-hidden="true"></i>
            </div>
            <div class="input-style">
	        <input id="identification" type="text" class="input-block-level inputArea" placeholder="身份证号" id="identification" ng-model="identification" required name="identification" ng-pattern="/^\S{18}$/" onblur="checkIdentification()" >
            </div>
        </div>
        <div class="regFeedback" id="Itext"></div> 
          <!-- 地理区域 -->
        <div id="region" class="regionArea">
            <div class="selectItem">
            	<select id="province" class="prov input-small" name="province"></select>
            </div>
            <div class="selectItem">
            	<select id="city" class="city input-small" name="city"></select>
            </div>
            <div class="selectItem">
            <select id="district" class="dist input-small" name="district" disabled="disabled" style="display: none;"></select>
            </div>
        </div>
        <div class="contractArea">
         <div class="layui-input-inline">
            <input id="contract" type="checkbox" title="同意">
         </div>
        <div>
           <p>同意"服务协议与隐私条款"</p>
         </div>
        </div>
        <div class="layui-form-item">
	        <button class="layui-btn layui-btn-normal" style="width:100%" type="submit" onclick="checkAll()">注册</button>
        </div>
    </form>
</div>
</body>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script src="<%=basePath%>/js/bootstrap.min.js"></script>
<script src="<%=basePath%>/js/angular.min.js"></script>
<!-- 城市联动插件 -->
<script src="<%=basePath%>/js/city_json.min.js"></script>
<script src="<%=basePath%>/js/city.min.js"></script>
<script src="<%=basePath%>/js/register.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/layui.js"></script>
<script>
//激活layui表单
layui.use('form', function(){
  var form = layui.form;

});
$('#contract').attr("checked",true);
</script>
<script>
angular.element(document).ready(function() {
    angular.module("loginController",[]);
});
function loginController ($scope) {
    //默认勾选
    $scope.agreement = true;
    //填充城市信息
    $("#region").citySelect({prov:"浙江",nodata:"none"});
    };
</script>
</html>