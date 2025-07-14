package kr.ac.kopo.controller;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class StockSseController {
	
	private final Map<String, SseEmitter> emitters = new ConcurrentHashMap<>();
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	@GetMapping(value = "/sse/stock", produces = "text/event-stream;charset=UTF-8")
    public SseEmitter connect() {
		System.out.println("진입");
        SseEmitter emitter = new SseEmitter(30 * 60 * 1000L); // 타임아웃 무제한
        String id = UUID.randomUUID().toString();
        emitters.put(id, emitter);
        try {
        emitter.send(SseEmitter.event().name("connect").data("connected!"));
        } catch (IOException e) {
        	e.printStackTrace();
        }

        emitter.onCompletion(() -> emitters.remove(id));
        emitter.onTimeout(() -> emitters.remove(id));

        return emitter;
    }
	
	public void notifyStockLow(String foodName, int stock, String code) {
		 	Map<String, Object> alertData = Map.of(
	                "food", foodName,
	                "stock", stock,
	                "message", "재고 부족!",
	                "code", code
	        );
	        for (SseEmitter emitter : emitters.values()) {
	            try {
	                emitter.send(SseEmitter.event()
	                        .name("stock-alert")
	                        .data(alertData));
	            } catch (IOException e) {
	                emitter.complete();
	            }
	        }
	    }
}
