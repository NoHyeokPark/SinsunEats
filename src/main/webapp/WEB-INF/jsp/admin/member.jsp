<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 관리 | 신선 잇츠 관리자</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel='stylesheet' href="${pageContext.request.contextPath}/reference/css/layout.css">
<style>
    :root {
        --admin-primary-color: #34568B;
    }
    body { background-color: #f8f9fa; }

    /* 관리자 페이지 공통 헤더 */
    .admin-header { background-color: #fff; padding: 15px 5%; box-shadow: 0 2px 4px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
    .admin-header .logo { font-size: 1.8em; font-weight: bold; color: var(--admin-primary-color); }
    .admin-header .logo .sub-title { font-size: 0.6em; color: #6c757d; }

    .main-container { padding: 40px 5%; }

    /* 필터 및 검색 바 */
    .filter-bar { background-color: #fff; padding: 20px; border-radius: 8px; margin-bottom: 30px; display: flex; flex-wrap: wrap; gap: 15px; align-items: center; }

    /* 회원 목록 테이블 */
    .member-table { width: 100%; background-color: #fff; border-collapse: collapse; font-size: 0.9em; }
    .member-table th, .member-table td { padding: 12px 10px; text-align: center; vertical-align: middle; border-bottom: 1px solid #dee2e6; }
    .member-table th { background-color: #f8f9fa; font-weight: 600; }
    
    /* 인라인 폼 컨트롤 스타일 */
    .inline-form { display: flex; gap: 5px; align-items: center; justify-content: center;}
    
    /* 모달 내부 스타일 */
    .detail-section dl { display: flex; margin-bottom: 8px; font-size: 1.1em; }
    .detail-section dt { width: 120px; color: #6c757d; }
    .detail-section dd { margin-left: 10px; font-weight: 500;}
</style>
</head>
<body>

     <header class="admin-header">
    <jsp:include page="/WEB-INF/jsp/include/adminTop.jsp"></jsp:include>
    </header>

    <main class="main-container">
        <h2 class="h3 mb-4">회원 관리</h2>

        <!-- 필터 및 검색 바 -->
        <div class="filter-bar shadow-sm">
            <select class="form-select form-select-sm" style="width: 150px;">
                <option selected>전체 등급</option>
                <option value="U">일반회원</option>
                <option value="A">관리자</option>
                <option value="V">VIP</option>
                <option value="S">정지회원</option>
            </select>
            <input type="text" class="form-control form-control-sm" placeholder="회원ID, 이름, 이메일 검색">
            <button class="btn btn-sm" style="background-color: var(--admin-primary-color); color:white;">검색</button>
        </div>

        <!-- 회원 목록 테이블 -->
        <div class="table-responsive shadow-sm" style="border-radius: 8px; overflow: hidden;">
            <table class="member-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>연락처</th>
                        <th>등급</th>
                        <th>가입일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- 실제 데이터는 JSTL/EL을 사용하여 DB에서 가져와야 함 --%>
                    <tr>
                        <td>user01</td>
                        <td>김신선</td>
                        <td>fresh@example.com</td>
                        <td>010-1234-5678</td>
                        <td>
                            <div class="inline-form">
                                <select class="form-select form-select-sm">
                                    <option value="U" selected>일반회원</option>
                                    <option value="V">VIP</option>
                                    <option value="S">활동정지</option>
                                    <option value="A">관리자</option>
                                </select>
                                <button class="btn btn-sm btn-outline-secondary">저장</button>
                            </div>
                        </td>
                        <td>2025-06-20</td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#memberDetailModal">상세보기</button>
                            <button class="btn btn-sm btn-outline-danger">강제탈퇴</button>
                        </td>
                    </tr>
                    <tr>
                        <td>user02</td>
                        <td>박헬시</td>
                        <td>healthy@example.com</td>
                        <td>010-9876-5432</td>
                        <td>
                            <div class="inline-form">
                                <select class="form-select form-select-sm">
                                    <option value="U">일반회원</option>
                                    <option value="V" selected>VIP</option>
                                    <option value="S">활동정지</option>
                                    <option value="A">관리자</option>
                                </select>
                                <button class="btn btn-sm btn-outline-secondary">저장</button>
                            </div>
                        </td>
                        <td>2025-05-15</td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#memberDetailModal">상세보기</button>
                            <button class="btn btn-sm btn-outline-danger">강제탈퇴</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <%-- 페이지네이션 컴포넌트 위치 --%>
    </main>
    
    <!-- 회원 상세정보 모달 -->
    <div class="modal fade" id="memberDetailModal" tabindex="-1" aria-labelledby="memberDetailModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="memberDetailModalLabel">회원 상세 정보</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="detail-section">
                <%-- AJAX로 채워질 내용 --%>
                <dl><dt>아이디</dt><dd>user01</dd></dl>
                <dl><dt>이름</dt><dd>김신선</dd></dl>
                <hr>
                <dl><dt>이메일</dt><dd>fresh@example.com</dd></dl>
                <dl><dt>연락처</dt><dd>010-1234-5678</dd></dl>
                <hr>
                <dl><dt>우편번호</dt><dd>12345</dd></dl>
                <dl><dt>주소</dt><dd>서울시 강남구 테헤란로 123, 래미안아파트 101동 202호</dd></dl>
                <hr>
                <dl><dt>회원등급</dt><dd>일반회원 (U)</dd></dl>
                <dl><dt>가입일</dt><dd>2025-06-20 10:30:15</dd></dl>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
          </div>
        </div>
      </div>
    </div>
        <footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>