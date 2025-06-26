<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - 식품몰</title>
<link rel='stylesheet' href="${pageContext.request.contextPath}/reference/css/layout.css">
    <style>
.price-original {
	text-decoration: line-through;
	color: #888;
	margin-right: 8px;
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

    <header>
<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
    </header>

    <main class="container">
        <section class="section">
            <h2 class="section-title">상품 목록</h2>
            <div class="product-grid">

                <c:forEach items="${goodsList}" var="i">
	   				<div class="product-card">
	   				<a href="${pageContext.request.contextPath}/detail?code=${i.foodCode}">
                    <img src="https://images.unsplash.com/photo-1550258987-190a2d41a8ba?q=80&w=1974&auto=format&fit=crop" alt="파인애플">
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
                        <button class="add-to-cart-btn" onclick="cartIn('${i.foodCode}', 1)">장바구니 담기</button>
                    </div>
                	</div>
				</c:forEach>

            </div>

            <!-- 페이지네이션 -->
      <div class="pagination">
    <!-- 이전 블록으로 -->
    <c:if test="${startPage > 1}">
        <a href="${pageContext.request.contextPath}/goods?no=${startPage - 1}&filter=${filter}">&laquo;</a>
    </c:if>

    <!-- 현재 블록의 페이지들 -->
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <a href="${pageContext.request.contextPath}/goods?no=${i}&filter=${filter}" 
           class="<c:if test='${i == currentPage}'>active</c:if>">
            ${i}
        </a>
    </c:forEach>

    <!-- 다음 블록으로 -->
    <c:if test="${endPage < totalPage}">
        <a href="${pageContext.request.contextPath}/goods?no=${endPage + 1}&filter=${filter}">&raquo;</a>
    </c:if>
</div>
        </section>
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