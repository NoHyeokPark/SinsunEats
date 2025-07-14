package kr.ac.kopo.board.dao;

import java.util.List;
import java.util.Map;

import kr.ac.kopo.vo.MemberVO;

public interface MemberDAO {
	
	void joinMember(MemberVO m);
	
	MemberVO login(MemberVO m);
	
	void logout();
	
	MemberVO apiLogin(MemberVO m);
	
	void useMileage(MemberVO m);
	
	List<MemberVO> selectAd(Map<String, String> map);
}
