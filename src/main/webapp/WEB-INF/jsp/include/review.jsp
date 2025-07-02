<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="section review-write-section">
	<h3 class="section-title">후기 작성</h3>
	<form id="review-form"
		action="${pageContext.request.contextPath}/review/write" method="post">
		<input type="hidden" name="foodCode" value="${detail.foodCode}">
		<div class="form-group">
			<label for="review-grade">별점</label>
			<div class="star-input">
				<input type="radio" id="star5" name="grade" value="5" required>
				<label for="star5">★</label> <input type="radio" id="star4"
					name="grade" value="4"> <label for="star4">★</label> <input
					type="radio" id="star3" name="grade" value="3"> <label
					for="star3">★</label> <input type="radio" id="star2" name="grade"
					value="2"> <label for="star2">★</label> <input type="radio"
					id="star1" name="grade" value="1"> <label for="star1">★</label>
			</div>
		</div>
		<div class="form-group">
		<input type='hidden' name='writer' value="${user.id}">
			<label for="review-writer">작성자</label> <input type="text"
				id="review-writer" name="name" class="form-control"
				value="${user.name}" readonly>
		</div>
		<div class="form-group">
			<label for="review-title">제목</label> <input type="text"
				id="review-title" name="title" maxlength="100" required
				class="form-control">
		</div>
		<div class="form-group">
			<label for="review-content">내용</label>
			<textarea id="review-content" name="content" maxlength="1000"
				rows="4" required class="form-control"></textarea>
		</div>

		<button type="submit" class="btn btn-primary">후기 등록</button>
	</form>
</div>

<style>
/* ▼▼▼ 후기 작성 폼 스타일 ▼▼▼ */
.review-write-section {
	margin-top: 40px;
	padding: 20px;
	border-top: 1px solid #eee;
	background-color: #f9f9f9;
	border-radius: 8px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: 600;
	color: #333;
}

.form-control {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 1em;
}

#review-writer {
	background-color: #f9f9f9;
}

.star-input {
	display: flex;
	gap: 8px;
}

.star-input input[type="radio"] {
	display: none;
}

.star-input label {
	font-size: 24px;
	color: #ddd;
	cursor: pointer;
}

.star-input input[type="radio"]:checked ~ label, .star-input input[type="radio"]:hover 
	~ label, .star-input label:hover {
	color: #ffc107;
}

.star-input input[type="radio"]:checked ~ label {
	color: #ffc107;
}
</style>
