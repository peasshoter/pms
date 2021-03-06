package com.lotut.pms.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;

import com.lotut.pms.constants.Settings;
import com.lotut.pms.dao.BrandManagementDao;
import com.lotut.pms.domain.Brand;
import com.lotut.pms.domain.BrandCategory;
import com.lotut.pms.domain.BrandCategoryCount;
import com.lotut.pms.domain.BrandLegalStatus;
import com.lotut.pms.domain.BrandLegalStatusCount;
import com.lotut.pms.domain.BrandManagement;
import com.lotut.pms.domain.BrandManagementSearchCondition;
import com.lotut.pms.domain.BrandNoticeType;
import com.lotut.pms.domain.BrandRemark;
import com.lotut.pms.domain.Page;
import com.lotut.pms.service.BrandManagementService;
import com.lotut.pms.service.utils.BrandExcelGenerator;

public class BrandManagementServiceImpl implements BrandManagementService{
	private BrandManagementDao brandManagementDao;

	public BrandManagementServiceImpl(BrandManagementDao brandManagementDao) {
		this.brandManagementDao = brandManagementDao;
	}

	@Override
	public List<BrandManagement> getUserBrandManagementByPage(Page page) {
		return brandManagementDao.getUserBrandManagementByPage(page);
	}

	@Override
	public int getUserBrandManagementCount(int userId) {
		return brandManagementDao.getUserBrandManagementCount(userId);
	}

	@Override
	public List<BrandCategory> getAllBrandCategory() {
		return brandManagementDao.getAllBrandCategory();
	}

	@Override
	public List<BrandLegalStatus> getAllBrandLegalStatus() {
		return brandManagementDao.getAllBrandLegalStatus();
	}
	@Override
	public void insertUserBrandManagements(List<Map<String, Integer>> userBrandManagementRecords) {
		brandManagementDao.insertUserBrandManagements(userBrandManagementRecords);
	}

	@Override
	public void saveBrandRemark(BrandRemark brandRemark) {
		brandManagementDao.saveBrandRemark(brandRemark);
	}

	@Override
	public List<BrandRemark> getBrandRemark(int brandId) {
		return brandManagementDao.getBrandRemark(brandId);
	}
	
	@Override
	public List<BrandManagement> searchUserBrandManagementByPage(BrandManagementSearchCondition searchCondition) {
		return brandManagementDao.searchUserBrandManagementByPage(searchCondition);
	}

	@Override
	public int searchUserBrandManagementByCount(BrandManagementSearchCondition searchCondition) {
		return brandManagementDao.searchUserBrandManagementByCount(searchCondition);
	}

	@Override
	public String exportExcelUserBrand(List<Integer> brandIds,String excelName) {
		List<BrandManagement> brands = brandManagementDao.getUserExcelDate(brandIds);
		String brandExcelPath = Settings.TEMP_DIR + excelName;
		BrandExcelGenerator.writeBrandToexcel(brands, brandExcelPath);
		return brandExcelPath;
	}

	@Override
	public List<BrandLegalStatusCount> getLegalStatusCount(int userId) {
		return brandManagementDao.getLegalStatusCount(userId);
	}

	@Override
	public List<BrandCategoryCount> getBrandCategoryCount(int userId) {
		return brandManagementDao.getBrandCategoryCount(userId);
	}

	@Override

	public void brandsTrash(List<Integer> brandManagementIds, int userId) {
		brandManagementDao.brandsTrash(brandManagementIds,userId);
		
	}

	public int insertOrUpdateBrand(BrandManagement brandManagement) {
		return brandManagementDao.insertOrUpdateBrand(brandManagement);
	}

	@Override
	public void insertUserBrand(int userId, int brandId) {
		brandManagementDao.insertUserBrand(userId, brandId);
	}

	@Override
	public BrandManagement showBrandManagementDetail(int brandId) {
		return brandManagementDao.showBrandManagementDetail(brandId);
	}
	
	public List<BrandNoticeType> getAllBrandNoticeTypes() {
		return brandManagementDao.getAllBrandNoticeTypes();
	}

	@Override
	public void deleteShareUser(int brandId, int shareUserId) {
		brandManagementDao.deleteShareUser(brandId, shareUserId);
	}

	@Override
	public int getBrandsRecycledCount(int userId) {
		return brandManagementDao.getBrandsRecycledCount(userId);
	}

