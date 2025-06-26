<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  [개발자 참고]
  - 이 JSP는 Spring Controller에서 'deliveryList'라는 이름으로 List<DeliveryDTO> 객체를 받았다고 가정합니다.
  - DeliveryDTO는 DeliveryItemDTO의 리스트를 멤버 변수로 포함하는 구조입니다.
  - 아래 <c:set> 부분은 Controller가 없어도 페이지를 바로 확인할 수 있도록 만든 샘플 데이터입니다.
    실제 프로젝트에서는 이 부분을 삭제하고 Controller에서 받은 데이터를 사용하세요.
--%>
<c:if test="${empty deliveryList}">
    <c:set var="deliveryList">
        <c:set var="order1">
            <c:set var="item1_1" value="${{'foodCode':'F001', 'foodName':'신선 유기농 계란(10입)', 'quantity':1, 'price':4500}}" />
            <c:set var="item1_2" value="${{'foodCode':'F002', 'foodName':'무농약 대저 토마토(1kg)', 'quantity':2, 'price':12000}}" />
            ${{'deliveryId': 10024, 'userId': 'user01', 'deliveryStatus': '배송완료', 'orderDate': '2025-06-22 14:30:00', 'recipientName': '홍길동', 'totalPrice': 28500, 'deliveryItems': [item1_1, item1_2]}}
        </c:set>
        <c:set var="order2">
            <c:set var="item2_1" value="${{'foodCode':'F003', 'foodName':'프리미엄 한돈 삼겹살(500g)', 'quantity':1, 'price':18000}}" />
            ${{'deliveryId': 10021, 'userId': 'user01', 'deliveryStatus': '배송중', 'orderDate': '2025-06-20 09:10:00', 'recipientName': '홍길동', 'totalPrice': 18000, 'deliveryItems': [item2_1]}}
        </c:set>
        <c:set var="order3">
            <c:set var="item3_1" value="${{'foodCode':'F004', 'foodName':'새벽에 수확한 상추(200g)', 'quantity':1, 'price':2500}}" />
            <c:set var="item3_2" value="${{'foodCode':'F005', 'foodName':'1A 등급 우유(900ml)', 'quantity':2, 'price':3200}}" />
            ${{'deliveryId': 10015, 'userId': 'user01', 'deliveryStatus': '출고준비', 'orderDate': '2025-06-18 21:00:00', 'recipientName': '홍길동', 'totalPrice': 8900, 'deliveryItems': [item3_1, item3_2]}}
        </c:set>
        ${[order1, order2, order3]}
    </c:set>
</c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문/배송 조회</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 25px;
            border-bottom: 2px solid #212529;
            padding-bottom: 10px;
        }
        
        .order-card {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            transition: box-shadow 0.2s ease-in-out;
        }
        
        .order-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .order-summary {
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }

        .order-info {
            display: flex;
            flex-direction: column;
        }

        .order-date {
            font-size: 14px;
            color: #868e96;
            margin-bottom: 5px;
        }

        .order-id {
            font-size: 16px;
            font-weight: 500;
            color: #495057;
        }
        
        .order-id strong {
            color: #007bff;
        }
        
        .order-status-price {
             text-align: right;
        }

        .delivery-status {
            font-weight: 700;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
        }

        .status-ready { background-color: #6c757d; color: white; }
        .status-shipping { background-color: #ff9800; color: white; }
        .status-delivered { background-color: #28a745; color: white; }
        
        .total-price {
            font-size: 18px;
            font-weight: 700;
            margin-top: 8px;
        }

        .order-details {
            display: none; /* 기본적으로 상세내역은 숨김 */
            padding: 0 20px 20px 20px;
            border-top: 1px solid #e9ecef;
        }

        .detail-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f1f3f5;
        }
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .item-info {
            flex-grow: 1;
        }
        
        .item-name {
            font-weight: 500;
        }
        
        .item-qty-price {
            font-size: 14px;
            color: #868e96;
        }

        .item-price {
            width: 120px;
            text-align: right;
            font-size: 16px;
            font-weight: 500;
        }
        
        .empty-history {
            text-align: center;
            padding: 60px;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
        }
        
        .empty-history h3 {
             font-size: 20px;
             margin-bottom: 10px;
        }
        .empty-history p {
            color: #6c757d;
        }

    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">주문 / 배송 내역</h2>

        <c:choose>
            <c:when test="${not empty deliveryList}">
                <c:forEach var="delivery" items="${deliveryList}">
                    <div class="order-card">
                        <div class="order-summary" onclick="toggleDetails(this)">
                            <div class="order-info">
                                <span class="order-date">
                                    <fmt:parseDate value="${delivery.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedOrderDate" />
                                    <fmt:formatDate value="${parsedOrderDate}" pattern="yyyy년 MM월 dd일 주문" />
                                </span>
                                <span class="order-id">주문번호: <strong>${delivery.deliveryId}</strong></span>
                            </div>
                            <div class="order-status-price">
                                <c:choose>
                                    <c:when test="${delivery.deliveryStatus == '배송완료'}">
                                        <span class="delivery-status status-delivered">배송완료</span>
                                    </c:when>
                                    <c:when test="${delivery.deliveryStatus == '배송중'}">
                                        <span class="delivery-status status-shipping">배송중</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="delivery-status status-ready">출고준비</span>
                                    </c:otherwise>
                                </c:choose>
                                <div class="total-price">
                                    <fmt:formatNumber value="${delivery.totalPrice}" pattern="#,###" />원
                                </div>
                            </div>
                        </div>

                        <div class="order-details">
                            <c:forEach var="item" items="${delivery.deliveryItems}">
                                <div class="detail-item">
                                    <%-- 실제로는 FOOD 테이블과 JOIN하여 상품 이미지 등을 가져올 수 있습니다. --%>
                                    <div class="item-info">
                                        <div class="item-name">${item.foodName}</div>
                                        <div class="item-qty-price">
                                            <fmt:formatNumber value="${item.price}" pattern="#,###" />원 / ${item.quantity}개
                                        </div>
                                    </div>
                                    <div class="item-price">
                                        <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###" />원
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-history">
                    <h3>주문 내역이 없습니다.</h3>
                    <p>주문하신 상품의 배송 현황을 이곳에서 확인하실 수 있습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function toggleDetails(element) {
            // 클릭된 order-summary의 부모(.order-card)를 찾은 후,
            // 그 안의 .order-details 요소를 찾습니다.
            const details = element.nextElementSibling;

            if (details.style.display === 'block') {
                details.style.display = 'none';
            } else {
                details.style.display = 'block';
            }
        }
    </script>
</body>
</html>
