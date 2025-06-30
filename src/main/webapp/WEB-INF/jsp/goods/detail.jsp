<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">

<style>
.review-section {
	margin-top: 40px;
	padding-top: 20px;
	border-top: 1px solid #eee;
}

.review-list-container {
	margin-top: 20px;
	display: flex;
	flex-direction: column;
	gap: 20px; /* 각 리뷰 사이의 간격 */
}

.review-item {
	border: 1px solid #e0e0e0;
	border-radius: 8px;
	padding: 20px;
	background-color: #f9f9f9;
}

.review-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.review-title {
	font-size: 1.2em;
	font-weight: bold;
	color: #333;
	margin: 0;
}

.review-meta {
	display: flex;
	align-items: center;
	gap: 15px; /* 작성자, 날짜 사이 간격 */
	font-size: 0.9em;
	color: #777;
}

.review-stars {
	color: #ffc107; /* 별점 색상 */
	font-size: 1.2em;
	letter-spacing: 2px;
}

.review-content {
	color: #444;
	line-height: 1.6;
	margin-top: 10px;
	padding-left: 5px;
}
/* 영양성분표 전체 스타일 */
.nutrition-facts-label {
	border: 2px solid #333;
	background-color: #fff;
	padding: 15px;
	width: 320px;
	font-family: 'Noto Sans KR', sans-serif;
	/* [수정] margin의 좌우 값을 auto로 변경하여 중앙 정렬합니다. */
	margin: 20px auto;
	color: #000;
}
/* 제목 스타일 */
.nutrition-facts-label .title {
	font-size: 28px;
	font-weight: 900;
	letter-spacing: 0.5px;
	margin: 0;
	text-align: center;
}
/* 구분선 스타일 */
.nutrition-facts-label .separator {
	border-bottom: 10px solid #333;
	margin: 5px 0;
}

.nutrition-facts-label .separator.thin {
	border-bottom-width: 1px;
}

.nutrition-facts-label .separator.medium {
	border-bottom-width: 5px;
}
/* 제공량 정보 */
.serving-info {
	display: flex;
	justify-content: space-between;
	font-size: 14px;
	margin-bottom: 5px;
}

.serving-info .calories {
	font-weight: bold;
}
/* 영양소 행 스타일 */
.nutrient-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 4px 0;
	font-size: 15px;
}
/* 영양소 이름 (들여쓰기 포함) */
.nutrient-row .nutrient-name {
	font-weight: bold;
}

.nutrient-row .nutrient-name.indented {
	padding-left: 20px;
	font-weight: normal;
}
/* 영양소 값과 %DV */
.nutrient-row .nutrient-value {
	display: flex;
	align-items: center;
	gap: 8px; /* 값과 %DV 사이 간격 */
}

.nutrient-row .percent-dv {
	font-weight: bold;
	min-width: 40px; /* %DV 너비 고정 */
	text-align: right;
}
/* %DV 막대 그래프 */
.dv-bar-container {
	width: 100px;
	height: 12px;
	background-color: #e0e0e0;
	border-radius: 6px;
	overflow: hidden;
}

