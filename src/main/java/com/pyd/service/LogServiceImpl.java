package com.pyd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pyd.dao.LogMapper;
import com.pyd.entity.Log;
import com.pyd.entity.SearchCondition;

@Service("logService")
public class LogServiceImpl implements LogService{
	@Autowired
    private LogMapper logMapper;
    @Override
	public int changeLog(Log log) {
		// TODO 自动生成的方法存根
		return logMapper.changeLog(log);
	}
    
    @Override
	public Log queryLogByCard(Log log) {
		// TODO 自动生成的方法存根
		return logMapper.queryLogByCard(log);
	}

	@Override
	public List<Log> queryAllLog() {
		// TODO 自动生成的方法存根
		return logMapper.queryAllLog();
	}

	@Override
	public List<Log> queryLogByCondition(String condition) {
		return logMapper.queryLogByCondition(condition);
	}

	// 鄢锦玲
	@Override
	public List<Log> queryLogAllByCard(String card) {
		// TODO 自动生成的方法存根
		return logMapper.queryLogAllByCard(card);
	}

	// 鄢锦玲
	@Override
	public List<Log> queryOneAccountLog(SearchCondition condition) {
		// TODO 自动生成的方法存根
		return logMapper.queryOneAccountLog(condition);
	}

	@Override
	public List<Log> queryLogByCard(String card) {
		// TODO 自动生成的方法存根
		return logMapper.queryLogByCard(card);
	}

}
