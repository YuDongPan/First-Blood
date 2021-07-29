package com.pyd.dao;

import java.util.List;

import com.pyd.entity.Account;
import com.pyd.entity.Deposit;
import com.pyd.entity.Log;
import com.pyd.entity.Pagination;
import com.pyd.entity.SearchCondition;

/**
 * @author Administrator
 *
 */
/**
 * @author Administrator
 *
 */
public interface AccountMapper {
	
	/** 
	 * 修改支付密码
	 * @author 胡辉
	 * @param Account
	 * @return 
	 */
	public int modifyPayPassword(Account acc);
	
	
	/**
	 * 账户存款
	 * @param acc.card 存款卡号
	 * @param acc.monsey 存款金额
	 * @return 操作是否成功
	 */
	public int saveMoney(Account acc);
	
	/**
	 * 账户取款
	 * @author 潘昱东
	 * @param acc
	 * @return 返回取款操作是否成功.密码或账号错误会导致操作失败,余额不足也会操作失败
	 */
	public int takeMoney(Account acc);
	
	/**
	 * 判断银行卡归属的账户是否存在
	 * @param card 卡号
	 * @return 是否存在
	 */
	public List<Account> queryAccount(String card);
	public boolean checkAccountIsExists(String card);

	/**
	 * 判断密码是否正确
	 * @param acc 账户信息
	 * @return 密码是否正确
	 */
	
	public Account queryPassword(Account acc);
	public Account checkPasswordIsRight(Account acc);
	
	/**
	 * 查询余额
	 * @param card 卡号
	 * @return 余额,卡号不存在返回-1
	 */
	
	public int queryMoney(String card);

	/**
	 * 转账
	 * @param saccount 转账人账户
	 * @param recAccount 收款人卡号
	 * @return 返回转账操作是否成功.密码或账号错误会导致操作失败,余额不足也会操作失败
	 */
	
	public boolean transferMoney(Account saccount, String recAccount);
	
	/**
	 * 开户
	 * @param account
	 * @return 返回开户是否成功(卡号不能重复)
	 */
	
	public int openAccount(Account account);

	/**
	 * 查询账户总数(用于分页)
	 * @return
	 */
	
	public int queryTotalAccountNumber();
	
	/**
	 * 查询账户列表(分页查询)
	 * @param page
	 * @param count
	 * @return
	 */
	
	public List<Account> queryAccountByPage(Pagination pag);
	public List<Account> getAccountList(int page, int count);
	
	/**
	 * 删除账户(挂失)
	 * @param account
	 * @return
	 */
	
	public int deleteAccount(Account account);
	
	/**
	 * 查询单个账户
	 * @param account
	 * @return
	 */
	
	public Account queryOneAccount(Account account);
	
	/**
	 * @author 潘昱东、胡辉
	 * 根据用户登录名查询账户信息
	 * @param name
	 * @return
	 */
	
	public Account queryAccountByName(String username);

	/**
	 * 根据卡号或者姓名查询流水账单
	 * @param msg
	 * @return
	 */
		
	public List<Log> getAccountLogByCard(Log msg);
	
	/**
	 * 通过卡号查询账户是否存在
	 * @author 鄢锦玲
	 * @param card
	 * @return 
	 * */
	public Account queryAccountExistByCard(String card);
	
	/**
	 * 通过用户名查询账户是否存在
	 * @author 鄢锦玲
	 * @param username
	 * @return 
	 * */
	public Account queryAccountExistByName(String username);
	
	/**
     * 查询所有用户
     * @author 潘昱东
     * @param condition
     * @return 存款情况
     */
	public List<Account> queryAllAccount();
	
	/**
     * 根据条件进行账户储蓄模糊查询
     * @author 潘昱东
     * @param condition
     * @return 账户情况
     */
  
    public List<Account> queryAccountByCondition(String condition);
    
    /**
     * 根据条件进行账户模糊查询记录条数
     * @author 潘昱东
     * @param condition
     * @return 账户情况
     */
  
    public int queryAccountRecordCnt(SearchCondition sc);
}
