package com.pyd.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.json.JSONUtils;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.pyd.entity.Account;
import com.pyd.entity.User;
import com.pyd.service.AccountService;
import com.pyd.service.UserService;
import com.zhenzi.sms.ZhenziSmsClient;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private AccountService accountService;
      
    //判别用户名是否存在
 	@RequestMapping(value = "/checkUsername.do", method = RequestMethod.POST)
 	public @ResponseBody Map<String, Object> registerCheckUsername(HttpServletRequest request) throws IOException {
 		String username = request.getParameter("username");
 		System.out.println(username);
        User user = userService.queryUserByName(username);
 		// 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
 		Map<String, Object> map = new HashMap<String, Object>();
 		if(user != null){
 		map.put("msg_username", "error");
 		}
 		else{
 			map.put("msg_username", "ok");	
 		}
 		return map;
 	}
 	
 	//判别手机号是否存在
	 @RequestMapping(value = "/checkTel.do", method = RequestMethod.POST)
	 public @ResponseBody Map<String, Object> registerCheckTel(HttpServletRequest request) throws IOException {
	 	String phoneNumber = request.getParameter("phoneNumber");
	 	System.out.println(phoneNumber);
	    User user = userService.queryUserByTel(phoneNumber);
	 	// 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
	 	Map<String, Object> map = new HashMap<String, Object>();
	 	if(user != null){
	 	map.put("msg_phonenumber", "ok");
	 	}
	 	else{
	 		map.put("msg_phonenumber", "error");	
	 	}
	 	return map;
	 	}
	 	
 	//判别电子邮件是否存在
 	@RequestMapping(value = "/checkEmail.do", method = RequestMethod.POST)
 	public @ResponseBody Map<String, Object> registerCheckEmail(HttpServletRequest request) throws IOException {
 		String email = request.getParameter("email");
        User user = userService.queryUserByEmail(email);
 		// 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
 		Map<String, Object> map = new HashMap<String, Object>();
 		if(user != null){
 		map.put("msg_email", "error");
 		}
 		else{
 			map.put("msg_email", "ok");	
 		}
 		return map;
 	}
 			
 	 //判别身份是否存在
 	@RequestMapping(value = "/checkIdentification.do", method = RequestMethod.POST)
 	public @ResponseBody Map<String, Object> registerCheckIdentification(HttpServletRequest request) throws IOException {
 		String identification = request.getParameter("identification");
        User user = userService.queryUserByIdentification(identification);
 		// 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
 		Map<String, Object> map = new HashMap<String, Object>();
 		if(user != null){
 		map.put("msg_identification", "error");
 		}
 		else{
 			map.put("msg_identification", "ok");	
 		}
 		return map;
 	}
    
	// 用户注册
	@RequestMapping("/register.do")
	public String register(HttpServletRequest request,Model model,HttpSession session) throws UnsupportedEncodingException{
		request.setCharacterEncoding("UTF-8");
		String username = request.getParameter("userName");
		String password = request.getParameter("passWord");
		String phonenumber = request.getParameter("phoneNumber");
		String email = request.getParameter("email");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		String identification = request.getParameter("identification");
		String region = province + city + district;
		User user = new User(username,password,phonenumber,email,identification,region);
		System.out.println(user);
		if(userService.queryUserByName(username) != null){
			model.addAttribute("msg","isExistUsername");
			return "/user/register";
		}
		if(userService.queryUserByEmail(email) != null){
			model.addAttribute("msg","isExistEmail");
			return "/user/register";
		}
		userService.addUser(user);
		model.addAttribute("msg","registerSuccess");
		return "/user/register";
	}

	// 用户登陆
	@RequestMapping("/login.do")
	public String login(HttpServletRequest request,HttpSession session,Model model){
		//判断是否需自动登录
		String isChecked[] = request.getParameterValues("autologin");
		   if(isChecked != null){
			User sessionUser = (User)session.getAttribute("loginUser");   
			if(sessionUser != null){
				Account acc = accountService.queryAccountByName(sessionUser.getUsername());
				session.setAttribute("loginAccount", acc);
				session.setAttribute("loginUsername",sessionUser.getUsername());
				return "bank/index";
			}
		}
		   
	   String username = request.getParameter("userName");   
	   String password = request.getParameter("passWord"); 
	   String identity = request.getParameter("identity");
	   User user = new User(username,password);
	   User checkUser = userService.queryUserByNP(user);
	   if(checkUser == null){
		   model.addAttribute("msg","no");
		   return "login";
	   }
	   else{		   
	   System.out.println("yes");
	   session.setAttribute("loginUsername",username);
	   session.setAttribute("loginUser",checkUser);
	   //用户成功登录
	   if(identity.equals("user") && !username.equals("admin")){
		   Account acc = accountService.queryAccountByName(username);
		   if(acc == null){
			   model.addAttribute("msg","user_open_account_error");
			   return "login";
		   }
		   session.setAttribute("loginAccount", acc);
		   session.setAttribute("loginAccountMoney", acc.getMoney());
		   if(acc.getNew_pay_password().equals(acc.getOld_pay_password())){
			   model.addAttribute("msg","old_pay_password_error");			   
		   }
		   return "bank/index"; 
	   }
	   //用户失败登录
	   else if(identity.equals("user") && username.equals("admin")){
		   model.addAttribute("msg","identityErro_user");
		   return "login";
	   }
	   //管理员成功登录
	   else if(identity.equals("admin") && username.equals("admin")){
		    session.setAttribute("adminPsw", password);
		    List<Account> listAcc = accountService.queryAllAccount();
		    session.setAttribute("listAcc", listAcc);
		    return "bank/index"; 
	   }
	   //管理员失败登录
	   else if(identity.equals("admin") && !username.equals("admin")){
		   model.addAttribute("msg","identityErro_admin");
		   return "login";
	   }
	   
	   }
	   return "login";
	}

	//修改密码
	@RequestMapping("/updatepsw.do")
	public String updatepsw(HttpServletRequest request,Model model){
		String phoneNumber = request.getParameter("phoneNumber");
		String newpassword = request.getParameter("passWord");
		User checkUser = userService.queryUserByTel(phoneNumber);
		//用户存在
		if (checkUser != null) {
			User newuser = new User();
			newuser.setPhonenumber(phoneNumber);
			newuser.setPassword(newpassword);
			userService.updateUser(newuser);
			//修改成功
			model.addAttribute("msg", "yes");
		} else {
			//密码不匹配，修改失败
			model.addAttribute("msg","no");
		}	
		return "user/updatepsw";
	}
	
	  	//用户退出
		@RequestMapping("/exit.do")
		public String exit(HttpSession session,Model model){
			session.removeAttribute("loginUsername");
			session.removeAttribute("loginUser");
			session.removeAttribute("loginAccount");
			session.removeAttribute("loginAccountOldPsw");
	        session.removeAttribute("adminPsw");
	        session.removeAttribute("card");
	        session.removeAttribute("listAcc");
	        session.removeAttribute("listDps");
			return "/login";
		}
		
	    //用户发送手机验证码
		@RequestMapping(value="/send.do",produces = "application/json;charset=utf8")
		public @ResponseBody String sendSMS(HttpServletRequest request,HttpServletResponse response) throws Exception{
			//ZhenziSmsClient client = new ZhenziSmsClient(apiUrl,appId,appSecret);
			//apiUrl为请求地址,其余两个参数可在榛子云官网查询
			ZhenziSmsClient client = new ZhenziSmsClient("https://sms_developer.zhenzikj.com","108166","bb028ce3-1dfc-4f51-b710-75ac8a577006");
			String tel = request.getParameter("tel");
			String templateId = "3749";
			String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("number", tel);
			params.put("templateId", templateId);
			String[] templateParams = new String[2];
			templateParams[0] = verifyCode; 
			templateParams[1] = "1";
			params.put("templateParams", templateParams);
			String result = client.send(params);
			//将验证码存入session
			HttpSession session = request.getSession();
			session.removeAttribute("verifyCode");
			session.setAttribute("verifyCode", verifyCode);
			System.out.println("verifyCode:" + (String)session.getAttribute("verifyCode"));
			return result;
/*			Object jsonObj = JSONUtils.parse(result);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("result", jsonObj);
			return map;	*/
		}
		
		//验证码校对
		@RequestMapping("/validate.do")
		public @ResponseBody boolean Validate(HttpSession session,HttpServletRequest request,Model model){
			String phoneNumber = request.getParameter("phoneNumber");
			System.out.println(phoneNumber);
            String inputCode = request.getParameter("inputCode");
            String verifyCode = (String)session.getAttribute("verifyCode");
            if(inputCode.equals(verifyCode)){          	
            	session.setAttribute("phoneNumber", phoneNumber);
            	return true;
            }
			return false;
		}
		
		
}
