package kr.ac.kopo.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.vo.GoodsDetailVO;
import kr.ac.kopo.vo.GoodsVO;
import kr.ac.kopo.vo.ReviewVO;
import kr.ac.kopo.vo.nutritionVO;

@Repository
public class GoodsDAOimpl implements GoodsDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	@Override
	public List<GoodsVO> selectGoodsTop8() {
		return sql.selectList("goods.top8");
	}
	
	@Override
	public List<GoodsVO> goodsAll(int no, String filter, String keyword) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("offset", (no-1)*10);
		paramMap.put("filter", filter);
		paramMap.put("keyword", keyword);
		return sql.selectList("goods.all", paramMap);
	}
	
	@Override
	public GoodsDetailVO selectDetail(String id) {
		
		return sql.selectOne("goods.detail", id);
	}
	
	@Override
	public List<GoodsVO> selectAllDiv() {

		return sql.selectList("goods.div");
	}
	
	@Override
	public nutritionVO selectNutrition(String code) {
		// TODO Auto-generated method stub
		return sql.selectOne("goods.nut", code);
	}
	
	@Override
	public List<ReviewVO> selectReview(String code) {

		return sql.selectList("review.list", code);
	}
	
}
