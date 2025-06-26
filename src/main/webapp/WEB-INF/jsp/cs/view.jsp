<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의 상세</title>
    
    <%-- 외부 CSS 파일 경로 --%>
	<link rel='stylesheet' href="${pageContext.request.contextPath}/reference/css/layout.css">
    
    <style>
        .view-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .view-header {
            padding-bottom: 20px;
            border-bottom: 2px solid #333;
        }
        .view-title {
            font-size: 2em;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .view-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9em;
            color: #666;
        }
        
        .view-content-area {
            padding: 40px 10px;
            border-bottom: 1px solid #ddd;
            min-height: 200px;
            line-height: 1.8;
            white-space: pre-wrap; /* 줄바꿈과 공백을 그대로 표시 */
        }
        
        /* 답변 영역 스타일 */
        .answer-area {
            margin-top: 30px;
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 30px;
        }
        .answer-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .answer-header .icon {
            font-size: 1.5em;
            margin-right: 10px;
            color: #28a745;
        }
        .answer-header .title {
            font-size: 1.3em;
            font-weight: 600;
        }
        .answer-content {
            line-height: 1.8;
            white-space: pre-wrap; /* 줄바꿈과 공백을 그대로 표시 */
        }
        
        /* 버튼 영역 */
        .button-container {
            display: flex;
            justify-content: space-between; /* 기본 정렬 */
            margin-top: 40px;
        }
        
        .button-group-right {
             display: flex;
             gap: 10px;
        }

        .btn {
            padding: 12px 25px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-list {
            background-color: #fff;
            color: #333;
        }
        .btn-list:hover {
            background-color: #f1f1f1;
        }
        
        .btn-edit, .btn-delete {
            color: white;
            border: none;
        }
        
        .btn-edit {
             background-color: #007bff;
        }
        .btn-edit:hover {
            background-color: #0056b3;
        }
        .btn-delete {
             background-color: #dc3545;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

    <main class="container">
        <section class="section view-container">
            <div class="view-header">
                <h2 class="view-title">${inquiry.title}</h2>
                <div class="view-meta">
                    <span><strong>카테고리:</strong> ${inquiry.category}</span>
                    <span><strong>작성자:</strong> ${inquiry.writer}</span>
                    <span>
                        <strong>작성일:</strong> 
                        <fmt:parseDate value="${inquiry.regDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedRegDate" />
                        <fmt:formatDate value="${parsedRegDate}" pattern="yyyy-MM-dd" />
                    </span>
                </div>
            </div>

            <div class="view-content-area">
                ${inquiry.content}
            </div>
            
            <%-- 답변이 있는 경우에만 답변 영역 표시 --%>
            <c:if test="${not empty inquiry.answer}">
                <div class="answer-area">
                    <div class="answer-header">
                        <span class="icon">💬</span>
                        <span class="title">답변 내용</span>
                    </div>
                    <div class="answer-content">
                        ${inquiry.answer}
                    </div>
                </div>
            </c:if>

            <div class="button-container">
                <button type="button" class="btn btn-list" onclick="location.href='${pageContext.request.contextPath}/cs/list'">목록</button>

                <%-- 로그인한 사용자와 게시글 작성자가 동일한 경우에만 수정/삭제 버튼 표시 --%>
                <c:if test="${sessionScope.loginUser.id == inquiry.writer}">
                    <div class="button-group-right">
                        <button type="button" class="btn btn-edit" onclick="location.href='${pageContext.request.contextPath}/cs/edit?no=${inquiry.no}'">수정</button>
                        <button type="button" class="btn btn-delete" onclick="deleteInquiry()">삭제</button>
                    </div>
                </c:if>
            </div>
        </section>
    </main>
    
 	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
    
    <script>
        function deleteInquiry() {
            // 사용자에게 삭제 여부를 다시 한번 확인
            if (confirm("정말로 이 문의를 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
                // 사용자가 '확인'을 누르면 삭제를 처리할 URL로 이동
                // 실제로는 form을 생성하여 POST 방식으로 전송하는 것이 더 안전합니다.
                location.href = '${pageContext.request.contextPath}/cs/delete?no=${inquiry.no}';
            }
        }
    </script>
</body>
</html>