.dv-bar-fill {
	height: 100%;
	background-color: #333;
	border-radius: 6px;
	transition: width 0.5s ease-in-out;
}
/* 하단 안내문 */
.dv-footer {
	font-size: 12px;
	text-align: justify;
	padding-top: 10px;
}
</style>
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
				<img src="${detail.imgSrc}" alt="상품 이미지"
					style="width: 100%; border-radius: 8px;">
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
				<p id="delivery-info">배송비 ${detail.shippingFee}원 |
					내일(${deliveryDayOfWeek}) ${deliveryDate} 도착 예정</p>
				<p style="margin: 20px 0; color: #555;">${detail.detailDescription}</p>

				<button class="add-to-cart-btn"
					onclick="cartIn('${detail.foodCode}', 1)">장바구니 담기</button>
				<button class="add-to-cart-btn"
					style="background-color: #28a745; color: #fff; margin-left: 10px;">바로구매</button>
			</div>
		</div>

		<!-- 상품 설명 -->
		<div class="section" align="center">
			<h2 class="section-title">상품 상세 설명</h2>
			<p style="line-height: 1.8;"></p>
			<img src="${detail.contentSrc}" alt="파인애플">
		</div>

		<!-- 상품 고지 -->
		<div class="section">
			<h2 class="section-title">상품 고지 정보</h2>

			<div class="nutrition-facts-label" id="nutrition-container">
				<h3 class="title">영양정보</h3>
				<div class="separator"></div>
				<div class="serving-info">
					<span>총 내용량 <span id="total-weight">[총 내용량]</span>
					</span> <span class="calories"><span id="total-calories">[총
							칼로리]</span></span>
				</div>
				<div class="serving-info">
					<span>1회 제공량 당 <span id="serving-weight">[1회 제공량]</span>
					</span>
				</div>
				<div class="separator medium"></div>
				<div
					style="text-align: right; font-weight: bold; font-size: 14px; margin-bottom: 4px;">1일
					영양성분 기준치에 대한 비율(%)</div>
				<div class="separator thin"></div>

				<!-- 나트륨 -->
				<div class="nutrient-row">
					<span class="nutrient-name">나트륨</span>
					<div class="nutrient-value">
						<span id="sodium-mg">[값]mg</span> <span id="sodium-dv"
							class="percent-dv">[값]%</span>
					</div>
				</div>
				<div class="separator thin"></div>

				<!-- 탄수화물 -->
				<div class="nutrient-row">
					<span class="nutrient-name">탄수화물</span>
					<div class="nutrient-value">
						<span id="carbs-g">[값]g</span> <span id="carbs-dv"
							class="percent-dv">[값]%</span>
					</div>
				</div>
				<!-- 당류 -->
				<div class="nutrient-row">
					<span class="nutrient-name indented">당류</span>
					<div class="nutrient-value">
						<span id="sugars-g">[값]g</span> <span id="sugars-dv"
							class="percent-dv">[값]%</span>
					</div>
				</div>
				<div class="separator thin"></div>

				<!-- 지방 -->
				<div class="nutrient-row">
					<span class="nutrient-name">지방</span>
					<div class="nutrient-value">
						<span id="fat-g">[값]g</span> <span id="fat-dv" class="percent-dv">[값]%</span>
					</div>
				</div>
				<!-- 트랜스지방 -->
				<div class="nutrient-row">
					<span class="nutrient-name indented">트랜스지방</span>
					<div class="nutrient-value">
						<span id="transfat-g">[값]g</span>
					</div>
				</div>
				<!-- 포화지방 -->
				<div class="nutrient-row">
					<span class="nutrient-name indented">포화지방</span>
					<div class="nutrient-value">
						<span id="satfat-g">[값]g</span> <span id="satfat-dv"
							class="percent-dv">[값]%</span>
					</div>
				</div>
				<div class="separator thin"></div>

				<!-- 콜레스테롤 -->
				<div class="nutrient-row">
					<span class="nutrient-name">콜레스테롤</span>
					<div class="nutrient-value">
						<span id="cholesterol-mg">[값]mg</span> <span id="cholesterol-dv"
							class="percent-dv">[값]%</span>
					</div>
				</div>
				<div class="separator thin"></div>

				<!-- 단백질 -->
				<div class="nutrient-row">
					<span class="nutrient-name">단백질</span>
					<div class="nutrient-value">
						<span id="protein-g">[값]g</span> <span id="protein-dv"
							class="percent-dv">[값]%</span>
					</div>
				</div>

				<!-- 여기부터는 막대 그래프 시각화 영역입니다. -->
				<div class="separator medium"></div>
				<div class="nutrient-row">
					<span>나트륨</span>
					<div class="dv-bar-container">
						<div id="sodium-bar" class="dv-bar-fill"></div>
					</div>
				</div>
				<div class="nutrient-row">
					<span>탄수화물</span>
					<div class="dv-bar-container">
						<div id="carbs-bar" class="dv-bar-fill"></div>
					</div>
				</div>
				<div class="nutrient-row">
					<span>당류</span>
					<div class="dv-bar-container">
						<div id="sugars-bar" class="dv-bar-fill"></div>
					</div>
				</div>
				<div class="nutrient-row">
					<span>지방</span>
					<div class="dv-bar-container">
						<div id="fat-bar" class="dv-bar-fill"></div>
					</div>
				</div>
				<div class="nutrient-row">
					<span>포화지방</span>
					<div class="dv-bar-container">
						<div id="satfat-bar" class="dv-bar-fill"></div>
					</div>
				</div>
				<div class="nutrient-row">
					<span>콜레스테롤</span>
					<div class="dv-bar-container">
						<div id="cholesterol-bar" class="dv-bar-fill"></div>
					</div>
				</div>
				<div class="nutrient-row">
					<span>단백질</span>
					<div class="dv-bar-container">
						<div id="protein-bar" class="dv-bar-fill"></div>
					</div>
				</div>

				<div class="separator medium"></div>
				<p class="dv-footer">1일 영양성분 기준치에 대한 비율(%)은 2,000kcal 기준이므로 개인의
					필요 열량에 따라 다를 수 있습니다.</p>
			</div>


			<p style="line-height: 1.8;" align="center">${detail.productNotice}</p>
		</div>

		<div class="section review-section">
			<h2 class="section-title">상품 후기</h2>
			<div class="review-list-container" id="review-list">
				<c:if test="${empty reviews}">
					<p style="text-align: center; color: #888;">등록된 리뷰가 없습니다.</p>
				</c:if>

				<c:forEach items="${reviews}" var="r">
					<div class="review-item" data-review-id="${r.reviewId}">
						<div class="review-header">
							<h4 class="review-title">${r.title}</h4>
							<%-- 
                        [중요] r.grade 값을 data-grade 속성에 저장합니다. 
                        JavaScript가 이 값을 읽어 별점으로 변환합니다.
                    --%>
							<div class="review-stars" data-grade="${r.grade}"></div>
						</div>
						<div class="review-meta">
							<span>작성자: ${r.writer}</span> <span> 작성일: ${r.regDate}
							</span>
						</div>
						<p class="review-content">${r.content}</p>
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- 추천 상품 -->
		<div class="section">
			<h2 class="section-title">함께 보면 좋은 상품</h2>
			<div class="product-grid">
				<div class="product-card">
					<img
						src="https://images.unsplash.com/photo-1550258987-190a2d41a8ba?q=80&w=1974&auto=format&fit=crop"
						alt="추천 상품">
					<div class="product-card-content">
						<h3>델몬트 파인애플</h3>
						<div class="price">9,900원</div>
						<button class="add-to-cart-btn">장바구니</button>
					</div>
				</div>
				<div class="product-card">
					<img
						src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTyqMR-Us9BWmx1xMXZ5girEiSvzfW_5VP7g&s"
						alt="추천 상품">
					<div class="product-card-content">
						<h3>망고가 얼망고</h3>
						<div class="price">3,900원</div>
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

