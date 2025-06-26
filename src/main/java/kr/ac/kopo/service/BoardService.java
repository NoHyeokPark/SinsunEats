package kr.ac.kopo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.board.dao.BoardDAO;
import kr.ac.kopo.vo.BoardVO;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO b;

	
	public List<BoardVO> listAllService() {
		return b.selectBoardAll();
	}
	
	public BoardVO detailService(int no) {
		return b.selectBoardByNo(no);
	}
}
