package kr.ac.kopo.controller;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	
	@PostMapping("/toss")
	public ModelAndView tossProcess(@RequestParam("cartId") List<Integer> cartIds, OrderVO ov, @RequestParam("usedMileage") int usedMileage, HttpSession session) {
		ModelAndView mav = new ModelAndView("cart/toss");
		List<CartVO> list = cartService.viewCheckCart(cartIds);
		ov.setDeliveryStatus("결제대기");
		cartService.convert(list, ov);
		String ck = UUID.randomUUID().toString();
		String orderName = list.get(0).getFoodName()+" 외" + (list.size()-1) + '건';
		mav.addObject("orderId", "tossPayment_"+ov.getDeliveryId());
		mav.addObject("ck", ck);
		mav.addObject("orderName", orderName);
		mav.addObject("price", ov.getTotalPrice());
		return mav;
	}
	
	@GetMapping("/success")
	public ModelAndView success(HttpSession session, 
			@RequestParam("paymentType") String type
			,@RequestParam("orderId") String orderId
			,@RequestParam("paymentKey") String paymentKey
			,@RequestParam("amount") int amount) {
		OrderVO ov= new OrderVO();
		ov.setDeliveryId(Integer.parseInt(orderId.substring(12)));
		ov = cartService.selectOne(ov);
		ModelAndView mav = null;
		if(ov.getTotalPrice() == amount) {	
	        Map<String, Object> data = new HashMap<>();
	        data.put("orderId", orderId);
	        data.put("amount", amount);
	        data.put("paymentKey", paymentKey);
	        ObjectMapper mapper = new ObjectMapper();
	        try {
				String jsonString = mapper.writeValueAsString(data);
				ResponseEntity<JsonNode> response = approve(jsonString);
				JsonNode body = response.getBody();
				System.out.println(body.get("status").asText());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		mav = new ModelAndView("cart/process");
		ms.useMileage(-ov.getUsedMileage(), ov.getUserId());
		MemberVO m = (MemberVO) session.getAttribute("user");
		m.setMileage(m.getMileage() - ov.getUsedMileage());
		session.setAttribute("user", m);
		cartService.paySuccess(ov.getDeliveryId(), paymentKey);
		mav.addObject("orderInfo",ov);
		} else {
		mav = new ModelAndView("redirect:/cart/fail?code=AMOUNT_MISMATCH&message=결제금액이+다릅니다&orderId=" + orderId);
		}
		return mav;
	}
	
	private ResponseEntity<JsonNode> approve(String jsonString) throws Exception {
		   String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
	        Base64.Encoder encoder = Base64.getEncoder();
	        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
	        String authorizations = "Basic " + new String(encodedBytes);

	        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
	        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
	        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	        connection.setRequestProperty("Authorization", authorizations);
	        connection.setRequestProperty("Content-Type", "application/json");
	        connection.setRequestMethod("POST");
	        connection.setDoOutput(true);

	        OutputStream outputStream = connection.getOutputStream();
	        outputStream.write(jsonString.getBytes("UTF-8"));

	        int code = connection.getResponseCode();
	        boolean isSuccess = code == 200;

	        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

	        // 결제 성공 및 실패 비즈니스 로직을 구현하세요.
	        InputStreamReader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
	        ObjectMapper mapper = new ObjectMapper();
	        JsonNode jsonObject = mapper.readTree(reader);
	        responseStream.close();

	        return ResponseEntity.status(code).body(jsonObject);
	}
	
	@GetMapping("/fail")
	public ModelAndView fail(HttpSession session, 
			@RequestParam("code") String code
			,@RequestParam("message") String message
			,@RequestParam("orderId") String orderId) {
		ModelAndView mav = new ModelAndView("cart/fail");
		cartService.deleteOrder(Integer.parseInt(orderId.substring(12)));
		return mav;
	}

	@PostMapping("/process")
	public ModelAndView orderProcess(@RequestParam("cartId") List<Integer> cartIds, OrderVO ov, @RequestParam("usedMileage") int usedMileage, HttpSession session) {
		ModelAndView mav = new ModelAndView("cart/Process");
		List<CartVO> list = cartService.viewCheckCart(cartIds);
		cartService.convert(list, ov);
		ms.useMileage(-usedMileage, ov.getUserId());
		MemberVO m = (MemberVO) session.getAttribute("user");
		m.setMileage(m.getMileage() - usedMileage);
		session.setAttribute("user", m);
		mav.addObject("orderInfo",ov);
		return mav;
	}
	
    @ExceptionHandler(IllegalStateException.class)
    public String handleStockException(IllegalStateException ex, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("errorMsg", ex.getMessage());
        return "redirect:/home";
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
