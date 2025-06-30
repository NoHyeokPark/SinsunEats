package kr.ac.kopo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.service.CartService;
import kr.ac.kopo.service.MemberService;
import kr.ac.kopo.vo.CartVO;
import kr.ac.kopo.vo.MemberVO;
import kr.ac.kopo.vo.OrderVO;

@Controller
@RequestMapping("/cart")
public class CartController {
	@Autowired
	private CartService cartService;
	@Autowired
	private MemberService ms;

	@GetMapping("/info")
	public ModelAndView info(HttpSession session) {
		MemberVO m = (MemberVO) session.getAttribute("user");
		ModelAndView mav = new ModelAndView("cart/cart");
		if (m != null) {
		List<CartVO> list = cartService.viewCart(m.getId());
		mav.addObject("carts",list);
		} else {}
		return mav;
	}
	
	@PostMapping("/order")
	public ModelAndView order(@RequestParam("cartId") List<Integer> cartIds, @RequestParam("usedMileage") int usedMileage) {
		ModelAndView mav = new ModelAndView("cart/order");
		List<CartVO> list = cartService.viewCheckCart(cartIds);
		mav.addObject("cartItems",list);
		mav.addObject("usedMileage",usedMileage);
		return mav;
	}
	

	@PostMapping("/process")
	public ModelAndView orderProcess(@RequestParam("cartId") List<Integer> cartIds, OrderVO ov, @RequestParam("usedMileage") int usedMileage, HttpSession session) {
		ModelAndView mav = new ModelAndView("cart/process");
		List<CartVO> list = cartService.viewCheckCart(cartIds);
		cartService.convert(list, ov);
		ms.useMileage(-usedMileage, ov.getUserId());
		MemberVO m = (MemberVO) session.getAttribute("user");
		m.setMileage(m.getMileage() - usedMileage);
		session.setAttribute("user", m);
		mav.addObject("orderInfo",ov);
		return mav;
	}

	@ResponseBody
	@PostMapping("/add")
	public Map<String, Object> addToCart(@RequestBody CartVO cart, HttpSession session) {

		Map<String, Object> result = new HashMap<>();

		MemberVO member = (MemberVO) session.getAttribute("user");

		if (member == null) {
			result.put("success", false);
			result.put("message", "로그인이 필요합니다.");
			return result;
		}

		cart.setUserId(member.getId());

		try {
			cartService.addCartItem(cart);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public Map<String, Object> deleteToCart(@RequestBody CartVO cart) {
		Map<String, Object> result = new HashMap<>();

		try {
			cartService.delete(cart.getCartId()); 
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
	
	@ResponseBody
	@PostMapping("/updateQuantity")
	public Map<String, Object> updateCart(@RequestBody CartVO cart) {
		Map<String, Object> result = new HashMap<>();
		System.out.println("1");
		try {
			cartService.update(cart.getCartId(), cart.getQuantity()); 
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
			System.out.println(e.getMessage());
			result.put("message", "오류발생 고객센터에 문의해주세요");
		}

		return result;
	}
}
