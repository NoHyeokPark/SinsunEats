package kr.ac.kopo.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.vo.CsBoardVO;

@Repository
public class CsDAOimpl implements CsDAO {

	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public List<CsBoardVO> select(String id) {
		return sql.selectList("cs.all",id);
	}
	
	@Override
	public void insert(CsBoardVO cs) {
		sql.insert("cs.write",cs);
		
	}
	
	@Override
	public List<CsBoardVO> selectAll() {
		return sql.selectList("cs.allAll");
	}
	
	@Override
	public CsBoardVO selectOne(int no) {
		return sql.selectOne("cs.one", no);
	}
	
	@Override
	public void insertAnswer(CsBoardVO cs) {
		sql.update("cs.answer", cs);
		
	}
}
