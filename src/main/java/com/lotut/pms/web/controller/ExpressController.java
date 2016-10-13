package com.lotut.pms.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lotut.pms.domain.CustomerSupport;
import com.lotut.pms.domain.Express;
import com.lotut.pms.domain.Page;
import com.lotut.pms.service.ExpressService;
import com.lotut.pms.service.FriendService;
import com.lotut.pms.service.UserService;
import com.lotut.pms.util.PrincipalUtils;
import com.lotut.pms.web.util.WebUtils;

@Controller
@RequestMapping(path="/express")
public class ExpressController {
	private ExpressService expressService;
	private FriendService friendService;
	private UserService userService;
	
	@Autowired
	public ExpressController(ExpressService expressService, FriendService friendService,UserService userService) {
		this.expressService = expressService;
		this.friendService = friendService;
		this.userService = userService;
	}	
	
	@RequestMapping(path="/addExpressForm", method=RequestMethod.GET)
	public String addExpressForm(Model model) {
		List<Map<String, String>> provinces = userService.getAllProvinces();
		model.addAttribute("provinces", provinces);
		return "express_add";
	}
	
	@RequestMapping(path="/addExpress", method=RequestMethod.GET)
	public void addExpress(Express express,Model model) {
		expressService.addExpress(express);
	}
	
	@RequestMapping(path="/confirmSendOff", method=RequestMethod.GET)
	public void confirmSendOff(Express express,Model model) {
		expressService.confirmSendOff(express);
	}
	
	
	@RequestMapping(path="/getUserSenderExpressList", method=RequestMethod.GET)
	public String getUserSenderExpressList(Model model,HttpSession session ,Page page) {
		
		int userId = PrincipalUtils.getCurrentUserId();
		page.setUserId(userId);
		page.setPageSize(WebUtils.getPageSize(session));
		if (page.getCurrentPage() <= 0) {
			page.setCurrentPage(1);
		}
		int totalCount=expressService.getUserSenderExpressCount(userId);
		page.setTotalRecords(totalCount);
		List<Express> expressResult = expressService.getUserSenderExpressListByPage(page);
		model.addAttribute("express", expressResult);
		return "";
	}
	
	@RequestMapping(path="/getUserReceiverExpressList", method=RequestMethod.GET)
	public String getUserReceiverExpressList(Model model,HttpSession session ,Page page) {
		
		int userId = PrincipalUtils.getCurrentUserId();
		page.setUserId(userId);
		page.setPageSize(WebUtils.getPageSize(session));
		if (page.getCurrentPage() <= 0) {
			page.setCurrentPage(1);
		}
		int totalCount=expressService.getUserReceiverExpressCount(userId);
		page.setTotalRecords(totalCount);
		List<Express> expressResult = expressService.getUserReceiverExpressListByPage(page);
		model.addAttribute("express", expressResult);
		return "";
	}
	
}