<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신선 잇츠 | 회사 소개</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel='stylesheet' href="${pageContext.request.contextPath}/reference/css/layout.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=631cbf35dbda1e2f52a91b9e1e16b773"></script>
<style>
	/* --- 페이지 전용 스타일 --- */

	/* 기존 버튼 스타일 유지 */
	.btn {
		background-color: #28a745;
		color: white !important; /* a 태그의 기본 색상을 덮어쓰기 위해 !important 사용 */
		padding: 12px 25px;
		border-radius: 5px;
		font-weight: bold;
		transition: background-color 0.3s;
		text-decoration: none; /* a 태그의 밑줄 제거 */
		display: inline-block;
	}
	.btn:hover {
		background-color: #218838;
		color: white !important;
	}
	
	/* 회사 소개 헤더 섹션 */
	.about-header {
		padding: 80px 20px;
		text-align: center;
		background-color: #f8f9fa;
		margin-bottom: 40px;
	}
	.about-header h1 {
		font-size: 2.8em;
		font-weight: bold;
		color: #343a40;
	}
	.about-header p {
		font-size: 1.2em;
		color: #6c757d;
		max-width: 800px;
		margin: 20px auto 0;
	}
	
	/* 핵심 가치 카드 섹션 */
	.values-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		gap: 30px;
		margin-top: 40px;
	}
	.value-card {
		background-color: #fff;
		padding: 30px;
		border: 1px solid #e9ecef;
		border-radius: 8px;
		text-align: center;
		box-shadow: 0 4px 8px rgba(0,0,0,0.05);
		transition: transform 0.3s, box-shadow 0.3s;
	}
	.value-card:hover {
		transform: translateY(-5px);
		box-shadow: 0 8px 16px rgba(0,0,0,0.1);
	}
	.value-card .icon {
		font-size: 3em;
		color: #28a745;
		margin-bottom: 15px;
	}
	.value-card h3 {
		font-size: 1.5em;
		margin-bottom: 10px;
	}
	
	/* 게임 섹션 */
	.game-section {
		background-color: #e9ecef;
		padding: 50px 20px;
		text-align: center;
		border-radius: 8px;
		margin-top: 40px;
	}
	.game-section h3 {
		margin-bottom: 20px;
	}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
</header>
<main>

	<section class="about-header">
		<h1>가장 신선한 순간을 당신의 식탁으로</h1>
		<p>
			'신선 잇츠(Sinsun Eats)'는 자연의 순수함과 건강함을 믿습니다.<br>
			매일 새벽, 전국 각지의 정직한 농부들이 정성껏 키운 최상의 농산물을 선별하여<br>
			가장 신선한 상태 그대로 당신의 집 앞까지 배송하는 푸드 라이프스타일 브랜드입니다.
		</p>
	</section>

	<section class="section container">
		<h2 class="section-title">신선 잇츠의 약속</h2>
		<div class="values-grid">
			<div class="value-card">
				<div class="icon">🍃</div>
				<h3>최고의 신선함</h3>
				<p>산지에서 식탁까지, 유통 과정을 최소화한 '초신선 배송 시스템'으로 자연의 맛과 영양을 그대로 전해드립니다.</p>
			</div>
			<div class="value-card">
				<div class="icon">🤝</div>
				<h3>생산자와의 상생</h3>
				<p>정당한 가격으로 농산물을 매입하여 농가의 안정적인 소득을 보장하고, 소비자와 생산자가 함께 웃는 세상을 만듭니다.</p>
			</div>
			<div class="value-card">
				<div class="icon">🥗</div>
				<h3>건강한 식문화</h3>
				<p>누구나 쉽고 맛있게 건강한 삶을 누릴 수 있도록, 믿을 수 있는 먹거리와 다양한 레시피를 제안합니다.</p>
			</div>
		</div>
	</section>
	
	<section class="section container">
		<h2 class="section-title">오시는 길 (오프라인 매장)</h2>
		<div id="map" style="width:100%;height:400px;"></div>
		<script>
			var mapContainer = document.getElementById('map');
			var mapOption = {
				center: new kakao.maps.LatLng(37.5105851258395, 127.116932495882), // '신선 잇츠' 매장 좌표
				level: 3
			};
			var map = new kakao.maps.Map(mapContainer, mapOption);
			var markerPosition = new kakao.maps.LatLng(37.5105851258395, 127.116932495882);

			var marker = new kakao.maps.Marker({
				position: markerPosition
			});
			marker.setMap(map);

			var iwContent = '<div style="padding:8px; text-align:center;">신선 잇츠 본사<br></div>';
			var infowindow = new kakao.maps.InfoWindow({
				content: iwContent,
				removable: true
			});
			
			// 마커 위에 인포윈도우 표시
			infowindow.open(map, marker);
		</script>
		<div align="center" style="margin-top: 20px;">
			<a href="https://map.kakao.com/link/to/신선잇츠,37.5105851258395,127.116932495882" class="btn" target="_blank">빠른 길찾기</a>
			<a href="https://map.kakao.com/link/roadview/37.5105851258395,127.116932495882" class="btn" target="_blank">로드뷰 보기</a>
		</div>
	</section>
	
	<section class="section container">
		<div class="game-section">
			<h3>잠깐의 휴식!</h3>
			<p>신선 잇츠가 준비한 작은 선물과 함께 즐거운 시간을 보내세요.</p>
			<a href="https://nohyeokpark.github.io/dinosurvive/" class="btn" target="_blank">공룡 게임 시작!</a>
		</div>
	</section>

</main>
<footer>
	<%@ include file="/WEB-INF/jsp/include/foot.jsp" %>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>