package kr.ac.kopo.board.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.vo.CartVO;
import kr.ac.kopo.vo.OrderVO;

@Repository
public class CartDAOimpl implements CartDAO {

	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public void insertCartItem(CartVO cart) {
		CartVO c = sql.selectOne("board.dao.CartDAO.existCart", cart);
		if (c != null) {
			cart.setQuantity(c.getQuantity() + cart.getQuantity());
			sql.update("board.dao.CartDAO.updateCart", cart);
		} else {

			sql.insert("board.dao.CartDAO.insertCart", cart);
		}
	}

	@Override
	public List<CartVO> selectCart(String id) {

		return sql.selectList("board.dao.CartDAO.selectCart",id);
	}
	
	@Override
	public CartVO selectCheckCart(int id) {
		return sql.selectOne("board.dao.CartDAO.selectCheckCart",id);
	}
	
	@Override
	public void delete(int cartId) {
		sql.delete("board.dao.CartDAO.deleteOne",cartId);
	}
	
	@Override
	public void update(CartVO quantity) {
		sql.update("board.dao.CartDAO.updateQuantity", quantity);
	}
	
	@Override
	public List<OrderVO> selectOVO(Map<String, String> map) {
		
		return sql.selectList("board.dao.CartDAO.selectOVO",map);
	}

}
