package kr.ac.kopo.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.vo.PopupVO;

@Repository
public class PopupDAOimpl implements PopupDAO {

	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public List<PopupVO> selectActivePopup() {
		return sql.selectList("board.dao.PopupDAO.selectActivePopup");

	}

	@Override
	public List<PopupVO> selectAllPopup() {
		// TODO Auto-generated method stub
		return sql.selectList("board.dao.PopupDAO.selectAllPopup");
	}
	
	@Override
	public void insertPopup(PopupVO pop) {
		sql.insert("board.dao.PopupDAO.insertPop",pop);
		
	}
	
	@Override
	public void updatePopup(PopupVO pop) {
		sql.update("board.dao.PopupDAO.updatePop",pop);
		
	}
	
	@Override
	public void updateStat(PopupVO pop) {
		sql.update("board.dao.PopupDAO.updateStat",pop);
		
	}
	
	@Override
	public void deletePop(int id) {
		sql.delete("board.dao.PopupDAO.delete",id);
		
	}
}
