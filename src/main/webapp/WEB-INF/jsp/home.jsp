<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<style>
.category-item a {
	text-decoration: none; /* 밑줄 제거 */
	color: inherit; /* 부모 요소의 글자색 상속 */
	display: block; /* 링크 영역을 아이템 전체로 확장 */
	padding: 16px; /* 내부 여백 (기존 .category-item의 패딩을 a태그로 이동) */
}

.price-original {
	text-decoration: line-through;
	color: #888;
	margin-right: 8px;
}

/* 캐러셀 이미지의 최대 높이 지정 및 비율 유지 */
.carousel-item img {
	max-height: 550px;
	object-fit: cover;
	filter: brightness(0.8); /* 이미지를 약간 어둡게 하여 텍스트 가독성 향상 */
}

/* 캐러셀 캡션(텍스트)에 대한 스타일 */
.carousel-caption {
	background-color: rgba(0, 0, 0, 0.4); /* 반투명 검은색 배경 */
	border-radius: 8px;
	padding: 1.5rem;
}

/* 모달 */
.modal-overlay {
	display: none; /* 평소에는 숨김 */
	position: fixed;
	z-index: 1050;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	/* Flexbox 설정 */
	display: flex;
	justify-content: center; /* 가로 중앙 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
	flex-wrap: wrap; /* 공간이 없으면 다음 줄로 넘김 */
	gap: 20px; /* 팝업 사이의 간격 */
	padding: 20px; /* 화면 가장자리와의 여백 */
	overflow-y: auto; /* 팝업이 많아지면 전체를 스크롤 */
}

/* 개별 팝업 (Flexbox의 자식 아이템) */
.popup-modal {
	/* position, margin 등 위치 관련 속성 제거 */
	background-color: #fff;
	padding: 30px;
	border: 1px solid #ccc;
	width: 90%; /* 모바일 화면을 위해 너비 유연하게 설정 */
	max-width: 400px;
	border-radius: 12px;
	position: relative; /* 닫기 버튼의 기준점 역할은 유지 */
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
	font-family: 'Arial', sans-serif;
	/* Flexbox 아이템으로서의 동작 */
	flex-shrink: 0; /* 팝업 크기가 줄어들지 않도록 설정 */
	display: none; /* JS가 개별적으로 제어하기 위해 기본은 숨김 */
}

/* 닫기 버튼 (기존과 동일) */
.close-btn {
	color: #aaa;
	position: absolute;
	top: 15px;
	right: 25px;
	font-size: 30px;
	font-weight: bold;
	cursor: pointer;
	transition: opacity 0.3s ease;
}

.close-btn:hover, .close-btn:focus {
	color: #333;
	opacity: 1;
}

.modal-content h3 {
	color: #333;
	margin-top: 0;
	margin-bottom: 20px;
	font-size: 1.8em;
	font-weight: bold;
	text-align: center; /* 제목 가운데 정렬 */
}

.modal-content p {
	color: #555;
	line-height: 1.6;
	margin-bottom: 25px;
}

/* [추가됨] 오늘 하루 보지 않기 영역 스타일 */
.popup-footer {
	margin-top: 20px;
	padding-top: 15px;
	border-top: 1px solid #eee;
	text-align: left;
}

.popup-footer label {
	display: flex;
	align-items: center;
	cursor: pointer;
	font-size: 14px;
	color: #444;
}

