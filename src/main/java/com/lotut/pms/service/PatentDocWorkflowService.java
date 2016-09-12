package com.lotut.pms.service;

import java.util.List;

import com.lotut.pms.domain.PatentDoc;
import com.lotut.pms.domain.PatentDocOrder;

public interface PatentDocWorkflowService {
	int createOrder(PatentDocOrder order, List<PatentDoc> PatentDocs);
	
	PatentDocOrder getOrderById(long orderId);
	
	int updateOrderStatus(long orderId, int status);
	
	void processOrderPaidSuccess(long orderId);
	
	int updatePatentDocStatus(List<Long> patentDocIds, int status);
	
	int updatePatentDocProxyStatus(List<Long> patentDocIds, int status);
	
	void redistributePatentDoc(long patentDocId,int action,int userId);
	
	int getCountByWorkflowHistory(long patentDocId,int userId,int action);
}