// 페이지가 로드되면 영양성분표를 렌더링하는 함수를 실행합니다.
document.addEventListener('DOMContentLoaded', function() {

    // 1. 샘플 데이터 (DB에서 가져온 데이터로 이 객체를 교체하세요)
    // SQL 테이블의 컬럼명을 키(key)로 사용했습니다.
    const foodData = {
            FOOD_NAME: '${detail.foodName}',
            WEIGHT: '${nutrition.weight}',
            TOTAL_WEIGHT: '${nutrition.weight}',
            ENERGY_KCAL: parseFloat('${nutrition.energyKcal}' || 0),
            NNSODIUM_MG: parseFloat('${nutrition.nnsodiumMg}' || 0),
            CARBOHYDRATE_G: parseFloat('${nutrition.carbohydrateG}' || 0),
            NNSUGARS_G: parseFloat('${nutrition.nnsugarsG}' || 0),
            FAT_G: parseFloat('${nutrition.fatG}' || 0),
            NNTRANSFATTYACIDS_G: '${nutrition.nntransfattyacidsG}' || '0',
            NNSATURATEDFATTYACIDS_G: parseFloat('${nutrition.nnsaturatedfattyacidsG}' || 0),
            NNCHOLESTEROL_MG: parseFloat('${nutrition.nncholesterolMg}' || 0),
            PROTEIN_G: parseFloat('${nutrition.proteinG}' || 0),
        };

        // 2. 1일 영양성분 기준치
        const dailyValues = {
            NNSODIUM_MG: 2000,
            CARBOHYDRATE_G: 324,
            NNSUGARS_G: 100,
            FAT_G: 54,
            NNSATURATEDFATTYACIDS_G: 15,
            NNCHOLESTEROL_MG: 300,
            PROTEIN_G: 55,
        };

        // 3. 데이터를 기반으로 영양성분표를 채우는 함수 (백틱 제거 버전)
        function renderNutritionFacts(data) {
            function calculateDV(value, dailyValue) {
                if (!value || !dailyValue) return 0;
                return Math.round((value / dailyValue) * 100);
            }
            
            document.getElementById('total-weight').textContent = (data.TOTAL_WEIGHT || '[정보없음]');
            document.getElementById('serving-weight').textContent = (data.WEIGHT || '[정보없음]');
            document.getElementById('total-calories').textContent = (data.ENERGY_KCAL || '[정보없음]') + ' kcal';

            const sodiumDV = calculateDV(data.NNSODIUM_MG, dailyValues.NNSODIUM_MG);
            document.getElementById('sodium-mg').textContent = (data.NNSODIUM_MG || 0) + 'mg';
            document.getElementById('sodium-dv').textContent = sodiumDV + '%';
            document.getElementById('sodium-bar').style.width = sodiumDV + '%';

            const carbsDV = calculateDV(data.CARBOHYDRATE_G, dailyValues.CARBOHYDRATE_G);
            document.getElementById('carbs-g').textContent = (data.CARBOHYDRATE_G || 0) + 'g';
            document.getElementById('carbs-dv').textContent = carbsDV + '%';
            document.getElementById('carbs-bar').style.width = carbsDV + '%';
            
            const sugarsDV = calculateDV(data.NNSUGARS_G, dailyValues.NNSUGARS_G);
            document.getElementById('sugars-g').textContent = (data.NNSUGARS_G || 0) + 'g';
            document.getElementById('sugars-dv').textContent = sugarsDV + '%';
            document.getElementById('sugars-bar').style.width = sugarsDV + '%';

            const fatDV = calculateDV(data.FAT_G, dailyValues.FAT_G);
            document.getElementById('fat-g').textContent = (data.FAT_G || 0) + 'g';
            document.getElementById('fat-dv').textContent = fatDV + '%';
            document.getElementById('fat-bar').style.width = fatDV + '%';

            document.getElementById('transfat-g').textContent = (data.NNTRANSFATTYACIDS_G || 0) + 'g';
            
            const satfatDV = calculateDV(data.NNSATURATEDFATTYACIDS_G, dailyValues.NNSATURATEDFATTYACIDS_G);
            document.getElementById('satfat-g').textContent = (data.NNSATURATEDFATTYACIDS_G || 0) + 'g';
            document.getElementById('satfat-dv').textContent = satfatDV + '%';
            document.getElementById('satfat-bar').style.width = satfatDV + '%';

            const cholesterolDV = calculateDV(data.NNCHOLESTEROL_MG, dailyValues.NNCHOLESTEROL_MG);
            document.getElementById('cholesterol-mg').textContent = (data.NNCHOLESTEROL_MG || 0) + 'mg';
            document.getElementById('cholesterol-dv').textContent = cholesterolDV + '%';
            document.getElementById('cholesterol-bar').style.width = cholesterolDV + '%';
            
            const proteinDV = calculateDV(data.PROTEIN_G, dailyValues.PROTEIN_G);
            document.getElementById('protein-g').textContent = (data.PROTEIN_G || 0) + 'g';
            document.getElementById('protein-dv').textContent = proteinDV + '%';
            document.getElementById('protein-bar').style.width = proteinDV + '%';
        }
        
        function renderReviewStars() {
            // 모든 리뷰의 별점 컨테이너를 선택합니다.
            const starContainers = document.querySelectorAll('.review-stars');

            starContainers.forEach(container => {
                // data-grade 속성에서 평점 값을 가져옵니다 (정수형으로 변환).
                const grade = parseInt(container.dataset.grade, 10);
                
                // 유효한 숫자가 아니면 함수를 종료합니다.
                if (isNaN(grade) || grade < 0 || grade > 5) {
                    container.textContent = '평점 정보 없음';
                    return;
                }

                let starsHtml = '';
                // 5번 반복하여 별을 생성합니다.
                for (let i = 1; i <= 5; i++) {
                    if (i <= grade) {
                        starsHtml += '★'; // 채워진 별
                    } else {
                        starsHtml += '☆'; // 비어있는 별
                    }
                }
                // 생성된 별 HTML을 컨테이너에 삽입합니다.
                container.innerHTML = starsHtml;
            });
        }

        // 함수를 실행하여 별점을 렌더링합니다.
        renderReviewStars();

        // 함수 실행
        renderNutritionFacts(foodData);
    });

</script>
</body>
</html>
