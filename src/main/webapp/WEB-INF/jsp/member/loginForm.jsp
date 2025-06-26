<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/reference/css/layout.css">
<style>
.login-container {
	background-color: #ffffff;
	max-width: 400px;
	margin: 100px auto;
	padding: 40px 30px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

.login-container h2 {
	text-align: center;
	margin-bottom: 30px;
	color: #28a745;
}

.login-container label {
	display: block;
	margin-bottom: 5px;
	font-weight: 500;
}

.login-container input[type="text"], .login-container input[type="password"]
	{
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 1em;
}

.login-container button {
	width: 100%;
	padding: 12px;
	background-color: #28a745;
	color: white;
	font-size: 1em;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
	transition: background-color 0.3s;
}

.login-container button:hover {
	background-color: #218838;
}

.login-container .links {
	text-align: center;
	margin-top: 15px;
	font-size: 0.9em;
}

.login-container .links a {
	color: #007bff;
}

.login-container .links a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

	<div class="login-container">
		<h2>로그인</h2>
		<form action="${pageContext.request.contextPath}/login" method="post">
			<label for="id">아이디</label> <input type="text" id="id" name="id"
				required maxlength="20"> <label for="password">비밀번호</label>
			<input type="password" id="password" name="password" required
				maxlength="20">

			<button type="submit">로그인</button>
		</form>
		<div>
		<a href="${pageContext.request.contextPath}/kakao" ><img src="${pageContext.request.contextPath}/reference/img/kakao_login_medium_wide.png" width="100%" height="45px" /></a>
		</div>
		<div class="links">
			<p>
				<a href="${pageContext.request.contextPath}/signup">회원가입</a> | <a
					href="/forgot-password">비밀번호 찾기</a>
			</p>
		</div>

	</div>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
</body>
</html>