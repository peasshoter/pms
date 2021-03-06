package com.lotut.pms.service.impl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.lotut.pms.constants.Settings;
import com.lotut.pms.dao.NewsDao;
import com.lotut.pms.domain.News;
import com.lotut.pms.domain.NewsSearchCondition;
import com.lotut.pms.domain.NewsType;
import com.lotut.pms.domain.Page;
import com.lotut.pms.service.NewsService;
import com.lotut.pms.util.PrincipalUtils;
import com.lotut.pms.web.util.FileOption;

public class NewsServiceImpl implements NewsService {
	private NewsDao newsDao;

	public NewsServiceImpl(NewsDao newsDao) {
		this.newsDao = newsDao;
	}

	@Override
	public List<News> getUserNewsByPage(Page page) {
		return newsDao.getUserNewsByPage(page);
	}

	@Override
	public int getUserNewsCount(int userId) {
		return newsDao.getUserNewsCount(userId);
	}

	@Override
	public News getUserNewsById(int newsId) {
		return newsDao.getUserNewsById(newsId);
	}

	@Override
	public List<News> searchUserNewsByPage(NewsSearchCondition newsSearchCondition) {
		return newsDao.searchUserNewsByPage(newsSearchCondition);
	}

	@Override
	public int searchUserNewsCount(NewsSearchCondition searchCondition) {
		return newsDao.searchUserNewsCount(searchCondition);
	}

	@Override
	public List<NewsType> getAllNewsTypes() {
		return newsDao.getAllNewsTypes();
	}

	@Override
	public void deleteNewsById(int newsId) {
		newsDao.deleteNewsById(newsId);
	}
	
	@Override
	public void insertNews(News news) {
		newsDao.insertNews(news);
	}
	
	@Override
	public void saveNews(News news) {
		newsDao.saveNews(news);
	}
	

	@Override
	@Transactional
	public String insertNewsImage(MultipartFile multipartFile) {
		String defaultSaveDir = Settings.NEWS_SMALL_IMAGE_PATH;
		String defaultSaveUrl = Settings.NEWS_SMALL_IMAGE_URL;
		int userId = PrincipalUtils.getCurrentUserId();
		String saveImageUrl = FileOption.uploaffile(userId, multipartFile, defaultSaveDir, defaultSaveUrl);
		return saveImageUrl;
	}
	
	@Override
	public void updateNewsInfo(News news) {
		newsDao.updateNewsInfo(news);
	}
	
	@Override
	public void updateNewsType(NewsType newsType) {
		newsDao.updateNewsType(newsType);
	}
	
	@Override
	public int getNewsTypeCount(NewsType newsType) {
		return newsDao.getNewsTypeCount(newsType);
	}
	
	@Override
	public void deleteNewsType(NewsType newsType) {
		newsDao.deleteNewsType(newsType);
	}

	@Override
	public void addNewsType(NewsType newsType) {
		newsDao.addNewsType(newsType);
	}
	
	@Override
	public void updateNewsCheckStatus(int newsId) {
		newsDao.updateNewsCheckStatus(newsId);
	}

	@Override
	public void auditPass(News news) {
		newsDao.auditPass(news);
	}

	@Override
	public List<News> getAllNewsByPage(Page page) {
		
		return newsDao.getAllNewsByPage(page);
	}

	@Override
	public List<News> searchAllNewsByPage(NewsSearchCondition searchCondition) {
		
		return newsDao.searchAllNewsByPage(searchCondition);
	}

	@Override
	public int getAllNewsCount(int userId) {
		
		return newsDao.getAllNewsCount(userId);
	}

	@Override
	public int searchAllNewsCount(NewsSearchCondition searchCondition) {
		
		return newsDao.searchAllNewsCount(searchCondition);
	}
}
