package kr.ac.kopo.board.dao;

import kr.ac.kopo.vo.MemberVO;

public interface MemberDAO {
	
	void joinMember(MemberVO m);
	
	MemberVO login(MemberVO m);
	
	void logout();
	
	MemberVO apiLogin(MemberVO m);
	
	void useMileage(MemberVO m);
}
