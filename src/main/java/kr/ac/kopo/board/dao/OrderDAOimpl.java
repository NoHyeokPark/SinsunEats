package kr.ac.kopo.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.vo.OrderDetailVO;
import kr.ac.kopo.vo.OrderVO;

@Repository
public class OrderDAOimpl implements OrderDAO {
	

	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public void insertDetail(OrderDetailVO odvo) {
		sql.insert("board.dao.OrderDAO.insertDetail", odvo);
		
	}
	@Override
	public void insertOv(OrderVO ov) {
		sql.insert("board.dao.OrderDAO.insertOv", ov);
		
	}
	
	@Override
	public void statusUpdate(OrderVO order) {
		sql.update("board.dao.OrderDAO.updateOv",order);
		
	}
	
	@Override
	public void invoUpdate(OrderVO order) {
		sql.update("board.dao.OrderDAO.updateInvo",order);
		
	}
	
	@Override
	public List<OrderDetailVO> selectDetail(OrderVO order) {
		return sql.selectList("board.dao.OrderDAO.selectDetail",order);
	}
	
	@Override
	public OrderVO selectOne(OrderVO order) {
		// TODO Auto-generated method stub
		return sql.selectOne("board.dao.OrderDAO.selectOne",order);
	}
}
