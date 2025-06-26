package kr.ac.kopo.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public void deleteBoardByNo(int no) {
		// TODO Auto-generated method stub

	}

	@Override
	public void insertBoard(BoardVO newgle) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<BoardVO> selectBoardAll() {
		return sql.selectList("board.dao.BoardDAO.selectAllBoard");
	}

	@Override
	public BoardVO selectBoardByNo(int no) {
		// TODO Auto-generated method stub
		return sql.selectOne("board.dao.BoardDAO.selectById", no);
	}

	@Override
	public List<BoardVO> selectBoardByTitle(String title) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateBoardByNo(BoardVO upBoard) {
		// TODO Auto-generated method stub

	}

	public BoardDAOImpl() {

	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
}
