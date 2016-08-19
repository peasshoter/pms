package com.lotut.pms.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;


import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lotut.pms.domain.CommonAppPerson;
import com.lotut.pms.domain.User;
import com.lotut.pms.constants.Settings;
import com.lotut.pms.domain.AppPersonType;


import com.lotut.pms.domain.AppPersonType;
import com.lotut.pms.domain.CommonAppPerson;
import com.lotut.pms.domain.User;
import com.lotut.pms.service.AppPersonService;
import com.lotut.pms.service.FriendService;
import com.lotut.pms.util.PrincipalUtils;
import com.lotut.pms.web.util.WebUtils;

@Controller
@RequestMapping(path="/appPerson")
public class AppPersonController {
	private FriendService friendService;
	private AppPersonService AppPersonService;



	
	public AppPersonController() {
	}
	
	@Autowired


	public AppPersonController(AppPersonService AppPersonService, FriendService friendService) {
		this.AppPersonService = AppPersonService;
		this.friendService = friendService;


	}
	@RequestMapping(path="/contactAppPersonAddForm")
	public String contactAppPersonAddForm(Model model){
		List<AppPersonType> appPersonTypes=AppPersonService.getAppPersonTypes();
		model.addAttribute("appPersonTypes",appPersonTypes);
		return "appPerson_add";
		
	}
	
	@RequestMapping(path="/list" ,method=RequestMethod.GET)
	public String getList(Model model){
		int userId=PrincipalUtils.getCurrentUserId();
		List<CommonAppPerson> appPersons=AppPersonService.getUserAppPersons(userId);
		List<AppPersonType> appPersonTypes=AppPersonService.getAppPersonTypes();
		model.addAttribute("appPersonTypes",appPersonTypes);
		model.addAttribute("appPersons", appPersons);
		return "app_person_list";
	}
	
	@RequestMapping(path="/addContactInfo",method=RequestMethod.POST)
	public String addContactInfo(@ModelAttribute CommonAppPerson AppPerson,Model model){
		int userId=PrincipalUtils.getCurrentUserId();
		AppPerson.setUserId(userId);
		AppPersonService.addAppPerson( AppPerson);
		return "redirect:/appPerson/list.html";
	}
	
	@RequestMapping(path="/findOneAppPersonInfo")
	public String findOneAppPersonInfo(@RequestParam("appPersonId")int AppPersonId,Model model ){
		CommonAppPerson appPerson=AppPersonService.getOneAppPersonById(AppPersonId);
		List<AppPersonType> appPersonTypes=AppPersonService.getAppPersonTypes();
		model.addAttribute("appPersonTypes",appPersonTypes);
		model.addAttribute("appPerson", appPerson);
		return "appPerson_update";
		
	}
	@RequestMapping(path="/updateAppPersonInfo",method=RequestMethod.POST)
	public String updateAppPersonInfo(@Valid CommonAppPerson AppPerson,Model model ){
		int userId=PrincipalUtils.getCurrentUserId();
		AppPerson.setUserId(userId);
		AppPersonService.updateAppPerson(AppPerson);
		return "redirect:/appPerson/list.html";
		
	}
	
	@RequestMapping(path="/deleteAppPersonInfo")
	public String deleteAppPersonInfo(@RequestParam("appPersonId")int AppPersonId){
		AppPersonService.deleteAppPersonById(AppPersonId);
		return "redirect:/appPerson/list.html";
	}
	

	@RequestMapping(path="/showFriends", method=RequestMethod.GET)
	public String showFriends(Model model) {
		int userId = PrincipalUtils.getCurrentUserId();
		List<User> friends = friendService.getUserFriends(userId);
		model.addAttribute("friends", friends);
		return "app_person_select_friends";
	}
	
	@RequestMapping(path="searchFriends", method=RequestMethod.GET)
	public String searchFriends(@RequestParam("keyword")String keyword, Model model) {
		int userId = PrincipalUtils.getCurrentUserId();
		List<User> friends = friendService.searchUserFriends(userId, keyword);
		model.addAttribute("friends", friends);
		return "app_person_select_friends";
	}	
	
