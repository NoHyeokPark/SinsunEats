<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 목록 - 식품몰</title>
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
<style>
.price-original {
	text-decoration: line-through;
	color: #888;
	margin-right: 8px;
}
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 25px;
    padding: 20px 0;
}
.product-card {
    background-color: #ffffff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
}
.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}
.product-card a {
    display: block;
    text-decoration: none;
    color: inherit;
}
.product-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-bottom: 1px solid #f0f0f0;
    transition: transform 0.3s ease;
}
.product-card:hover img {
    transform: scale(1.03);
}
.product-card-content {
    padding: 15px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

/* [수정] 상품명 하단 여백을 8px에서 4px로 줄임 */
.product-card-content h3 {
    font-size: 1.15em;
    font-weight: 700;
    color: #333;
    margin-top: 0;
    margin-bottom: 4px; /* 여백 축소 */
    line-height: 1.4;
    max-height: 2.8em;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

/* 가격 정보 전체를 감싸는 컨테이너 */
.price-info {
    display: flex;
    flex-direction: column;
    gap: 4px; /* 가격 라인 간의 간격 */
}

/* 할인율과 원가를 담는 라인 */
.price-line {
    display: flex;
    align-items: center; /* 수직 중앙 정렬 */
}

.discount-percent {
    font-size: 1.1em;
    font-weight: bold;
    color: #e63946; /* 빨간색으로 강조 */
    margin-right: 8px; /* 할인율과 원가 사이 여백 */
}

.price-original {
    text-decoration: line-through;
    color: #888;
    font-size: 0.9em;
}

.discount-price {
    font-size: 1.3em;
    font-weight: 800;
    color: #333; /* 최종 가격 색상 */
}

/* 리뷰 및 별점 섹션 */
.product-review {
	justify-content: center;
    display: flex;
    align-items: center;
    font-size: 0.9em;
    color: #555;
    gap: 6px; /* 별점과 텍스트 사이 간격 */
}

.star-rating {
    color: #ffc107; /* 채워진 별 색상 */
    font-size: 1.1em;
    letter-spacing: 1px;
}

.review-summary {
    font-weight: 500;
}

/* 장바구니 버튼 */
.add-to-cart-btn {
    background-color: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1em;
    font-weight: 600;
    width: 100%;
    transition: background-color 0.3s ease;
    margin-top: auto; /* 항상 하단에 위치하도록 설정 */
}

.add-to-cart-btn:hover {
    background-color: #0056b3;
}

.product-review {
    display: flex;
    align-items: center;
    margin-bottom: 15px; /* 장바구니 버튼과의 간격 */
    font-size: 0.9em;
    color: #555;
}

.star-rating {
    color: #ffc107; /* 채워진 별 색상 (노란색) */
    font-size: 1.1em; /* 별 크기 */
    letter-spacing: 1px; /* 별 사이 간격 */
    margin-right: 8px;
}

.review-summary {
    font-weight: 600;
}
.rating {
	color: #ffc107;
	margin-top: 8px;
}

.pagination {
	margin-top: 50px;
	text-align: center;
}

.pagination a {
	display: inline-block;
	padding: 10px 15px;
	margin: 0 5px;
	border-radius: 5px;
	background-color: #ffffff;
	color: #28a745;
	font-weight: bold;
	border: 1px solid #28a745;
	transition: background-color 0.3s, color 0.3s;
}

.pagination a:hover, .pagination a.active {
	background-color: #28a745;
	color: white;
}
</style>

</head>
<body>
<jsp:include page="/WEB-INF/jsp/include/quik.jsp"></jsp:include>
	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

	<main class="container">
		<section class="section">
			<h2 class="section-title">상품 목록</h2>
			<div class="product-grid">

				<c:forEach items="${goodsList}" var="i">
					<div class="product-card">
						<a
							href="${pageContext.request.contextPath}/detail?code=${i.foodCode}">
							<img src="${i.imgSrc}" alt="파인애플">
						</a>
						<div class="product-card-content">
							<h3>${i.foodName}</h3>
							<div>
								<c:if test="${i.discountPercent != 0}">
									<span style="color: red;">${i.discountPercent}%!!</span>
									<span class="price-original">${i.price}원</span>
								</c:if>
								<span class="price">${i.discountPrice}원</span>
							</div>
							<div class="product-review">
								<!-- 별점이 동적으로 생성될 영역 -->
								<div class="star-rating" data-rating="${i.averageRating}"></div>
								<!-- 리뷰 요약 정보 -->
								<span class="review-summary"> ${i.averageRating} (리뷰
									${i.reviewCount}개) </span>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>

			<!-- 페이지네이션 -->
			<div class="pagination">
				<!-- 이전 블록으로 -->
				<c:if test="${startPage > 1}">
					<a
						href="${pageContext.request.contextPath}/goods?no=${startPage - 1}&filter=${filter}&keyword=${keyword}">&laquo;</a>
				</c:if>

				<!-- 현재 블록의 페이지들 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<a
						href="${pageContext.request.contextPath}/goods?no=${i}&filter=${filter}&keyword=${keyword}"
						class="<c:if test='${i == currentPage}'>active</c:if>"> ${i} </a>
				</c:forEach>

				<!-- 다음 블록으로 -->
				<c:if test="${endPage < totalPage}">
					<a
						href="${pageContext.request.contextPath}/goods?no=${endPage + 1}&filter=${filter}&keyword=${keyword}">&raquo;</a>
				</c:if>
			</div>
		</section>
	</main>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
	<script>
	 document.addEventListener("DOMContentLoaded", function () {
	        // 모든 별점 컨테이너를 선택
	        const starRatingContainers = document.querySelectorAll('.star-rating');

	        starRatingContainers.forEach(container => {
	            // data-rating 속성에서 평점 값을 가져옴 (숫자형으로 변환)
	            const rating = parseFloat(container.dataset.rating);
	            if (isNaN(rating)) return; // 평점 값이 없으면 실행 중단

	            container.innerHTML = ''; // 기존 내용을 비움
	            let starsHtml = '';
	            
	            // 5개의 별을 순회
	            for (let i = 1; i <= 5; i++) {
	                if (i <= rating) {
	                    // 평점보다 작거나 같으면 꽉 찬 별(★) 추가
	                    starsHtml += '★';
	                } else if (i - 0.5 <= rating) {
	                    // 평점이 0.5 단위에 걸리면 반쪽 별(☆) - 여기서는 CSS로 처리하거나 간단히 빈 별로 표현
	                    // 여기서는 간단하게 빈 별로 처리합니다. 더 정교한 반쪽 별은 CSS clip-path가 필요합니다.
	                    starsHtml += '☆';
	                } else {
	                    // 평점보다 크면 빈 별(☆) 추가
	                    starsHtml += '☆';
	                }
	            }
	            container.innerHTML = starsHtml;
	        });
	        

	    });
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