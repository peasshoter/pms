package com.lotut.pms.service.impl;


import java.util.List;
import java.util.Map;

import com.lotut.pms.dao.PatentDocWorkflowHistoryDao;
import com.lotut.pms.domain.PatentDocWorkflowHistory;
import com.lotut.pms.domain.PatentDocWorkflowTarget;
import com.lotut.pms.service.PatentDocWorkflowHistoryService;

public class PatentDocWorkflowHistoryServiceImpl implements PatentDocWorkflowHistoryService{
	private PatentDocWorkflowHistoryDao patentDocWorkFlowHistoryDao;
	
	
	
	public PatentDocWorkflowHistoryServiceImpl(PatentDocWorkflowHistoryDao patentDocWorkFlowHistoryDao) {
		this.patentDocWorkFlowHistoryDao = patentDocWorkFlowHistoryDao;
	}

	@Override
	public void addHistory(PatentDocWorkflowHistory patentDocWorkFlowHistory) {
		patentDocWorkFlowHistoryDao.addHistory(patentDocWorkFlowHistory);	
	}

	@Override
	public void addWorkFlowTarget(PatentDocWorkflowTarget patentDocWorkflowTarget) {
		patentDocWorkFlowHistoryDao.addWorkFlowTarget(patentDocWorkflowTarget);
	}

	@Override
	public void insertHistory(List<Map<String, Long>> patentDocWorkflowHistoryRecords) {
		patentDocWorkFlowHistoryDao.insertHistory(patentDocWorkflowHistoryRecords);
	}

//	@Override
//	public List<Long> insertHistory(List<Map<String, Long>> patentDocWorkflowHistoryRecords) {
//		
//		return patentDocWorkFlowHistoryDao.insertHistory(patentDocWorkflowHistoryRecords);
//	}
	
}
