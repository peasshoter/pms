package com.lotut.pms.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.lotut.pms.dao.PatentDao;
import com.lotut.pms.dao.SharePatentDao;
import com.lotut.pms.domain.GoodsDetail;
import com.lotut.pms.domain.GoodsFirstColumn;
import com.lotut.pms.domain.GoodsSecondColumn;
import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.Patent;
import com.lotut.pms.domain.PatentSearchCondition;
import com.lotut.pms.domain.PatentStatus;
import com.lotut.pms.domain.PatentType;
import com.lotut.pms.service.PatentService;
import com.lotut.pms.service.utils.PatentExcelParser;
import com.lotut.pms.util.UpdatePatentsUtils;

public class PatentServiceImpl implements PatentService {
	private PatentDao patentDao;
	private SharePatentDao sharePatentDao;
	
	public PatentServiceImpl(PatentDao patentDao, SharePatentDao sharePatentDao) {
		this.patentDao = patentDao;
		this.sharePatentDao = sharePatentDao;
	}
	
	/*
	 * 专利分页相关
	 */
	public long getPatentsCount(int userId){
		return patentDao.getUserPatentCount(userId);
	}
	@Override
	public List<Patent> getUserPatents(Page page) {
		return patentDao.getUserPatents(page);
	}
	
	@Override
	public List<Patent> getUserPatentsByType(int userId, int patentType) {
		return patentDao.getUserPatentsByType(userId, patentType);
	}	
	
	@Override
	public List<Patent> getUserPatentsByStatus(int userId, int patentStatus) {
		return patentDao.getUserPatentsByStatus(userId, patentStatus);
	}	
	
	@Override
	public Patent getPatentDetail(long patentId) {
		return patentDao.getPatentById(patentId);
	}
	
	@Override
	public List<Patent> searchUserPatents(PatentSearchCondition searchCondition) {
		return patentDao.searchUserPatents(searchCondition);
	}
	//搜索专利分页
	@Override
	public long searchUserPatentsCount(PatentSearchCondition searchCondition){
		return patentDao.searchUserPatentsCount(searchCondition);
	}
	
	@Override
	public List<Patent> searchUserPatentsWithPage(PatentSearchCondition searchCondition) {
		return patentDao.searchUserPatentsByPage(searchCondition);
	}
	
	@Override
	public List<PatentType> getAllPatentTypes() {
		return patentDao.getAllPatentTypes();
	}
	
	@Override
	public List<PatentStatus> getAllPatentStatus() {
		return patentDao.getAllPatentStatus();
	}

	@Override
	@Transactional
	public void changeInternalCode(int patentId, String internalCode) {
		patentDao.updateInternalCode(patentId, internalCode);
	}

	@Override
	@Transactional
	public void uploadPatents(InputStream is) throws IOException {
		List<Patent> patents = PatentExcelParser.parsePatentFile(is);
		for (Patent patent: patents) {
			patentDao.insertOrUpdatePatent(patent);
		}
		List<Map<String, Integer>> userPatentList = new ArrayList<>();
		UpdatePatentsUtils.updatepatents(userPatentList,patents,sharePatentDao);
		
	}

	@Override
	public List<GoodsFirstColumn> getFirstColumn() {
		// TODO Auto-generated method stub
		return  patentDao.getFirstColumn();
	}

	@Override
	public List<GoodsSecondColumn> getSecondColumn(int firstColumnId) {
		// TODO Auto-generated method stub
		return  patentDao.getSecondColumn(firstColumnId);
	}

	@Override
	public void saveGoods(GoodsDetail goodsDetail) {
		// TODO Auto-generated method stub
		patentDao.saveGoods(goodsDetail);
	}

	@Override
	@Transactional
	public void addPatent(Patent patent) {
		patentDao.insertOrUpdatePatent(patent);
		List<Map<String, Integer>> userPatentList = new ArrayList<>();
		HashMap<String, Integer> userPatentMap = new HashMap<>();
		userPatentMap.put("user", patent.getOwnerId());
		userPatentMap.put("patent", (int) patent.getPatentId());
		userPatentList.add(userPatentMap);
		sharePatentDao.insertUserPatents(userPatentList);
	}

	@Override
	public Map<String, Map<String, String>> getUserPatentCountByType(int userId) {
		return patentDao.getUserPatentCountByType(userId);
	}

	@Override
	public Map<String, Map<String, String>> searchUserPatentsByPatentStatus(int userId) {
		return patentDao.searchUserPatentsByPatentStatus(userId);
	}

	@Override
	public List<Patent> getUserPatentsWithFee(int userId) {
		return patentDao.getUserPatentsWithFee(userId);
	}

	@Override
	public Patent getPatentsByAppNo(Integer userId,String appNo) {
		return patentDao.getPatentsByAppNo(userId,appNo);
	}

	@Override
	public int getPatentIdByAppNo(Integer userId,String appNo) {
		return patentDao.getPatentIdByAppNo(userId,appNo);
	}

	@Override
	public void autoUpdatePatents(InputStream is) throws IOException {
		List<Patent> patents = PatentExcelParser.parsePatentFile(is);
		patentDao.insertOrUpdatePatents(patents);
		List<Map<String, Integer>> userPatentList = new ArrayList<>();
		UpdatePatentsUtils.updatepatents(userPatentList,patents,sharePatentDao);
		
	}
}
