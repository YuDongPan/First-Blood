package com.pyd.dao;

import java.util.List;

import com.pyd.entity.Log;
import com.pyd.entity.SearchCondition;

public interface LogMapper {
	 /**
	  * 更改流水日志
	  * @author 潘昱东
	  * @param log
	  * @return 操作结果
	  */
     public int changeLog(Log log);
     
     /**
      * 查询流水日志
      * @author 潘昱东
      * @param log
      * @return 查询结果
      */
     public Log queryLogByCard(Log log);
     
     /**
      * 根据卡号搜索所有日志
      * @author 胡辉、鄢锦玲
      * @param card
      * @return
      */
     public List<Log> queryLogByCard(String card);
     
     /**
      * 查询所有日志
      * @author 胡辉
      * @param 
      * @return
      */
     public List<Log> queryAllLog();
     
     /**
      * 根据条件模糊查询所有日志
      * @author 胡辉
      * @param condition
      * @return
      */
     public List<Log> queryLogByCondition(String condition);
     
     /**
      * 根据条件模糊查询所有日志数量
      * @author 胡辉
      * @param condition
      * @return
      */  
     public int queryLogsRecordCnt(SearchCondition condition);
     
     /**
      * 查询单个用户的所有日志
      * @author 鄢锦玲
      * @param card
      * @return
      */
     
     public List<Log> queryLogAllByCard(String card);
     
     /**
      * 查询单个用户指定条件的日志
      * @author 鄢锦玲
      * @param condition
      * @return
      */
     
     public List<Log> queryOneAccountLog(SearchCondition condition);
      
     /**
      * 查询单个用户的所有日志
      * @author 鄢锦玲
      * @param condition
      * @return
      */
     public int queryOneAccountNum(SearchCondition condition);
     
}
