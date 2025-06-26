<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 1:1 문의 내역</title>
    
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
    

    <style>
        .inquiry-list-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        /* 문의 등록하기 버튼 (layout.css 기반) */
        .btn-write {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
            border: none;
            cursor: pointer;
        }
        .btn-write:hover {
            background-color: #218838;
        }

        /* 반응형 테이블을 위한 래퍼 */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }
        
        .inquiry-table {
            width: 100%;
            min-width: 800px; /* 모바일에서 최소 너비 지정 */
            border-collapse: collapse;
            text-align: center;
            font-size: 0.95em;
        }

        .inquiry-table thead {
            background-color: #f8f9fa;
        }
        
        .inquiry-table th, .inquiry-table td {
            padding: 15px 10px;
            border-bottom: 1px solid #dee2e6;
        }

        .inquiry-table th {
            color: #495057;
            font-weight: 600;
        }

        .inquiry-table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .inquiry-table .col-title {
            text-align: left;
        }
        .inquiry-table .col-title a {
            color: #333;
            transition: color 0.3s;
        }
        .inquiry-table .col-title a:hover {
            color: #28a745;
            text-decoration: underline;
        }
        
        /* 답변 상태 배지 스타일 */
        .status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            color: #fff;
        }
        .status.complete {
            background-color: #28a745; /* 답변 완료: 녹색 */
        }
        .status.pending {
            background-color: #6c757d; /* 답변 대기: 회색 */
        }

        /* 페이지네이션 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 40px;
            list-style: none;
            padding: 0;
        }
        .pagination a {
            color: #333;
            padding: 8px 15px;
            margin: 0 4px;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: all 0.3s;
        }
        .pagination a:hover {
            background-color: #f1f1f1;
            border-color: #ccc;
        }
        .pagination a.active {
            background-color: #28a745;
            color: white;
            border-color: #28a745;
            font-weight: bold;
        }

        /* 문의 내역이 없을 때 메시지 */
        .empty-list-message {
            text-align: center;
            padding: 100px 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            color: #6c757d;
        }
        .empty-list-message h3 {
            font-size: 1.5em;
            margin-bottom: 20px;
        }
        .empty-list-message p {
            margin-bottom: 30px;
        }

    </style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

    <main class="container">
        <section class="section inquiry-list-container">

            <div class="page-header">
                <h2 class="section-title" style="text-align: left; margin-bottom: 0;">나의 1:1 문의 내역</h2>
                <button class="btn-write" onclick="location.href='${pageContext.request.contextPath}/cs/write'">문의 등록하기</button>
            </div>

            <%-- JSTL을 사용하여 컨트롤러에서 전달받은 inquiryList가 비어있는지 확인 --%>
            <c:if test="${empty inquiryList}">
                <div class="empty-list-message">
                    <h3>등록된 문의 내역이 없습니다.</h3>
                    <p>궁금한 점이 있다면 언제든지 문의를 남겨주세요.</p>
                    <button class="btn-write" onclick="location.href='${pageContext.request.contextPath}/cs/write'">문의 등록하기</button>
                </div>
            </c:if>

            <c:if test="${not empty inquiryList}">
                <div class="table-responsive">
                    <table class="inquiry-table">
                        <thead>
                            <tr>
                                <th style="width: 8%;">번호</th>
                                <th style="width: 12%;">답변상태</th>
                                <th style="width: 15%;">문의유형</th>
                                <th>제목</th>
                                <th style="width: 12%;">작성자</th>
                                <th style="width: 12%;">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- 
                                컨트롤러에서 inquiryList (List<InquiryVO>)를 모델에 담아 전달했다고 가정.
                                InquiryVO는 no, status, category, title, writer, regDate 등의 필드를 가짐.
                            --%>
                            <c:forEach var="item" items="${inquiryList}" varStatus="status">
                                <tr>
                                    <td>${item.no}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty item.answer}">
                                                <span class="status complete">답변완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status pending">답변대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${item.category}</td>
                                    <td class="col-title" style="text-align: center;">
                                        <a href="${pageContext.request.contextPath}/cs/view?no=${item.no}">${item.title}</a>
                                    </td>
                                    <td>${item.writer}</td>
                                    <td>${item.regDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <nav>
                    <ul class="pagination">
                        <li><a href="#">&laquo;</a></li>
                        <li><a href="#" class="active">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </nav>
            </c:if>
        </section>
    </main>

 	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

</body>
</html>