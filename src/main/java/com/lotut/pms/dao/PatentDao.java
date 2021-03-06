package com.lotut.pms.dao;

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

public interface PatentDao {
	int getUserPatentCount(int userId);
	List<Patent> getUserPatents(Page page);
	
	List<Patent> getUserPatentsByType(int userId, int patentType);
	
	List<Patent> getUserPatentsByStatus(int userId, int patentStatus);
	
	Patent getPatentById(long patentId);
	
	List<Patent> getPatentsByIds(List<Long> patentIds);
	
	Patent getPatentByAppNoAndOwner(String appNo, int ownerId);
	
	List<Patent> searchUserPatents(PatentSearchCondition searchCondition);
	//搜索分页
	int searchUserPatentsCount(PatentSearchCondition searchCondition);
	
	List<Patent> searchUserPatentsByPage(PatentSearchCondition searchCondition);
	
	List<PatentType> getAllPatentTypes();
	
	List<PatentStatus> getAllPatentStatus();
	
	void updateInternalCode(int patentId, String internalCode);
	
	long insertOrUpdatePatent(Patent patent);
	void insertPatent(Patent patent);
	
	void updatePatent(Patent patent);
	List<GoodsFirstColumn> getFirstColumn();
	List<GoodsSecondColumn> getSecondColumn(int firstColumnId);
	void saveGoods(GoodsDetail goodsDetail);
	
	void addPatent(Patent patent);
	
	Map<String, Map<String, String>> getUserPatentCountByType(int userId);
	
	Map<String, Map<String, String>> searchUserPatentsByPatentStatus(int userId);
	
	List<Patent> getUserPatentsWithFee(int userId);
	
	Patent getPatentsByAppNo(Integer userId,String appNo);
	
	Long getPatentIdByAppNo(Integer userId,String appNo);
	
	List<GoodsDetail> getUserTransactionPatents(Page page);
	
	int getUserTransactionPatentsCount(int userId);
	
	List<GoodsDetail> searchTransactionPatentsByPage(TransactionPatentSearchCondition searchCondition);
	
	int searchTransactionPatentsCount(TransactionPatentSearchCondition searchCondition);

	void downTransactionPatent(int patentId);
	void upTransactionPatent(int patentId);
	void deleteTransactionPatent(int patentId);
	
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
	
	void changeStatus(int status,int patentId);
	
	void changSecondColume(int SecondColumn,int patentId);
	
	void batchChangePrice(int price,List<Long> patentIds);

	int bacthsaveGoodsCheckOut(List<Long> patentIds);
	
	List<PatentRemark> getPatentRemarks(long patentId);
	
	void addPatentRemark(long patentId,String content,int userId);

	Patent showPatentDetail(long patentId);
	
	boolean savePatentDetail(Patent patent);
	
	void deleteShareUser(long patentId, int ownerId, int shareUserId);
	
	List<Integer> getPatentDocShareUesrs(String internalCode);
	
	Long getPatentIdByInternalCode(String internalCode,int currentUserId);
	
	//void savePatentShareUser(List<Integer> userIds,long patentId);
	void savePatentShareUser(int userId,long patentId);
	
	List<Patent> getUserPatentsByIds(List<Long> patentIds);
	
	void updateDocumentStatusText(String patentStatusText,String internalCode);
	
	void updateDocumentStatus(int patentStatus,String internalCode);
	
	void cancelRecommendPatent(long patentId);
	
	void recommendPatent(long patentId);
	
	void batchChangeTransferor(String transferor,List<Long> patentIds);
	
	void saveSellPatentDescription(String description,int patentId);

	Map<String, Map<String, String>> getUserTransactionCountByPatentType(int userId);
	
	Map<String, Map<String, String>> searchUserTransactionByTransactionStatus(int userId);

	List<Patent> exportTransactionPatents(List<Long> patentId);	
	
	void batchChangeDescription(String description,List<Long> patentIds);
	
	void batchUpdatePatentField(int description,List<Long> patentIds);

	Patent getOverviewPatentByAppNo(String appNo,int userId);
	
	List<PatentRemark> getRemarkByUserIdAndAppNo(String appNo,int userId);
	
	SalePatentGood getTransactionOverview(String appNo,int userId);
	
	List<GoodsDetail> getAllUserTransactionPatents(Page page);
	
	int getAllUserTransactionPatentsCount();
	
	List<GoodsDetail>searchAllTransactionPatentsByPage(TransactionPatentSearchCondition searchCondition);
	
	int searchAllTransactionPatentsCount(TransactionPatentSearchCondition searchCondition);
	
	Map<String, Map<String, String>> getTraderUserTransactionCountByPatentType(TransactionPatentSearchCondition searchCondition);

	Map<String, Map<String, String>> searchTraderUserTransactionByTransactionStatus(TransactionPatentSearchCondition searchCondition);
	
	Map<String, Map<String, String>> getTransactionCountByPatentType();
	
	Map<String, Map<String, String>> getTransactionByTransactionStatus();
	
	List<Patent> getLOTUTPatentsByIds(int userId);
	
	List<Patent> getUserAnnualFeeMonitorPatents(Page page);
	
	int  getUserAnnualFeeMonitorPatentsCount(int userId);
	
	int isFeeMonitorPatents(int userId,List<Long> patentIds);
	
	void batchAddFeeMonitorPatents(int userId,List<Long> patentIds);
	
	void batchCancelFeeMonitorPatents(int userId,List<Long> patentIds);
	
	List<Patent> searchUserAnnualFeeMonitorPatents(PatentSearchCondition searchCondition);
	
	int searchUserAnnualFeeMonitorPatentsCount(PatentSearchCondition searchCondition);

	List<Patent> SearchPatentsRecycled(PatentSearchCondition searchCondition);
	
	int SearchPatentsRecycledCount(PatentSearchCondition searchCondition);
	
	void changeUserPatentRemark(int userId,long patentId,String patentRemark);

	List<Map<String,String>> getAppPersonCountByAppPerson(int userId);
}
