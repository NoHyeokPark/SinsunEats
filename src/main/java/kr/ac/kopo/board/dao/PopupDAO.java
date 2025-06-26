package kr.ac.kopo.board.dao;

import java.util.List;

import kr.ac.kopo.vo.PopupVO;

public interface PopupDAO {

	List<PopupVO> selectActivePopup();
	List<PopupVO> selectAllPopup();
	void insertPopup(PopupVO pop);
	void updatePopup(PopupVO pop);
	void updateStat(PopupVO pop);
	void deletePop(int id);
}
