package kr.ac.kopo.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.ac.kopo.board.dao.GoodsDAO;
import kr.ac.kopo.service.GoodsService;
import kr.ac.kopo.vo.GoodsDetailVO;
import kr.ac.kopo.vo.GoodsVO;
import kr.ac.kopo.vo.OrderVO;
import kr.ac.kopo.vo.ReviewVO;
import kr.ac.kopo.vo.nutritionVO;

@Controller
public class GoodsController {

	@Autowired
	private GoodsService gs;

	@GetMapping("/goods")
	public ModelAndView listAll(@RequestParam("no") int no,
			@RequestParam(value = "filter", required = false) String filter,
			@RequestParam(value = "keyword", required = false) String keyword) {
		ModelAndView mav = new ModelAndView("/goods/list");
		List<GoodsVO> list = gs.allService(no, filter, keyword);
		mav.addObject("goodsList", list);
		int totalPage;
		mav.addObject("currentPage", no);
		int pageCountPerBlock = 10;

		int startPage = ((no - 1) / pageCountPerBlock) * pageCountPerBlock + 1;
		int endPage = startPage + pageCountPerBlock - 1;
		if (list.size() == 8) {
			totalPage = endPage + 1;
		} else {
			totalPage = no;
		}
		mav.addObject("totalPage", totalPage);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("filter", filter);
		mav.addObject("keyword", keyword);
		return mav;
	}

	@GetMapping("/detail")
	public ModelAndView detail(@RequestParam("code") String foodCode) {
		GoodsDetailVO detail = gs.detailService(foodCode);
		nutritionVO nvo = gs.nutrition(foodCode);
		List<ReviewVO> list = gs.reviewList(foodCode);
		ModelAndView mav = new ModelAndView("goods/detail");
		LocalDate tomorrow = LocalDate.now().plusDays(1);
		String dayOfWeek = tomorrow.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);
		String deliveryDate = tomorrow.format(DateTimeFormatter.ofPattern("M/d"));
		mav.addObject("nutrition", nvo);
		mav.addObject("reviews", list);
		mav.addObject("detail", detail);
		mav.addObject("deliveryDate", deliveryDate);
		mav.addObject("deliveryDayOfWeek", dayOfWeek); 
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/review/write")
	public Map<String, Object> refund(@RequestBody ReviewVO r) {

		Map<String, Object> result = new HashMap<>();

		try {
			gs.reviewIn(r);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}

}
