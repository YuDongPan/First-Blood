package com.pyd.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pyd.entity.Account;
import com.pyd.entity.Log;
import com.pyd.entity.SearchCondition;
import com.pyd.entity.User;
import com.pyd.service.AccountService;
import com.pyd.service.LogService;
import com.pyd.service.UserService;

@Controller
@RequestMapping("/bank")
public class AccountController{
	@Autowired
	private AccountService accountService;
	@Autowired
	private LogService logService;
	@Autowired
	private UserService userService;
	private int pageSize = 5;
	 
	//判别卡号是否存在
	 	@RequestMapping(value = "/checkCard.do", method = RequestMethod.POST)
	 	public @ResponseBody Map<String, Object> registerCheckUsername(HttpServletRequest request) throws IOException {
	 		String card = request.getParameter("card");
	        Account acc = accountService.queryAccountExistByCard(card);
	 		// 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
	 		Map<String, Object> map = new HashMap<String, Object>();
	 		if(acc != null){
	 		map.put("msg_card", "ok");
	 		}
	 		else{
	 			map.put("msg_card", "error");	
	 		}
	 		return map;
	 	}
	 	
		//存款操作
	    @Transactional(rollbackFor = Exception.class)
		@RequestMapping("/user_save_money.do") // 存款操作
		public String user_save_money(HttpSession session, HttpServletRequest request, Model model) {
	    	String loginUsername = (String)session.getAttribute("loginUsername");
			String pay_password = request.getParameter("pay_password");
			Account acc = accountService.queryAccountByName(loginUsername);
			//检查用户是否修改了初始密码,若不修改则无法执行该操作
	    	if(acc.getNew_pay_password().equals(acc.getOld_pay_password()))
	    	{
	    	model.addAttribute("msg","old_pay_password_error");	
	    	return "bank/user_save_money";
	    	}
	    	//检查用户是否输入了正确的支付密码
	    	if(!pay_password.equals(acc.getNew_pay_password())){
	    	model.addAttribute("msg","password_error");	
	        return "bank/user_save_money";	
	    	}
			session.setAttribute("card", acc.getCard());
			String money = request.getParameter("money");// 提取文本款
			Double addmoney = Double.valueOf(money.toString());// 存多少钱		
			acc.setMoney(addmoney);
			if (pay_password.equals(acc.getNew_pay_password())) {
				accountService.saveMoney(acc);// 更新数据库的钱
				Account acc1 = accountService.queryAccountByName(loginUsername);// 查询数据库更新session
				model.addAttribute("msg", "success");
				session.setAttribute("loginAccount", acc1);// 更新session
			} else {
				Account acc1 = accountService.queryAccountByName(loginUsername);
				session.setAttribute("loginAccount", acc1);
				model.addAttribute("msg", "no");
			}
			return "toalipay.do?money=" + money + "&&a=123";
		}

	//取款操作
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("user_take_money.do")
		public String user_take_money(Model model, HttpSession session, HttpServletRequest request) {
		String loginUsername = (String)session.getAttribute("loginUsername");
		String pay_password = request.getParameter("pay_password");
		Account acc = accountService.queryAccountByName(loginUsername);
		//检查用户是否修改了初始密码,若不修改则无法执行该操作
    	if(acc.getNew_pay_password().equals(acc.getOld_pay_password()))
    	{
    	model.addAttribute("msg","old_pay_password_error");	
    	return "bank/user_take_money";
    	}
    	//检查用户是否输入了正确的支付密码
    	if(!pay_password.equals(acc.getNew_pay_password())){
    	model.addAttribute("msg","password_error");	
        return "bank/user_take_money";	
    	}
		session.setAttribute("card", acc.getCard());
		Double oldMoney = acc.getMoney();// 原先账户余额
		String money = request.getParameter("money");// 提取文本款
		Double addmoney = Double.valueOf(money.toString());// 取多少钱
		acc.setMoney(addmoney);// 迭代替换money=money-money;
		if (pay_password.equals(acc.getNew_pay_password())) {// 支付密码正确
		if (oldMoney >= addmoney)// 卡里钱够,可以取出
			{
			accountService.takeMoney(acc);// 更新数据库的钱
			Account acc1 = accountService.queryAccountByName(loginUsername);// 查询数据库更新session
			model.addAttribute("msg", "yes");
			session.setAttribute("loginAccount", acc1);// 更新session
			} else {// 钱不够
			model.addAttribute("msg", "no1");
			Account acc1 = accountService.queryAccountByName(loginUsername);
			session.setAttribute("loginAccount", acc1);
		}

			} else {
				Account acc1 = accountService.queryAccountByName(loginUsername);
				session.setAttribute("loginAccount", acc1);
				model.addAttribute("msg", "no2");
				System.out.println("存款失败");
			}
			return "bank/user_take_money";

		}

