package com.lotut.pms.dao;

import java.util.List;

import com.lotut.pms.domain.CustomerSupport;
import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.ProcessPerson;
import com.lotut.pms.domain.ProxyOrg;
import com.lotut.pms.domain.TechPerson;

public interface EmployeeDao {

	List<CustomerSupport> getCustomerSupportList(int proxyOrgId);

	List<TechPerson> getTechPersonList(int proxyOrgId);
	
	List<ProcessPerson> getProcessPersonList(int proxyOrgId);
	
	void addOrUpdateCustomerSupport(CustomerSupport customerSupport);

	void addOrUpdateTechPerson(TechPerson techPerson);
	
	void addOrUpdateProcessPerson(ProcessPerson processPerson);
	
	void deleteCustomerSupport(int id);
	
	void deleteTechPerson(int id);
	
	void deleteProcessPerson(int id);

	void changeCustomerSupportRemarkName(int id, String remarkName);

	void changeTechPersonRemarkName(int id, String remarkName);

	void changeProcessPersonRemarkName(int id, String remarkName);
	
	void insertGroupMember(int userId,String roleName);

	List<ProxyOrg> getProxyOrgList(int parentOrgId);

	void addOrUpdateProxyOrg(ProxyOrg proxyOrg);

	void changeProxyOrgRemarkName(int orgId, String remarkName);

	void deleteProxyOrg(int orgId);

	int getOrgIdByUserId(int currentUserId);
	
	int getOrgIdByCustomerSupportId(int currentUserId);

	void addOrUpdateTopProxyOrg(ProxyOrg proxyOrg);

	List<ProxyOrg> getTopProxyOrgListByPage(Page page);
	
	List<ProxyOrg> getTopProxyOrgList();

	ProxyOrg getOrgByParentOrgId(int orgUserId);
	
	List<CustomerSupport> searchCustomersByProxyId(String keyword,int currentUserId);
	
	List<TechPerson> searchTechPersonByProxyId(String keyword,int currentUserId);
	
	List<ProcessPerson> searchProcessPersonByProxyId(String keyword,int currentUserId);
	
	List<ProxyOrg> searchProxyOrgId(String keyword,Integer parentOrgId);
	
	List<ProxyOrg> getProxyOrgListByPage(Page page);
	
	int getProxyOrgCount(int proxyOrgId);
	
	List<CustomerSupport> getCustomerSupportListByPage(Page page);
	
	int getCustomerSupportCount (int proxyOrgId);
	
	List<TechPerson> getTechPersonListByPage(Page page);
	
	int getTechPersonCount (int proxyOrgId);
	
	List<ProcessPerson> getProcessPersonListByPage(Page page);
	
	int getProcessPersonCount (int proxyOrgId);

	int getTopProxyOrgListCount();
}
