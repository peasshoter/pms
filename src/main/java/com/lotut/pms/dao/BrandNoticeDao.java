package com.lotut.pms.dao;

import java.util.List;
import java.util.Map;

import com.lotut.pms.domain.BrandNotice;
import com.lotut.pms.domain.BrandNoticeRemark;
import com.lotut.pms.domain.BrandNoticeSearchCondition;
import com.lotut.pms.domain.BrandNoticeType;
import com.lotut.pms.domain.BrandNoticeTypeCount;
import com.lotut.pms.domain.Page;

public interface BrandNoticeDao {

	int getUserBrandNoticeCount(int userId);

	List<BrandNotice> getUserBrandNoticeList(Page page);
	
	List<BrandNotice> getUserBrandNoticeExcelData(List<Integer>noticeIds);
	
	void saveBrandNoticeRemark(BrandNoticeRemark brandNoticeRemark);
	
	List<BrandNoticeRemark> getBrandNoticeListByNoticeId(long brandNoticeId);

	void batchChangeBrandNoticeViewStatus(List<Map<String, Long>> noticeIdList);

	void batchUpdateStarTargetStatus(List<Long> noticeIds);
	
	List<BrandNotice> searchUserBrandNoticeByPage(BrandNoticeSearchCondition searchCondition);
	
	int searchBrandNoticeCountByPage(BrandNoticeSearchCondition searchCondition);
	
	List<BrandNoticeType> getBrandNoticeTypes();
	
	List<BrandNoticeTypeCount> getBrandNoticeCountByNoticeType(int userId);
	
	void saveBrandNotice(BrandNotice brandNotice);

}
