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
						src="https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?q=80&w=2070&auto=format&fit=crop"
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
							<h3>${pop.title}</h3>
							<p>
								<c:out value="${pop.content}" />
							</p>

							<%-- [추가됨] 오늘 하루 보지 않기 체크박스 --%>
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
           // if (!document.cookie.includes(`hidePopup_${popupId}=true`)) {
                popup.style.display = "block"; // 개별 팝업 보이기
                visiblePopupsCount++;
           // }

            // 닫기 버튼에 이벤트 할당
            closeBtn.onclick = () => {
                popup.style.display = "none"; // 해당 팝업만 숨기기
                document.cookie = `hidePopup_${popupId}=true; path=/; max-age=86400`;
                visiblePopupsCount--;

                // 보이는 팝업이 하나도 없으면 전체 오버레이를 숨김
                if (visiblePopupsCount === 0) {
                    overlay.style.display = "none";
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

			<h2 class="section-title">이달의 추천 상품</h2>
			<div class="product-grid">
				<c:forEach items="${hotItem}" var="i">
					<div class="product-card">
						<a
							href="${pageContext.request.contextPath}/detail?code=${i.foodCode}">
							<img
							src="https://images.unsplash.com/photo-1550258987-190a2d41a8ba?q=80&w=1974&auto=format&fit=crop"
							alt="파인애플">
						</a>
						<div class="product-card-content">
							<h3>${i.foodName}</h3>
							<div>
								<span style="color: red;">${i.discountPercent}%!!</span> <span
									class="price-original"> ${i.price}원</span> <span class="price">${i.discountPrice}원</span>
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
