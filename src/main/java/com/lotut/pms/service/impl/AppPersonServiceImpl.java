package com.lotut.pms.service.impl;

import java.util.List;
import java.util.Map;

import com.lotut.pms.dao.AppPersonDao;
import com.lotut.pms.domain.AppPersonSearchCondition;
import com.lotut.pms.domain.CommonAppPerson;
import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.UserAppPerson;
import com.lotut.pms.service.AppPersonService;



public class AppPersonServiceImpl implements AppPersonService {
	private AppPersonDao appPersonDao;
	
	
	
	public AppPersonServiceImpl(AppPersonDao appPersonDao) {
		this.appPersonDao =appPersonDao;
	}


	public void addappPerson(CommonAppPerson commonappPerson) {
		appPersonDao.addAppPerson(commonappPerson);
		
	}

	@Override
	public List<CommonAppPerson> getAllAppPersonByUser(int userId) {
		
		return appPersonDao.getAllAppPersonByUser(userId) ;
	}


	@Override
	public CommonAppPerson getOneAppPersonById(int id) {
		return appPersonDao.getOneAppPersonById(id);
	}


	@Override
	public void updateAppPerson(CommonAppPerson appPerson) {
		appPersonDao.updateAppPerson(appPerson);
		
	}


	@Override
	public void deleteAppPersonById(int id) {
		appPersonDao.deleteAppPersonById(id);
		
	}


	@Override

	public void saveAttachmentFile(CommonAppPerson appPerson) {
		
		appPersonDao.saveAttachmentFile(appPerson);
	}


	@Override
	public String getAppPersonUrlById(int id) {
		
		return appPersonDao.getAppPersonUrlById(id);
	}
	public void addCommonappPerson(CommonAppPerson CommonappPerson) {
		appPersonDao.addCommonAppPerson(CommonappPerson);

	}


	@Override
	public void saveProxyFile(CommonAppPerson appPerson) {
		
		appPersonDao.saveProxyFile(appPerson);
	}


	@Override
	public String getProxyUrlById(int id) {
		
		return appPersonDao.getProxyUrlById(id);
	}


	@Override
	public void deleteAttachmentFileById(int id) {
		
		appPersonDao.deleteAttachmentFileById(id);
	}


	@Override
	public void addAppPerson(CommonAppPerson commonAppPerson) {
		
		appPersonDao.addAppPerson(commonAppPerson);
	}


	@Override
	public void addCommonAppPerson(CommonAppPerson CommonAppPerson) {
		
		appPersonDao.addCommonAppPerson(CommonAppPerson);
	}


	@Override
	public void addUserAppPerson(UserAppPerson userAppPerson) {
		
		appPersonDao.addUserAppPerson(userAppPerson);
	}


	@Override
	public List<Integer> getIdbyAppPerson(CommonAppPerson commonAppPerson) {
	
		return appPersonDao.getIdbyAppPerson(commonAppPerson);
	}

	@Override
	public void deleteUserAppPersonbyId(UserAppPerson userAppPerson) {
		appPersonDao.deleteUserAppPersonbyId(userAppPerson);
		
	}


	@Override
	public void updateAppPersonUserIdNull(CommonAppPerson commonAppPerson) {
		
		appPersonDao.updateAppPersonUserIdNull(commonAppPerson);
		
	}


	@Override
	public void insertUserAppPersons(List<Map<String, Integer>> userAppPersonRecords) {
		appPersonDao.insertUserAppPersons(userAppPersonRecords);
		
	}


	@Override
	public List<CommonAppPerson> searchAppPersonByPage(AppPersonSearchCondition searchCondition) {
		
		return appPersonDao.searchAppPersonByPage(searchCondition);
	}


	@Override
	public int searchAppPersonCount(AppPersonSearchCondition searchCondition) {
		
		return appPersonDao.searchAppPersonCount(searchCondition);
	}


	@Override
	public int getUserAppPersonCount(int userId) {
		
		return appPersonDao.getUserAppPersonCount(userId);
	}


	@Override
	public List<CommonAppPerson> getUserAppPersons(Page page) {
		
		return appPersonDao.getUserAppPersons(page);
	}





}
