<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JSTL 사용을 위해 태그 라이브러리 선언 (데이터 표현에 필요) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>내 정보 수정</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/reference/css/layout.css">
  <style>
    /* 기본 컨테이너 스타일 (회원가입 폼과 통일성 유지) */
    .mypage-container {
      background-color: #ffffff;
      max-width: 500px;
      margin: 80px auto;
      padding: 40px 30px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      border-radius: 8px;
    }

    .mypage-container h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #28a745; /* 포인트 컬러 유지 */
    }

    .mypage-container label {
      display: block;
      margin-bottom: 5px;
      font-weight: 500;
    }

    .mypage-container input[type="text"],
    .mypage-container input[type="password"],
    .mypage-container input[type="email"],
    .mypage-container select {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1em;
      box-sizing: border-box; /* 패딩과 테두리를 너비에 포함 */
    }

    /* 아이디와 같이 수정 불가능한 필드에 대한 스타일 */
    .mypage-container input[readonly] {
      background-color: #e9ecef;
      cursor: not-allowed;
    }

    .mypage-container .form-row {
      display: flex;
      gap: 10px;
      align-items: center; /* 수직 정렬을 위해 추가 */
    }

    .mypage-container .form-row input {
      flex: 1;
    }

    /* 수정하기 버튼 스타일 */
    .mypage-container button {
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

    .mypage-container button:hover {
      background-color: #218838;
    }

    /* 하단 링크 (회원 탈퇴 등) */
    .mypage-container .links {
      text-align: center;
      margin-top: 15px;
      font-size: 0.9em;
    }

    .mypage-container .links a {
      color: #dc3545; /* 위험 경고성 색상 */
    }

    .mypage-container .links a:hover {
      text-decoration: underline;
    }

    .mypage-container {
      background-color: #ffffff;
      max-width: 500px;
      margin: 80px auto;
      padding: 40px 30px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      border-radius: 8px;
    }

    .mypage-container h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #28a745;
    }

    .mypage-container label {
      display: block;
      margin-bottom: 5px;
      font-weight: 500;
    }

    .mypage-container input[type="text"],
    .mypage-container input[type="password"],
    .mypage-container input[type="email"],
    .mypage-container select {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1em;
      box-sizing: border-box;
    }

    .mypage-container input[readonly] {
      background-color: #e9ecef;
      cursor: not-allowed;
    }

    .mypage-container .form-row {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .mypage-container .form-row input {
      flex: 1;
    }

    .mypage-container button {
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

    .mypage-container button:hover {
      background-color: #218838;
    }

    .mypage-container .links {
      text-align: center;
      margin-top: 15px;
      font-size: 0.9em;
    }

    .mypage-container .links a {
      color: #dc3545;
    }

    .mypage-container .links a:hover {
      text-decoration: underline;
    }
  </style>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

  <%-- 컨트롤러에서 "loginMember" 라는 이름으로 회원 정보를 보냈다고 가정합니다. --%>
  <div class="mypage-container">
    <h2>내 정보 수정</h2>
    <form action="${pageContext.request.contextPath}/member/update" method="post">
      <label for="id">아이디</label>
      <input type="text" id="id" name="id" value="${user.id}" readonly>

      <label for="name">이름</label>
      <input type="text" id="name" name="name" value="${user.name}" maxlength="20" required>

      <label for="password">현재 비밀번호</label>
      <input type="password" id="password" name="password" placeholder="비밀번호 변경 시에만 입력하세요" maxlength="20">
      <label for="password">새 비밀번호</label>
      <input type="password" id="newPassword" name="newPassword" placeholder="비밀번호 변경 시에만 입력하세요" maxlength="20">
      <label for="password">비밀번호 확인</label>
      <input type="password" id="checkPassword" name="checkPassword" placeholder="비밀번호 변경 시에만 입력하세요" maxlength="20">

      <label>이메일</label>
      <div class="form-row">
        <input type="text" name="emailId" value="${user.emailId}" maxlength="30" required>
        <span>@</span>
        <input type="text" name="emailDomain" value="${user.emailDomain}" maxlength="20" required>
      </div>

      <label>전화번호</label>
      <div class="form-row">
        <input type="text" name="tel1" value="${user.tel1}" maxlength="3" required>
        <input type="text" name="tel2" value="${user.tel2}" maxlength="4" required>
        <input type="text" name="tel3" value="${user.tel3}" maxlength="4" required>
      </div>

      <label for="post">우편번호 <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"> </label>
      <input type="text" id="post" name="post" value="${user.post}" maxlength="6">

      <label for="basic_addr">기본주소</label>
      <input type="text" id="basic_addr" name="basicAddr" value="${user.basicAddr}" maxlength="200">

      <label for="detail_addr">상세주소</label>
      <input type="text" id="detail_addr" name="detailAddr" value="${user.detailAddr}" maxlength="200">

      <button type="submit">정보 수정</button>
    </form>

    <div class="links">
      <a href="${pageContext.request.contextPath}/member/delete" onclick="return confirm('정말로 회원을 탈퇴하시겠습니까?');">회원 탈퇴</a>
    </div>
  </div>
  
  	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

  <%-- 주소찾기 API 스크립트 (기존과 동일) --%>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; 

                if (data.userSelectedType === 'R') { // 도로명 주소
                    addr = data.roadAddress;
                } else { // 지번 주소
                    addr = data.jibunAddress;
                }
                
                document.getElementById('post').value = data.zonecode;
                document.getElementById("basic_addr").value = addr;
                document.getElementById("detail_addr").focus();
            }
        }).open();
    }
  </script>
</body>
</html>