package com.lotut.pms.web.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lotut.pms.domain.GoodsDetail;
import com.lotut.pms.domain.GoodsFirstColumn;
import com.lotut.pms.domain.GoodsSecondColumn;
import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.Patent;
import com.lotut.pms.domain.PatentRemark;
import com.lotut.pms.domain.PatentSearchCondition;
import com.lotut.pms.domain.PatentStatus;
import com.lotut.pms.domain.PatentType;
import com.lotut.pms.domain.TransactionPatentSearchCondition;
import com.lotut.pms.domain.User;
import com.lotut.pms.service.FriendService;
import com.lotut.pms.service.PatentService;
import com.lotut.pms.service.UserService;
import com.lotut.pms.util.PrincipalUtils;
import com.lotut.pms.web.util.WebUtils;

@Controller
@RequestMapping(path="/patent")
public class PatentController {
	private PatentService patentService;
	private FriendService friendService;
	private UserService userService;
	
	@Autowired
	public PatentController(PatentService patentService, FriendService friendService,UserService userService) {
		this.patentService = patentService;
		this.friendService = friendService;
		this.userService = userService;
	}

	@RequestMapping(path="/list", method=RequestMethod.GET)
	public String getUserPatents(Model model, Page page, HttpSession session) {
		int userId = PrincipalUtils.getCurrentUserId();
		page.setUserId(userId);
		page.setPageSize(WebUtils.getPageSize(session));
		if (page.getCurrentPage() <= 0) {
			page.setCurrentPage(1);
		}
		//分页相关
		int totalCount=(int)patentService.getPatentsCount(userId);
		page.setTotalRecords(totalCount);
		Map<String, Map<String, String>> patentTypeCount=patentService.getUserPatentCountByType(userId);
		Map<String, Map<String, String>> patentStatusCount=patentService.searchUserPatentsByPatentStatus(userId);
		List<Patent> patents = patentService.getUserPatents(page);
		model.addAttribute("patents", patents);
		model.addAttribute("page", page);
		model.addAttribute("patentTypeCount", patentTypeCount);
		model.addAttribute("patentStatusCount", patentStatusCount);
		addPatentTypeAndStatusDataToModel(model);
		return "patent_list";
	}
	
	@RequestMapping(path="list", method=RequestMethod.GET, params="patentType")
	public String getPatentsByType(@RequestParam("patentType") int patentType, Model model) {
		int userId = PrincipalUtils.getCurrentUserId();
		List<Patent> patents = patentService.getUserPatentsByType(userId, patentType);
		model.addAttribute("patents", patents);
		addPatentTypeAndStatusDataToModel(model);
		return "patent_list";
	}
	
	@RequestMapping(path="list", method=RequestMethod.GET, params="patentStatus")
	public String getPatentsByStatus(@RequestParam("patentStatus") int patentStatus, Model model) {
		int userId = PrincipalUtils.getCurrentUserId();
		List<Patent> patents = patentService.getUserPatentsByStatus(userId, patentStatus);
		model.addAttribute("patents", patents);
		addPatentTypeAndStatusDataToModel(model);
		return "patent_list";
	}	
	
	@RequestMapping(path="list", method=RequestMethod.GET, params="user")
	public String getShareUserPatents(@RequestParam("user") int userId, Model model) {
		return null;
	}	
	
	
	@RequestMapping(path="showFriends", method=RequestMethod.GET)
	public String showFriends(Model model) {
		int userId = PrincipalUtils.getCurrentUserId();
		List<User> friends = friendService.getUserFriends(userId);
		model.addAttribute("friends", friends);
		return "patent_select_friends";
	}
	
	
	
	@RequestMapping(path="searchFriends", method=RequestMethod.GET)
	public String searchFriends(@RequestParam("keyword")String keyword, Model model) {
		int userId = PrincipalUtils.getCurrentUserId();
		List<User> friends = friendService.searchUserFriends(userId, keyword);
		model.addAttribute("friends", friends);
		return "patent_select_friends";
	}	
	
