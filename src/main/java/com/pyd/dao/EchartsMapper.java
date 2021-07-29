package com.pyd.dao;

import java.util.List;

import com.pyd.entity.Deposit;

public interface EchartsMapper {
	/**
	 * 查询账户列表中性别男的账户数量(用于echarts)
	 * @author 潘昱东
	 * @return
	 */
	public int queryAccountCntMale();
	
	/**
	 * 查询账户列表中性别女的账户数量(用于echarts)
	 * @author 潘昱东
	 * @return
	 */
	public int queryAccountCntFeMale();
	
	/**
	 * 查询账户列表中用户余额低于500的用户数量
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryAccountMoneyBelow500();
	
	/**
	 * 查询账户列表中用户余额介于500~1000的用户数量
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryAccountMoney500to1000();
	
	/**
	 * 查询账户列表中用户余额介于1000~5000的用户数量
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryAccountMoney1000to5000();
	
	/**
	 * 查询账户列表中用户余额大于5000的用户数量
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryAccountMoneyAbove5000();
	
	/**
	 * 查询账户列表中未挂失账户数量
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryAccountNoDelete();
	
	/**
	 * 查询账户列表中挂失账户数量
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryAccountIsDelete();
	
	/**
	 * 查询储蓄资金列表中各种储蓄方式的资金总额
	 * @author 潘昱东
	 * @return
	 */
	
	public List<Deposit> queryDepositMoney();
	
	
	/**
	 * 根据日志列表查询去年系统运营情况
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryOperationLastYear();
	
	
	/**
	 * 根据日志列表查询上个季度系统运营情况
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryOperationLastQuarter();
	
	
	
	/**
	 * 根据日志列表查询上个月系统运营情况
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryOperationLastMonth();
	
	/**
	 * 根据日志列表查询过去七天系统运营情况
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryOperationLastSevenDays();
	
	/**
	 * 根据日志列表查询昨天系统运营情况
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryOperationYesterday();
	
	/**
	 * 根据日志列表查询今天系统运营情况
	 * @author 潘昱东
	 * @return
	 */
	
	public int queryOperationToday();
		
}
