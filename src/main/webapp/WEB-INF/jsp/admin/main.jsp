<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>신선 잇츠 | 관리자 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel='stylesheet' href="${pageContext.request.contextPath}/reference/css/layout.css"> 
<style>
    :root {
        --admin-primary-color: #34568B; /* 관리자 페이지 포인트 컬러 */
        --admin-bg-light: #f8f9fa;
        --admin-text-dark: #212529;
        --admin-text-light: #6c757d;
    }

    body {
        background-color: var(--admin-bg-light);
    }

    /* 관리자 페이지 전용 헤더 */
    .admin-header {
        background-color: #ffffff;
        padding: 15px 5%;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .admin-header .logo {
        font-size: 1.8em;
        font-weight: bold;
        color: var(--admin-primary-color);
    }
    .admin-header .logo .sub-title {
        font-size: 0.6em;
        color: var(--admin-text-light);
    }
    
    /* 대시보드 핵심 지표 카드 */
    .dashboard-summary {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 30px;
    }
    .summary-card {
        background-color: #ffffff;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        display: flex;
        align-items: center;
        gap: 20px;
    }
    .summary-card .icon {
        font-size: 2.5em;
        color: var(--admin-primary-color);
    }
    .summary-card .info .count {
        font-size: 2em;
        font-weight: bold;
        color: var(--admin-text-dark);
    }
    .summary-card .info .title {
        font-size: 1em;
        color: var(--admin-text-light);
    }

    /* 관리 기능 바로가기 메뉴 */
    .feature-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
    }
    .feature-card {
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        transition: transform 0.3s, box-shadow 0.3s;
    }
    .feature-card a {
        display: block;
        padding: 30px;
        text-decoration: none;
        color: var(--admin-text-dark);
        text-align: center;
    }
    .feature-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        border: 1px solid var(--admin-primary-color);
    }
    .feature-card .icon {
        font-size: 3em;
        color: var(--admin-primary-color);
        margin-bottom: 15px;
    }
    .feature-card h3 {
        font-size: 1.5em;
        margin-bottom: 10px;
    }
    .feature-card p {
        color: var(--admin-text-light);
        font-size: 0.95em;
    }
</style>
</head>
<body>
    <header class="admin-header">
    <jsp:include page="/WEB-INF/jsp/include/adminTop.jsp"></jsp:include>
    </header>

    <main class="container" style="padding-top: 40px; padding-bottom: 40px;">
        <section class="section">
            <h2 class="section-title">TODAY's DASHBOARD</h2>
            <div class="dashboard-summary">
                <div class="summary-card">
                    <div class="icon">📦</div>
                    <div class="info">
                        <div class="count">15건</div>
                        <div class="title">오늘의 신규 주문</div>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="icon">💬</div>
                    <div class="info">
                        <div class="count">3건</div>
                        <div class="title">처리 대기 문의</div>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="icon">👤</div>
                    <div class="info">
                        <div class="count">28명</div>
                        <div class="title">오늘의 신규 가입</div>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="icon">📈</div>
                    <div class="info">
                        <div class="count">1,204명</div>
                        <div class="title">일일 방문자 수</div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <h2 class="section-title">관리 메뉴</h2>
            <div class="feature-grid">
                <div class="feature-card">
                    <a href="${pageContext.request.contextPath}/admin/goods">
                        <div class="icon">🥦</div>
                        <h3>상품 관리</h3>
                        <p>신규 상품 등록 및 기존 상품 정보를 수정, 삭제합니다.</p>
                    </a>
                </div>
                <div class="feature-card">
                    <a href="${pageContext.request.contextPath}/admin/order">
                        <div class="icon">🚚</div>
                        <h3>주문 및 배송 관리</h3>
                        <p>주문 내역을 확인하고 배송 상태를 변경, 관리합니다.</p>
                    </a>
                </div>
                <div class="feature-card">
                    <a href="${pageContext.request.contextPath}/admin/member">
                        <div class="icon">👥</div>
                        <h3>회원 관리</h3>
                        <p>가입된 회원 목록을 조회하고 등급 및 상태를 관리합니다.</p>
                    </a>
                </div>
                <div class="feature-card">
                    <a href="${pageContext.request.contextPath}/admin/cs">
                        <div class="icon">📋</div>
                        <h3>게시판 및 고객 문의</h3>
                        <p>공지사항, 이벤트 게시판과 1:1 고객 문의를 관리합니다.</p>
                    </a>
                </div>
                <div class="feature-card">
                    <a href="${pageContext.request.contextPath}/admin/summary">
                        <div class="icon">📊</div>
                        <h3>매출 및 통계</h3>
                        <p>기간별 매출, 상품별 판매 순위 등 통계 데이터를 확인합니다.</p>
                    </a>
                </div>
                <div class="feature-card">
                    <a href="${pageContext.request.contextPath}/admin/popup">
                        <div class="icon">⚙️</div>
                        <h3>기타 설정</h3>
                        <p>사이트 기본 정보, 배너, 팝업 등을 설정합니다.</p>
                    </a>
                </div>
            </div>
        </section>
    </main>
    
	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>