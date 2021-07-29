package com.pyd.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pyd.entity.Account;
import com.pyd.entity.Deposit;
import com.pyd.entity.Log;
import com.pyd.entity.SearchCondition;
import com.pyd.service.AccountService;
import com.pyd.service.DepositService;
import com.pyd.service.LogService;

@Controller
@RequestMapping("/bank")
public class DepositController {
	@Autowired
	private DepositService depositService;
	@Autowired
	private LogService logService;
	@Autowired
	private AccountService accountService;
	private int pageSize = 5;
	//用户储蓄存款操作
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("/user_save_deposit.do")
	public String user_save_deposit(HttpServletRequest request, Model model,HttpSession session) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		String save_card = request.getParameter("card");
		if(accountService.queryAccountExistByCard(save_card) == null){
			model.addAttribute("msg","missed_card");
			return "bank/user_save_deposit";
		}		
		String loginUsername = (String)session.getAttribute("loginUsername");
		String pay_password = request.getParameter("pay_password");
		Account acc = accountService.queryAccountByName(loginUsername);
		//检查用户是否修改了初始密码,若不修改则无法执行该操作
    	if(acc.getNew_pay_password().equals(acc.getOld_pay_password()))
    	{
    	model.addAttribute("msg","old_pay_password_error");	
    	return "bank/user_save_deposit";
    	}
    	//检查用户是否输入了正确的支付密码
    	if(!pay_password.equals(acc.getNew_pay_password())){
    	model.addAttribute("msg","password_error");	
        return "bank/user_save_deposit";	
    	}
    	String money = request.getParameter("money");	
		Integer save_money = Integer.valueOf(money);
		String save_way = request.getParameter("way");
		Integer save_arrive = 0;
		Date date = new Date();
		Timestamp save_time = new Timestamp(date.getTime());
		if(save_way.equals("活期存款"))
		save_arrive = 1;
		System.out.println(save_way + " " + save_arrive);
		Deposit deposit = new Deposit(save_card, save_money, save_way, save_arrive,save_time);
		int num = depositService.saveDeposit(deposit);
		if (num > 0) {
			String msg = save_way;
			if(!save_way.equals("活期存款"))
			msg += "存款";
			Log log = new Log(save_card, save_money, msg, save_time);
			logService.changeLog(log);
			model.addAttribute("msg", "user_save_deposit_success");
			model.addAttribute("save_money",save_money);
			if (save_way.equals("定期3秒")){
				double income = new BigDecimal((save_money * 1.10)).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();  
				model.addAttribute("income", income);
			}		
			else if (save_way.equals("定期1分"))
			{ 
				double income = new BigDecimal((save_money * 1.50)).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();  
			   model.addAttribute("income", income);
			}
			else if (save_way.equals("定期1小时")){
				double income = new BigDecimal((save_money * 2.00)).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();  
				model.addAttribute("income", income);
			}
			else if (save_way.equals("活期存款")){
				model.addAttribute("rate", save_money);
			}
			return "toalipay.do?money=" + money + "&&a=123";
		}
		model.addAttribute("msg", "user_save_deposit_failed");
		return "/bank/user_save_deposit";
	}

	// 管理员储蓄存款操作
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("/admin_save_deposit.do")
	public String admin_save_deposit(HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		String save_card = request.getParameter("card");
		if(accountService.queryAccountExistByCard(save_card) == null){
			model.addAttribute("msg","missed_card");
			return "bank/admin_save_deposit";
		}
		String money = request.getParameter("money");
		Integer save_money = Integer.valueOf(money);
		String save_way = request.getParameter("way");
		Integer save_arrive = 0;
		Date date = new Date();
		Timestamp save_time = new Timestamp(date.getTime());
		if(save_way.equals("活期存款"))
		save_arrive = 1;
		Deposit deposit = new Deposit(save_card, save_money, save_way, save_arrive,save_time);
		int num = depositService.saveDeposit(deposit);
		if (num > 0) {
			String msg = save_way;
			if(!save_way.equals("活期存款"))
				msg += "存款";
			Log log = new Log(save_card, save_money, msg, save_time);
			logService.changeLog(log);
			model.addAttribute("msg", "admin_save_deposit_success");
			model.addAttribute("save_money",save_money);
			if (save_way.equals("定期3秒")){
				double income = new BigDecimal((save_money * 1.10)).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();  
				model.addAttribute("income", income);
			}		
			else if (save_way.equals("定期1分"))
			{ 
				double income = new BigDecimal((save_money * 1.50)).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();  
			   model.addAttribute("income", income);
			}
			else if (save_way.equals("定期1小时")){
				double income = new BigDecimal((save_money * 2.00)).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();  
				model.addAttribute("income", income);
			}
			else if (save_way.equals("活期存款")){
				model.addAttribute("rate", save_money);
			}
			return "toalipay.do?money=" + money + "&&a=123";
		}
		model.addAttribute("msg", "admin_save_deposit_failed");
		return "/bank/admin_save_deposit";
	}
	
    //用户储蓄列表
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("admin_deposit_list.do")
	@ResponseBody
	public Map<String,Object> deposit_list(@RequestParam(name="condition",required = false)String condition,@RequestParam(required=false,defaultValue="1") Integer page,@RequestParam(required=false,defaultValue="5") Integer limit,HttpSession session){
		//SearchCondition scIndex = new SearchCondition(condition, page, limit);
		List<Deposit> listDps = depositService.queryDepositByCondition(condition);
		for(Deposit dps:listDps){
			Date date = new Date();
			Timestamp current_time = new Timestamp(date.getTime());
			double time_gap = (current_time.getTime() - dps.getSave_time().getTime())*0.001;
			if (dps.getSave_way().equals("定期3秒")) {
				if(time_gap >= 3 && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 1.10;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}
			} else if (dps.getSave_way().equals("定期1分")) {
				if(time_gap >= 60  && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 1.50;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}

			} else if (dps.getSave_way().equals("定期1小时")) {
				if(time_gap >= 3600  && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 2.00;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}

			} else if (dps.getSave_way().equals("活期存款")) {	
					double money1 = dps.getSave_money() * 1.09;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					depositService.updateDeposit(dps);				
			}			
		}	
		//使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
		//从下一条sql开始分页
		List<Deposit> deposits = null;
		PageHelper.startPage(page,limit);
		if(condition == null){
			deposits = depositService.queryAllDeposit();
		}
		else{
			condition = "%" + condition + "%";
			deposits = depositService.queryDepositByCondition(condition);
		}
		System.out.println(deposits);
		//使用pageInfo包装查询
		PageInfo<Deposit> rolePageInfo = new PageInfo<>(deposits);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("code",0);
		map.put("msg","");
		map.put("count", rolePageInfo.getTotal());
		map.put("data", rolePageInfo.getList());
		return map;
	}
	
    //查询单个用户储蓄列表
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("account_deposit_list.do")
	@ResponseBody
	public Map<String,Object> account_deposit_list(@RequestParam(required=false,defaultValue="1") Integer page,@RequestParam(required=false,defaultValue="5") Integer limit,HttpSession session){
		//SearchCondition scIndex = new SearchCondition(condition, page, limit);
		String card = (String)session.getAttribute("card");
		Account loginAccount = (Account)session.getAttribute("loginAccount");
		if(card == null){
			card = loginAccount.getCard();
		}
		List<Deposit> listDps = depositService.queryOneAccountDeposit(card);
		for(Deposit dps:listDps){
			Date date = new Date();
			Timestamp current_time = new Timestamp(date.getTime());
			double time_gap = (current_time.getTime() - dps.getSave_time().getTime())*0.001;
			if (dps.getSave_way().equals("定期3秒")) {
				if(time_gap >= 3 && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 1.10;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}
			} else if (dps.getSave_way().equals("定期1分")) {
				if(time_gap >= 60  && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 1.50;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}

			} else if (dps.getSave_way().equals("定期1小时")) {
				if(time_gap >= 3600  && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 2.00;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}

			} else if (dps.getSave_way().equals("活期存款")) {	
					double money1 = dps.getSave_money() * 1.09;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					depositService.updateDeposit(dps);				
			}			
		}
		
		//使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
		//从下一条sql开始分页
		List<Deposit> deposits = null;
		PageHelper.startPage(page,limit);
		deposits = depositService.queryOneAccountDeposit(card);
		//使用pageInfo包装查询
		PageInfo<Deposit> rolePageInfo = new PageInfo<>(deposits);
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		map.put("code",0);
		map.put("msg","");
		map.put("count", rolePageInfo.getTotal());
		dataMap.put("item", rolePageInfo.getList());
		map.put("data", dataMap);
		return map;
	}
	
		//用户储蓄链入操作
		@Transactional(rollbackFor = Exception.class)
		@RequestMapping("/user_take_deposit_first.do")
		public String user_take_deposit_first(Integer pageNow,HttpSession session, HttpServletRequest request,Model model){
			Account currentAccount = (Account)session.getAttribute("loginAccount");
			String card = currentAccount.getCard();
			if(accountService.queryAccountExistByCard(card) == null){
				model.addAttribute("msg","missed_card");
				return "bank/user_take_deposit_first";
			}
			String loginUsername = (String)session.getAttribute("loginUsername");
			String pay_password = request.getParameter("pay_password");
			Account acc = accountService.queryAccountByName(loginUsername);
			//检查用户是否修改了初始密码,若不修改则无法执行该操作
	    	if(acc.getNew_pay_password().equals(acc.getOld_pay_password()))
	    	{
	    	model.addAttribute("msg","old_pay_password_error");	
	    	return "bank/user_take_deposit_first";
	    	}
	    	//检查用户是否输入了正确的支付密码
	    	if(!pay_password.equals(acc.getNew_pay_password())){
	    	model.addAttribute("msg","password_error");	
	        return "bank/user_take_deposit_first";	
	    	}
	    	session.setAttribute("card", card);
			return "/bank/user_take_deposit";	
		}
	
		//用户储蓄取款操作
	    @Transactional(rollbackFor = Exception.class)
		@RequestMapping("/user_take_deposit.do")
	    @ResponseBody
		public Map<String,Object> user_take_deposit(Integer id,Integer money,@RequestParam(required=false,defaultValue="1") Integer page,@RequestParam(required=false,defaultValue="5") Integer limit,Model model,HttpSession session){
	    	//获取当前用户的相应信息
	    	Account currentAccount = (Account)session.getAttribute("loginAccount");	
			String card = currentAccount.getCard();
	    	//获取相应数据
			Integer take_id = id;
			Integer take_money = money;
			Deposit deposit = depositService.queryDepositById(take_id);
			String save_way = deposit.getSave_way();
			Integer save_arrive = deposit.getSave_arrive();
			Date date1 = new Date();
			Timestamp take_time = new Timestamp(date1.getTime());
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> dataMap = new HashMap<String,Object>();
			//计算取款后相应金额，做不同操作
			int remain = deposit.getSave_money() - take_money;
			if(remain > 0 && deposit.getSave_arrive() == 1){
				deposit.setSave_money(remain);
				depositService.takeDeposit(deposit);
				//将取出的钱打到用户账户上
				Account acc = new Account(card,money*1.0);
				accountService.saveMoney(acc);
				dataMap.put("msg_take","user_take_deposit_success");
				dataMap.put("take_money", take_money);
				dataMap.put("remain", remain);
			}
			else if(remain == 0 && deposit.getSave_arrive() == 1){
				//将取出的钱打到用户账户上
				Account acc = new Account(card,money*1.0);
				accountService.saveMoney(acc);
				depositService.deleteDeposit(take_id);
				dataMap.put("msg_take","user_take_deposit_success");
				dataMap.put("take_money", take_money);
				dataMap.put("remain", remain);
			}
			else if(remain < 0 || deposit.getSave_arrive() == 0){
				dataMap.put("msg_take","user_take_deposit_failed");
			}			
			
		    List<Deposit> listDps = depositService.queryOneAccountDeposit(card);
			for(Deposit dps:listDps){
				Date date2 = new Date();
				Timestamp current_time = new Timestamp(date2.getTime());
				double time_gap = (current_time.getTime() - dps.getSave_time().getTime())*0.001;
				if (dps.getSave_way().equals("定期3秒")) {
					if(time_gap >= 3 && dps.getSave_arrive() == 0){
						double money1 = dps.getSave_money() * 1.10;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						dps.setSave_arrive(1);
						depositService.updateDeposit(dps);				
					}
				} else if (dps.getSave_way().equals("定期1分")) {
					if(time_gap >= 60  && dps.getSave_arrive() == 0){
						double money1 = dps.getSave_money() * 1.50;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						dps.setSave_arrive(1);
						depositService.updateDeposit(dps);				
					}

				} else if (dps.getSave_way().equals("定期1小时")) {
					if(time_gap >= 3600  && dps.getSave_arrive() == 0){
						double money1 = dps.getSave_money() * 2.00;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						dps.setSave_arrive(1);
						depositService.updateDeposit(dps);				
					}

				} else if (dps.getSave_way().equals("活期存款")) {	
						double money1 = dps.getSave_money() * 1.09;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						depositService.updateDeposit(dps);				
				}			
			}
			String loginUsername = (String)session.getAttribute("loginUsername");
			Account loginAccount = accountService.queryAccountByName(loginUsername);
			session.setAttribute("loginAccount", loginAccount);
			//使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
			//从下一条sql开始分页
			List<Deposit> deposits = null;
			PageHelper.startPage(page,limit);
			deposits = depositService.queryOneAccountDeposit(card);
			//使用pageInfo包装查询
			PageInfo<Deposit> rolePageInfo = new PageInfo<>(deposits);
			map.put("code",0);
			map.put("msg","");
			map.put("count", rolePageInfo.getTotal());
			dataMap.put("item", rolePageInfo.getList());
			map.put("data", dataMap);		
			return map;
		}
	
	    //管理员储蓄取款链入列表操作
	    @Transactional(rollbackFor = Exception.class)
		@RequestMapping("/admin_take_deposit_first.do")
		public String admin_take_deposit_first(Integer pageNow, HttpServletRequest request, Model model,HttpSession session){
			String card = request.getParameter("card");
			if(card != null){ 
			session.setAttribute("card", card);
			card = (String)session.getAttribute("card");
			}
			else{
				model.addAttribute("msg","missed_card");
				return "bank/admin_take_deposit_first";
			}
			if(accountService.queryAccountExistByCard(card) == null){
				model.addAttribute("msg","missed_card");
				return "bank/admin_take_deposit_first";
			}	
			return "bank/admin_take_deposit";
		}
		
		//管理员储蓄取款操作
	    @Transactional(rollbackFor = Exception.class)
		@RequestMapping("/admin_take_deposit.do")
	    @ResponseBody
		public Map<String,Object> admin_take_deposit(Integer id,Integer money,@RequestParam(required=false,defaultValue="1") Integer page,@RequestParam(required=false,defaultValue="5") Integer limit,Model model,HttpSession session) throws UnsupportedEncodingException {
			//获取当前用户的相应信息	
			String card = (String)session.getAttribute("card");
	    	//获取相应数据
			Integer take_id = id;
			Integer take_money = money;
			Deposit deposit = depositService.queryDepositById(take_id);
			String save_way = deposit.getSave_way();
			Integer save_arrive = deposit.getSave_arrive();
			Date date1 = new Date();
			Timestamp take_time = new Timestamp(date1.getTime());
			//计算取款后相应金额，做不同操作
			int remain = deposit.getSave_money() - take_money;
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> dataMap = new HashMap<String,Object>();
			if(remain > 0 && deposit.getSave_arrive() == 1){
				deposit.setSave_money(remain);
				depositService.takeDeposit(deposit);
				//将取出的钱打到用户账户上
				Account acc = new Account(card,money*1.0);
				accountService.saveMoney(acc);
				dataMap.put("msg_take","admin_take_deposit_success");
				dataMap.put("take_money", take_money);
				dataMap.put("remain", remain);
			}
			else if(remain == 0 && deposit.getSave_arrive() == 1){
				//将取出的钱打到用户账户上
				Account acc = new Account(card,money*1.0);
				accountService.saveMoney(acc);
				depositService.deleteDeposit(take_id);
				dataMap.put("msg_take","admin_take_deposit_success");
				dataMap.put("take_money", take_money);
				dataMap.put("remain", remain);
			}
			else if(remain < 0 || deposit.getSave_arrive() == 0){
				dataMap.put("msg_take","admin_take_deposit_failed");
			}			
			
			SearchCondition scIndex = new SearchCondition(card, page, limit);
		    List<Deposit> listDps = depositService.queryOneAccountDeposit(card);
		    
			for(Deposit dps:listDps){
				Date date2 = new Date();
				Timestamp current_time = new Timestamp(date2.getTime());
				double time_gap = (current_time.getTime() - dps.getSave_time().getTime())*0.001;
				if (dps.getSave_way().equals("定期3秒")) {
					if(time_gap >= 3 && dps.getSave_arrive() == 0){
						double money1 = dps.getSave_money() * 1.10;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						dps.setSave_arrive(1);
						depositService.updateDeposit(dps);				
					}
				} else if (dps.getSave_way().equals("定期1分")) {
					if(time_gap >= 60  && dps.getSave_arrive() == 0){
						double money1 = dps.getSave_money() * 1.50;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						dps.setSave_arrive(1);
						depositService.updateDeposit(dps);				
					}

				} else if (dps.getSave_way().equals("定期1小时")) {
					if(time_gap >= 3600  && dps.getSave_arrive() == 0){
						double money1 = dps.getSave_money() * 2.00;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						dps.setSave_arrive(1);
						depositService.updateDeposit(dps);				
					}

				} else if (dps.getSave_way().equals("活期存款")) {	
						double money1 = dps.getSave_money() * 1.09;
						int money2 = (int) Math.round(money1);
						dps.setSave_money(money2);
						depositService.updateDeposit(dps);				
				}			
			}
			//使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
			//从下一条sql开始分页
			List<Deposit> deposits = null;
			PageHelper.startPage(page,limit);
			deposits = depositService.queryOneAccountDeposit(card);
			//使用pageInfo包装查询
			PageInfo<Deposit> rolePageInfo = new PageInfo<>(deposits);
			map.put("code",0);
			map.put("msg","");
			map.put("count", rolePageInfo.getTotal());
			dataMap.put("item", rolePageInfo.getList());
			map.put("data", dataMap);
			return map;
	}

	// 用户储蓄查询操作
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("/user_query_deposit.do")
	public String user_query_deposit(String condition,Integer pageNow,HttpServletRequest request,HttpSession session,Model model){
		Account currentAccount = (Account)session.getAttribute("loginAccount");
		String card = currentAccount.getCard();
		if(accountService.queryAccountExistByCard(card) == null){
			model.addAttribute("msg","missed_card");
			return "bank/user_query_deposit";
		}
		String loginUsername = (String)session.getAttribute("loginUsername");
		String pay_password = request.getParameter("pay_password");
		Account acc = accountService.queryAccountByName(loginUsername);
		//检查用户是否修改了初始密码,若不修改则无法执行该操作
    	if(acc.getNew_pay_password().equals(acc.getOld_pay_password()))
    	{
    	model.addAttribute("msg","old_pay_password_error");	
    	return "bank/user_query_deposit";
    	}
    	//检查用户是否输入了正确的支付密码
    	if(!pay_password.equals(acc.getNew_pay_password())){
    	model.addAttribute("msg","password_error");	
        return "bank/user_query_deposit";	
    	}
		SearchCondition scIndex = new SearchCondition(card, pageNow, pageSize);
	    List<Deposit> listDps = depositService.queryOneAccountDeposit(card);
	    System.out.println(listDps);
	    session.setAttribute("scIndex", scIndex);
		for(Deposit dps:listDps){
			Date date = new Date();
			Timestamp current_time = new Timestamp(date.getTime());
			double time_gap = (current_time.getTime() - dps.getSave_time().getTime())*0.001;
			if (dps.getSave_way().equals("定期3秒")) {
				if(time_gap >= 3 && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 1.10;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}
			} else if (dps.getSave_way().equals("定期1分")) {
				if(time_gap >= 60  && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 1.50;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}

			} else if (dps.getSave_way().equals("定期1小时")) {
				if(time_gap >= 3600  && dps.getSave_arrive() == 0){
					double money1 = dps.getSave_money() * 2.00;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					dps.setSave_arrive(1);
					depositService.updateDeposit(dps);				
				}

			} else if (dps.getSave_way().equals("活期存款")) {	
					double money1 = dps.getSave_money() * 1.09;
					int money2 = (int) Math.round(money1);
					dps.setSave_money(money2);
					depositService.updateDeposit(dps);				
			}			
		}	
		session.setAttribute("listDps", listDps);
		return "/bank/user_deposit_list";
	}
}