	//转账操作
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("/user_transfer_money.do")
	public String user_transfer_money(HttpServletRequest request, Model model,HttpSession session){
		String loginUsername = (String)session.getAttribute("loginUsername");
		//转账人支付密码
		String pay_password = request.getParameter("pay_password");
		Account acc = accountService.queryAccountByName(loginUsername);
		//检查用户是否修改了初始密码,若不修改则无法执行该操作
    	if(acc.getNew_pay_password().equals(acc.getOld_pay_password()))
    	{
    	model.addAttribute("msg","old_pay_password_error");	
    	return "bank/user_transfer_money";
    	}
    	//检查用户是否输入了正确的支付密码
    	if(!pay_password.equals(acc.getNew_pay_password())){
    	model.addAttribute("msg","password_error");	
        return "bank/user_transfer_money";	
    	}
		//转账人卡号
	   String sendAccountCard = request.getParameter("send_card");
		//收款人卡号
	   String recAccountCard = request.getParameter("receive_card");
		//转账金额
	   Double money = new Double(request.getParameter("money"));
	    //转账人余额
	   Double rest = new Double(request.getParameter("rest"));
	   if(accountService.queryAccountExistByCard(recAccountCard) == null){
		 model.addAttribute("msg","receive_card_error");
		 return "bank/user_transfer_money";
	   }
	   if(rest - money < 0){
		 model.addAttribute("msg","money_not_enough");
		 return "bank/user_transfer_money";
	  }
	  Account saccount = new Account(sendAccountCard,money);
	  accountService.transferMoney(saccount,recAccountCard);
	  Account loginAccount = accountService.queryAccountByName(loginUsername);
	  session.setAttribute("loginAccount", loginAccount);
	  model.addAttribute("msg","transfer_success");
	  return "bank/user_transfer_money";	
	}
     
	//支付密码修改
	@RequestMapping("/user_modify_payPassword.do")
	public String user_modify_payPassword(Model model, HttpSession session, HttpServletRequest Request) {
			String loginName = (String) session.getAttribute("loginUsername");// 获取用户名
			Account acc = accountService.queryAccountByName(loginName);// 获取账户
			String newPayPassword = Request.getParameter("newPayPassword");// 新密码
			acc.setNew_pay_password(newPayPassword);
			accountService.modifyPayPassword(acc);
			model.addAttribute("msg", "modify_success");
			session.setAttribute("loginAccount", acc);
			return "/bank/user_modify_payPassword";
			} 

