package com.pyd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pyd.dao.DepositMapper;
import com.pyd.entity.Deposit;
import com.pyd.entity.SearchCondition;

@Service
public class DepositServiceImpl implements DepositService {
	@Autowired
    private DepositMapper depositMapper;
	@Override
	public int saveDeposit(Deposit deposit) {
		// TODO 自动生成的方法存根
		return depositMapper.saveDeposit(deposit);
	}

	@Override
	public int takeDeposit(Deposit dps) {
		// TODO 自动生成的方法存根
		return depositMapper.updateDeposit(dps);
	}
    
	@Override
	public List<Deposit> queryAllDeposit() {
		// TODO 自动生成的方法存根
		return depositMapper.queryAllDeposit();
	}
	
	
	@Override
	public List<Deposit> queryDepositByCard(String save_card) {
		// TODO 自动生成的方法存根
		return depositMapper.queryDepositByCard(save_card);
	}

	@Override
	public int deleteDeposit(Integer id) {
		// TODO 自动生成的方法存根
		return depositMapper.deleteDeposit(id);
	}

	@Override
	public Deposit queryDepositById(Integer id) {
		// TODO 自动生成的方法存根
		return depositMapper.queryDepositById(id);
	}

	@Override
	public Deposit queryDeposit(Deposit dps) {
		// TODO 自动生成的方法存根
		return depositMapper.queryDeposit(dps);
	}

	@Override
	public int updateDeposit(Deposit dps) {
		// TODO 自动生成的方法存根
		return depositMapper.updateDeposit(dps);
	}

	@Override
	public List<Deposit> queryDepositByCondition(String condition) {
		// TODO 自动生成的方法存根
		return depositMapper.queryDepositByCondition(condition);
	}

	@Override
	public List<Deposit> queryOneAccountDeposit(String card) {
		// TODO 自动生成的方法存根
		return depositMapper.queryOneAccountDeposit(card);
	}

  
}
