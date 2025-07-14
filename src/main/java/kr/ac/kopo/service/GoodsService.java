package kr.ac.kopo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.board.dao.GoodsDAO;
import kr.ac.kopo.controller.StockSseController;
import kr.ac.kopo.vo.GoodsDetailVO;
import kr.ac.kopo.vo.GoodsVO;
import kr.ac.kopo.vo.OrderVO;
import kr.ac.kopo.vo.ReviewVO;
import kr.ac.kopo.vo.goodsAdminVO;
import kr.ac.kopo.vo.nutritionVO;

@Service
public class GoodsService {
	
	@Autowired
	private GoodsDAO b;
	
	@Autowired
	private StockSseController sseController;

	
	public List<GoodsVO> top8Service() {
		List<GoodsVO> list = b.selectGoodsTop8();
		discount(list);
		return list;
	}
	
	public List<GoodsVO> allService(int no, String filter, String keyword) {
		List<GoodsVO> list = b.goodsAll(no, filter, keyword);
		discount(list);
		return list;
	}
	
	public GoodsDetailVO detailService(String code) {
		GoodsDetailVO gdv = b.selectDetail(code);
		gdv.setDiscountPrice(gdv.getPrice()*(100-gdv.getDiscountPercent())/100/100*100);
		return gdv;
	}
	
	public List<goodsAdminVO> searchAdmin(Map<String, String> map){
		
		return b.selectAd(map);
	}
	
	public nutritionVO nutrition(String code) {
		
		return b.selectNutrition(code);
	}
	
	private void discount(List<GoodsVO> goods) {
		//{Math.floor((i.price * (100 - i.discountPercent) / 100) / 100) * 100}
		for (GoodsVO good : goods) {
			good.setDiscountPrice(good.getPrice()*(100-good.getDiscountPercent())/100/100*100);		
		}
	}
	
	public List<GoodsVO> div() {
		return b.selectAllDiv();
	}
	
	public List<ReviewVO> reviewList(String code){
		return b.selectReview(code);
		
	}
	
	public void reviewIn(ReviewVO r){
		b.reviewIn(r);
		
	}
	
	public void update(goodsAdminVO ad) {
		b.goodsupdate(ad);
	}
	
	public void stockUpdate(String code, String name, int quantity) {
		int stock = b.stockCheck(code);
		if (stock < quantity) {
	        throw new IllegalStateException(name +"상품 재고 부족!!");
	    }
		GoodsDetailVO gdv  = new GoodsDetailVO();
		gdv.setFoodCode(code);
		gdv.setStock(quantity);
		b.stockUpdate(gdv);
	    if (stock - quantity <= 10) {
	        sseController.notifyStockLow(name, stock - quantity, code); // 실시간 알림 전송
	    }
	}
	
}
