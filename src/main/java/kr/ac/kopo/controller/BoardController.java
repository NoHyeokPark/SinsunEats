package kr.ac.kopo.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import kr.ac.kopo.service.BoardService;
import kr.ac.kopo.vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	private BoardService bs;
	
	@GetMapping("/board")
	public ModelAndView boardList() {
		List<BoardVO> l = bs.listAllService();
		ModelAndView mav = new ModelAndView("Board/list");
		mav.addObject("boardList", l);
		
		return mav;
	}
	
	@GetMapping("/board/detail")
	public String boardDetail(@RequestParam("no") int boardNo, HttpServletRequest req) {
		BoardVO bb = bs.detailService(boardNo);
		req.setAttribute("bb", bb);
		return "/Board/detail";
				
	}
	
	
	@GetMapping("/board/{no}")
	public String boardDetail2(@PathVariable("no") int boardNo, Model model) {
		BoardVO bb = bs.detailService(boardNo);
		model.addAttribute("bb", bb);
		return "Board/detail";
	}
	
	
}
