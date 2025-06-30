package kr.ac.kopo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.kopo.board.dao.MemberDAO;
import kr.ac.kopo.vo.MemberVO;
import kr.ac.kopo.vo.OrderVO;

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
	
	public MemberVO apiLogin(MemberVO m) {
		return user.apiLogin(m);
	} 
	
	public void useMileage(int usedMileage, String Id) {
		MemberVO u = new MemberVO();
		u.setMileage(usedMileage);
		u.setId(Id);
		user.useMileage(u);
	}
	
	public void refund(OrderVO order) {
		MemberVO u = new MemberVO();
		u.setId(order.getUserId());
		u.setMileage(order.getUsedMileage());
		user.useMileage(u);
	}

}
