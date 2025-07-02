package kr.ac.kopo.board.dao;

import java.util.List;

import kr.ac.kopo.vo.GoodsDetailVO;
import kr.ac.kopo.vo.GoodsVO;
import kr.ac.kopo.vo.ReviewVO;
import kr.ac.kopo.vo.nutritionVO;

public interface GoodsDAO {
	List<GoodsVO> selectGoodsTop8();
	List<GoodsVO> goodsAll(int no, String filter, String keyword);
	GoodsDetailVO selectDetail(String id);
	List<GoodsVO> selectAllDiv();
	nutritionVO selectNutrition(String code);
	List<ReviewVO> selectReview(String code);
	void reviewIn(ReviewVO r);
}
