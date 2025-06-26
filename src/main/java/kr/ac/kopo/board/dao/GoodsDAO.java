package kr.ac.kopo.board.dao;

import java.util.List;

import kr.ac.kopo.vo.GoodsDetailVO;
import kr.ac.kopo.vo.GoodsVO;

public interface GoodsDAO {
	List<GoodsVO> selectGoodsTop8();
	List<GoodsVO> goodsAll(int no, String filter, String keyword);
	GoodsDetailVO selectDetail(String id);
	List<GoodsVO> selectAllDiv();
}
