package kr.ac.kopo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.service.CartService;
import kr.ac.kopo.service.CsService;
import kr.ac.kopo.service.GoodsService;
import kr.ac.kopo.service.PopupService;
import kr.ac.kopo.vo.CartVO;
import kr.ac.kopo.vo.CsBoardVO;
import kr.ac.kopo.vo.MemberVO;
import kr.ac.kopo.vo.OrderVO;
import kr.ac.kopo.vo.PopupVO;

@Controller
@RequestMapping("/admin")
public class adminController {
	
	@Autowired
	private GoodsService gs;
	@Autowired
	private CartService cartService;
	@Autowired
	private PopupService ps;
	@Autowired
	private CsService css;


	@GetMapping("/main")
	public String index() {
		return "/admin/main";
	}
	
	@GetMapping("/cs")
	public ModelAndView cs() {
		ModelAndView mav = new ModelAndView("/admin/cs");
		mav.addObject("csList",css.listAll());
		
		return mav;
	}
	
	@GetMapping("/goods")
	public String goods(Model model) {
		model.addAttribute("category", gs.div());
		
		return "/admin/goods";
	}
	
	@GetMapping("/member")
	public String member() {
		return "/admin/member";
	}
	
	@GetMapping("/order")
	public String order() {
		return "/admin/order";
	}
	
	@GetMapping("/popup")
	public ModelAndView popup() {
		ModelAndView mav = new ModelAndView("/admin/popup");
		mav.addObject("popupList",ps.getPopAll());
		return mav;
	}
	
	@GetMapping("/summary")
	public String summary() {
		return "/admin/summary";
	}
	
	@PostMapping("/order/search")
	public ModelAndView orderAdmin(@RequestParam("startDate") String startDate 
			,@RequestParam("endDate") String endDate ,@RequestParam("status") String status
			,@RequestParam("keyword") String keyword) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("status", status);
		map.put("keyword", keyword);
		
		ModelAndView mav = new ModelAndView("/admin/order");
		mav.addObject("orderList", cartService.search(map));
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/orders/updateStatus")
	public Map<String, Object> orderStatusChange(@RequestBody OrderVO order) {

		Map<String, Object> result = new HashMap<>();

		try {
			cartService.orderChange(order);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@PostMapping("/orders/updateInvoice")
	public Map<String, Object> updateInvoice(@RequestBody OrderVO order) {

		Map<String, Object> result = new HashMap<>();

		try {
			cartService.invoChange(order);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@GetMapping("/orders/details")
	public Map<String, Object> openOrderDetailModal(@RequestParam("deliveryId") int id) {

		Map<String, Object> result = new HashMap<>();
		OrderVO order = new OrderVO();
		order.setDeliveryId(id);
		try {
			result.put("orderInfo", cartService.selectOne(order));

			result.put("itemList", cartService.detailSearch(order));

			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@PostMapping("/popup/save")
	public Map<String, Object> popupSave(@RequestBody PopupVO pop) {

		Map<String, Object> result = new HashMap<>();

		try {
			ps.addPop(pop);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@PostMapping("/popup/update")
	public Map<String, Object> popupUpdate(@RequestBody PopupVO pop) {

		Map<String, Object> result = new HashMap<>();

		try {
			ps.updatePop(pop);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@PostMapping("/popup/update-status")
	public Map<String, Object> updateStatus(@RequestBody PopupVO pop) {

		Map<String, Object> result = new HashMap<>();

		try {
			ps.updateStat(pop);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	
	@ResponseBody
	@DeleteMapping("/popups/delete/{id}")
	public Map<String, Object> deletePop(@PathVariable("id") int id) {

		Map<String, Object> result = new HashMap<>();

		try {
			ps.deletePop(id);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@PostMapping("/cs/registerAnswer")
	public Map<String, Object> registerAnswer(@RequestBody CsBoardVO cs) {

		Map<String, Object> result = new HashMap<>();

		try {
			css.answer(cs);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
}
