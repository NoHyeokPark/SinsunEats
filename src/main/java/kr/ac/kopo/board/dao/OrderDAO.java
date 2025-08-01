package kr.ac.kopo.board.dao;

import java.util.List;

import kr.ac.kopo.vo.OrderDetailVO;
import kr.ac.kopo.vo.OrderVO;

public interface OrderDAO {

	public void insertDetail(OrderDetailVO odvo);
	public void insertOv(OrderVO ov);
	public void statusUpdate(OrderVO order);
	public void invoUpdate(OrderVO order);
	public List<OrderDetailVO> selectDetail(OrderVO order);
	public OrderVO selectOne(OrderVO order);
	public List<OrderVO> selectCs(String id);
	public int getNextId();
	public void delete(int id);
}
