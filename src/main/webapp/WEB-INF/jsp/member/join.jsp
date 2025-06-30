<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/reference/css/layout.css">
  <style>
    .signup-container {
      background-color: #ffffff;
      max-width: 500px;
      margin: 80px auto;
      padding: 40px 30px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      border-radius: 8px;
    }

    .signup-container h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #28a745;
    }

    .signup-container label {
      display: block;
      margin-bottom: 5px;
      font-weight: 500;
    }

    .signup-container input[type="text"],
    .signup-container input[type="password"],
    .signup-container input[type="email"],
    .signup-container select {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1em;
    }

    .signup-container .form-row {
      display: flex;
      gap: 10px;
    }

    .signup-container .form-row input {
      flex: 1;
    }

    .signup-container button {
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

    .signup-container button:hover {
      background-color: #218838;
    }

    .signup-container .links {
      text-align: center;
      margin-top: 15px;
      font-size: 0.9em;
    }

    .signup-container .links a {
      color: #007bff;
    }

    .signup-container .links a:hover {
      text-decoration: underline;
    }
  </style>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

  <div class="signup-container">
    <h2>회원가입</h2>
    <form action="${pageContext.request.contextPath}/signup" method="post">
      <label for="id">아이디</label>
      <input type="text" id="id" name="id" maxlength="20"
      <c:if test="${not empty user}">
      value = ${user.id }
      </c:if>
      
       required>

      <label for="name">이름</label>
      <input type="text" id="name" name="name" maxlength="20" required>

      <label for="password">비밀번호</label>
      <input type="password" id="password" name="password" maxlength="20" required>

      <label>이메일</label>
      <div class="form-row">
        <input type="text" name="emailId" placeholder="example" maxlength="30" required>
        <span>@</span>
        <input type="text" name="emailDomain" placeholder="domain.com" maxlength="20" required>
      </div>

      <label>전화번호</label>
      <div class="form-row">
        <input type="text" name="tel1" placeholder="010" maxlength="3" required>
        <input type="text" name="tel2" maxlength="4" required>
        <input type="text" name="tel3" maxlength="4" required>
      </div>

      <label for="post">우편번호 <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"> </label>
      <input type="text" id="post" name="post" maxlength="6">

      <label for="basic_addr">기본주소</label>
      <input type="text" id="basic_addr" name="basicAddr" maxlength="200">

      <label for="detail_addr">상세주소</label>
      <input type="text" id="detail_addr" name="detailAddr" maxlength="200">

<!-- 
      <label for="type">회원 유형</label>
      <select id="type" name="type">
        <option value="U" selected>일반회원</option>
        <option value="A">관리자</option>
      </select>
 -->
      <button type="submit">가입하기</button>
    </form>

    <div class="links">
      <p>이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/login">로그인</a></p>
    </div>
  </div>
  
  	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

  	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	                

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('post').value = data.zonecode;
	                document.getElementById("basic_addr").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detail_addr").focus();
	            }
	            
	        }).open();
	    }
  </script>
</body>
</html>