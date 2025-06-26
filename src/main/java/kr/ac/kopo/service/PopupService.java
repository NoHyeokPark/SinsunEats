package kr.ac.kopo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.board.dao.PopupDAO;
import kr.ac.kopo.vo.PopupVO;

@Service
public class PopupService {

	@Autowired
    private PopupDAO popdao;

    public List<PopupVO> getPopup() {
        return popdao.selectActivePopup();
    }
    
    public List<PopupVO> getPopAll() {
        return popdao.selectAllPopup();
    }
    
    public void addPop(PopupVO pop) {
    	popdao.insertPopup(pop);
    }
    
    public void updatePop(PopupVO pop) {
    	popdao.updatePopup(pop);
    }
    
    public void updateStat(PopupVO pop) {
    	popdao.updateStat(pop);
    }
    
    public void deletePop(int id) {
    	popdao.deletePop(id);
    }
}
