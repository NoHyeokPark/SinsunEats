<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문/결제</title>
    
    <%-- 공통 CSS 파일 링크 --%>
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
    
    <%-- 주문 페이지 전용 스타일 --%>
    <style>
        .order-page-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 40px;
            align-items: flex-start;
        }

        /* 왼쪽: 입력 폼 섹션 */
        .order-form-section .section-box {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .section-box h3 {
            font-size: 1.5em;
            margin-top: 0;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        .form-group input[type="text"] {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .address-group { display: flex; gap: 10px; align-items: center; }
        .address-group input[name="post"] { flex: 1; }
        .address-group button { 
            flex-shrink: 0; 
            padding: 12px 15px;
            background-color: #6c757d;
            color: #fff;
            border:none;
            border-radius: 4px;
            cursor: pointer;
        }

        /* 오른쪽: 주문 요약 섹션 */
        .order-summary-section {
            position: sticky;
            top: 100px; /* header 높이에 따라 조정 */
            background: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }
        .order-summary-section h3 {
            font-size: 1.5em;
            text-align: center;
            margin-top: 0;
            margin-bottom: 25px;
        }

        /* 주문 상품 리스트 */
        .order-item-list { list-style: none; padding: 0; margin: 0 0 20px 0; }
        .order-item-list li {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .order-item-list li:last-child { border-bottom: none; }
        .order-item-list img { width: 60px; height: 60px; border-radius: 4px; object-fit: cover; }
        .item-info { flex-grow: 1; }
        .item-info .item-name { font-weight: 500; }
        .item-info .item-quantity { font-size: 0.9em; color: #666; }
        .item-price { font-weight: bold; font-size: 1.1em; }
        
        /* 결제 금액 정보 */
        .price-details {
            border-top: 2px solid #ddd;
            padding-top: 20px;
            margin-bottom: 20px;
        }
        .price-details dl { display: flex; justify-content: space-between; margin: 10px 0; font-size: 1.1em;}
        .price-details dl.total { font-weight: bold; font-size: 1.3em; color: #28a745; }
        
        /* 약관 동의 */
        .terms-agreement {
            background-color: #fff;
            padding: 15px;
            border-radius: 4px;
            font-size: 0.9em;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        /* 결제 버튼 */
        .btn-checkout {
            width: 100%;
            padding: 15px;
            font-size: 1.2em;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-checkout:hover { background-color: #218838; }

        /* 반응형 */
        @media (max-width: 992px) {
            .order-page-container {
                grid-template-columns: 1fr;
            }
            .order-summary-section {
                position: static; /* 고정 해제 */
            }
        }
    </style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

    <main class="container">
        <h2 class="section-title" style="margin-top: 40px;">주문/결제</h2>
        <form id="orderForm" action="${pageContext.request.contextPath}/cart/process" method="post">
            <div class="order-page-container">

                <section class="order-form-section">
                    <div class="section-box">
                        <h3>배송지 정보</h3>
                        <%-- 로그인한 사용자의 정보를 컨트롤러에서 memberInfo로 전달했다고 가정 --%>
                        <input type="hidden" name="userId" value="${user.id}" />
                        <div class="form-group" style="display:flex; align-items:center; gap: 8px;">
                            <input type="checkbox" id="sameAsMember" onchange="fillMemberInfo()">
                            <label for="sameAsMember" style="margin-bottom:0;">회원 정보와 동일</label>
                        </div>
                        <div class="form-group">
                            <label for="recipientName">수령인</label>
                            <input type="text" id="recipientName" name="recipientName" required>
                        </div>
                        <div class="form-group">
                            <label for="recipientPhone">연락처</label>
                            <input type="text" id="recipientPhone" name="recipientPhone" placeholder="'-' 없이 숫자만 입력" required>
                        </div>
                        <div class="form-group">
                            <label>주소</label>
                            <div class="address-group">
                                <input type="text" id="postCode" name="postCode" placeholder="우편번호" readonly>
                                <button type="button" onclick="execDaumPostcode()">주소검색</button>
                            </div>
                            <input type="text" name="address" id="address" style="margin-top:10px;" placeholder="기본주소" readonly>
                            <input type="text" name="addressDetail" id="addressDetail" style="margin-top:10px;" placeholder="상세주소 입력">
                        </div>
                    </div>

                    <div class="section-box">
                        <h3>결제 수단</h3>
                        <div class="form-group">
                            <label for="paymentMethod">결제 수단을 선택해주세요</label>
                            <select id="paymentMethod" name="paymentMethod" class="form-group" style="width:100%; box-sizing:border-box; padding:12px; border:1px solid #ccc; border-radius:4px; font-size:1em;">
                                <option value="CARD">신용카드</option>
                                <option value="BANK">무통장입금</option>
                                <option value="KAKAOPAY">카카오페이</option>
                            </select>
                        </div>
                    </div>
                </section>

                <section class="order-summary-section">
                    <h3>주문 요약</h3>
                    
                    <ul class="order-item-list">
                        <%-- 컨트롤러에서 장바구니 상품 목록을 cartItems로 전달했다고 가정 --%>
                        <c:set var="totalPrice" value="0" />
                        <c:forEach var="item" items="${cartItems}">
                        <li>
                            <%-- 실제로는 상품 이미지 경로를 데이터베이스에서 가져와야 함 --%>
                            <img src="https://images.unsplash.com/photo-1550258987-190a2d41a8ba?q=80&w=1974&auto=format&fit=crop" alt="${item.foodName}">
                            <div class="item-info">
                                <div class="item-name">${item.foodName}</div>
                                <input type="hidden" name="cartId" value="${item.cartId}" />
                                <div class="item-quantity">수량: ${item.quantity}개</div>
                            </div>
                            <div class="item-price">
                                <fmt:formatNumber value="${item.discountPrice * item.quantity}" pattern="#,##0" />원
                            </div>
                        </li>
                        <c:set var="totalPrice" value="${totalPrice + (item.discountPrice * item.quantity)}" />
                        </c:forEach>
                    </ul>
                    
                    <c:set var="shippingFee" value="${totalPrice >= 30000 ? 0 : 3000}" />
                    <c:set var="finalPrice" value="${totalPrice + shippingFee}" />
                    
                    <div class="price-details">
                        <dl>
                            <dt>총 상품금액</dt>
                            <dd><fmt:formatNumber value="${totalPrice}" pattern="#,##0" />원</dd>
                        </dl>
                        <dl>
                            <dt>배송비</dt>
                            <dd><fmt:formatNumber value="${shippingFee}" pattern="#,##0" />원</dd>
                        </dl>
                        <dl>
                            <dt>마일리지</dt>
                            <dd><fmt:formatNumber value="-${usedMileage}" pattern="#,##0" />P</dd>
                            <input type="hidden" name="usedMileage" value="${usedMileage}" />
                        </dl>
                         <dl class="total">
                            <dt>총 결제금액</dt>
                            <dd><fmt:formatNumber value="${finalPrice-usedMileage}" pattern="#,##0" />원</dd>
                            <input type="hidden" name="totalPrice" value="${finalPrice-usedMileage}" />
                        </dl>
                    </div>

                    <div class="terms-agreement">
                        <input type="checkbox" id="terms" name="terms" required>
                        <label for="terms">주문 상품 정보 및 서비스 약관에 동의합니다.</label>
                    </div>

                    <button type="submit" class="btn-checkout">
                        <fmt:formatNumber value="${finalPrice-usedMileage}" pattern="#,##0" />원 결제하기
                    </button>
                </section>
            </div>
        </form>
    </main>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        // Daum 주소 API 실행 함수
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = '';
                    if (data.userSelectedType === 'R') {
                        addr = data.roadAddress;
                    } else {
                        addr = data.jibunAddress;
                    }
                    document.getElementById('postCode').value = data.zonecode;
                    document.getElementById("address").value = addr;
                    document.getElementById("addressDetail").focus();
                }
            }).open();
        }

        // '회원 정보와 동일' 체크박스 기능
        function fillMemberInfo() {
            const isChecked = document.getElementById('sameAsMember').checked;
 
            const member = {
                name: "${user.name}",
                phone: "${user.tel1}" + "${user.tel2}" + "${user.tel3}",
                post: "${user.post}",
                address: "${user.basicAddr}",
                addressDetail: "${user.detailAddr}"
            }
            if (isChecked) {
                document.getElementById('recipientName').value = member.name;
                document.getElementById('recipientPhone').value = member.phone;
                document.getElementById('postCode').value = member.post;
                document.getElementById('address').value = member.address;
                document.getElementById('addressDetail').value = member.addressDetail;
            } else {
                // 체크 해제 시 필드 초기화
                document.getElementById('recipientName').value = '';
                document.getElementById('recipientPhone').value = '';
                document.getElementById('post').value = '';
                document.getElementById('address').value = '';
                document.getElementById('addressDetail').value = '';
            }
            
        }
    </script>
</body>
</html>