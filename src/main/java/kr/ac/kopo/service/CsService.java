package kr.ac.kopo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.board.dao.CsDAO;
import kr.ac.kopo.vo.CsBoardVO;
import kr.ac.kopo.vo.KakaoTokenHolderVO;

@Service
public class CsService {
	
	@Autowired
	private CsDAO csdao;
	
	
	private KakaoTokenHolderVO token;
	
	public void write(CsBoardVO cs) {
		csdao.insert(cs);	
		
	}
	
	public CsBoardVO one(int no){
		return csdao.selectOne(no);
	}
	
	public List<CsBoardVO> list(String id){
		return csdao.select(id);
	}
	
	public List<CsBoardVO> listAll(){
		return csdao.selectAll();
	}
	
	public void answer(CsBoardVO cs) {
		csdao.insertAnswer(cs);
	}

}
