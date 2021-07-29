package com.pyd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pyd.dao.AccountMapper;
import com.pyd.dao.DepositMapper;
import com.pyd.dao.EchartsMapper;
import com.pyd.dao.LogMapper;
import com.pyd.dao.UserMapper;
import com.pyd.entity.Deposit;

@Service
public class EchartsServiceImpl implements EchartsService{
    @Autowired
    private EchartsMapper echartsMapper;
    @Override
	public int queryAccountCntMale() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountCntMale();
	}

	@Override
	public int queryAccountCntFeMale() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountCntFeMale();
	}

	@Override
	public int queryAccountMoneyBelow500() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountMoneyBelow500();
	}

	@Override
	public int queryAccountMoney500to1000() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountMoney500to1000();
	}

	@Override
	public int queryAccountMoney1000to5000() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountMoney1000to5000();
	}

	@Override
	public int queryAccountMoneyAbove5000() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountMoneyAbove5000();
	}

	@Override
	public int queryAccountNoDelete() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountNoDelete();
	}

	@Override
	public int queryAccountIsDelete() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryAccountIsDelete();
	}

	@Override
	public List<Deposit> queryDepositMoney() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryDepositMoney();
	}

	@Override
	public int queryOperationLastYear() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryOperationLastYear();
	}

	@Override
	public int queryOperationLastQuarter() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryOperationLastQuarter();
	}

	@Override
	public int queryOperationLastMonth() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryOperationLastMonth();
	}

	@Override
	public int queryOperationLastSevenDays() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryOperationLastSevenDays();
	}

	@Override
	public int queryOperationYesterday() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryOperationYesterday();
	}

	@Override
	public int queryOperationToday() {
		// TODO 自动生成的方法存根
		return echartsMapper.queryOperationToday();
	}

}
