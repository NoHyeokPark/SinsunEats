<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

	<main class="container">
		<div class="section"
			style="display: flex; flex-wrap: wrap; gap: 40px;">
			<!-- 상품 이미지 -->
			<div style="flex: 1; min-width: 300px;">
				<img
					src="https://images.unsplash.com/photo-1550258987-190a2d41a8ba?q=80&w=1974&auto=format&fit=crop"
					alt="상품 이미지" style="width: 100%; border-radius: 8px;">
			</div>

			<!-- 상품 정보 -->
			<div style="flex: 2; min-width: 300px;">
				<h1 style="font-size: 1.8em; margin-bottom: 10px;">${detail.foodName}</h1>
				<c:if test="${detail.discountPercent != 0}">
					<p style="color: red;">${detail.discountPercent}%!!</p>
					<p class="price-original" style="text-decoration: line-through;">${detail.price}원</p>
				</c:if>
				<p
					style="font-size: 1.4em; font-weight: bold; color: #28a745; margin: 10px 0;">${detail.discountPrice}원</p>
				<p id="delivery-info">배송비 ${detail.shippingFee}원 | 내일(${deliveryDayOfWeek}) ${deliveryDate} 도착 예정</p>
				<p style="margin: 20px 0; color: #555;">${detail.detailDescription}</p>

				<button class="add-to-cart-btn" onclick="cartIn('${detail.foodCode}', 1)">장바구니 담기</button>
				<button class="add-to-cart-btn"
					style="background-color: #28a745; color: #fff; margin-left: 10px;" >바로구매</button>
			</div>
		</div>

		<!-- 상품 설명 -->
		<div class="section">
			<h2 class="section-title">상품 상세 설명</h2>
			<p style="line-height: 1.8;"></p>
		</div>

		<!-- 상품 고지 -->
		<div class="section">
			<h2 class="section-title">상품 고지 정보</h2>
			<p style="line-height: 1.8;">${detail.productNotice}</p>
		</div>

		<!-- 추천 상품 -->
		<div class="section">
			<h2 class="section-title">함께 보면 좋은 상품</h2>
			<div class="product-grid">
				<div class="product-card">
					<img src="https://via.placeholder.com/300x200" alt="추천 상품">
					<div class="product-card-content">
						<h3>미니 협탁</h3>
						<div class="price">29,900원</div>
						<button class="add-to-cart-btn">장바구니</button>
					</div>
				</div>
				<div class="product-card">
					<img src="https://via.placeholder.com/300x200" alt="추천 상품">
					<div class="product-card-content">
						<h3>우드 테이블</h3>
						<div class="price">39,900원</div>
						<button class="add-to-cart-btn">장바구니</button>
					</div>
				</div>
				<!-- 추가 추천 상품도 동일한 방식으로 -->
			</div>
		</div>
	</main>


	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
			<script>
function cartIn(productCode, quantity) {
	fetch('${pageContext.request.contextPath}/cart/add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            foodCode: productCode,
            quantity: quantity
        })
    })
    .then(response => response.json())
    .then(result => {
        if(result.success) {
            alert("장바구니에 담겼습니다!");
        } else {
            alert("실패: " + result.message);
        }
    });
}


</script>
</body>
</html>