		// 查询余额 鄢锦玲添加
		@RequestMapping("/user_query_rest.do")
		public String queryRestMoney(HttpServletRequest request, Model model, HttpSession session) {
			Account account = (Account) session.getAttribute("loginAccount");
			if (account != null) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "error");
			}
			return "bank/user_query_rest";
		}
		
		// 新建账户(开户)
		@RequestMapping("/admin_open_account.do")
		public String admin_open_account(HttpServletRequest request, Model model, HttpSession session) throws UnsupportedEncodingException {
			request.setCharacterEncoding("UTF-8");
			String username = request.getParameter("username");
			if(username == "") return "bank/admin_open_account";
			Account ac = accountService.queryAccountExistByName(username);
			if (ac == null) {
				String sex = request.getParameter("sex");
				Double money = Double.valueOf(request.getParameter("money"));
				String old_pay_password = request.getParameter("old_pay_password");
				String identification = request.getParameter("identification");
				Date date = new Date();
				Timestamp tt = new Timestamp(date.getTime());
				// 生成随机卡号(10位数字字符串)
				String card = "";
				Random random = new Random();
				for (int i = 0; i < 10; i++) {
					card += String.valueOf(random.nextInt(10));
				}
				while (accountService.queryAccountExistByCard(card) != null) {
					for (int i = 0; i < 10; i++) {
						card += String.valueOf(random.nextInt(10));
					}
				}
				User checkIU = new User();
				checkIU.setUsername(username);
				checkIU.setIdentification(identification);
				User aUser = userService.queryUserByIU(checkIU);
				if (aUser != null) {
					String email = aUser.getEmail();
					Account account = new Account(card, username, sex, money, tt, old_pay_password, 0, email);
					System.out.println(account);
					int op = accountService.openAccount(account);
					if (op > 0) {
						model.addAttribute("msg", "ok");
						model.addAttribute("card", card);
						session.setAttribute("loginAccount", account);
					} else {
						model.addAttribute("msg", "error");
					}
				} else {
					model.addAttribute("msg", "usererror");
				}
			} else {
				model.addAttribute("msg", "adderror");
			}
			return "bank/admin_open_account";
		}

		// 账户挂失
		@RequestMapping("/admin_cancel_account.do")
		public String admin_cancle_account(HttpServletRequest request, Model model, HttpSession session) {
			String card = request.getParameter("card");
			Account oldAccount = accountService.queryAccountExistByCard(card);
			if (oldAccount != null) {
				// 删除旧账户
				accountService.deleteAccount(oldAccount);
				// 在新开一个账户				
				String newName = oldAccount.getUsername();	
				User user = userService.queryUserByName(newName);
				String newOldPayPassword  = oldAccount.getOld_pay_password();
				String newNewPayPassword  = oldAccount.getNew_pay_password();
				String newEmail = user.getEmail();
				String newSex = oldAccount.getSex();
				Double newMoney = oldAccount.getMoney();
				Date date = new Date();
				Timestamp tt = new Timestamp(date.getTime());
				// 生成随机卡号(10位数字字符串)
				String newCard = "";
				Random random = new Random();
				for (int i = 0; i < 10; i++) {
					newCard += String.valueOf(random.nextInt(10));
				}
				while (accountService.queryAccountExistByCard(newCard) != null) {
					for (int i = 0; i < 10; i++) {
						newCard += String.valueOf(random.nextInt(10));
					}
				}
				Account newAccount = new Account(newCard, newName, newSex, newMoney, tt, newOldPayPassword, newNewPayPassword, 0, newEmail);
				System.out.println(newAccount);
				int op = accountService.openAccount(newAccount);	
				if (op > 0) {
					model.addAttribute("msg", "ok");
					model.addAttribute("account_msg", newAccount);
					session.setAttribute("loginAccount", newAccount);
					return "bank/admin_cancel_account";
				} 
				else {
					model.addAttribute("msg", "error");
					return "bank/admin_cancel_account";
				}
				
			} 
			else {
				model.addAttribute("msg", "accounterror");
				return "bank/admin_cancel_account";
			}
		}
		
		// 查询所有日志 潘昱东添加
		@RequestMapping("/selectAccLogList.do")
		@ResponseBody
		public Map<String,Object> selectAccLogList(HttpSession session,@RequestParam(name="condition",required = false)String condition,@RequestParam(required=false,defaultValue="1") Integer page,@RequestParam(required=false,defaultValue="5") Integer limit)
		throws UnsupportedEncodingException {
		//使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
		//从下一条sql开始分页
	    Account acc = (Account)session.getAttribute("loginAccount");
	    String card = acc.getCard();
		PageHelper.startPage(page,limit);
		List<Log> accLogs = null;
		if(condition == null){
		accLogs = logService.queryLogAllByCard(card);
		}
		else{
			condition = "%" + condition + "%";
			SearchCondition sc = new SearchCondition(card,condition);
			accLogs = logService.queryOneAccountLog(sc);
		}
		//使用pageInfo包装查询
		PageInfo<Log> rolePageInfo = new PageInfo<>(accLogs);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("code",0);
		map.put("msg","");
		map.put("count", rolePageInfo.getTotal());
		map.put("data", rolePageInfo.getList());
		return map;
		}
		
		// 查询所有日志 潘昱东添加
		@RequestMapping("/selectLogList.do")
		@ResponseBody
		public Map<String,Object> selectLogList(@RequestParam(name="condition",required = false)String condition,@RequestParam(required=false,defaultValue="1") Integer page,@RequestParam(required=false,defaultValue="5") Integer limit)
				throws UnsupportedEncodingException {
			//使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
			//从下一条sql开始分页
			PageHelper.startPage(page,limit);
			List<Log> logs = null;
			if(condition == null){
				logs = logService.queryAllLog();
			}
			else{
				condition = "%" + condition + "%";
				logs = logService.queryLogByCondition(condition);
			}
			//使用pageInfo包装查询
			PageInfo<Log> rolePageInfo = new PageInfo<>(logs);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("code",0);
			map.put("msg","");
			map.put("count", rolePageInfo.getTotal());
			map.put("data", rolePageInfo.getList());
			return map;
		}
			
       //查询所有账户的分页列表 潘昱东添加
		@RequestMapping("/selectAccList.do")
		@ResponseBody
		public Map<String,Object> selectAccList(@RequestParam(name="condition",required = false)String condition,@RequestParam(required=false,defaultValue="1") Integer page,@RequestParam(required=false,defaultValue="5") Integer limit){
			//使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
			//从下一条sql开始分页
			PageHelper.startPage(page,limit);
			List<Account> accounts = null;
			if(condition == null){
				accounts = accountService.queryAllAccount();
			}
			else{
				condition = "%" + condition + "%";
				accounts = accountService.queryAccountByCondition(condition);
			}
			//使用pageInfo包装查询
			PageInfo<Account> rolePageInfo = new PageInfo<>(accounts);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("code",0);
			map.put("msg","");
			map.put("count", rolePageInfo.getTotal());
			map.put("data", rolePageInfo.getList());
			return map;
		}
}

		