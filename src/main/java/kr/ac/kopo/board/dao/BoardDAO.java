package kr.ac.kopo.board.dao;

import java.sql.SQLException;
import java.util.List;

import kr.ac.kopo.vo.BoardVO;
/**
 * 다오좀 다오
 * @author me
 */
public interface BoardDAO {
/*
 * 조회
 * 
 * 등록
 * 
 * 검색
 * 
 * 수정
 * 
 * 삭제
 * */
	
	/**
	 * 전체 게시글 조회
	 * @return 보드리스트
	 */
	List<BoardVO> selectBoardAll();
	/**
	 * 새글등록
	 * @param newgle 새글VO
	 * @return x
	 */
	void insertBoard(BoardVO newgle);
	/**
	 * 
	 * @param title
	 * @return 검색된 보드리스트
	 */
	List<BoardVO> selectBoardByTitle(String title);
	BoardVO selectBoardByNo(int no);
	/**
	 * 
	 * @param upBoard 수정 정보
	 */
	void updateBoardByNo(BoardVO upBoard);
	/**
	 * 
	 * @param no 게시글번호
	 */
	void deleteBoardByNo(int no);
}
