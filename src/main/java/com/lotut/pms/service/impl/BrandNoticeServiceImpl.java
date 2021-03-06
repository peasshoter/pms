package com.lotut.pms.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.lotut.pms.constants.Settings;
import com.lotut.pms.dao.BrandNoticeDao;
import com.lotut.pms.domain.BrandNotice;
import com.lotut.pms.domain.BrandNoticeRemark;
import com.lotut.pms.domain.BrandNoticeSearchCondition;
import com.lotut.pms.domain.BrandNoticeType;
import com.lotut.pms.domain.BrandNoticeTypeCount;
import com.lotut.pms.domain.NoticeSearchCondition;
import com.lotut.pms.domain.Page;
import com.lotut.pms.service.BrandNoticeService;
import com.lotut.pms.service.utils.BrandNoticeExcelGenerator;

public class BrandNoticeServiceImpl implements BrandNoticeService {
	private BrandNoticeDao brandNoticeDao;

	public BrandNoticeServiceImpl(BrandNoticeDao brandNoticeDao) {
		this.brandNoticeDao = brandNoticeDao;
	}

	@Override
	public int getUserBrandNoticeCount(int userId) {
		return brandNoticeDao.getUserBrandNoticeCount(userId);
	}

	@Override
	public List<BrandNotice> getUserBrandNoticeList(Page page) {
		return brandNoticeDao.getUserBrandNoticeList(page);
	}

	@Override
	public String exportNoticeExcel(List<Integer> noticeIds, String excelNoticesName) throws Exception {
		List<BrandNotice> notices = brandNoticeDao.getUserBrandNoticeExcelData(noticeIds);
		String excelNoticePath = Settings.TEMP_DIR + excelNoticesName;
		BrandNoticeExcelGenerator.writeBrandNoticeToExcel(notices, excelNoticePath);
		return excelNoticePath;
	}

	@Override
	public void saveBrandNoticeRemark(BrandNoticeRemark brandNoticeRemark) {
		brandNoticeDao.saveBrandNoticeRemark(brandNoticeRemark);
	}

	@Override
	public List<BrandNoticeRemark> getBrandNoticeListByNoticeId(long brandNoticeId) {
		return brandNoticeDao.getBrandNoticeListByNoticeId(brandNoticeId);
	}
	@Transactional
	public int batchChangeBrandNoticeViewStatus(List<Long> noticeIdList,int userId) {
		List<Map<String, Long>> list =new ArrayList<>();
		for(Long noticeId:noticeIdList){
			Map<String,Long> map=new HashMap<String,Long>();
			map.put("noticeId", noticeId);
			map.put("userId", new Long(userId));
			list.add(map);
		}
		brandNoticeDao.batchChangeBrandNoticeViewStatus(list);
		return 1;
	}

	@Override
	public void batchUpdateStarTargetStatus(List<Long> noticeIds) {
		 brandNoticeDao.batchUpdateStarTargetStatus(noticeIds);
	}	

	@Override
	public void batchCancelStarTargetStatus(List<Long> noticeIds) {
		brandNoticeDao.batchCancelStarTargetStatus(noticeIds);
		
	}
	
	public List<BrandNotice> searchUserBrandNoticeByPage(BrandNoticeSearchCondition searchCondition) {
		return brandNoticeDao.searchUserBrandNoticeByPage(searchCondition);
	}

	@Override
	public int searchBrandNoticeCountByPage(BrandNoticeSearchCondition searchCondition) {
		return brandNoticeDao.searchBrandNoticeCountByPage(searchCondition);
	}

	@Override
	public List<BrandNoticeType> getBrandNoticeTypes() {
		return brandNoticeDao.getBrandNoticeTypes();
	}

	@Override
	public Map<String, Map<String, String>> getUserStarTargetNoticeCountByRemainDay(int userId) {
		return brandNoticeDao.getUserStarTargetNoticeCountByRemainDay(userId);
	}

	@Override
	public List<BrandNotice> getUserStarTargetNoticesByPage(Page page) {
		return brandNoticeDao.getUserStarTargetNoticesByPage(page);
	}

	@Override
	public int getUserStarTargetNoticesCount(int userId) {
		return brandNoticeDao.getUserStarTargetNoticesCount(userId);
	}

	
	
	public List<BrandNoticeTypeCount> getBrandNoticeCountByNoticeType(int userId) {
		return brandNoticeDao.getBrandNoticeCountByNoticeType(userId);
	}
	
	@Override
	public void saveBrandNotice(BrandNotice brandNotice) {
		brandNoticeDao.saveBrandNotice(brandNotice);
	}

	@Override
	public int getAllBrandNoticeCountByUserId(int userId) {
		return brandNoticeDao.getAllBrandNoticeCountByUserId(userId);
	}

	@Override
	public List<BrandNotice> searchUserStarTargetNoticesByPage(NoticeSearchCondition searchCondition) {
		return brandNoticeDao.searchUserStarTargetNoticesByPage(searchCondition);
	}

	@Override
	public int searchUserStarTargetNoticesCount(NoticeSearchCondition searchCondition) {
		return brandNoticeDao.searchUserStarTargetNoticesCount(searchCondition);
	}

	@Override
	public String getzipFileNameById(long noticeId) {
		return brandNoticeDao.getzipFileNameById(noticeId);
	}

	
}
