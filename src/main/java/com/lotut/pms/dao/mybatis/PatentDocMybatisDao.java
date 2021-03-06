package com.lotut.pms.dao.mybatis;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.lotut.pms.dao.PatentDocDao;
import com.lotut.pms.dao.mapper.PatentDocMapper;
import com.lotut.pms.domain.Attachment;
import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.PatentDoc;
import com.lotut.pms.domain.PatentDocSearchCondition;
import com.lotut.pms.domain.User;

public class PatentDocMybatisDao extends SqlSessionDaoSupport implements PatentDocDao{
	private PatentDocMapper patentDocMapper;

	public void setPatentDocMapper(PatentDocMapper patentDocMapper) {
		this.patentDocMapper = patentDocMapper;
	}



	@Override
	public void savePatentDoc(PatentDoc patentDoc) {
		patentDocMapper.savePatentDoc(patentDoc);
		
	}



	@Override
	public List<PatentDoc> getUserPatentDoc(Page page) {
		return patentDocMapper.getUserPatentDoc(page);
	}



	@Override
	public PatentDoc getUserPatentDocById( long patentDocId) {
		return patentDocMapper.getUserPatentDocById( patentDocId);
	}



	@Override
	public void updatePatentDoc(PatentDoc patentDoc) {
		patentDocMapper.updatePatentDoc(patentDoc);
		
	}




	@Override
	public void deletePatentDoc(long patentDocId,int userId) {
	
		patentDocMapper.deletePatentDoc(patentDocId,userId);
	}



	@Override
	public void savePatentImgUrl(Attachment attachment) {
		patentDocMapper.savePatentImgUrl(attachment);
		
	}



	@Override
	public List<Attachment> getAttachmentById(long patentDocId) {
		return patentDocMapper.getAttachmentById(patentDocId);
	}



	@Override
	public boolean delectAttachmentById(long attachmentId) {
		return patentDocMapper.delectAttachmentById(attachmentId);
		
	}



	@Override
	public void deleteNullPatentDoc() {
		patentDocMapper.deleteNullPatentDoc();
		
	}



	@Override
	public void savePatentAbstractImg(PatentDoc PatentDoc) {
		patentDocMapper.savePatentAbstractImg(PatentDoc);
		
	}



	@Override
	public Attachment getLabelByUrl(String url) {
		return patentDocMapper.getLabelByUrl(url);
	}



	@Override
	public void savePatentDocAttachmentFile(PatentDoc PatentDoc) {
		patentDocMapper.savePatentDocAttachmentFile(PatentDoc);
	}



	@Override
	public String getPatentDocAttachmentFile(long patentDocId) {
		return patentDocMapper.getPatentDocAttachmentFile(patentDocId);
	}



	@Override
	public void savePatentDocFile(PatentDoc patentDoc) {
		patentDocMapper.savePatentDocFile(patentDoc);
		
	}



	@Override
	public String getPatentDocUrlById(long patentDocId) {
		return patentDocMapper.getPatentDocUrlById(patentDocId);
	}



	@Override
	public void insertUserPatentDoc(List<Map<String, Integer>> userPatentDocRecords) {
		patentDocMapper.insertUserPatentDoc(userPatentDocRecords);
		
	}



	@Override
	public List<PatentDoc> searchUserPatentDocsByPage(PatentDocSearchCondition searchCondition) {
		return patentDocMapper.searchUserPatentDocsByPage(searchCondition);
	}



	@Override
	public int searchUserPatentDocsCount(PatentDocSearchCondition searchCondition) {
		return patentDocMapper.searchUserPatentDocsCount(searchCondition);
	}



	@Override
	public int getUserPatentDocCount(int userId) {
		return patentDocMapper.getUserPatentDocCount(userId);
	}



	@Override
	public List<PatentDoc> getUserPatentDocEditor(int userId) {
		return patentDocMapper.getUserPatentDocEditor(userId);
	}



	@Override
	public int getAttatchmentPicCount(long patentDocId) {
		return patentDocMapper.getAttatchmentPicCount(patentDocId);
	}



	@Override
	public int getMaxAttachmentPicNum(long patentDocId) {
		return patentDocMapper.getMaxAttachmentPicNum(patentDocId);
	}



	@Override
	public void updateAttachmentImgName(Attachment attachment) {
		patentDocMapper.updateAttachmentImgName(attachment);
		
	}



	@Override
	public Attachment getAttachmentByAttachId(long attachmentId) {
		return patentDocMapper.getAttachmentByAttachId(attachmentId);
	}



	@Override
	public void updateAttachmentImgUrl(Attachment attachment) {
		patentDocMapper.updateAttachmentImgUrl(attachment);
	}



	@Override
	public List<PatentDoc> getPatentDocsByIds(List<Long> patentDocIds) {
		return patentDocMapper.getPatentDocsByIds(patentDocIds);
	}



	@Override
	public void insertProxyOrgPatentDoc(List<Map<String, Long>> userPatentDocRecords) {
		patentDocMapper.insertProxyOrgPatentDoc(userPatentDocRecords);
		
	}



	@Override
	public List<PatentDoc> getUserPatentDocByRole(Page page) {
		return patentDocMapper.getUserPatentDocByRole(page);
	}



	@Override
	public Integer getUserPatentDocCountByRole(Page page) {
		return patentDocMapper.getUserPatentDocCountByRole(page);
	}



	@Override
	public List<PatentDoc> getPatentDocByTechAndCustomer(Page page, List<Integer> statusList) {
		return patentDocMapper.getPatentDocByTechAndCustomer(page, statusList);
	}



	@Override
	public int getPatentDocCountByTechAndCustomer(Page page, List<Integer> statusList) {
		return patentDocMapper.getPatentDocCountByTechAndCustomer(page, statusList);
	}



	@Override
	public void savePatentStandardFile(PatentDoc patentDoc) {
		patentDocMapper.savePatentStandardFile(patentDoc);
	}



	@Override
	public void saveInternalCode(PatentDoc patentDoc) {
		patentDocMapper.saveInternalCode(patentDoc);
	}



	@Override
	public String getPatentDocAttachmentUrlById(Long patentDocId) {
		return patentDocMapper.getPatentDocAttachmentUrlById(patentDocId);
	}



	@Override
	public List<User> searchShareUsers(long patentDocId) {
		return patentDocMapper.searchShareUsers(patentDocId);
	}



	@Override
	public void saveInvoicePath(String invoicePic, long patentDocId) {
		patentDocMapper.saveInvoicePath(invoicePic, patentDocId);
	}



	@Override
	public String getPatentDocInvoicePic(Long patentDocId) {
		return patentDocMapper.getPatentDocInvoicePic(patentDocId);
	}
}
