<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>1:1 문의하기</title>

<%-- 공통 CSS 파일 링크 --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/reference/css/layout.css">

<%-- 문의 작성 폼 페이지 전용 스타일 --%>
<style>
.inquiry-form-container {
	max-width: 800px;
	margin: 60px auto;
	padding: 40px;
	background-color: #ffffff;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

/* 폼 내 각 항목 그룹 */
.form-group {
	margin-bottom: 25px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	font-size: 1.05em;
	color: #343a40;
}

.form-group input[type="text"], .form-group select, .form-group textarea
	{
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 1em;
	transition: border-color 0.3s;
}

.form-group input[type="text"]:focus, .form-group select:focus,
	.form-group textarea:focus {
	outline: none;
	border-color: #28a745; /* layout.css의 포인트 색상 */
}

.form-group textarea {
	min-height: 200px;
	resize: vertical;
}

/* 파일 첨부 커스텀 스타일 */
.file-group .file-upload-name {
	display: inline-block;
	height: 45px;
	padding: 0 12px;
	vertical-align: middle;
	border: 1px solid #ccc;
	width: calc(100% - 120px);
	color: #555;
	line-height: 45px;
	border-radius: 4px;
	background-color: #f8f9fa;
}

.file-group label.file-upload-button {
	display: inline-block;
	padding: 12px 20px;
	color: #fff;
	background-color: #6c757d;
	vertical-align: middle;
	border-radius: 4px;
	cursor: pointer;
	margin-left: 8px;
	transition: background-color 0.3s;
}

.file-group label.file-upload-button:hover {
	background-color: #5a6268;
}

.file-group input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

/* 비밀글 체크박스 */
.checkbox-group {
	display: flex;
	align-items: center;
	gap: 8px;
}

.checkbox-group input[type="checkbox"] {
	width: 18px;
	height: 18px;
}

/* 폼 버튼 그룹 */
.form-actions {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 40px;
}

.form-actions .btn {
	padding: 12px 30px;
	font-size: 1.1em;
	font-weight: bold;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	transition: all 0.3s;
}

.form-actions .btn-submit {
	background-color: #28a745;
	color: white;
}

.form-actions .btn-submit:hover {
	background-color: #218838;
}

.form-actions .btn-cancel {
	background-color: #f1f1f1;
	color: #333;
	border: 1px solid #ddd;
}

.form-actions .btn-cancel:hover {
	background-color: #e2e2e2;
}

/* 안내사항 박스 */
.guidelines {
	background-color: #f8f9fa;
	border: 1px solid #e9ecef;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 40px;
	font-size: 0.9em;
	color: #495057;
}

.guidelines ul {
	padding-left: 20px;
	margin: 0;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>


	<main class="container">
		<div class="inquiry-form-container">
			<h2 class="section-title">1:1 문의하기</h2>

			<div class="guidelines">
				<strong>문의 전 확인해주세요!</strong>
				<ul>
					<li>문의 답변은 평일 기준 24시간 이내에 드리는 것을 원칙으로 합니다.</li>
					<li>주문 관련 문의 시, 주문번호를 함께 기재해주시면 더 빠른 처리가 가능합니다.</li>
					<li>욕설, 비방, 광고성 문의는 무통보 삭제될 수 있습니다.</li>
				</ul>
			</div>

			<form action="${pageContext.request.contextPath}/cs/write"
				method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="category">문의 유형</label> <select id="category"
						name="category" onchange="showInfo()">
						<option value="ORDER">주문/결제</option>
						<option value="DELIVERY">배송</option>
						<option value="RETURN">취소/반품/교환</option>
						<option value="MEMBER">회원정보</option>
						<option value="ETC">기타</option>
					</select>
				</div>

				<div id="ORDER_info" class="category-info">
					<c:if test="${not empty order}">
						<div id="order_list_div">
							<select id="orderReference" name="orderReference">
								<option value="">문의할 주문을 선택하세요</option>
								<%-- "order" 리스트를 순회하며 option 태그를 생성합니다. --%>
								<c:forEach var="o" items="${order}">
									<%-- option의 value에는 주문번호(PK)를, 텍스트에는 상품명 등을 표시 --%>
									<option value="${o.deliveryId}">받는 분 :
										${o.recipientName}(주문일: ${o.orderDate}) 금액 : ${o.totalPrice}</option>
								</c:forEach>
							</select>
						</div>
					</c:if>
				</div>

				<div id="DELIVERY_info" class="category-info">
					<p>배송 관련 문의 시, 주문번호와 함께 문의 내용을 남겨주시면 더 빠른 처리가 가능합니다.</p>
				</div>

				<div id="RETURN_info" class="category-info">
					<p>취소/반품/교환은 '마이페이지 > 주문내역'에서 신청하실 수 있습니다.</p>
				</div>

				<div id="MEMBER_info" class="category-info">
					<p>회원정보 관련 문의 내용을 자세히 적어주세요.</p>
				</div>

				<div id="ETC_info" class="category-info">
					<p>기타 문의 내용을 자세히 적어주세요.</p>
				</div>
<br>
				<%-- 여기에 다른 공통 입력 필드들 (제목, 내용 등) --%>

				<c:if test="${empty user }">

					<div class="form-group">
						<label for="content">작성자</label> <input type="text" id="writer"
							name="writer" required>
					</div>

				</c:if>

				<c:if test="${not empty user }">
					<input type='hidden' name='writer' value="${user.id}">
				</c:if>



				<div class="form-group">
					<c:choose>
						<c:when test="${not empty user}">
							<label>전화 번호</label>
							<input type="text" name="tel" id="tel"
								value="${user.tel1}-${user.tel2}-${user.tel3}" required>
						</c:when>
						<c:otherwise>
							<input type="text" name="tel" id="tel" placeholder="전화번호를 입력해주세요"
								required>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="form-group">
					<label for="title">제목</label> <input type="text" id="title"
						name="title" placeholder="제목을 입력해주세요." required>
				</div>

				<div class="form-group">
					<label for="content">문의 내용</label>
					<textarea id="content" name="content"
						placeholder="문의하실 내용을 자세하게 입력해주세요." required></textarea>
				</div>


				<div class="form-group file-group">
					<label>파일 첨부</label>
					<div>
						<input type="text" class="file-upload-name" value="첨부파일" readonly>
						<label for="file" class="file-upload-button">파일찾기</label> <input
							type="file" id="file" name="file">
					</div>
				</div>


				<div class="form-actions">
					<button type="button" class="btn btn-cancel"
						onclick="history.back();">취소</button>
					<button type="submit" class="btn btn-submit">등록하기</button>
				</div>
			</form>
		</div>
	</main>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

	<script>
        // 파일 첨부 시, 선택된 파일명을 화면에 표시하는 스크립트
        document.addEventListener('DOMContentLoaded', () => {
            const fileInput = document.getElementById('file');
            const fileNameDisplay = document.querySelector('.file-upload-name');

            fileInput.addEventListener('change', () => {
                const fileName = fileInput.value.split('\\').pop();
                fileNameDisplay.value = fileName ? fileName : '첨부파일';
            });
            showInfo();
        });
        function showInfo() {
            // 1. 모든 정보 영역을 일단 숨깁니다.
            const allInfoDivs = document.querySelectorAll('.category-info');
            allInfoDivs.forEach(div => {
                div.style.display = 'none';
            });

            // 2. select 요소에서 현재 선택된 값(value)을 가져옵니다.
            const selectedCategory = document.getElementById('category').value;

            // 3. 선택된 값에 해당하는 id를 가진 정보 영역을 찾습니다.
            const infoToShow = document.getElementById(selectedCategory + '_info');

            // 4. 해당 정보 영역이 존재하면 화면에 보여줍니다 (display = 'block').
            if (infoToShow) {
                infoToShow.style.display = 'block';
            }
        }
    </script>
</body>
</html>