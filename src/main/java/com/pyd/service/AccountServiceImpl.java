package com.pyd.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.jdbc.RuntimeSqlException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pyd.dao.AccountMapper;
import com.pyd.dao.LogMapper;
import com.pyd.dao.UserMapper;
import com.pyd.dbutil.MyBatisUtil;
import com.pyd.entity.Account;
import com.pyd.entity.Deposit;
import com.pyd.entity.Log;
import com.pyd.entity.Pagination;
import com.pyd.entity.SearchCondition;

@Service
public class AccountServiceImpl implements AccountService{
	@Autowired
    private AccountMapper accountMapper;
	@Autowired
    private LogMapper logMapper;
	@Autowired
	private UserMapper userMapper;
	// 存款
		public int saveMoney(Account acc) {
			Date date = new Date();
			Timestamp tt = new Timestamp(date.getTime());
			int num = 0;
			Integer money = Integer.valueOf(acc.getMoney().intValue());
			Log log = new Log(acc.getCard(), money, "存款", tt);
			// 更新account表,返回受影响的行数
			System.out.println(log);
			num = accountMapper.saveMoney(acc);
			logMapper.changeLog(log);
			return num;
		}

		// 取款
		public int takeMoney(Account acc) {
			// 查询账户余额，如果账户不存在或者取款金额大于余额,则本次操作失败
			int reMoney = queryMoney(acc.getCard());
			if (reMoney == -1 || acc.getMoney() > reMoney) {
				return reMoney;
			}
			//操作日期
			Date date = new Date();
			Timestamp tt = new Timestamp(date.getTime());
			int num = 0;
			// 流水日志
			Log log = new Log(acc.getCard(), acc.getMoney().intValue(), "取款", tt);
			// 更新account表,返回受影响的行数
			num = accountMapper.takeMoney(acc);
			logMapper.changeLog(log);
			return num;
		}

	// 转账
	@Transactional(rollbackFor = Exception.class)
	public boolean transferMoney(Account saccount, String recAccountCard) {
		// 查询转账人账户和收款人账户，如果账户不存在,则本次操作失败
		System.out.println(saccount);
		System.out.println(recAccountCard);
		if ((accountMapper.queryAccount(saccount.getCard()) == null)
				&& (accountMapper.queryAccount(recAccountCard) == null)) {
			return false;
		}
		// 操作日期
		Date date = new Date();
		Timestamp tt = new Timestamp(date.getTime());
		// 收款人
		Account raccount = new Account();
		raccount.setCard(recAccountCard);
		raccount.setMoney(saccount.getMoney());
		// 若转账人的账户余额大等于本次转账的数目，则执行转账操作，否则实现事务回滚
		if (accountMapper.queryMoney(saccount.getCard()) >= saccount.getMoney()) {
			accountMapper.takeMoney(saccount);
			accountMapper.saveMoney(raccount);
		}

		Log log_in = new Log(saccount.getCard(), saccount.getMoney().intValue(), "转账", tt);
		Log log_out = new Log(raccount.getCard(), raccount.getMoney().intValue(), "收款", tt);
		logMapper.changeLog(log_in);
		logMapper.changeLog(log_out);
		return true;
	}

	// 判断银行卡归属的账户是否存在
	public List<Account> queryAccount(String card){
		return accountMapper.queryAccount(card);
	}
	
	public boolean checkAccountIsExists(String card) {
		List<Account> listAccount = queryAccount(card);
		if(listAccount == null){
			return false;
		}
		return true;
	}

	// 判断账户是否正确
	public Account queryPassword(Account acc){
		return accountMapper.queryPassword(acc);
	}	
	
	public boolean checkPasswordIsRight(Account acc) {
		Account checkAccount = queryPassword(acc);
		if(checkAccount == null) return false;
		return true;
	}

	// 查询余额,如果账户不存在返回-1
	public int queryMoney(String card) {
         return accountMapper.queryMoney(card);
	}
		
	//开户
	public int openAccount(Account account) {		
		return accountMapper.openAccount(account);
	}
		
	//查询账户总数
	public int queryTotalAccountNumber() {
		return accountMapper.queryTotalAccountNumber();
	}
	
	//查询账户列表(分页查询)
	public List<Account> queryAccountByPage(Pagination pag){
		return accountMapper.queryAccountByPage(pag);
	}
	
	public List<Account> getAccountList(int page, int count) {
		SqlSession session = MyBatisUtil.getSession();
		page = (page - 1)*count;
		Pagination pag = new Pagination(page, count);
		List<Account> list = accountMapper.queryAccountByPage(pag);
		return list;
	}
	
	//挂失账户
	public int deleteAccount(Account account) {	
		return accountMapper.deleteAccount(account);
	}
	
	//查询单个账户
	public Account queryOneAccount(Account account) {
		return accountMapper.queryOneAccount(account);	
	}
		
	
	//根据用户登录名查询用户信息
	public Account queryAccountByName(String username) {
		return accountMapper.queryAccountByName(username);
	}

	//根据卡号查询账单
	public List<Log> getAccountLogByCard(Log msg) {
		return accountMapper.getAccountLogByCard(msg);		 
	}

	@Override
	public int modifyPayPassword(Account acc) {
		// TODO 自动生成的方法存根
		return accountMapper.modifyPayPassword(acc);
	}

	@Override
	public Account queryAccountExistByCard(String card) {
		// TODO 自动生成的方法存根
		return accountMapper.queryAccountExistByCard(card);
	}

	@Override
	public Account queryAccountExistByName(String username) {
		// TODO 自动生成的方法存根
		return accountMapper.queryAccountExistByName(username);
	}
    
	@Override
	public List<Account> queryAllAccount() {
		// TODO 自动生成的方法存根
		return accountMapper.queryAllAccount();
	}
	
	@Override
	public List<Account> queryAccountByCondition(String condition) {
		// TODO 自动生成的方法存根
		return accountMapper.queryAccountByCondition(condition);
	}


}
