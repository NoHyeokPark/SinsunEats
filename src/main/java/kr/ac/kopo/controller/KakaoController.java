package kr.ac.kopo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.service.KakaoService;
import kr.ac.kopo.vo.MemberVO;

@Controller
public class KakaoController {

	private final String KAKAO_CLIENT_ID = "631cbf35dbda1e2f52a91b9e1e16b773";

	private final String KAKAO_REDIRECT_URI = "http://localhost:8080/Food-Shop-Spring/kakaoToken";

	@Autowired
	private KakaoService kakaoService; // 비즈니스 로직을 처리할 서비스 주입

	@GetMapping("/kakao")
	public String kakaoLogin() {
		String reqUrl = "https://kauth.kakao.com/oauth/authorize?client_id=" + KAKAO_CLIENT_ID + "&redirect_uri="
				+ KAKAO_REDIRECT_URI + "&response_type=code";
		return "redirect:" + reqUrl;
	}

	@GetMapping("/kakaoToken")
	public String kakaoToken(@RequestParam("code") String code, HttpSession session) {
		 try {
	            // 1. 인가 코드로 액세스 토큰 받기
	            String accessToken = kakaoService.getAccessToken(code, KAKAO_CLIENT_ID, KAKAO_REDIRECT_URI);

	            // 2. 액세스 토큰으로 카카오 사용자 정보 받기
	            JsonNode userInfo = kakaoService.getUserInfo(accessToken);

	            // 3. 사용자 정보 파싱
	            long id = userInfo.get("id").asLong();	            

	            // 4. 사용자 DB 조회 및 처리 (회원가입/로그인)
	            // 이 부분은 실제 프로젝트의 UserService나 MemberService에서 처리해야 합니다.
	            // User user = userService.processKakaoUser(id, nickname, email);

	            // 5. 세션에 로그인 정보 저장
	            MemberVO user = new MemberVO();
	            String kakaoId = "Kakao_" + id;
	            user.setId(""+id);
	            user.setName(kakaoId);
	            session.setAttribute("access_token", accessToken); // 로그아웃 시 필요할 수 있음
	            session.setAttribute("user", user);
	            

	        } catch (Exception e) {
	        	System.out.println("카카오 로그인 처리 중 오류 발생 " + e);
	            // 에러 페이지로 리다이렉트 또는 적절한 예외 처리
	            return "redirect:/home"; 
	        }

	        // 로그인 성공 후 홈 화면으로 리다이렉트 kakaoLogout
	        return "redirect:/home";
	    
	}
	
	@GetMapping("/kakaoLogout")
	public String kakaoLogout(HttpSession session, @RequestParam("token") String token) {
		System.out.println(token);
		try {
			JsonNode userid = kakaoService.logout(token);
			long idx = userid.get("id").asLong();
			System.out.println("로그아웃 성공 "+idx);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/home"; 
		}
		
		return "redirect:/home";
	}
}