.popup-footer input[type="checkbox"] {
	margin-right: 8px;
	width: 16px;
	height: 16px;
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
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/include/quik.jsp"></jsp:include>
	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>
	<main>
		<%-- 기존 hero 섹션 대신 아래 캐러셀 코드로 교체 --%>
		<section id="eventCarousel" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#eventCarousel"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#eventCarousel"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#eventCarousel"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>

			<div class="carousel-inner">
				<div class="carousel-item active">
					<img
						src="https://images.unsplash.com/photo-1543083477-4f785aeafaa9?q=80&w=2070&auto=format&fit=crop"
						class="d-block w-100" alt="여름 과일 이벤트">
					<div class="carousel-caption d-none d-md-block">
						<h1>여름맞이! 시원한 과일 축제</h1>
						<p>갈증을 날려줄 수박, 멜론, 자두를 최대 40% 할인가에 만나보세요.</p>
						<a href="#" class="btn btn-lg btn-success">이벤트 보러가기</a>
					</div>
				</div>
				<div class="carousel-item">
					<img
						src="https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1974&auto=format&fit=crop"
						class="d-block w-100" alt="유기농 채소 이벤트">
					<div class="carousel-caption d-none d-md-block">
						<h1>자연을 담은 유기농 채소 기획전</h1>
						<p>화학 비료 없이 자란 건강한 채소로 우리 가족의 식탁을 책임지세요.</p>
						<a href="#" class="btn btn-lg btn-success">기획전 바로가기</a>
					</div>
				</div>
				<div class="carousel-item">
					<img
						src="https://elumedu.co.kr/event/join_member/dist/images/main_bg.jpg"
						class="d-block w-100" alt="신규회원 이벤트">
					<div class="carousel-caption d-none d-md-block">
						<h1>신규 회원을 위한 특별한 혜택!</h1>
						<p>지금 가입하고 인기 상품 100원 딜과 무료 배송 쿠폰을 받아가세요.</p>
						<a href="#" class="btn btn-lg btn-success">회원가입 하러가기</a>
					</div>
				</div>
			</div>

			<button class="carousel-control-prev" type="button"
				data-bs-target="#eventCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#eventCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</section>
		<!--  -->
		<c:if test="${not empty popup}">
			<%-- 
        varStatus="status"를 추가하여 루프의 인덱스를 사용할 수 있습니다.
        pop 객체에 고유 id가 있다면 ${pop.id}를 사용하는 것이 더 좋습니다.
    --%>
			<div id="popup-overlay" class="modal-overlay">
				<c:forEach items="${popup}" var="pop" varStatus="status">
					<div id="popupModal_${pop.id}" class="popup-modal"
						data-popup-id="${pop.id}">
						<div class="modal-content">
							<span class="close-btn" data-popup-id="${pop.id}">&times;</span>
							<img style="max-width:100%; height:auto;"
						src="${pageContext.request.contextPath}${pop.imgSrc}">
							<div class="popup-footer">
								<label> <input type="checkbox"
									class="hide-today-checkbox"> 오늘 하루 보지 않기
								</label>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>


			<script>
			
    document.addEventListener("DOMContentLoaded", function () {
        const overlay = document.getElementById("popup-overlay");
        // querySelectorAll은 NodeList를 반환하므로, 배열로 변환하여 filter 사용
        const popups = Array.from(overlay.querySelectorAll(".popup-modal"));
        let visiblePopupsCount = 0;
        overlay.style.display = "none";

        // 1. 각 팝업을 순회하며 보여줄지 결정
        popups.forEach(popup => {
            const popupId = popup.getAttribute("data-popup-id");
            const closeBtn = popup.querySelector(".close-btn");

            // 쿠키가 없으면 팝업을 보여줄 대상으로 설정
            if (!document.cookie.includes('hidePopup_'+popupId+'=true')) {
                popup.style.display = "block"; // 개별 팝업 보이기
                visiblePopupsCount++;
            }

            // 닫기 버튼에 이벤트 할당
            closeBtn.onclick = () => {
                popup.style.display = "none"; // 해당 팝업만 숨기기
                visiblePopupsCount--;

                // 보이는 팝업이 하나도 없으면 전체 오버레이를 숨김
                if (visiblePopupsCount === 0) {
                    overlay.style.display = "none";
                }
                const hideTodayCheckbox = popup.querySelector(".hide-today-checkbox");    
                if (hideTodayCheckbox.checked) {
                document.cookie = 'hidePopup_'+popupId+'=true; path=/; max-age=86400';
                }
            };
        });

        // 2. 보여줄 팝업이 하나라도 있으면 전체 오버레이를 띄움
        if (visiblePopupsCount > 0) {
            overlay.style.display = "flex";
        }

        // 3. 오버레이 배경 클릭 시 전체 닫기
        overlay.onclick = (e) => {
            // 클릭된 대상이 오버레이 자신일 때만 실행 (팝업 내부 클릭은 무시)
            if (e.target === overlay) {
                overlay.style.display = "none";
            }
        };
    });
    </script>
		</c:if>

		<section class="section container">

			<h2 class="section-title">이달의 특가 상품</h2>
			<div class="product-grid">
				<c:forEach items="${hotItem}" var="i">
					<div class="product-card">
						<a
							href="${pageContext.request.contextPath}/detail?code=${i.foodCode}">
							<img
							src="${i.imgSrc}"
							alt="파인애플">
						</a>
						<div class="product-card-content">
							<h3>${i.foodName}</h3>
							<div>
								 <span class="discount-percent">${i.discountPercent}%</span> <span
									class="price-original"> ${i.price}원</span> <span class="price">${i.discountPrice}원</span>
							</div>
							 <div class="product-review">
                                <!-- 별점이 동적으로 생성될 영역 -->
                                <div class="star-rating" data-rating="${i.averageRating}"></div>
                                <!-- 리뷰 요약 정보 -->
                                <span class="review-summary">
                                    ${i.averageRating} (리뷰 ${i.reviewCount}개)
                                </span>
                            </div>
							<button class="add-to-cart-btn"
								onclick="cartIn('${i.foodCode}', 1)">장바구니 담기</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>

		<section class="section container"
			style="background-color: #e9ecef; border-radius: 8px;">
			<h2 class="section-title">카테고리</h2>
			<div class="category-grid">
				<a href="${pageContext.request.contextPath}/goods?no=1&filter=14"><div
						class="category-item">🥬 나물/생채</div></a> <a
					href="${pageContext.request.contextPath}/goods?no=1&filter=19"><div
						class="category-item">🍦 유제품/빙과</div></a> <a
					href="${pageContext.request.contextPath}/goods?no=1&filter=1"><div
						class="category-item">🍚 밥류</div></a> <a
					href="${pageContext.request.contextPath}/goods?no=1&filter=10"><div
						class="category-item">🍲 조리식품</div></a> <a
					href="${pageContext.request.contextPath}/goods?no=1&filter=2"><div
						class="category-item">🍞 떡/빵/과자</div></a> <a
					href="${pageContext.request.contextPath}/goods?no=1&filter=20"><div
						class="category-item">🍵 음료/차</div></a>
			</div>
		</section>
	</main>
	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
