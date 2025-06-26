<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <a href="${pageContext.request.contextPath}/info" class="logo"><img alt="" src="/reference/img/logo.png"/>신선 잇츠</a>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">홈</a></li>
                <li><a href="${pageContext.request.contextPath}/goods?no=1">상품보기</a></li>
                <li><a href="#">이벤트</a></li>
                <li><a href="${pageContext.request.contextPath}/cs">고객센터</a></li>
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
                ${user.name}님 
                <a href="${pageContext.request.contextPath}/logout"> 로그아웃 </a>
                </c:if> </div>
                
        </div>
