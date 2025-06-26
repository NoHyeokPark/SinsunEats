package kr.ac.kopo.board.dao;

import java.util.List;
import java.util.Map;

import kr.ac.kopo.vo.CartVO;
import kr.ac.kopo.vo.OrderVO;

public interface CartDAO {
	void insertCartItem(CartVO cart);
	List<CartVO> selectCart(String id);
	CartVO selectCheckCart(int id);
	void delete(int cartId);
	void update(CartVO quantity);
	List<OrderVO> selectOVO(Map<String, String> map);
}