	@Override
	public List<Brand> getBrandsRecycled(Page page) {
		return brandManagementDao.getBrandsRecycled(page);
	}
	
	@Override
	public int SearchBrandsRecycledCount(BrandManagementSearchCondition searchCondition) {
		return brandManagementDao.SearchBrandsRecycledCount(searchCondition);
	}

	@Override
	public List<Brand> SearchBrandsRecycled(BrandManagementSearchCondition searchCondition) {
		return brandManagementDao.SearchBrandsRecycled(searchCondition);
	}

	@Override
	public void recoverBrands(List<Integer> brandManagementIds, int userId) {
		brandManagementDao.recoverBrands(brandManagementIds,userId);
		
	}

	@Override
	public void deleteForeverBrands(List<Integer> brandManagementIds, int userId) {
		brandManagementDao.deleteForeverBrands(brandManagementIds,userId);
		
	}

	@Override
	public List<BrandManagement> getUserMonitorBrand(Page page) {
		return brandManagementDao.getUserMonitorBrand(page);
	}

	@Override
	public int getUserMonitorBrandCount(int userId) {
		return brandManagementDao.getUserMonitorBrandCount(userId);
	}

	@Override
	public void changeBrandMonitorStatus(int userId, List<Long> brandIds) {
		brandManagementDao.changeBrandMonitorStatus(userId, brandIds);
	}

	@Override
	public void cancelBrandMonitorStatus(int userId, List<Long> brandIds) {
		brandManagementDao.cancelBrandMonitorStatus(userId, brandIds);
	}

	@Override
	public List<BrandManagement> searchUserMonitorBrand(BrandManagementSearchCondition searchCondition) {
		return brandManagementDao.searchUserMonitorBrand(searchCondition);
	}

	@Override
	public int searchUserMonitorBrandCount(BrandManagementSearchCondition searchCondition) {
		return brandManagementDao.searchUserMonitorBrandCount(searchCondition);
	}

	@Override
	public void changeBrandTransactionStatus(int brandId) {
		brandManagementDao.changeBrandTransactionStatus(brandId);
	}

	@Override
	public void changeBrandTransactionStatusTo0(int id) {
		brandManagementDao.changeBrandTransactionStatusTo0(id);
	}

	@Override
	public void changeBrandTransactionStatusByBrandNo(BrandManagement brandManagement) {
		brandManagementDao.changeBrandTransactionStatusByBrandNo(brandManagement);
	}

	@Override
	public List<File> packZip(int brandId) {
		String rootPath=Settings.BRAND_MANAGEMENT_PATH;
		BrandManagement brand=brandManagementDao.showBrandManagementDetail(brandId);
		String proxyFile=brand.getProxyFile();
		String businessLicense=brand.getBusinessLicense();
		String individualLicense=brand.getIndividualLicense();
		String entityLicense=brand.getEntityLicense();
		String identityCard=brand.getIdentityCard();
		String application=brand.getApplication();
		String proxyFileUrl="";
		String businessLicenseUrl ="";
		String entityLicenseUrl ="";
		String identityCardUrl ="";
		String applicationUrl ="";
		String individualLicenseUrl="";
		proxyFileUrl = rootPath+proxyFile;
		businessLicenseUrl = rootPath+businessLicense;
		individualLicenseUrl =rootPath+ individualLicense;
		entityLicenseUrl = rootPath+entityLicense;
		identityCardUrl = rootPath+identityCard;
		applicationUrl = rootPath+application;
		List<File> files=new ArrayList<>();
		if(StringUtils.isEmpty(proxyFile)==false){
		files.add(new File(proxyFileUrl));
		}
		if(StringUtils.isEmpty(businessLicense)==false){
			files.add(new File(businessLicenseUrl));
		}
		if(StringUtils.isEmpty(individualLicense)==false){
			files.add(new File(individualLicenseUrl));
			}
		if(StringUtils.isEmpty(identityCard)==false){
			files.add(new File(identityCardUrl));
			}
		if(StringUtils.isEmpty(entityLicense)==false){
			files.add(new File(entityLicenseUrl));
			}
		if(StringUtils.isEmpty(application)==false){
			files.add(new File(applicationUrl));
			}
		
		return files;
	}

	


	
}
