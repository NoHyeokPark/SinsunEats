<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=631cbf35dbda1e2f52a91b9e1e16b773"></script>
  <style>
         .btn {
         
            background-color: #28a745;
            color: white;
            padding: 12px 25px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #218838;
        }
  </style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
</header>
<main>
<h2 align="center">찾아오시는 길</h2>
  <div id="map" style="width:100%;height:400px;"></div>
  <script>
    var mapContainer = document.getElementById('map'); 
    var mapOption = {
        center: new kakao.maps.LatLng(37.5105851258395, 127.116932495882), // 서울 좌표
        level: 3
    };
    var map = new kakao.maps.Map(mapContainer, mapOption);
    var markerPosition  = new kakao.maps.LatLng(37.5105851258395, 127.116932495882); 

    // 마커 생성
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 지도에 마커 표시
    marker.setMap(map);

    // 인포윈도우에 표시할 내용
    var iwContent = '<div style="padding:8px;">신선 마켓</div>';

    // 인포윈도우 생성
    var infowindow = new kakao.maps.InfoWindow({
        content: iwContent,
        removable: false // 닫기 버튼 생성
    });

    // 마커 위에 인포윈도우 표시
    //infowindow.open(map, marker);
  </script>
  <div align="center">
  <a href="https://map.kakao.com/link/to/신선마트,37.5105851258395,127.116932495882" class="btn" >길 찾기</a>
  <a href="https://map.kakao.com/link/roadview/37.5105851258395,127.116932495882" class="btn" >로드 뷰</a>
  </div>
    </main>
<footer> 
	<%@ include file="/WEB-INF/jsp/include/foot.jsp" %>
</footer>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 