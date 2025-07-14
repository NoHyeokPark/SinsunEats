package kr.ac.kopo.board.dao;

import java.util.List;
import java.util.Map;

import kr.ac.kopo.vo.CartVO;
import kr.ac.kopo.vo.GoodsDetailVO;
import kr.ac.kopo.vo.GoodsVO;
import kr.ac.kopo.vo.ReviewVO;
import kr.ac.kopo.vo.goodsAdminVO;
import kr.ac.kopo.vo.nutritionVO;

public interface GoodsDAO {
	List<GoodsVO> selectGoodsTop8();
	List<GoodsVO> goodsAll(int no, String filter, String keyword);
	GoodsDetailVO selectDetail(String id);
	List<GoodsVO> selectAllDiv();
	nutritionVO selectNutrition(String code);
	List<ReviewVO> selectReview(String code);
	void reviewIn(ReviewVO r);
	List<goodsAdminVO> selectAd(Map<String, String> map);
	void goodsupdate(goodsAdminVO ad);
	void stockUpdate(GoodsDetailVO c);
	int stockCheck(String code);
}
