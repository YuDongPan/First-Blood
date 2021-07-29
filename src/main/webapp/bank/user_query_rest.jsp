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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css"/>	
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main_raw.css">
	<link href="<%=basePath%>/css/settings.css" rel="stylesheet">
    <link href="<%=basePath%>/css/common.css" rel="stylesheet">
	<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
	<!-- 右 -->
	<div class="left" style="background: white">
		<div class="header">
			<h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">查询余额</strong></h1>
		</div>
		<section class="container-fluid">
        <div class="container">
            <div class="row">
                <!--PROFILE6-->
                <div class="bg6">
                    <div class="main_style_6">
                        <div id="profile2" class="profile2">
                            <a href="javascript:void(0)" class="closebtn3" onclick="closeNav3()">&times;</a>
                            <div class="row mt-5">
                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
                                    <h5>NEWS</h5>
                                </div>
                            </div>
                            <div class="row border_btm2" id="news">
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <div class="round6"></div>
                                </div>
                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                    <h5>Carina</h5>
                                    <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                                </div>
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <h6 class="time">1hr ago</h6>
                                </div>
                            </div>
                            <div class="row border_btm2" id="news">
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <div class="round6"></div>
                                </div>
                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                    <h5>Carina</h5>
                                    <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                                </div>
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <h6 class="time">1hr ago</h6>
                                </div>
                            </div>
                            <div class="row border_btm2" id="news">
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <div class="round6"></div>
                                </div>
                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                    <h5>Carina</h5>
                                    <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                                </div>
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <h6 class="time">1hr ago</h6>
                                </div>
                            </div>
                            <div class="row border_btm2" id="news">
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <div class="round6"></div>
                                </div>
                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                    <h5>Carina</h5>
                                    <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                                </div>
                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                    <h6 class="time">1hr ago</h6>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="img7">
                                    <img src="<%=basePath%>/img/China_Bank.jpg" class="img-fluid">
                                    <h4 class="name">China Bank Corporation<span class="title">About China Bank</span></h4>
                                </div>
                            </div>
                        </div>
                        <div style="margin-top:20px"></div>
                        <!-- 姓名 -->
                        <div class="rowInfo">
                            <div class="textInfo">
                              	用户姓名
                            </div>
                       	 	<div class="iconInfo">
                        		<i class="fa fa-user" aria-hidden="true"></i>
                        	</div>
                        	<div class="entityInfo">
                        	      ${loginUser.username}
                        	</div>
                        </div>
                        <!-- 银行卡号 -->
                        <div class="rowInfo">
                            <div class="textInfo">
                              	银行卡号
                            </div>
                       	 	<div class="iconInfo">
                        		<i class="fa fa-credit-card-alt" aria-hidden="true"></i>
                        	</div>
                        	<div class="entityInfo">
                        	     ${loginAccount.card}
                        	</div>
                        </div>
                         <!-- 银行卡号 -->
                        <div class="rowInfo">
                            <div class="textInfo">
                              	账户余额
                            </div>
                       	 	<div class="iconInfo">
                        		<i class="fa fa-jpy" aria-hidden="true"></i> 
                        	</div>
                        	<div class="entityInfo">
                        	     ${loginAccount.money}
                        	</div>
                        </div>
                        
                        <!-- 充值余额 -->
                        <div align="center">
                         <button type="button" class="snd" onclick="window.location.href='<%=basePath%>/user_save_money.jsp'">
                        <i class="fa fa-check-square" aria-hidden="true"></i>
                             	充值余额
                          </button>
                        </div> 
                   </div>
               </div>
          </div>
         </div>
         
	 <!--/PROFILE6/-->
    </section>
	</div>
		<c:if test="${msg.equals('cerror')}">
			<script>
				swal("您未开户,请先进行开户!","","warning");
			</script>
		</c:if>
</body>
</html>