package com.lotut.pms.dao;

import java.util.List;

import com.lotut.pms.domain.CommonInventor;

public interface InventorDao {
	void addInventor(CommonInventor inventor);
	List<CommonInventor> getAllInventorsByUser(int id);
	CommonInventor getInventorById(int id);
	void updateById(CommonInventor inventor);
	 void deleteById(int id);
}
