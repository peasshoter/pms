package com.lotut.pms.web.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lotut.pms.domain.Fee;
import com.lotut.pms.domain.FeeMonitorStatus;
import com.lotut.pms.domain.FeePaymentStatus;
import com.lotut.pms.domain.FeeProcessStatus;
import com.lotut.pms.domain.FeeSearchCondition;
import com.lotut.pms.domain.Notice;
import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.Patent;
import com.lotut.pms.domain.PatentStatus;
import com.lotut.pms.domain.PatentType;
import com.lotut.pms.domain.User;
import com.lotut.pms.service.FeeService;
import com.lotut.pms.util.PrincipalUtils;
import com.lotut.pms.web.util.WebUtils;

@Controller
@RequestMapping(path="/fee")
public class FeeController {
	private FeeService feeService;
	
	@Autowired
	public FeeController(FeeService feeService) {
		this.feeService = feeService;
	}

	/*
	 * 批量缴费
	 */	
	@RequestMapping(path="/batchGrabFees", method=RequestMethod.GET)
	public String batchGrabFees(@RequestParam("patents")List<Long> patentIds, Model model) {
		Map<String, List<?>> grabResultMap = feeService.batchGrabFees(patentIds);
		model.addAllAttributes(grabResultMap);
		return "batch_fee_list";
	}	
	
	/*
	 * 单个缴费
	 */		
	@RequestMapping(path="/grabFees", method=RequestMethod.GET)
	public String grabFees(@RequestParam("patent")long patentId, Model model) {
		Map<String, Object> grabResultMap = feeService.grabFees(patentId);
		model.addAllAttributes(grabResultMap);
		return "fee_list";
	}	

	/*
	 * 单个修改监控
	 */
	@RequestMapping(path="/changeMonitorStatus", method=RequestMethod.GET)
	public String changeMonitorStatus(@RequestParam("fees")List<Long> feeIds, @RequestParam("monitorStatus")int monitorStatus,Model model) {
		List<Fee> fees=feeService.changeMonitorStatus(feeIds, monitorStatus);
			model.addAttribute("fees", fees);
			return "fee_list_without_grab";
	}
	
	/*
	 * 批量修改监控
	 */
	@RequestMapping(path="/batchChangeMonitorStatus", method=RequestMethod.GET)
	public String batchChangeMonitorStatus(@RequestParam("fees")List<Long> feeIds,@RequestParam("patents")List<Long> patents, @RequestParam("monitorStatus")int monitorStatus,Model model) {
		List<Fee> fees=feeService.batchChangeMonitorStatus(feeIds, patents,monitorStatus);
		model.addAttribute("fees", fees);
		return "batch_fee_list_withou_grap";
	}
	
	@RequestMapping(path="/list", method=RequestMethod.GET)
	public ModelAndView getFeeList() {
		return null;
	}
	//CS:分页
	@RequestMapping(path="/monitoredFeeList", method=RequestMethod.GET)
	public String getMonitoredFees(Model model,Page page,HttpSession session) {
		int userId = PrincipalUtils.getCurrentUserId();
		page.setPageSize(WebUtils.getPageSize(session));
		page.setUserId(userId);
		int totalCount=(int)feeService.getUserMonitoredFeesCounts(userId);
		page.setTotalRecords(totalCount);
		List<Fee> fees = feeService.getUserMonitoredFeesByPage(page);
		Map<String,Map<String,String>> patentTypeCount=feeService.getMonitoredFeesByType(userId);
		Map<String,Map<String,String>> feePaymentStatusCount=feeService.getMonitoredFeesByStatus(userId);
		Map<String,Map<String,String>> patentStatusCount=feeService.getMonitoredFeesByFeeType(userId);
		model.addAttribute("patentTypeCount", patentTypeCount);
		model.addAttribute("feePaymentStatusCount", feePaymentStatusCount);
		model.addAttribute("patentStatusCount", patentStatusCount);
		model.addAttribute("page", page);
		model.addAttribute("fees", fees);
		return "monitored_fee_list";
	}	
	
	//CS:搜索分页
	@RequestMapping(path="/search", method=RequestMethod.GET)
	public String searchUserMonitoredFees(@ModelAttribute("searchCondition")FeeSearchCondition searchCondition, Model model,HttpSession session) {
		Page page=searchCondition.getPage();
		page.setPageSize(WebUtils.getPageSize(session));
		searchCondition.setUserId(PrincipalUtils.getCurrentUserId());
		List<Fee> fees = feeService.searchUserMonitoredFeesByPage(searchCondition);
		int totalCount=(int)feeService.searchUserMonitoredFeesCount(searchCondition);
		page.setTotalRecords(totalCount);
		Map<String,Map<String,String>> patentTypeCount=feeService.getMonitoredFeesByType(searchCondition.getUserId());
		Map<String,Map<String,String>> feePaymentStatusCount=feeService.getMonitoredFeesByStatus(searchCondition.getUserId());
		Map<String,Map<String,String>> patentStatusCount=feeService.getMonitoredFeesByFeeType(searchCondition.getUserId());
		model.addAttribute("patentTypeCount", patentTypeCount);
		model.addAttribute("feePaymentStatusCount", feePaymentStatusCount);
		model.addAttribute("patentStatusCount", patentStatusCount);
		model.addAttribute("fees", fees);
		model.addAttribute("page", page);
		return "monitored_fee_list";
	
	}
	
	
	
	@RequestMapping(path="/changeInvoiceTitle", method=RequestMethod.GET)
	public String changeInvoiceTitle(@RequestParam("fees")List<Long> feeIds, @RequestParam("invoiceTitle")String invoiceTitle) {
		feeService.changeFeesInvoiceTitle(feeIds, invoiceTitle);
		return "monitored_fee_list";
	}
	
	@RequestMapping(path="/exportFees", method=RequestMethod.GET)
	public void exportFees(@RequestParam("fees")List<Long> feeIds, HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.ms-excel");
		
		User user = PrincipalUtils.getCurrentPrincipal();
		String exportExcelName = user.getUsername() + System.currentTimeMillis() + ".xls";
		String exportExcelPath = feeService.generateFeeExportExcel(feeIds, exportExcelName);
		
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
	
	
	
	
	@RequestMapping(path="/delete", method=RequestMethod.GET)
	public ModelAndView deleteFee() {
		return null;
	}		
	
	//CS:deleteFees
		@RequestMapping(path="/deleteFees", method=RequestMethod.GET)
		public String deleteFees(@RequestParam("fees")List<Long> feeIds) {
			int userId = PrincipalUtils.getCurrentUserId();
			feeService.deleteFees(feeIds, userId);
			return "monitored_fee_list";
		}
		
	    
}
