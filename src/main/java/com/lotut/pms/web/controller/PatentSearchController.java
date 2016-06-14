package com.lotut.pms.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lotut.pms.domain.Page;
import com.lotut.pms.domain.Patent;
import com.lotut.pms.service.PatentSearchService;
import com.lotut.pms.service.PatentService;
import com.lotut.pms.util.PrincipalUtils;


@Controller
@RequestMapping(path="/patent")
public class PatentSearchController {
	@Autowired
	private PatentSearchService patentSearchService;
	@Autowired
	private PatentService patentService;
	
	
	@RequestMapping(path="/searchPatent")
	public String search(@RequestParam("q")String keyword,Page page, Model model) {
		List<Patent> patent=patentSearchService.search(keyword,page);
		model.addAttribute("patent", patent);
		model.addAttribute("page", page);
		return "patent_search";
	}
	
	@RequestMapping(path="/addPatents")
	public void addPatents(@RequestParam("patents")List<String> patentIds,Model model) {
		List<Patent> patents=patentSearchService.getPatentsByIds(patentIds);
		int userId = PrincipalUtils.getCurrentUserId();
		patentService.addOrUpdatePatents(patents, userId);
	}
}
