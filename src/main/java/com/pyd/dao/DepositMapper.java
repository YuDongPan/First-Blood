package com.pyd.dao;

import java.util.List;

import com.pyd.entity.Deposit;
import com.pyd.entity.SearchCondition;

public interface DepositMapper {
	
	/**
	 * 储蓄存款
	 * @author 潘昱东
	 * @param deposit
	 * @return 操作是否成功
	 */
	
    public int saveDeposit(Deposit dps);
    
    /**
     * 储蓄取款
     * @author 潘昱东
     * @param deposit
     * @return 操作是否成功,账户不存在,账户挂失,余额不足均会导致操作失败
     */
    
    public int takeDeposit(Deposit dps);
    
    /**
     * 储蓄删除
     * @author 潘昱东
     * @param deposit
     * @return 操作是否成功,当存款完全被取出时才能够被删除
     */
    
    public int deleteDeposit(Integer id);
    
    /**
     * 储蓄更新
     * @author 潘昱东
     * @param deposit
     * @return 操作是否成功,根据存款方式进行不同利息计算
     */
    
    public int updateDeposit(Deposit dps);
    
    /**
     * 查询所有储蓄记录
     * @author 潘昱东
     * @return 存款情况
     */
    public List<Deposit> queryAllDeposit();
    
    /**
     * 通过卡号进行储蓄查询
     * @author 潘昱东
     * @param save_card
     * @return 存款情况
     */
    
    public List<Deposit> queryDepositByCard(String save_card);
    
    /**
     * 通过id进行储蓄查询
     * @author 潘昱东
     * @param id
     * @return 存款情况
     */
  
    public Deposit queryDepositById(Integer id);
    
    
    /**
     * 储蓄查询
     * @author 潘昱东
     * @param deposit
     * @return 存款情况
     */
  
    public Deposit queryDeposit(Deposit dps);
    
    /**
     * 根据条件进行储蓄模糊查询
     * @author 潘昱东
     * @param condition
     * @return 存款情况
     */
  
    public List<Deposit> queryDepositByCondition(String condition);
    
    /**
     * 根据条件进行储蓄模糊查询记录条数
     * @author 潘昱东
     * @param condition
     * @return 存款情况
     */
  
    public int queryDepositRecordCnt(SearchCondition sc);
     
    /**
     * 根据条件进行储蓄精确查询存储情况
     * @author 潘昱东
     * @param condition
     * @return 存款情况
     */
    public List<Deposit> queryOneAccountDeposit(String card);
    
    
    /**
     * 根据条件进行储蓄精确查询记录条数
     * @author 潘昱东
     * @param condition
     * @return 存款情况
     */
    public int queryOneAccountDepositRecordCnt(SearchCondition sc);
    
    
}
