package com.lotut.pms.service;

import java.util.List;
import java.util.Map;

import com.lotut.pms.domain.ContactAddress;
import com.lotut.pms.domain.User;


public interface UserService {
	List<User> getAllUsers();
	/*
	 * 注册
	 */
	boolean register(User user);
	/*
	 * 修改密码
	 */
	boolean changePassword(String lastPassword,String newPassword);
	
	User getUserDetail(int userId);
	
	List<Map<String, String>> getAllProvinces();
	
	List<Map<String, String>> getCitiesByProvinceId(int provinceId);
	
	List<Map<String, String>> getDistrictsByCityId(long cityId);
	
	List<Map<String, String>> getStreetsByDistrictId(long districtId);
	
	void saveContactAddress(ContactAddress contactAddress);
	
	List<ContactAddress> getUserContactAddresses(int userId);
}
