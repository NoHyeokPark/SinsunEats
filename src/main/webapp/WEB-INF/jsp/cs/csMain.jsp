<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터</title>

<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">

    <style>
        /* --- 검색창 섹션 --- */
        .customer-center-header {
            text-align: center;
            padding: 80px 20px;
            background-color: #f8f9fa; /* layout.css의 body 배경색과 동일 */
        }
        .customer-center-header h1 {
            color: #343a40; /* layout.css의 .section-title 색상 */
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        .faq-search-bar {
            max-width: 600px;
            margin: 0 auto;
            position: relative;
        }
        .faq-search-bar input {
            width: 100%;
            padding: 18px 25px;
            font-size: 1.1em;
            border-radius: 50px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }
        .faq-search-bar input:focus {
            outline: none;
            border-color: #28a745; /* layout.css의 포인트 색상 */
            box-shadow: 0 2px 8px rgba(40, 167, 69, 0.3);
        }

        /* --- FAQ 카테고리 (layout.css의 .category-grid 활용) --- */
        .faq-categories .category-item {
            padding: 25px 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        /* 아이콘 예시 스타일 (실제 아이콘 라이브러리 사용 권장) */
        .faq-categories .icon {
            font-size: 2em;
            color: #28a745;
        }

        /* --- 아코디언 FAQ 리스트 --- */
        .accordion-container {
            max-width: 800px;
            margin: 0 auto;
        }
        .accordion-item {
            background-color: #ffffff;
            margin-bottom: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            border: 1px solid #eee;
        }
        .accordion-question {
            width: 100%;
            background: none;
            border: none;
            text-align: left;
            padding: 20px;
            font-size: 1.1em;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s;
        }
        .accordion-question:hover {
            background-color: #f8f9fa;
        }
        .accordion-question::after { /* 토글 아이콘 */
            content: '+';
            font-size: 1.5em;
            color: #28a745;
            transition: transform 0.3s;
        }
        .accordion-question.active::after {
            transform: rotate(45deg);
        }
        .accordion-answer {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out, padding 0.3s ease-out;
            padding: 0 20px;
            line-height: 1.6;
            color: #555;
        }
        .accordion-answer p {
            padding: 20px 0;
            margin: 0;
            border-top: 1px solid #eee;
        }

        /* --- 추가 지원 섹션 --- */
        .contact-actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            text-align: center;
        }
        .contact-card {
            background-color: #ffffff;
            padding: 40px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }
        .contact-card h3 {
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        .contact-card p {
            margin-bottom: 25px;
            color: #666;
        }
        .contact-card .btn {
            background-color: #28a745; /* layout.css의 .hero .btn 스타일 활용 */
            color: white;
            padding: 12px 25px;
            border-radius: 5px;
            font-weight: bold;
            display: inline-block;
            transition: background-color 0.3s;
        }
        .contact-card .btn:hover {
             background-color: #218838;
        }
        .contact-card .btn.secondary {
            background-color: #6c757d;
        }
        .contact-card .btn.secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>
    <main>
        <section class="customer-center-header">
            <h1>무엇을 도와드릴까요?</h1>
            <div class="faq-search-bar">
                <input type="text" placeholder="궁금한 점을 검색해보세요. (예: 배송 조회)">
            </div>
        </section>

        <div class="container">
            <section class="section faq-categories">
                <h2 class="section-title">자주 묻는 질문</h2>
                <div class="category-grid">
                    <a href="#" class="category-item">
                        <span class="icon">📄</span>
                        <span>주문/결제</span>
                    </a>
                    <a href="#" class="category-item">
                        <span class="icon">🚚</span>
                        <span>취소/반품/교환</span>
                    </a>
                    <a href="#" class="category-item">
                        <span class="icon">📦</span>
                        <span>배송</span>
                    </a>
                    <a href="#" class="category-item">
                        <span class="icon">👤</span>
                        <span>회원정보</span>
                    </a>
                    <a href="#" class="category-item">
                        <span class="icon">✨</span>
                        <span>포인트/쿠폰</span>
                    </a>
                    <a href="#" class="category-item">
                        <span class="icon">⚙️</span>
                        <span>서비스 이용</span>
                    </a>
                </div>
            </section>

            <section class="section">
                <h2 class="section-title">TOP 3 질문</h2>
                <div class="accordion-container">
                    <div class="accordion-item">
                        <button class="accordion-question">Q. 배송은 얼마나 걸리나요?</button>
                        <div class="accordion-answer">
                            <p>A. 보통 주문 후 1~3일 이내에 배송됩니다. 다만, 상품 종류나 지역, 재고 상황에 따라 배송일이 달라질 수 있습니다. '마이페이지 > 주문내역'에서 자세한 배송 상태를 확인하실 수 있습니다.</p>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <button class="accordion-question">Q. 주문을 취소하고 싶어요.</button>
                        <div class="accordion-answer">
                            <p>A. '입금대기' 또는 '결제완료' 상태에서는 즉시 주문 취소가 가능합니다. '배송준비중' 상태부터는 취소가 어려울 수 있으며, 상품 수령 후 반품으로 처리해주셔야 합니다.</p>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <button class="accordion-question">Q. 비밀번호를 잊어버렸어요.</button>
                        <div class="accordion-answer">
                            <p>A. 로그인 페이지 하단의 '비밀번호 찾기' 기능을 통해 가입 시 등록한 이메일 또는 휴대폰 번호로 임시 비밀번호를 발급받으실 수 있습니다.</p>
                        </div>
                    </div>
                    <%-- 다른 TOP 질문들을 여기에 추가 --%>
                </div>
            </section>

            <section class="section">
                <h2 class="section-title">문제가 해결되지 않으셨나요?</h2>
                <div class="contact-actions">
                    <div class="contact-card">
                        <h3>1:1 문의하기</h3>
                        <p>전문 상담원이 신속하고<br>정확하게 답변해 드립니다.</p>
                        
                        <a href="${pageContext.request.contextPath}/cs/list" class="btn">문의 등록하기</a>
                        
                    </div>
                    <div class="contact-card">
                        <h3>전화 상담 안내</h3>
                        <p>평일 09:00 ~ 18:00<br>(주말 및 공휴일 휴무)</p>
                        <a href="tel:1588-0000" class="btn secondary">1588-0000</a>
                    </div>
                </div>
            </section>
        </div>
    </main>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

    <script>
        // 아코디언 기능 구현 스크립트
        document.addEventListener('DOMContentLoaded', () => {
            const accordionQuestions = document.querySelectorAll('.accordion-question');

            accordionQuestions.forEach(question => {
                question.addEventListener('click', () => {
                    const answer = question.nextElementSibling;
                    const isActive = question.classList.contains('active');

                    // 모든 활성화된 항목 비활성화
                    // accordionQuestions.forEach(q => {
                    //     q.classList.remove('active');
                    //     q.nextElementSibling.style.maxHeight = null;
                    // });

                    // 현재 클릭한 항목 토글
                    if (!isActive) {
                        question.classList.add('active');
                        answer.style.maxHeight = answer.scrollHeight + 50 + 'px'; // 여유 공간 추가
                        answer.style.padding = '0 20px';
                    } else {
                        question.classList.remove('active');
                        answer.style.maxHeight = null;
                        answer.style.padding = '0 20px';
                    }
                });
            });
        });
    </script>
</body>
</html>