package kr.ac.kopo.service;

import java.io.IOException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.ac.kopo.vo.KakaoTokenHolderVO;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service
public class KakaoService {

	public String getAccessToken(String code, String clientId, String redirectUri) throws JsonProcessingException {
		// 1. HTTP Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 2. HTTP Body 생성
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("grant_type", "authorization_code");
		body.add("client_id", clientId);
		body.add("redirect_uri", redirectUri);
		body.add("code", code);

		// 3. HTTP 요청 보내기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(body, headers);
		RestTemplate rt = new RestTemplate();
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				kakaoTokenRequest, String.class);

		// 4. JSON 응답에서 액세스 토큰 파싱
		String responseBody = response.getBody();
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonNode = objectMapper.readTree(responseBody);
		return jsonNode.get("access_token").asText();
	}

	public JsonNode getUserInfo(String accessToken) throws JsonProcessingException {
		// 1. HTTP Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 2. HTTP 요청 보내기
		HttpEntity<MultiValueMap<String, String>> kakaoUserInfoRequest = new HttpEntity<>(headers);
		RestTemplate rt = new RestTemplate();
		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				kakaoUserInfoRequest, String.class);

		// 3. JSON 응답 파싱
		String responseBody = response.getBody();
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readTree(responseBody);
	}

	public JsonNode logout(String accessToken) throws JsonProcessingException {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();

		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(body, headers);
		RestTemplate rt = new RestTemplate();
		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v1/user/logout", HttpMethod.POST,
				kakaoTokenRequest, String.class);

		String responseBody = response.getBody();
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readTree(responseBody);

	}

	public void sendAlam(String access_token, String category, String title) {
		final String KAKAO_API_URL = "https://kapi.kakao.com/v2/api/talk/memo/default/send";
		final String CTX = "http://172.31.57.147:8080/Food-Shop-Spring";

		OkHttpClient client = new OkHttpClient();

		// template_object 생성 (JSON 형식의 문자열)
		String templateObj = String.format(
				"{\"object_type\":\"text\",\"text\":\"(신선잇츠) 문의글이 올라왔습니다! (%s), %s\","
				+ "\"link\":{\"web_url\":\"%s/admin/cs\",\"mobile_web_url\":\"%s/admin/cs\"},"
				+ "\"button_title\":\"답변하러 가기\"}",
				category, title, CTX, CTX);

		// 요청 본문(body) 생성
		RequestBody requestBody = new FormBody.Builder().add("template_object", templateObj).build();

		// 요청(Request) 객체 생성
		Request request = new Request.Builder().url(KAKAO_API_URL).post(requestBody)
				.addHeader("Content-Type", "application/x-www-form-urlencoded")
				.addHeader("Authorization", "Bearer " + access_token).build();

		// 요청 실행 및 응답 처리
		try (Response response = client.newCall(request).execute()) {
			if (response.isSuccessful()) {
				System.out.println("메시지가 성공적으로 전송되었습니다.");
				System.out.println("Response: " + response.body().string());
			} else {
				System.err.println("메시지 전송 실패");
				System.err.println("Response Code: " + response.code());
				System.err.println("Response Body: " + response.body().string());
			}
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("에러 발생: " + e.getMessage());
		}
	}

}
