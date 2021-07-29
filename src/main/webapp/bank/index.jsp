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
<title>银行管理系统</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" href="<%=basePath%>/css/layui.css">
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
<script src="<%=basePath%>/js/showtime.js"></script>
<style type="text/css">
   a:link,a:hover,a:visited,a:active{
    text-decoration:none;
   }
</style>
</head>
<body class="layui-layout-body" onload="ShowTime();">		
	<!-- 上 -->
	<div class="layui-layout layui-layout-admin">
			<div class="layui-header">
				<div class="layui-logo">银行管理系统</div>
				<div class="TheTime" id="stime"></div>
				<!-- 头部区域（可配合layui已有的水平导航） -->
				<ul class="layui-nav layui-layout-right">		    
						
					<li class="layui-nav-item">
					    <c:if test="${loginUsername.equals('admin')}">
						<a href="javascript:;">
							<img src="<%=basePath%>/img/1.gif" class="layui-nav-img"> 管理员
						</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="<%=basePath%>/user/userDataSearch.jsp" target="_blank">系统可视化数据</a>
							</dd>
							<dd>
								<a href="<%=basePath%>/user/updatepsw_first.jsp" target="_blank">密码修改</a>
							</dd>
							<dd>
							   <a href="<%=basePath%>/postgraduate/postgraduate.html" target="_blank">合作伙伴</a>
							</dd>
						</dl>
						</c:if>
						
						<c:if test="${loginUsername != 'admin'}">
						<a href="javascript:;">
							<img src="<%=basePath%>/img/1.gif" class="layui-nav-img">${loginUsername}
						</a>
						<dl class="layui-nav-child">
						   <dd>
							   <a href="<%=basePath%>/bank/user_information.jsp" target="right">个人信息</a>
							</dd>
							<dd>
								<a href="<%=basePath%>/user/updatepsw_first.jsp" target="_blank">密码修改</a>
							</dd>
							<dd>
								<a href="<%=basePath%>/bank/index.jsp">返回首页</a>
							</dd>
						</dl>
						</c:if>
					</li>
					<li class="layui-nav-item">
						<a href="<%=basePath%>/login.jsp">安全退出</a>
					</li>
				</ul>
			</div>
			
			<div class="layui-side layui-bg-black">
				<div class="layui-side-scroll">
					<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
					<c:if test="${loginUsername.equals('admin')}">
					<ul class="layui-nav layui-nav-tree" lay-filter="test">
						<li class="layui-nav-item layui-nav-itemed">
							<a class="" href="javascript:;">储蓄业务</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="<%=basePath%>/bank/admin_save_deposit.jsp" target="right">存款</a>
								</dd>
								<dd>
									<a href="<%=basePath%>/bank/admin_take_deposit_first.jsp" target="right">取款</a>
								</dd>
								<dd>														
									<a href="<%=basePath%>/bank/admin_query_deposit.jsp" target="right">查询</a>
								</dd>
							</dl>
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">账户管理</a>
							<dl class="layui-nav-child">	
							   <dd>
							   <a href="<%=basePath%>/bank/admin_account_list.jsp" target="right">账户列表</a>
							   </dd>
							   <dd>
							   <a href="<%=basePath%>/bank/admin_open_account.jsp" target="right">账户开户</a>
							   </dd>	
							   <dd>
							   	<a href="<%=basePath%>/bank/admin_cancel_account.jsp" target="right">账户挂失</a>
							   </dd>
							   <dd>
							      	<a href="<%=basePath%>/bank/admin_account_log.jsp" target="right">流水账单</a>
							   </dd>					
							</dl>
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">系统页面</a>
							<dl class="layui-nav-child">
							<dd>
								 	<a href="<%=basePath%>/login.jsp" target="_blank">登录页面</a>
								</dd>
								<dd>
									<a href="<%=basePath%>/user/register.jsp" target="_blank">注册页面</a>
								</dd>
								<dd>
									<a href="<%=basePath%>/user/userDataSearch.jsp" target="_blank">数据可视化</a>
								</dd>
								<dd>
								   	<a href="<%=basePath%>/user/updatepsw_first.jsp" target="_blank">密码修改</a>
								</dd>
						   </dl>
						</li>
						
						<li class="layui-nav-item">
							<a href="https://me.csdn.net/weixin_43715601" target="_blank" class="nav-header">关于作者</a>
						</li>			
					</ul>
					 </c:if>
					 
					<c:if test="${loginUsername != 'admin'}">
					<ul class="layui-nav layui-nav-tree" lay-filter="test">
						<li class="layui-nav-item layui-nav-itemed">
							<a class="" href="javascript:;">银行卡操作</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="<%=basePath%>/bank/user_save_money.jsp" target="right">存款</a>
								</dd>
								<dd>
									<a href="<%=basePath%>/bank/user_take_money.jsp" target="right">取款</a>
								</dd>
								<dd>
									<a href="<%=basePath%>/bank/user_transfer_money.jsp" target="right">转账</a>
								</dd>
							</dl>
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">储蓄业务</a>
							<dl class="layui-nav-child">
							<dd>
							  <a href="<%=basePath%>/bank/user_save_deposit.jsp" target="right">存款</a>
							</dd>
							<dd>
							   <a href="<%=basePath%>/bank/user_take_deposit_first.jsp" target="right">取款</a>
							</dd>
							<dd>				   								
								<a href="<%=basePath%>/bank/user_query_deposit.jsp" target="right">查询</a>
							</dd>	
							</dl>			
						</li>
						<li class="layui-nav-item">
							<a href="javascript:;">账户操作</a>
							<dl class="layui-nav-child">
								<dd>
								   <a href="<%=basePath%>/bank/user_information.jsp" target="right">账户信息</a>
								</dd>
								<dd>
								  	<a href="<%=basePath%>/bank/user_query_rest.jsp" target="right">查询余额</a>
								</dd>
								<dd>
								   <a href="<%=basePath%>/bank/user_account_log.jsp" target="right">流水账单</a>
								</dd>
							</dl>
						</li>
						
						<li class="layui-nav-item">
							<a href="https://me.csdn.net/weixin_43715601" target="_blank" class="nav-header">关于作者</a>
						</li>		
						
					</ul>
					 </c:if>
					 
				</div>
			</div>
           
            
			<div class="layui-body" style="z-index: 0;">
				<!-- 内容主体区域 -->
				<div style="padding: 5px;">
					<iframe src="<%=basePath%>/indexCarousel.html" name="right" frameborder="0" width="100%" height="1000px">
					</iframe>
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
							right.location="<%=basePath%>/bank/user_modify_payPassword_first.jsp";
						}
						});
				   </script>
				</c:if>		
				</div>
			</div>


		</div>
		
		<script type="text/javascript" src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/myplugs/js/plugs.js">
		</script>
		<script type="text/javascript">
			//添加编辑弹出层
			function updatePwd(title, id) {
				$.jq_Panel({
					title: title,
					iframeWidth: 500,
					iframeHeight: 300,
					url: "updatePwd.html"
				});
			}
		</script>
		<script src="<%=basePath%>/js/layui.js"></script>
		<script>
			//JavaScript代码区域
			layui.use('element', function() {
				var element = layui.element;

			});
		</script>
	</body>

</html>
	