	@RequestMapping(path="/showAttachmentUploadForm",method=RequestMethod.GET)
	public String showAttachmentUploadForm(@RequestParam("appPersonId") long appPersonId,Model model){
		model.addAttribute("appPersonId", appPersonId);
		return "app_person_upload_form";
		
		
	}
	
	@RequestMapping(path="/uploadAttachmentUploadForm",method=RequestMethod.POST)
	public void uploadAttachmentUploadForm(HttpServletRequest request,HttpServletResponse response,PrintWriter printOut){
		int userId = PrincipalUtils.getCurrentUserId();
		try{
			String savePath=Settings.APP_PERSON_ATTACHMENT_FILE_PATH;
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file1 = multipartRequest.getFile("file");
			String fileName = file1.getOriginalFilename();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String ymd = sdf.format(new Date());
			savePath += ymd + "/";
			File dirFile = new File(savePath);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}
			String newFileName = userId + "_" + new Random().nextInt(10000) + "_" + fileName;
			InputStream is = file1.getInputStream();
			int BUFFER_SIZE = 8 * 1024;
			byte[] buffer = new byte[BUFFER_SIZE];
			try (OutputStream out = new FileOutputStream(savePath + newFileName);) {
				int bytesRead = -1;
				while ((bytesRead = is.read(buffer)) != -1) {
					out.write(buffer, 0, bytesRead);
				}
				out.flush();
				out.close();
			}
			WebUtils.writeJsonStrToResponse(response,ymd + "/"+newFileName);
		}catch(Exception e){
			e.printStackTrace();
		}
	}	
	

	@RequestMapping(path="/saveAttachmentFile",method=RequestMethod.POST)
	public void saveAttachmentFile(CommonAppPerson appPerson,PrintWriter writer){
		AppPersonService.saveAttachmentFile(appPerson);
		writer.write(1);
	}
	
	@RequestMapping(path="/downloadAttachmentFile", method=RequestMethod.GET)
	public void downloadPatentFile(@RequestParam("appPersonId")int appPersonId, HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setContentType("application/doc");
		String relativeUrl = AppPersonService.getAppPersonUrlById(appPersonId);
		String downloadFileName = URLEncoder.encode(relativeUrl.substring(relativeUrl.lastIndexOf("/")+1), "UTF8");
		String filePath = Settings.APP_PERSON_ATTACHMENT_FILE_PATH + relativeUrl;
		File appPersonFile = new File(filePath);
		if("FF".equals(getBrowser(request))){
		    //针对火狐浏览器处理
			downloadFileName =new String(relativeUrl.substring(relativeUrl.lastIndexOf("/")+1).getBytes("UTF-8"),"iso-8859-1");
		}
		response.setHeader("Content-Disposition", "attachment;filename=" + downloadFileName);
		response.setContentLength((int)appPersonFile.length());
		WebUtils.writeStreamToResponse(response, new FileInputStream(appPersonFile));
	}
	
	private String getBrowser(HttpServletRequest request){
	    String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
	    if(UserAgent!=null){
	        if (UserAgent.indexOf("msie") >=0 ) return "IE";
	        if (UserAgent.indexOf("firefox") >= 0) return "FF";
	    }
	    return null;
	}
//	@RequestMapping(path="/loadAppPersoner")
//	public void loadInventor(@RequestParam("appPersoner") String appPersoner, HttpServletResponse response){
//		response.setContentType("application/json;charset=UTF-8");
//
//		List<CommonAppPerson> appPersoners=AppPersonService.getAppPersonByName(appPersoner);
//
//		int userId = PrincipalUtils.getCurrentUserId();
//		List<CommonAppPerson> appPersoners=appPersonService.getAppPersonByName(appPersoner,userId);
//
//		try{
//			Map<String, Object> map = new HashMap<>();
//			map.put("appPersoners", appPersoners);
//			WebUtils.writeJsonStrToResponse(response, map);
//			//WebUtils.writeJsonStrToResponse(response, inventors);
//		}catch(IOException e){
//			e.printStackTrace();
//		}
//	}


}
