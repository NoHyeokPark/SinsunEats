package kr.ac.kopo.board.dao;

import java.util.List;

import kr.ac.kopo.vo.CsBoardVO;

public interface CsDAO {
	public void insert(CsBoardVO cs);

	public List<CsBoardVO> select(String id);
	
	public CsBoardVO selectOne(int no);
	
	public List<CsBoardVO> selectAll();

	public void insertAnswer(CsBoardVO cs);

	
}