	@RequestMapping(path="/detail/{patentId:\\d+}", method=RequestMethod.GET)
	public String showDetail(@PathVariable long patentId, Model model) {
		Patent patent = patentService.getPatentDetail(patentId);
		model.addAttribute("patent", patent);
		return "patent_detail";
	}	
	
	
	@RequestMapping(path="/changeInternalCode", method=RequestMethod.GET)
	public String changeInternalCode(@RequestParam("patentId")int patentId, @RequestParam("internalCode")String internalCode) {
		patentService.changeInternalCode(patentId, internalCode);
		return "patent_list";
	}
	
	@RequestMapping(path="/search", method=RequestMethod.GET)
	public String searchUserPatents(@ModelAttribute("searchCondition")PatentSearchCondition searchCondition, Model model,HttpSession session) {
		Page page=searchCondition.getPage();
		page.setPageSize(WebUtils.getPageSize(session));
		searchCondition.setUserId(PrincipalUtils.getCurrentUserId());
		List<Patent> resultPatents = patentService.searchUserPatentsWithPage(searchCondition);
		int totalCount=(int)patentService.searchUserPatentsCount(searchCondition);
		page.setTotalRecords(totalCount);
		Map<String, Map<String, String>> patentTypeCount=patentService.getUserPatentCountByType(searchCondition.getUserId());
		Map<String, Map<String, String>> patentStatusCount=patentService.searchUserPatentsByPatentStatus(searchCondition.getUserId());
		model.addAttribute("patents", resultPatents);
		model.addAttribute("page", page);
		model.addAttribute("patentTypeCount",patentTypeCount);
		model.addAttribute("patentStatusCount",patentStatusCount);
		addPatentTypeAndStatusDataToModel(model);
		return "patent_list";
	}
	
	@RequestMapping(path="/showUploadForm", method=RequestMethod.GET)
	public String showUploadForm() {
		return "patent_upload_form";
	}	
	
	@RequestMapping(path="/upload", method=RequestMethod.POST)
	public String uploadPatents(@RequestParam("patentFile")Part patentFile, Model model) {
		try {
			if (!patentFile.getSubmittedFileName().endsWith(".xls") && !patentFile.getSubmittedFileName().endsWith(".xlsx")) {
				throw new RuntimeException("上传的文件不是excel表格");
			}
			InputStream is = patentFile.getInputStream();
			int userId = PrincipalUtils.getCurrentUserId();
			patentService.uploadPatents(is,userId);
			return "upload_success";
		} catch (Exception e) {
			model.addAttribute("message", "上传失败，请检查文件格式稍后再试！");
			return "common_message";
		}
	}	
	
	@RequestMapping(path="/goods", method=RequestMethod.GET)
	public String showGoodsForm(@RequestParam("patent") int patent_id,Model model) throws IOException {
		
		List<GoodsFirstColumn>  FirstColumns=patentService.getFirstColumn();
		
		Patent patent = patentService.getPatentDetail(patent_id);
		User patentOwner = userService.getUserDetail(patent.getOwnerId());
		model.addAttribute("patent", patent);		
		model.addAttribute("ownerName", patentOwner.getUsername());
		model.addAttribute("patentId", patent_id);
		model.addAttribute("FirstColumns", FirstColumns);
		return "goods_form";
	}	
	@RequestMapping(path="/addGoods", method=RequestMethod.POST)
	public String addGoods(@Valid GoodsDetail goodDetail, Model model) throws IOException {
		goodDetail.setUserId(PrincipalUtils.getCurrentUserId());
		patentService.saveGoods(goodDetail);
		return "goods_add_success";
	}		
		
	@RequestMapping(path="/getGoodsSecoundColumn", method=RequestMethod.GET)
	public void getGoodsSecoundColumn(@RequestParam("first_column")int firstColumnId, 
			Model model, HttpServletResponse response) throws IOException {

		response.setContentType("application/json;charset=UTF-8");
		List<GoodsSecondColumn>  SecondColumns=patentService.getSecondColumn(firstColumnId);
		WebUtils.writeJsonStrToResponse(response, SecondColumns);
	}
	
	private void addPatentTypeAndStatusDataToModel(Model model) {
		List<PatentType> allPatentTypes = patentService.getAllPatentTypes();
		List<PatentStatus> allPatentStatus = patentService.getAllPatentStatus();
		model.addAttribute("allPatentTypes", allPatentTypes);
		model.addAttribute("allPatentStatus", allPatentStatus);
	}
	
