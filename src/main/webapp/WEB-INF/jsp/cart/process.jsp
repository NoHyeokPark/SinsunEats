<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료</title>
    
    <%-- 공통 CSS 파일 링크 --%>
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
    
    <%-- 주문 완료 페이지 전용 스타일 --%>
    <style>
        .order-complete-container {
            max-width: 700px;
            margin: 80px auto;
            padding: 50px;
            background-color: #ffffff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-radius: 8px;
            text-align: center;
        }

        /* 성공 아이콘 스타일 */
        .success-icon {
            display: inline-block;
            width: 80px;
            height: 80px;
            line-height: 80px;
            border-radius: 50%;
            background-color: #28a745;
            color: white;
            font-size: 3em;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .order-complete-container h2 {
            font-size: 2em;
            margin-bottom: 15px;
            color: #333;
        }

        .order-complete-container p {
            font-size: 1.1em;
            color: #666;
            margin-bottom: 40px;
        }

        /* 구매 내역 요약 */
        .order-details {
            text-align: left;
            padding: 25px;
            background-color: #f8f9fa;
            border-radius: 8px;
            border: 1px solid #e9ecef;
            margin-bottom: 40px;
        }
        .order-details h3 {
            margin-top: 0;
            margin-bottom: 20px;
            text-align: center;
            font-size: 1.3em;
        }
        .order-details dl {
            display: flex;
            margin: 10px 0;
            font-size: 1em;
        }
        .order-details dt {
            width: 120px;
            color: #555;
            font-weight: 500;
            flex-shrink: 0;
        }
        .order-details dd {
            margin-left: 0;
            color: #333;
            font-weight: bold;
        }

        /* 버튼 그룹 */
        .actions {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .actions .btn {
            padding: 12px 30px;
            font-size: 1.1em;
            font-weight: bold;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }
        .actions .btn-primary {
            background-color: #28a745;
            color: white;
        }
        .actions .btn-primary:hover {
            background-color: #218838;
        }
        .actions .btn-secondary {
            background-color: #fff;
            color: #333;
            border: 1px solid #ccc;
        }
        .actions .btn-secondary:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>
    
    <%-- 컨트롤러에서 최종 확정된 주문 정보를 orderInfo 객체로 전달했다고 가정 --%>
    <main class="container">
        <div class="order-complete-container">
            <div class="success-icon">✔</div>
            <h2>주문이 성공적으로 완료되었습니다.</h2>
            <p>신선 잇츠를 이용해주셔서 감사합니다.</p>

            <div class="order-details">
                <h3>구매 내역</h3>
                <dl>
                    <dt>주문번호:</dt>
                    <dd>${orderInfo.deliveryId}</dd>
                </dl>
                <dl>
                    <dt>받는 분:</dt>
                    <dd>${orderInfo.recipientName}</dd>
                </dl>
                <dl>
                    <dt>배송지:</dt>
                    <dd>${orderInfo.address} ${orderInfo.addressDetail}</dd>
                </dl>
                <dl>
                    <dt>결제금액:</dt>
                    <dd><fmt:formatNumber value="${orderInfo.totalPrice}" pattern="#,##0"/>원</dd>
                </dl>
                <dl>
                    <dt>결제수단:</dt>
                    <dd>${orderInfo.paymentMethod}</dd>
                </dl>
            </div>
            
            <div class="actions">
                <button class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/cart/history'">주문내역 상세 보기</button>
                <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/home'">홈으로 돌아가기</button>
            </div>
        </div>
    </main>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
</body>
</html>