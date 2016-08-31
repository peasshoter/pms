package com.lotut.pms.service;

import java.util.List;

import com.lotut.pms.domain.CommonAppPerson;
import com.lotut.pms.domain.CommonInventor;
import com.lotut.pms.domain.ContactAddress;
import com.lotut.pms.domain.PatentDocAppPerson;
import com.lotut.pms.domain.PatentDocInventor;

public interface PetitionService {
	List<CommonInventor> findInventorNameById(List<Long> inventorIds,int userId );
	
	List<CommonAppPerson> findAppPersonNameById(List<Integer> appPersonIds,int userId);
	
	void addCommonAppPerson(CommonAppPerson commonAppPerson);
	
	void addCommonInventor(CommonInventor commonInventor);
	
	List<ContactAddress> findContactNameById(List<Integer> contactIds,int userId);
	
	void addPatentDocAppPerson(List<CommonAppPerson> commonAppPersons,Long patentDocId,int userId);
	
	List<PatentDocAppPerson> findPatentDocAppPersonById(Long patentDocId);
	
	void addPatentDocInventor(Long patentDocId,List<CommonInventor> commonInventors,int userId);
	
	List<PatentDocInventor> findPatentDocInventorById(Long patentDocId);
	
	void deletePatentDocApperson(Long personId);
	
	void updatePatentDocApperson(PatentDocAppPerson patentDocAppPerson);
	
	void deletePatentDocInventor(Long inventorId);
	
	void updatePatentDocInventor(PatentDocInventor patentDocInventor);
	
	PatentDocAppPerson findAppPersonByAppId(Long personId);
	
	PatentDocInventor findInventorById(Long inventorId);
	
	 void updatePatentDocAttachmentUrl(String attachmentUrl, Long patentDocId);
}