	@RequestMapping(path="/addPatentFrom", method=RequestMethod.GET)
	public String addPatentFrom(Model model){
		addPatentTypeAndStatusDataToModel(model);
		return "addPatentFrom";
	}
	
	@RequestMapping(path="/addPatent", method=RequestMethod.POST)
	public String addPatent(@ModelAttribute("patent")Patent patent,Model model){
		int userId = PrincipalUtils.getCurrentUserId();
		patent.setOwnerId(userId);
		patentService.addPatent(patent);
		return "add_patent_success";
	}
	
	@RequestMapping(path="/exportPatents",method=RequestMethod.GET)
	public void exportPatents(@RequestParam("patentIds") List<Long> patentIds,HttpServletResponse response) throws IOException{
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("X-FRAME-OPTIONS", "SAMEORIGIN");

		User user = PrincipalUtils.getCurrentPrincipal();
		String exportExcelName = user.getUsername() + System.currentTimeMillis() + ".xls";
		String exportExcelPath = patentService.patentExportExcel(patentIds, exportExcelName);
		File excelFile = new File(exportExcelPath);
		response.setContentLength((int)excelFile.length());
		response.setHeader("Content-Disposition", "attachment;filename=" + exportExcelName);
		
		int BUFFER_SIZE = 8192;
		byte[] buffer = new byte[BUFFER_SIZE];
		try (OutputStream out = response.getOutputStream(); 
				BufferedInputStream bis = new BufferedInputStream(new FileInputStream(excelFile))) {
			int bytesRead = -1;
			while ((bytesRead = bis.read(buffer)) != -1) {
				out.write(buffer, 0, bytesRead);
			}
			out.flush();
		}
	}
	
	@RequestMapping(path="/getUserTransactionPatents", method=RequestMethod.GET)
	public String getUserTransactionPatents(Model model, Page page, HttpSession session) {
		int userId = PrincipalUtils.getCurrentUserId();
		page.setUserId(userId);
		page.setPageSize(WebUtils.getPageSize(session));
		if (page.getCurrentPage() <= 0) {
			page.setCurrentPage(1);
		}
		int totalCount=(int)patentService.getUserTransactionPatentsCount(userId);
		page.setTotalRecords(totalCount);
		List<GoodsDetail> patents = patentService.getUserTransactionPatents(page);
		List<GoodsFirstColumn>  FirstColumns=patentService.getFirstColumn();
		model.addAttribute("FirstColumns", FirstColumns);
		model.addAttribute("patents", patents);
		model.addAttribute("page", page);
		return "goods_list";
	}
	
	@RequestMapping(path="/searchTransactionPatents", method=RequestMethod.GET)
	public String searchTransactionPatents(@ModelAttribute("searchCondition")TransactionPatentSearchCondition searchCondition, Model model,HttpSession session) {
		Page page=searchCondition.getPage();
		page.setPageSize(WebUtils.getPageSize(session));
		searchCondition.setUserId(PrincipalUtils.getCurrentUserId());
		List<GoodsDetail> resultPatents = patentService.searchTransactionPatentsByPage(searchCondition);
		int totalCount=(int)patentService.searchTransactionPatentsCount(searchCondition);
		page.setTotalRecords(totalCount);
		List<GoodsFirstColumn>  FirstColumns=patentService.getFirstColumn();
		model.addAttribute("FirstColumns", FirstColumns);
		model.addAttribute("patents", resultPatents);
		model.addAttribute("page", page);
		return "goods_list";
	}

	@RequestMapping(path="/downTransactionPatent")
	public void downTransactionPatents(@RequestParam("patentId") int patentId,PrintWriter writer){
		patentService.downTransactionPatent(patentId);
		writer.write(1);
	}	
	@RequestMapping(path="/upTransactionPatent")
	public void upTransactionPatents(@RequestParam("patentId") int patentId,PrintWriter writer){
		patentService.upTransactionPatent(patentId);
		writer.write(1);
	}	
	@RequestMapping(path="/deleteTransactionPatent")
	public void deleteTransactionPatents(@RequestParam("patentId") int patentId,PrintWriter writer){
		patentService.deleteTransactionPatent(patentId);
		writer.write(1);
	}
	
