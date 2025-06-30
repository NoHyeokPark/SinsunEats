package kr.ac.kopo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.service.CartService;
import kr.ac.kopo.service.CsService;
import kr.ac.kopo.service.KakaoService;
import kr.ac.kopo.vo.CsBoardVO;
import kr.ac.kopo.vo.MemberVO;

@Controller
public class CsControllrer {
	
	@Autowired
	private CsService css;
	
	@Autowired
	private KakaoService ks;
	
	@Autowired
	private CartService cartService;
	
	@GetMapping("/cs")
	public String info() {
		return "cs/csMain";
	}
	
	@GetMapping("/cs/view")
	public String view(@RequestParam("no") int no, Model model) {
		System.out.println("no :"+no);
		model.addAttribute("inquiry",css.one(no));
		return "cs/view";
	}
	
	@GetMapping("/cs/list")
	public String list(HttpSession session, Model model) {
		MemberVO vo = (MemberVO) session.getAttribute("user");
		if(vo == null) {
			return "member/alert";
		}
		model.addAttribute("inquiryList", css.list(vo.getId()));
		return "cs/csList";
	}
	
	@GetMapping("/cs/write")
	public String write(HttpSession session, Model model) {
		MemberVO vo = (MemberVO) session.getAttribute("user");
		model.addAttribute("order", cartService.list(vo.getId()));
		return "cs/write";
	}
	
	@PostMapping("/cs/write")
	public String writePost(HttpSession session, @RequestParam("orderReference") int orderReference, @RequestParam("category") String category,
            @RequestParam("title") String title,
            @RequestParam("writer") String writer,
            @RequestParam("content") String content,
            @RequestParam("tel") String tel, @RequestParam(value = "file" ,required = false) MultipartFile file) {
		
		CsBoardVO cs = new CsBoardVO();
		cs.setCategory(category);
		cs.setContent(content);
		cs.setTel(tel);
		cs.setTitle(title);
		cs.setWriter(writer);
		cs.setOrderReference(orderReference);
		String token = (String) session.getAttribute("access_token");
		ks.sendAlam(token, category ,title);
		css.write(cs);
		return "redirect:/cs/list";
	}
}
