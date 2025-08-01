<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <a href="${pageContext.request.contextPath}/info" class="logo">신선 잇츠</a>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">홈</a></li>
                <li><a href="${pageContext.request.contextPath}/goods?no=1">상품보기</a></li>
                <li><a href="#">이벤트</a></li>
                <li><a href="${pageContext.request.contextPath}/cs">고객센터</a></li>
                <!-- <li><button onclick="send('${access_token}')">test</button></li> -->
                <c:if test="${not empty user && user.type == 'S' }">
                <li><a href="${pageContext.request.contextPath}/admin/main" > 관리자 메뉴 </a></li>
                </c:if> 
            </ul>
        </nav>
        <div class="header-utils">
            <div class="search-bar">
            <form id="searchForm" action="${pageContext.request.contextPath}/goods" method="get">
            	<input type="hidden" name="no" value="1">
                <input type="text" name="keyword" placeholder="상품 검색...">
                </form>
            </div>
            <div class="user-icons">
                <a href="${pageContext.request.contextPath}/cart/info">🛒</a> 
                <c:if test="${empty user }">
                <a href="${pageContext.request.contextPath}/login">👤</a>
                </c:if>
                <c:if test="${not empty user }">
                <a href="${pageContext.request.contextPath}/mypage">👤</a>
                ${user.name}님 (보유 마일리지 : ${user.mileage}P)
                <a href="${pageContext.request.contextPath}/logout"> 로그아웃 </a>
                </c:if> 

                </div>
                
        </div>
        <!--  
<script>

    function send(access_token) {
        const ctx = "http://172.31.57.147:8080/Food-Shop-Spring";  // JSP 변수 문자열로 처리

        const templateObj = {
            object_type: "text",
            text: "(신선잇츠) 문의글이 올라왔습니다!",
            link: {
                web_url: ctx + "/home",
                mobile_web_url: ctx + "/home"
            },
            button_title: "답변하러 가기"
        };
        const requestBody = 'template_object='+encodeURIComponent(JSON.stringify(templateObj));
        fetch("https://kapi.kakao.com/v2/api/talk/memo/default/send", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Authorization': 'Bearer ' + access_token
            },
            body: requestBody 
        })
        .then(response => {
            if (response.ok) {
                alert('메세지가 성공적으로 전송되었습니다.');
            } else {
                response.json().then(data => {
                    console.error('에러 응답:', data);
                    alert('메세지 전송 실패: ' + JSON.stringify(data));
                });
            }
        })
        .catch(error => {
            console.error('Fetch 에러:', error);
            alert('에러 발생: ' + error.message);
        });
    }
</script>
-->