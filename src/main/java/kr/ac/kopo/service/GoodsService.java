package kr.ac.kopo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.board.dao.GoodsDAO;
import kr.ac.kopo.vo.GoodsDetailVO;
import kr.ac.kopo.vo.GoodsVO;

@Service
public class GoodsService {
	
	@Autowired
	private GoodsDAO b;

	
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
	
	private void discount(List<GoodsVO> goods) {
		//{Math.floor((i.price * (100 - i.discountPercent) / 100) / 100) * 100}
		for (GoodsVO good : goods) {
			good.setDiscountPrice(good.getPrice()*(100-good.getDiscountPercent())/100/100*100);		
		}
	}
	
	public List<GoodsVO> div() {
		return b.selectAllDiv();
	}
	
}
