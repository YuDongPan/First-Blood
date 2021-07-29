<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <title>用户登录</title>
    <script type="text/javascript" src="http://www.bootstrapmb.com/content/js/jquery.min.js"></script>
    <!--必要样式-->
    <link href="<%=basePath%>/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>/css/demo.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>/css/loaders.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css"/>
</head>
<body>
     <c:if test="${msg.equals('no')}">
     <script>swal("用户不存在或密码错误","","error");</script>
    </c:if>
    <c:if test="${msg.equals('user_open_account_error')}">
     <script>swal("此用户还未开户,请先开户","","error");</script>
    </c:if>
    <c:if test="${msg.equals('identityErro_user')}">
     <script>swal("此用户不存在","","error");</script>
    </c:if>
    <c:if test="${msg.equals('identityErro_admin')}">
     <script>swal("该管理员不存在","","error");</script>
    </c:if>
    <div class='login'>
        <div class='login_title'>
            <span>登录界面</span>
        </div>
        <div class='login_fields'>
            <form id="myForm" method="post" action="<%=basePath%>/user/login.do">
            <div class='login_fields__user'>
                <div class='icon'>
                    <img alt="" src='img/user_icon_copy.png' />
                </div>
                <input id="userName" name="userName" placeholder='用户名' maxlength="16" type='text' autocomplete="off" />
                <div class='validation'>
                    <img alt="" src='img/tick.png' />
                </div>
            </div>
            <div class='login_fields__password'>
                <div class='icon'>
                    <img alt="" src='img/lock_icon_copy.png' />
                </div>
                <input id="passWord" name="passWord" placeholder='密码' maxlength="16" type='password' autocomplete="off" />
                <div class='validation'>
                    <img alt="" src='img/tick.png' />
                </div>
            </div>
            <div class='login_fields__password'>
                <div class='icon'>
                    <img alt="" src='img/key.png' />
                </div>
                <input id="verifyCode" name="verifyCode" placeholder='验证码' maxlength="4" type='text' name="ValidateNum" autocomplete="off" />
                <div class='validation' style="opacity: 1; right: -5px;top: -3px;">
                    <canvas class="J_codeimg" id="myCanvas" onclick="Code();">对不起，您的浏览器不支持canvas，请下载最新版浏览器!</canvas>
                </div>
            </div>
            <div class="login_fields__identity">
              <input class="radio_type" type="radio" name="identity" value="user"/>用户
              <input class="radio_type" type="radio" name="identity" value="admin"/>管理员
            </div>
            <div class='login_fields__submit'>
                <input type='button' value='登录' />
            </div>
            <div class="login_fields__link">
                <a href="<%=basePath%>/user/register.jsp">没有账户?点此注册</a>
            </div>
            </form>
        </div>
           
        <div class='success'>
        </div>
        <div class='disclaimer'>
            <p>&copy; 2021 www.ethan-hunt.top</p>
        </div>
    </div>
    <div class='authent'>
        <div class="loader" style="height: 44px;width: 44px;margin-left: 28px;">
            <div class="loader-inner ball-clip-rotate-multiple">
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>
        <p>认证中...</p>
    </div>
    <div class="OverWindows"></div>


    <script type="text/javascript" src="<%=basePath%>/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src='<%=basePath%>/js/stopExecutionOnTimeout.js'></script>

    <script type="text/javascript" src="<%=basePath%>/js/Particleground.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/Treatment.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.mockjax.js"></script>
    <script type="text/javascript">
    var canGetCookie = 0;//是否支持存储Cookie 0 不支持 1 支持
    var ajaxmockjax = 1;//是否启用虚拟Ajax的请求响 0 不启用  1 启用
    //验证码的值
    var CodeVal = 0;
    Code();
    function Code() {
        if (canGetCookie == 1) {
            createCode("AdminCode");
            var AdminCode = getCookieValue("AdminCode");
            showCheck(AdminCode);
        } else {
            showCheck(createCode(""));
        }
    }
    function showCheck(a) {
        CodeVal = a;
        var c = document.getElementById("myCanvas");
        var ctx = c.getContext("2d");
        ctx.clearRect(0, 0, 1000, 1000);
        ctx.font = "80px 'Hiragino Sans GB'";
        ctx.fillStyle = "#E8DFE8";
        ctx.fillText(a, 0, 100);
    }
    function isChecked(){
    	var identity = $('input:radio[name="identity"]:checked').val();
    	if(identity == null) return false;
    	return true;
    }
	//校验验证码  
	function isValidate() {
		//取得输入的验证码
		var inputVerifyCode = document.getElementById("verifyCode").value;
		if (inputVerifyCode.toUpperCase() != CodeVal.toUpperCase()) { //若输入的验证码与产生的验证码不一致时  
		$("#verifyCode").val("");//清空文本框 
		showCheck(createCode(""));;//刷新验证码  
		return false;
		} else { //输入正确时  
			return true;
		}
	}
    $(document).keypress(function (e) {
        // 回车键事件
        if (e.which == 13) {
            $('input[type="button"]').click();
        }
    });
    //粒子背景特效
    $('body').particleground({
        dotColor: '#E8DFE8',
        lineColor: '#133b88'
    });
    $('input[name="passWord"]').focus(function () {
        $(this).attr('type', 'password');
    });
    $('input[type="text"]').focus(function () {
        $(this).prev().animate({ 'opacity': '1' }, 200);
    });
    $('input[type="text"],input[type="password"]').blur(function () {
        $(this).prev().animate({ 'opacity': '.5' }, 200);
    });
    $('input[type="radio"]').focus(function () {
        $(this).prev().animate({ 'opacity': '1' }, 200);
    });
    $('input[type="radio"]').blur(function () {
        $(this).prev().animate({ 'opacity': '.5' }, 200);
    });
    $('input[name="userName"],input[name="passWord"]').keyup(function () {
        var Len = $(this).val().length;
        if (!$(this).val() == '' && Len >= 5) {
            $(this).next().animate({
                'opacity': '1',
                'right': '30'
            }, 200);
        } else {
            $(this).next().animate({
                'opacity': '0',
                'right': '20'
            }, 200);
        }
    });
    
    $('input[name="userName"],input[name="passWord"]').keyup(function () {
        var Len = $(this).val().length;
        if (!$(this).val() == '' && Len >= 6) {
            $(this).next().animate({
                'opacity': '1',
                'right': '30'
            }, 200);
        } else {
            $(this).next().animate({
                'opacity': '0',
                'right': '20'
            }, 200);
        }
    });
    var open = 0;
    //非空验证
    $('input[type="button"]').click(function () {
        if(!isValidate()){
        	swal("验证码有误","","error");
        }
        else if(!isChecked()){
        	swal("请选择身份","","error");
        }
        else {
            //认证中..
            fullscreen();
            $('.login').addClass('test'); //倾斜特效
            setTimeout(function () {
                $('.login').addClass('testtwo'); //平移特效
            }, 300);
            setTimeout(function () {
                $('.authent').show().animate({ right: -320 }, {
                    easing: 'easeOutQuint',
                    duration: 600,
                    queue: false
                });
                $('.authent').animate({ opacity: 1 }, {
                    duration: 200,
                    queue: false
                }).addClass('visible');
                 setTimeout(function(){
                     $('#myForm').submit();
                 },2000);
            }, 500);
            //alert("ssss");
        }
    })
    var fullscreen = function () {
        elem = document.body;
        if (elem.webkitRequestFullScreen) {
            elem.webkitRequestFullScreen();
        } else if (elem.mozRequestFullScreen) {
            elem.mozRequestFullScreen();
        } else if (elem.requestFullScreen) {
            elem.requestFullscreen();
        } else {
            //浏览器不支持全屏API或已被禁用
        }
    }
    </script>

</body>
</html>
