package com.lotut.pms.dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lotut.pms.domain.CustomerSupport;
import com.lotut.pms.domain.ProcessPerson;
import com.lotut.pms.domain.TechPerson;


public interface EmployeeMapper {

	List<CustomerSupport> getCustomerSupportList(int proxyOrgId);
	
	List<TechPerson> getTechPersonList(int proxyOrgId);
	
	List<ProcessPerson> getProcessPersonList(int proxyOrgId);

	void addOrUpdateCustomerSupport(CustomerSupport customerSupport);
	
	void addOrUpdateTechPerson(TechPerson techPerson);
	
	void addOrUpdateProcessPerson(ProcessPerson processPerson);

	void deleteCustomerSupport(int id);
	
	void deleteTechPerson(int id);
	
	void deleteProcessPerson(int id);

	void changeCustomerSupportRemarkName(@Param("id") int id,@Param("remarkName") String remarkName);

	void changeTechPersonRemarkName(@Param("id") int id, @Param("remarkName") String remarkName);

	void changeProcessPersonRemarkName(@Param("id") int id, @Param("remarkName") String remarkName);
	
	void insertGroupMember(@Param("userId") int userId,@Param("roleName") String roleName);

}