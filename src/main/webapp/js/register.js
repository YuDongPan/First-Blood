var validateUser = false;
var validatePassword = false;
var validateRePassword = false;
var validatePhonenumber = false;
var validateEmail = false;
var validateIdentification = false;
function checkUsername(){
	var regUsername = /[\u4E00-\u9FA5\uF900-\uFA2D_a-zA-Z0-9_]{2,15}/;	
    if(!regUsername.test($('#username').val())){
    	$("#Utext").text("用户名仅支持2-15位由中英文字符、数字、下划线组成的字符串");
    }
    else{
    $("#Utext").text("");
	$.ajax({
        type: "POST",
        url:"../user/checkUsername.do",
        data:{
            username:$("#username").val(),
        },
        dataType:"json",
        success: function(data) {
        	  if(data.msg_username == "ok"){
                $("#Utext").text("");
                validateUser = true;
                 }
           else if(data.msg_username == "error"){
                $("#Utext").text("该用户名已存在");
                validateUser = false;
            }
        }
    });
    }
}    
function checkPassword(){
	var regCheckPassword = new RegExp("^[a-zA-z_0-9]{6,20}$");
	if(!regCheckPassword.test($('#password').val())){
		$("#Ptext").text("请输入6-20位英文字母、数字或符号");
		validatePassword = false;
	}
	else{
		$("#Ptext").text("");
		validatePassword = true;
	}
}
function checkRePassword(){
    var password = $("#password").val();
    var repassword = $("#repassword").val();
	if(password != repassword){
		$("#rPtext").text("两次密码输入的不一致");
		validateRePassword = false;
	}
	else{
		$("#rPtext").text("");
		validateRePassword = true;
	}
}
function checkPhoneNumber(){
	var regPhoneNumber = new RegExp("^[0-9]{11}$");
    if(!regPhoneNumber.test($('#phonenumber').val())){
    	$("#Ttext").text("请输入11位数字字符");
    }
    else{
    $("#Ttext").text("");
	$.ajax({
        type: "POST",
        url:"../user/checkTel.do",
        data:{
            phoneNumber:$("#phonenumber").val(),
        },
        dataType:"json",
        success: function(data) {
        	  if(data.msg_phonenumber == "error"){
                $("#Ttext").text("");
                validatePhonenumber = true;
                 }
           else if(data.msg_phonenumber == "ok"){
                $("#Ttext").text("该手机号已被其他用户使用");
                validatePhonenumber = false;
            }
        }
    });	
    }
}    

function checkEmail(){
	var regEmail = new RegExp("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$");
	if(!regEmail.test($('#email').val())){
		$("#Etext").text("邮箱格式错误");
	}
	else{
	$("#Etext").text("");
	$.ajax({
        type: "POST",
        url:"../user/checkEmail.do",
        data:{
            email:$("#email").val(),
        },
        dataType:"json",
        success: function(data) {
        	  if(data.msg_email == "ok"){
        		 validateEmail = true;
                $("#Etext").text("");
                 }
           else if(data.msg_email == "error"){
        	    validateEmail = false;
                $("#Etext").text("该电子邮箱已被其他使用");
            }
        }
    });
	}
}    

function checkIdentification(){
	var regIdentification = new RegExp("^[0-9]{17}[0-9X]$")
	if(!regIdentification.test($('#identification').val())){
		$("#Itext").text("请输入18位的身份证号");
	}
	else{
		$("#Itext").text("");
	$.ajax({
        type: "POST",
        url:"../user/checkIdentification.do",
        data:{
            identification:$("#identification").val(),
        },
        dataType:"json",
        success: function(data) {
        	  if(data.msg_identification == "ok"){
                $("#Itext").text("");
                validateIdentification = true;
                 }
           else if(data.msg_identification == "error"){
                $("#Itext").text("该身份证号已被其他用户使用");
                validateIdentification = false;
            }
        }
    });
	}
	
}    
function checkAll(){
	if(!$("#contract").prop("checked")){
		swal("请先同意相关协议条款!","","warning");
		return;
	}
	var form = document.getElementById("myForm");
	if(validateUser && validatePassword && validateRePassword && validateNumber && validateEmail && validateIdentification){
		setTimeout(function(){swal({ 
			  title: "注册成功，正在加载", 
			  text: "正在努力跳转中,2秒后自动关闭。", 
			  timer: 2000, 
			  showConfirmButton: false 
			});},0);
		setTimeout(function(){
			window.location.href="<%=basePath%>/user/updatepsw.jsp";
			},2000);
		form.submit();
	}
	else{
		swal("请输入正确的注册信息","","error");
	}
}