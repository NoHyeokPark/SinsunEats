package kr.ac.kopo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.kopo.service.GoodsService;
import kr.ac.kopo.service.PopupService;
import kr.ac.kopo.vo.GoodsVO;
import kr.ac.kopo.vo.PopupVO;

@Controller
public class SimpleLinkController {

	@Autowired
	private GoodsService gs;
	
	@Autowired
	private PopupService ps;

	@GetMapping("/home")
	public ModelAndView list() {
		List<GoodsVO> goods8 = gs.top8Service();
		List<PopupVO> popup = ps.getPopup();
		ModelAndView mav = new ModelAndView("home");
		mav.addObject("hotItem", goods8);
		mav.addObject("popup", popup);
		return mav;
	}
	
	@GetMapping("/info")
	public String info() {
		return "info/info";
	}
	

}
