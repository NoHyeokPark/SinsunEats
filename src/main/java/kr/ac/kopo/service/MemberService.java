package kr.ac.kopo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.kopo.board.dao.MemberDAO;
import kr.ac.kopo.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO user;
	
	public MemberVO login(MemberVO m) {
		return user.login(m);
	}
	
	public void signup(MemberVO m) {
		user.joinMember(m);
	}

}
