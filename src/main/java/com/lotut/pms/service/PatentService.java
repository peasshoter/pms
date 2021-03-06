package com.lotut.pms.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import com.lotut.pms.domain.GoodsDetail;
import com.lotut.pms.domain.GoodsFirstColumn;
import com.lotut.pms.domain.GoodsSecondColumn;
import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.Patent;
import com.lotut.pms.domain.PatentRemark;
import com.lotut.pms.domain.PatentSearchCondition;
import com.lotut.pms.domain.PatentStatus;
import com.lotut.pms.domain.PatentType;
import com.lotut.pms.domain.SalePatentGood;
import com.lotut.pms.domain.TransactionPatentSearchCondition;

public interface PatentService {
	public long getPatentsCount(int userId);
	
	List<Patent> getUserPatents(Page page);
	
	List<Patent> getUserPatentsByType(int userId, int patentType);
	
	List<Patent> getUserPatentsByStatus(int userId, int patentStatus);
	
	Patent getPatentDetail(long patentId);
	
	List<Patent> searchUserPatents(PatentSearchCondition searchCondition);
	
	public long searchUserPatentsCount(PatentSearchCondition searchCondition);
	
	List<Patent> searchUserPatentsWithPage(PatentSearchCondition searchCondition);
	
	List<PatentType> getAllPatentTypes();
	
	List<PatentStatus> getAllPatentStatus();
	
	void changeInternalCode(int patentId, String internalCode);
	

	boolean uploadPatents(InputStream is,int userId) throws IOException;

	public List<GoodsFirstColumn> getFirstColumn();

	public List<GoodsSecondColumn> getSecondColumn(int firstColumnId);

	public void saveGoods(GoodsDetail goodsDetail);
	
	 void addPatent(Patent patent);
	 
	 Map<String, Map<String, String>> getUserPatentCountByType( int userId);
	 
	 Map<String, Map<String, String>> searchUserPatentsByPatentStatus(int userId);
	 
	 List<Patent> getUserPatentsWithFee(int userId);
	 
	 Patent getPatentsByAppNo(Integer userId,String appNo);
	 
	 Long getPatentIdByAppNo(Integer userId,String appNo);
	 
	 void autoUpdatePatents(InputStream is,int userId) throws IOException;
	 
//	 String generatePatentExportExcel(List<Long> patentIds,String excelName) throws IOException;
	 
	 public boolean  addOrUpdatePatents(List<Patent> patents,int userId);
	 
	 List<GoodsDetail> getUserTransactionPatents(Page page);
	 
	 int getUserTransactionPatentsCount(int userId);

	 List<GoodsDetail> searchTransactionPatentsByPage(TransactionPatentSearchCondition searchCondition);
		
	int searchTransactionPatentsCount(TransactionPatentSearchCondition searchCondition);
	
	public void downTransactionPatent(int patentId);

	public void upTransactionPatent(int patentId);

	public void deleteTransactionPatent(int patentId);
	
	void patentsTrash(List<Long> patentIds,int userId);

	List<Patent> getPatentsRecycled(Page page);
	
	int getPatentsRecycledCount(int userId);
	
	void recoverPatents(List<Long> patentIds,int userId );
	
	void deleteForeverPatents(List<Long> patentIds,int userId);
	
	List<Patent> getUserPatentsByCreateTime(Page page);
	
	void batchSaveGoods(List<Long> patentIds,int userId,String transferor);
	
	void updatePatentsGoodsStatus(List<Long> patentIds);
	
	void updateGoodPatents(int price,int SecondColumn,int patentId);
	

	void changePrice(int price,int patentId);
	
	void changSecondColume(int SecondColumn,int patentId);
	
	void batchChangePrice(int price,List<Long> patentIds);

	boolean bacthsaveGoodsCheckOut(List<Long> patentIds);
	
	List<PatentRemark> getPatentRemarks(long patentId);
	
	void addPatentRemark(long patentId,String content,int userId);
	
	Patent showPatentDetail(long patentId);
	
	boolean savePatentDetail(Patent patent);
	
	void deleteShareUser(long patentId,int ownerId,int shareUserId);
	
	String patentExportExcel(List<Long> patentIds,String exportExcelName) throws IOException;

	String patentTransactionExportExcel(List<Long> patentIds,String exportExcelName) throws IOException;	
	
	public void cancelRecommendPatent(long patentId);
	
	public void recommendPatent(long patentId);	
	
	void batchChangeTransferor(String transferor,List<Long> patentIds);
	
	void saveSellPatentDescription(String description,int patentId);

	public Map<String, Map<String, String>> getUserTransactionCountByPatentType(int userId);

	public Map<String, Map<String, String>> searchUserTransactionByTransactionStatus(int userId);

	List<Patent> exportTransactionPatents(List<Long> patentIds);
	
	void changeStatus(int status,int patentId);
	
	void batchChangeDescription(String description,List<Long> patentIds);
	
	void batchUpdatePatentField(int field,List<Long> patentIds);
	
	Patent getOverviewPatentByAppNo(String appNo,int userId);
	
	List<PatentRemark> getRemarkByUserIdAndAppNo(String appNo,int userId);
	
	SalePatentGood getTransactionOverview(String appNo,int userId);

	List<GoodsDetail>searchAllTransactionPatentsByPage(TransactionPatentSearchCondition searchCondition);
	
	int searchAllTransactionPatentsCount(TransactionPatentSearchCondition searchCondition);
	
	Map<String, Map<String, String>> getTraderUserTransactionCountByPatentType(TransactionPatentSearchCondition searchCondition);

	Map<String, Map<String, String>> searchTraderUserTransactionByTransactionStatus(TransactionPatentSearchCondition searchCondition);
	
	List<GoodsDetail> getAllUserTransactionPatents(Page page);
	
	int getAllUserTransactionPatentsCount();
	
	Map<String, Map<String, String>> getTransactionCountByPatentType();
	
	Map<String, Map<String, String>> getTransactionByTransactionStatus();
	
	String getLotutPatentExportExcel(int userId,String exportExcelName) throws IOException;
	
	List<Patent> getUserAnnualFeeMonitorPatents(Page page);
	
	int  getUserAnnualFeeMonitorPatentsCount(int userId);
	
	boolean isFeeMonitorPatents(int userId,List<Long> patentIds);
	
	void batchAddFeeMonitorPatents(int userId,List<Long> patentIds);
	
	void batchCancelFeeMonitorPatents(int userId,List<Long> patentIds);
	
	List<Patent> searchUserAnnualFeeMonitorPatents(PatentSearchCondition searchCondition);
	
	int searchUserAnnualFeeMonitorPatentsCount(PatentSearchCondition searchCondition);
	
	List<Patent> SearchPatentsRecycled(PatentSearchCondition searchCondition);
	
	int SearchPatentsRecycledCount(PatentSearchCondition searchCondition);
	
	void changeUserPatentRemark(int userId,long patentId,String patentRemark);
	
	List<Map<String,String>> getAppPersonCountByAppPerson(int userId);
}

