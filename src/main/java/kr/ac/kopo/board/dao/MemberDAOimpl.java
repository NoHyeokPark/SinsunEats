package kr.ac.kopo.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.vo.MemberVO;

@Repository
public class MemberDAOimpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sql;

	public MemberDAOimpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void joinMember(MemberVO m) {
		sql.insert("board.dao.MemberDAO.signup", m);

	}

	@Override
	public MemberVO login(MemberVO m) {
		return sql.selectOne("board.dao.MemberDAO.login", m);
	}

	@Override
	public void logout() {
		// TODO Auto-generated method stub

	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}

	@Override
	public MemberVO apiLogin(MemberVO m) {
		// TODO Auto-generated method stub
		return sql.selectOne("board.dao.MemberDAO.loginApi", m);
	}
	
	@Override
	public void useMileage(MemberVO m) {
		sql.update("board.dao.MemberDAO.mileage", m);
		
	}
}
