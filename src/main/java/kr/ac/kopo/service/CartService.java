package kr.ac.kopo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.board.dao.CartDAOimpl;
import kr.ac.kopo.board.dao.OrderDAO;
import kr.ac.kopo.vo.CartVO;
import kr.ac.kopo.vo.OrderDetailVO;
import kr.ac.kopo.vo.OrderVO;

@Service
public class CartService {

	@Autowired
	private CartDAOimpl cartDAO;
	
	@Autowired
	private OrderDAO od;
	

	public void addCartItem(CartVO cart) {
		cartDAO.insertCartItem(cart);
	}
	
	public List<CartVO> viewCart(String id){
		
		return cartDAO.selectCart(id);
	}
	
	public List<CartVO> viewCheckCart(List<Integer> id){
		
		List<CartVO> list = new ArrayList<CartVO>();
		for(int i : id) {
		list.add(cartDAO.selectCheckCart(i));	
		}
		return list;
	}
	
	public void delete(int cartId) {
		cartDAO.delete(cartId);
	}
	
	public void update(int id, int quantity) {
		CartVO c = new CartVO();
		c.setCartId(id);
		c.setQuantity(quantity);
		cartDAO.update(c);
	}
	
	@Transactional
	public void convert(List<CartVO> list, OrderVO ov) {
		od.insertOv(ov);
		int delid = ov.getDeliveryId();
		for(CartVO c : list) {
			OrderDetailVO odvo = new OrderDetailVO();
			odvo.setDeliveryId(delid);
			odvo.setFoodCode(c.getFoodCode());
			odvo.setPrice(c.getDiscountPrice());
			odvo.setQuantity(c.getQuantity());
			od.insertDetail(odvo);
			cartDAO.delete(c.getCartId());	
		}
	}
	
	public List<OrderVO> search(Map<String, String> map){
		
		return cartDAO.selectOVO(map);
	}
	
	public void orderChange(OrderVO order) {
		od.statusUpdate(order);
	}
	
	public void invoChange(OrderVO order) {
		od.invoUpdate(order);
	}
	
	public List<OrderDetailVO> detailSearch(OrderVO order){
		return od.selectDetail(order);
	}
	
	public OrderVO selectOne(OrderVO order) {
		return od.selectOne(order);
	}
}
