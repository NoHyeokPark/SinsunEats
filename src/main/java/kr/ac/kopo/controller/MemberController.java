package kr.ac.kopo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.service.MemberService;
import kr.ac.kopo.vo.MemberVO;


@Controller
public class MemberController {

	@Autowired
	private MemberService ms;

	@PostMapping("/login")
	public String login(MemberVO m, HttpSession session) {
		MemberVO ma = ms.login(m);
		if(ma != null) {
			session.setAttribute("user", ma);
		}
		return "redirect:/home";
	}

	@GetMapping("/login")
	public String loginform(MemberVO m) {
		return "member/loginForm";
	}

	@GetMapping("/logout")
	public String logout(HttpSession s) {
		 String accessToken = (String) s.getAttribute("access_token");
		s.invalidate();
		if (accessToken != null) {
			return "redirect:/kakaoLogout?token="+accessToken;
		}
		return "redirect:/home";
	}

	@GetMapping("/signup")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/signup")
	public String joingo(MemberVO m) {
		ms.signup(m);
		return "redirect:/home";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "member/myPage";
	}

}