	@RequestMapping(path="/deletePatents", method=RequestMethod.GET)
	public void deletePatents(@RequestParam("patentIds") List<Long> patentIds,PrintWriter writer){
		int userId = PrincipalUtils.getCurrentUserId();
		patentService.patentsTrash(patentIds,userId);
		writer.write(1);
	}
	
	@RequestMapping(path="/patentRecycled", method=RequestMethod.GET)
	public String patentRecycled(Model model, Page page, HttpSession session){
		int userId = PrincipalUtils.getCurrentUserId();
		page.setUserId(userId);
		page.setPageSize(WebUtils.getPageSize(session));
		if (page.getCurrentPage() <= 0) {
			page.setCurrentPage(1);
		}
		int totalCount=patentService.getPatentsRecycledCount(userId);
		page.setTotalRecords(totalCount);
		List<Patent> patents=patentService.getPatentsRecycled(page);
		model.addAttribute("patents", patents);
		model.addAttribute("page", page);
		return "patent_recycled";
	}
	@RequestMapping(path="/recoverPatents", method=RequestMethod.GET)
	public void recoverPatent(@RequestParam("patentIds") List<Long> patentIds,PrintWriter writer){
		int userId = PrincipalUtils.getCurrentUserId();
		patentService.recoverPatents(patentIds, userId);
		writer.write(1);
		
	}
	
	@RequestMapping(path="/deleteForeverPatents", method=RequestMethod.GET)
	public void deleteForeverPatents(@RequestParam("patentIds") List<Long> patentIds,PrintWriter writer){
		int userId = PrincipalUtils.getCurrentUserId();
		patentService.deleteForeverPatents(patentIds, userId);
		writer.write(1);
	}
	
	
	@RequestMapping(path="/listByCreateTime", method=RequestMethod.GET)
	public String getUserPatentsByCreateTime(Model model, Page page, HttpSession session) {
		int userId = PrincipalUtils.getCurrentUserId();
		page.setUserId(userId);
		page.setPageSize(WebUtils.getPageSize(session));
		if (page.getCurrentPage() <= 0) {
			page.setCurrentPage(1);
		}
		//分页相关
		int totalCount=(int)patentService.getPatentsCount(userId);
		page.setTotalRecords(totalCount);
		Map<String, Map<String, String>> patentTypeCount=patentService.getUserPatentCountByType(userId);
		Map<String, Map<String, String>> patentStatusCount=patentService.searchUserPatentsByPatentStatus(userId);
		List<Patent> patents = patentService.getUserPatentsByCreateTime(page);
		model.addAttribute("patents", patents);
		model.addAttribute("page", page);
		model.addAttribute("patentTypeCount", patentTypeCount);
		model.addAttribute("patentStatusCount", patentStatusCount);
		addPatentTypeAndStatusDataToModel(model);
		return "patent_list";
	}
	
	
	@RequestMapping(path="/batchAddGoods", method=RequestMethod.GET)
	public void batchAddGoods(@RequestParam("patentIds") List<Long> patentIds,PrintWriter out) throws IOException {
		boolean notExistGoods = patentService.bacthsaveGoodsCheckOut(patentIds);
		int userId=PrincipalUtils.getCurrentUserId();
		  System.out.println(patentService.bacthsaveGoodsCheckOut(patentIds));
		if(!notExistGoods){
			patentService.batchSaveGoods(patentIds, userId);
			patentService.updatePatentsGoodsStatus(patentIds);
			out.write("批量发布成功");
		}else {
			out.write("所选择的专利中包含了已发布的专利，请和核对后再进行发布！");
		}
		
	}
	
	@RequestMapping(path="/changePrice", method=RequestMethod.GET)
	public void changePrice(int price,int patentId,PrintWriter writer) throws IOException {
		patentService.changePrice(price, patentId);
		writer.write(1);
	}
	
	@RequestMapping(path="/changSecondColume", method=RequestMethod.GET)
	public void changSecondColume(int SecondColumn,int patentId,PrintWriter writer) throws IOException {
		patentService.changSecondColume(SecondColumn, patentId);
	}
	
	@RequestMapping(path="/batchChangePrice", method=RequestMethod.GET)
	public void batchChangePrice(@RequestParam("price")int price,@RequestParam("patentIds") List<Long> patentIds,PrintWriter writer) throws IOException {
		patentService.batchChangePrice(price, patentIds);
		
	}
	
