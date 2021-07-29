package com.pyd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pyd.entity.Deposit;
import com.pyd.service.EchartsService;
@Controller
@RequestMapping("visualization")
public class EchartsController {
	   @Autowired
	   private EchartsService echartsService; 
	  //查询账户列表中的性别统计数据,并传送给数据可视化界面 潘昱东添加
	   @RequestMapping("queryCntSextoEcharts.do")
	   public @ResponseBody Map<String, Object> queryCntSextoEcharts(HttpServletRequest request){
		   int cntMale = echartsService.queryAccountCntMale();
		   int cntFemale = echartsService.queryAccountCntFeMale();
		   int totalCntSex = cntMale + cntFemale;
		   Map<String,Object> map = new HashMap<String,Object>();
		   map.put("male", cntMale);
		   map.put("female", cntFemale);
		   map.put("total", totalCntSex);
		   return map;		   
	   }
	
	   //查询账户列表中的性别统计数据,并传送给数据可视化界面 潘昱东添加
	   @RequestMapping("queryMoneytoEcharts.do")
	   public @ResponseBody Map<String, Object> queryMoneytoEcharts(HttpServletRequest request){
		   int Below500 = echartsService.queryAccountMoneyBelow500();
		   int Between500to1000 = echartsService.queryAccountMoney500to1000();
		   int Between1000to5000 = echartsService.queryAccountMoney1000to5000();
		   int Above5000 = echartsService.queryAccountMoneyAbove5000();
		   Map<String,Object> map = new HashMap<String,Object>();
		   map.put("level_first", Below500);
		   map.put("level_second", Between500to1000);
		   map.put("level_third", Between1000to5000);
		   map.put("level_forth", Above5000);
		   return map;		   
	   }
	   
	   //查询账户列表中的性别统计数据,并传送给数据可视化界面 潘昱东添加
	   @RequestMapping("queryIsDeletetoEcharts.do")
	   public @ResponseBody Map<String, Object> queryIsDeletetoEcharts(HttpServletRequest request){
		   int cntNoDelete = echartsService.queryAccountNoDelete();
		   int cntIsDelete = echartsService.queryAccountIsDelete();
		   Map<String,Object> map = new HashMap<String,Object>();
		   map.put("NoDelete", cntNoDelete);
		   map.put("IsDelete", cntIsDelete);
		   return map;		   
	   }
	   
	  //查询储蓄列表中的各种储蓄方式的储蓄资金统计数据,并传送给数据可视化界面 潘昱东添加
	   @RequestMapping("queryDeposittoEcharts.do")
	   public @ResponseBody Map<String, Object> queryDeposittoEcharts(HttpServletRequest request){
		   List<Deposit> listDep = echartsService.queryDepositMoney();
		   Map<String,Object> map = new HashMap<String,Object>();
		   for(Deposit deposit : listDep){
			   if(deposit.getSave_way().equals("定期3秒"))
				map.put("regular_3s", deposit.getSave_money());
			   else if(deposit.getSave_way().equals("定期1分"))
					map.put("regular_1m", deposit.getSave_money());
			   else if(deposit.getSave_way().equals("定期1小时"))
					map.put("regular_1h", deposit.getSave_money());
			   else if(deposit.getSave_way().equals("活期存款"))
					map.put("current", deposit.getSave_money());			   
		   }
		   System.out.println("map:" + map);
		   return map;		   
	   }
	   
	 //根据日志列表查询系统运营情况数据,并传送给数据可视化界面 潘昱东添加
	   @RequestMapping("queryOperationtoEcharts.do")
	   public @ResponseBody Map<String, Object> queryOperationtoEcharts(HttpServletRequest request){
		   int last_year = echartsService.queryOperationLastYear();
		   int last_quarter = echartsService.queryOperationLastQuarter();
		   int last_month = echartsService.queryOperationLastMonth();
		   int last_sevendays = echartsService.queryOperationLastSevenDays();
		   int yesterday = echartsService.queryOperationYesterday();
		   int today = echartsService.queryOperationToday();
		   Map<String,Object> map = new HashMap<String,Object>();
		   map.put("last_year",last_year);
		   map.put("last_quarter",last_quarter);
		   map.put("last_month",last_month);
		   map.put("last_sevendays",last_sevendays);
		   map.put("yesterday",yesterday);
		   map.put("today", today);
		   return map;		   
	   }
	   
	   
}
