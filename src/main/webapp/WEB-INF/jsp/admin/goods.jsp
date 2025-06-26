<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 관리 | 신선 잇츠 관리자</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel='stylesheet' href="${pageContext.request.contextPath}/reference/css/layout.css">
<style>
    :root {
        --admin-primary-color: #34568B; /* 관리자 페이지 포인트 컬러 */
        --status-selling: #28a745;
        --status-soldout: #dc3545;
        --status-hidden: #6c757d;
    }

    body { background-color: #f8f9fa; }

    /* 관리자 페이지 공통 헤더 */
    .admin-header { background-color: #fff; padding: 15px 5%; box-shadow: 0 2px 4px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
    .admin-header .logo { font-size: 1.8em; font-weight: bold; color: var(--admin-primary-color); }
    .admin-header .logo .sub-title { font-size: 0.6em; color: #6c757d; }

    .main-container { padding: 40px 5%; }

    /* 필터 및 검색 바 */
    .filter-bar { background-color: #fff; padding: 20px; border-radius: 8px; margin-bottom: 30px; display: flex; gap: 15px; align-items: center; }
    .filter-bar input, .filter-bar select { min-width: 150px; }

    /* 상품 목록 테이블 */
    .product-table { width: 100%; background-color: #fff; border-collapse: collapse; }
    .product-table th, .product-table td { padding: 12px 15px; text-align: center; vertical-align: middle; border-bottom: 1px solid #dee2e6; }
    .product-table th { background-color: #f8f9fa; }
    .product-table .product-info { display: flex; align-items: center; gap: 15px; text-align: left; }
    .product-table .product-info img { width: 50px; height: 50px; border-radius: 4px; object-fit: cover; }
    .product-info-text .name { font-weight: 500; }
    .product-info-text .code { font-size: 0.85em; color: #6c757d; }

    /* 상태 및 프로모션 배지 */
    .badge { display: inline-block; padding: .35em .65em; font-size: .75em; font-weight: 700; line-height: 1; text-align: center; white-space: nowrap; vertical-align: baseline; border-radius: .25rem; }
    .badge.bg-selling { background-color: var(--status-selling); color: #fff; }
    .badge.bg-soldout { background-color: var(--status-soldout); color: #fff; }
    .badge.bg-hidden { background-color: var(--status-hidden); color: #fff; }
    .badge.bg-promo { background-color: var(--admin-primary-color); color: #fff; }

    /* 재고 관리 */
    .stock-control input { width: 70px; text-align: center; }
    .stock-control .btn-sm { padding: 5px 10px; }
    
    /* 모달 스타일 */
    .modal-body { max-height: 70vh; overflow-y: auto; }
</style>
</head>
<body>

    <header class="admin-header">
    <jsp:include page="/WEB-INF/jsp/include/adminTop.jsp"></jsp:include>
    </header>

    <main class="main-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="h3">상품 관리</h2>
            <button class="btn" style="background-color: var(--admin-primary-color);" data-bs-toggle="modal" data-bs-target="#productModal" onclick="openNewProductModal()">+ 새 상품 등록</button>
        </div>

        <!-- 필터 및 검색 바 -->
        <div class="filter-bar shadow-sm">
            <select class="form-select form-select-sm">
                <option selected>전체 카테고리</option>
                <c:forEach items="${category}" var="cat" varStatus="loop">
                <option value="${loop.count}">${cat.foodDiv}</option>
                </c:forEach>
            </select>
            <select class="form-select form-select-sm">
                <option selected>전체 상태</option>
                <option value="selling">판매중</option>
                <option value="soldout">품절</option>
                <option value="hidden">숨김</option>
            </select>
            <input type="text" class="form-control form-control-sm" placeholder="상품명 또는 상품코드로 검색">
            <button class="btn btn-sm" style="background-color: var(--admin-primary-color); color:white;">검색</button>
        </div>

        <!-- 상품 목록 테이블 -->
        <div class="table-responsive shadow-sm" style="border-radius: 8px; overflow: hidden;">
            <table class="product-table">
                <thead>
                    <tr>
                        <th><input type="checkbox"></th>
                        <th style="width: 30%;">상품 정보</th>
                        <th>판매가</th>
                        <th>재고</th>
                        <th>상태</th>
                        <th>프로모션</th>
                        <th>등록일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- 실제 데이터는 JSTL/EL을 사용하여 DB에서 가져와야 함 --%>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>
                            <div class="product-info">
                                <img src="https://images.unsplash.com/photo-1550258987-190a2d41a8ba?q=80&w=1974&auto=format&fit=crop" alt="상품 이미지">
                                <div class="product-info-text">
                                    <div class="name">고당도 파인애플 1통</div>
                                    <div class="code">F0001</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <span style="text-decoration: line-through; color: #888;">12,000원</span><br>
                            <strong>9,900원</strong>
                        </td>
                        <td class="stock-control">
                            <input type="number" class="form-control form-control-sm d-inline-block" value="120">
                            <button class="btn btn-sm btn-outline-secondary">변경</button>
                        </td>
                        <td><span class="badge bg-selling">판매중</span></td>
                        <td>
                            <span class="badge bg-promo">BEST</span>
                            <span class="badge bg-promo">NEW</span>
                        </td>
                        <td>2025-06-23</td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#productModal" onclick="openEditProductModal()">수정</button>
                            <button class="btn btn-sm btn-outline-danger" onclick="confirm('정말로 삭제하시겠습니까?')">삭제</button>
                        </td>
                    </tr>
                    <%-- 다른 상품들 반복... --%>
                </tbody>
            </table>
        </div>
        <%-- 페이지네이션 컴포넌트 위치 --%>
    </main>
    
    <!-- 상품 등록/수정 모달 -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="productModalLabel">새 상품 등록</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="productForm">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">상품명*</label>
                        <input type="text" class="form-control" name="foodName" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">상품코드*</label>
                        <input type="text" class="form-control" name="foodCode" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">카테고리*</label>
                        <select class="form-select" name="categoryId" required>
                <c:forEach items="${category}" var="cat" varStatus="loop">
                <option value="${loop.count}">${cat.foodDiv}</option>
                </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">브랜드</label>
                        <input type="text" class="form-control" name="brand">
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">정상가*</label>
                        <input type="number" class="form-control" name="price" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">할인율(%)</label>
                        <input type="number" class="form-control" name="discountPercent" value="0">
                    </div>
                     <div class="col-md-4 mb-3">
                        <label class="form-label">재고*</label>
                        <input type="number" class="form-control" name="stock" required value="999">
                    </div>
                </div>
                 <hr>
                 <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">썸네일 이미지 URL</label>
                        <input type="text" class="form-control" name="thumbnailUrl">
                    </div>
                     <div class="col-md-6 mb-3">
                        <label class="form-label">판매 상태</label>
                        <select class="form-select" name="status">
                            <option value="판매중" selected>판매중</option>
                            <option value="품절">품절</option>
                            <option value="숨김">숨김</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">프로모션 설정</label>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="checkbox" name="isBest" value="Y">
                      <label class="form-check-label">BEST</label>
                    </div>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="checkbox" name="isNew" value="Y">
                      <label class="form-check-label">NEW</label>
                    </div>
                </div>
                <hr>
                <div class="mb-3">
                    <label class="form-label">상세 설명 (CLOB)</label>
                    <textarea class="form-control" name="detailDescription" rows="5"></textarea>
                </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="submit" form="productForm" class="btn" style="background-color:var(--admin-primary-color); color:white;">저장하기</button>
          </div>
        </div>
      </div>
    </div>
    	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 새 상품 등록 모달 열기
        function openNewProductModal() {
            document.getElementById('productModalLabel').textContent = '새 상품 등록';
            document.getElementById('productForm').reset();
            // 상품코드 필드를 활성화
            document.querySelector('input[name="foodCode"]').readOnly = false; 
        }

        // 기존 상품 수정 모달 열기 (실제로는 상품 데이터를 파라미터로 받아 폼을 채워야 함)
        function openEditProductModal() {
            document.getElementById('productModalLabel').textContent = '상품 정보 수정';
            document.getElementById('productForm').reset(); // 우선 폼 초기화
            
            // --- 예시 데이터로 폼 채우기 (실제 구현 시, DB에서 가져온 데이터 사용) ---
            document.querySelector('input[name="foodName"]').value = '고당도 파인애플 1통';
            document.querySelector('input[name="foodCode"]').value = 'F0001';
            document.querySelector('input[name="foodCode"]').readOnly = true; // 상품코드는 수정 불가
            document.querySelector('input[name="price"]').value = 12000;
            document.querySelector('input[name="discountPercent"]').value = 17.5; // 예시
            // ... 나머지 필드 채우기
            // -----------------------------------------------------------------
        }
    </script>
</body>
</html>