	@RequestMapping(path="showRemarks", method=RequestMethod.GET)
	public String showRemarks(@RequestParam("patentId")long patentId, Model model) {		
		List<PatentRemark> remarks = patentService.getPatentRemarks(patentId);
		model.addAttribute("remarks", remarks);
		model.addAttribute("addPatentId", patentId);
		return "patent_remarks";
	}

	@RequestMapping(path="addPatentRemark", method=RequestMethod.POST)
	public String addPatentRemark(@RequestParam("patentId")long patentId, @RequestParam("content") String content,Model model) {		
		int userId = PrincipalUtils.getCurrentUserId();
		patentService.addPatentRemark(patentId,content,userId);		
		return "patent_remarks";
	}	
	
	@RequestMapping(path="showPatentDetail", method=RequestMethod.GET)
	public String showPatentDetail(@RequestParam("patentId")long patentId,@RequestParam("ownerId")int ownerId,Model model) {
		int userId = PrincipalUtils.getCurrentUserId();
		Patent patent = patentService.showPatentDetail(patentId);
		boolean success = false;
		if(userId == patent.getOwnerId()) {
			success = true;
		}
		Map<String, Map<String, String>> patentTypeCount=patentService.getUserPatentCountByType(userId);
		Map<String, Map<String, String>> patentStatusCount=patentService.searchUserPatentsByPatentStatus(userId);
		model.addAttribute("patent", patent);
		model.addAttribute("success", success);
		model.addAttribute("patentTypeCount", patentTypeCount);
		model.addAttribute("patentStatusCount", patentStatusCount);
		addPatentTypeAndStatusDataToModel(model);
		return "patent_update_information";
	}	
	
	@RequestMapping(path="savePatentDetail", method=RequestMethod.POST)
	public String savePatentDetail(@ModelAttribute Patent patent,Model model) {
		patentService.savePatentDetail(patent);
		long patentId=patent.getPatentId();
		model.addAttribute("patentId", patentId);
		return "redirect:/patent/list.html"; 
	}	
	
	@RequestMapping(path="/deleteShareUser", method=RequestMethod.GET)
	public void deleteShareUser(@RequestParam("patentId")long patentId,@RequestParam("ownerId")int ownerId,@RequestParam("shareUserId")int shareUserId,Model model,
			HttpServletResponse response) throws IOException{
		patentService.deleteShareUser(patentId,ownerId,shareUserId);
		WebUtils.writeJsonStrToResponse(response, "success");
	}	
	
	@RequestMapping(path="/exportPatentsAllMessage", method=RequestMethod.GET)
	public void exportFeesAllMessage(@RequestParam("patents")List<Long> patentIds, HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("X-FRAME-OPTIONS", "SAMEORIGIN");

		User user = PrincipalUtils.getCurrentPrincipal();
		String exportExcelName = user.getUsername() + System.currentTimeMillis() + ".xls";
		String exportExcelPath = patentService.patentExportExcel(patentIds, exportExcelName);
		File excelFile = new File(exportExcelPath);
		response.setContentLength((int)excelFile.length());
		response.setHeader("Content-Disposition", "attachment;filename=" + exportExcelName);
		
		int BUFFER_SIZE = 8192;
		byte[] buffer = new byte[BUFFER_SIZE];
		try (OutputStream out = response.getOutputStream(); 
				BufferedInputStream bis = new BufferedInputStream(new FileInputStream(excelFile))) {
			int bytesRead = -1;
			while ((bytesRead = bis.read(buffer)) != -1) {
				out.write(buffer, 0, bytesRead);
			}
			out.flush();
		}
	}
	
	
	@RequestMapping(path="/cancelRecommendPatent", method=RequestMethod.GET)
	public void cancelRecommendPatent(long patentId,PrintWriter writer){
		patentService.cancelRecommendPatent(patentId);
		writer.write(1);
	}
	
	@RequestMapping(path="/recommendPatent", method=RequestMethod.GET)
	public void recommendPatent(long patentId,PrintWriter writer){
		patentService.recommendPatent(patentId);
		writer.write(1);
	}

}
