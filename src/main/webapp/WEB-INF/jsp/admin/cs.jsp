<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판 관리 | 신선 잇츠 관리자</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
<style>
:root {
	--admin-primary-color: #34568B;
	--status-pending: #fd7e14; /* 답변대기 */
	--status-complete: #198754; /* 답변완료 */
}

body {
	background-color: #f8f9fa;
}

/* 관리자 페이지 공통 헤더 */
.admin-header {
	background-color: #fff;
	padding: 15px 5%;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.admin-header .logo {
	font-size: 1.8em;
	font-weight: bold;
	color: var(--admin-primary-color);
}

.admin-header .logo .sub-title {
	font-size: 0.6em;
	color: #6c757d;
}

.main-container {
	padding: 40px 5%;
}

.nav-tabs .nav-link {
	color: #6c757d;
}

.nav-tabs .nav-link.active {
	color: var(--admin-primary-color);
	font-weight: bold;
	border-color: #dee2e6 #dee2e6 #fff;
}

.tab-content {
	background-color: #fff;
	padding: 30px;
	border: 1px solid #dee2e6;
	border-top: none;
	border-radius: 0 0 .375rem .375rem;
}

/* 아코디언 답변 UI */
.accordion-button:not(.collapsed) {
	background-color: #eef2f7;
	color: var(--admin-primary-color);
}

.accordion-button:focus {
	box-shadow: 0 0 0 .25rem rgba(52, 86, 139, .25);
}

.answer-form textarea {
	min-height: 120px;
}

/* 상태 배지 */
.status-badge {
	display: inline-block;
	padding: .4em .7em;
	font-size: .8em;
	font-weight: 700;
	border-radius: .25rem;
	color: #fff;
}

.status-badge.pending {
	background-color: var(--status-pending);
}

.status-badge.complete {
	background-color: var(--status-complete);
}
</style>
</head>
<body>

	<header class="admin-header">
		<jsp:include page="/WEB-INF/jsp/include/adminTop.jsp"></jsp:include>
	</header>

	<main class="main-container">
		<h2 class="h3 mb-4">게시판 및 고객 문의 관리</h2>

		<!-- 탭 네비게이션 -->
		<ul class="nav nav-tabs" id="csTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="inquiry-tab"
					data-bs-toggle="tab" data-bs-target="#inquiry-panel" type="button"
					role="tab">고객 문의 관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="notice-tab" data-bs-toggle="tab"
					data-bs-target="#notice-panel" type="button" role="tab">공지사항
					관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="faq-tab" data-bs-toggle="tab"
					data-bs-target="#faq-panel" type="button" role="tab">FAQ
					관리</button>
			</li>
		</ul>

		<!-- 탭 콘텐츠 -->
		<div class="tab-content shadow-sm">
			<!-- 1. 고객 문의 관리 탭 -->
			<div class="tab-pane fade show active" id="inquiry-panel"
				role="tabpanel">
				<div class="accordion" id="inquiryAccordion">
					<%-- JSTL/EL로 고객 문의 목록 (1:1, Q&A, 리뷰 등) 반복 --%>
					<c:forEach items="${ csList}" var="board" varStatus="loop">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse" data-bs-target="#inquiry-${loop.count}">
									<c:if test="${empty board.answer}">
										<span class="status-badge pending me-2">답변대기</span>
									</c:if>
									<c:if test="${not empty board.answer}">
										<span class="status-badge complete me-2">답변완료</span>
									</c:if>
									[${board.category }] ${board.title } | 작성자: ${board.writer } |
									연락처 : ${board.tel } | 작성일 : ${board.regDate }
								</button>
							</h2>
							<div id="inquiry-${loop.count}" class="accordion-collapse collapse"
								data-bs-parent="#inquiryAccordion">
								<div class="accordion-body">
									<strong>문의 내용: <a href="${pageContext.request.contextPath}/admin/order?no=${board.orderReference}" target="_blank"> 바로가기 </a></strong>
									<p class="border p-3 rounded bg-light">${board.content }</p>
									<div class="answer-form mt-3" id="answer-form-${board.no}" style="${not empty board.answer ? 'display:none;' : ''}">
										<h5>답변 작성</h5>
										<textarea class="form-control" id="answer-textarea-${board.no}" placeholder="답변을 입력하세요..."></textarea>
										<button type="button" class="btn btn-primary mt-2" onclick="submitAnswer(${board.no})" style="background-color: var(--admin-primary-color);">답변 등록</button>
									</div>
									<%-- 등록된 답변 (답변이 있을 때만 보임) --%>
									<div class="answered-section mt-3" id="answered-section-${board.no}" style="${empty board.answer ? 'display:none;' : ''}">
										<h5>등록된 답변</h5>
										<div class="border p-3 rounded bg-light" id="answer-content-${board.no}">${board.answer}</div>
										<button type="button" class="btn btn-secondary mt-2">답변 수정</button>
									</div>
								
							</div>
						</div>
						</div>
					</c:forEach>
				</div>
			</div>

			<!-- 2. 공지사항 관리 탭 -->
			<div class="tab-pane fade" id="notice-panel" role="tabpanel">
				<div class="d-flex justify-content-end mb-3">
					<button class="btn"
						style="background-color: var(--admin-primary-color);"
						data-bs-toggle="modal" data-bs-target="#postModal"
						onclick="openPostModal('notice', 'new')">+ 새 공지사항 작성</button>
				</div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>2</td>
							<td>[안내] 7월 배송 휴무 안내</td>
							<td>2025-06-20</td>
							<td>
								<button class="btn btn-sm btn-outline-primary"
									data-bs-toggle="modal" data-bs-target="#postModal"
									onclick="openPostModal('notice', 'edit')">수정</button>
								<button class="btn btn-sm btn-outline-danger">삭제</button>
							</td>
						</tr>
						<tr>
							<td>1</td>
							<td>[오픈] 신선 잇츠 정식 오픈!</td>
							<td>2025-05-01</td>
							<td>
								<button class="btn btn-sm btn-outline-primary"
									data-bs-toggle="modal" data-bs-target="#postModal"
									onclick="openPostModal('notice', 'edit')">수정</button>
								<button class="btn btn-sm btn-outline-danger">삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 3. FAQ 관리 탭 -->
			<div class="tab-pane fade" id="faq-panel" role="tabpanel">
				<div class="d-flex justify-content-end mb-3">
					<button class="btn"
						style="background-color: var(--admin-primary-color);"
						data-bs-toggle="modal" data-bs-target="#postModal"
						onclick="openPostModal('faq', 'new')">+ 새 FAQ 작성</button>
				</div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리</th>
							<th>제목(질문)</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>배송</td>
							<td>배송은 얼마나 걸리나요?</td>
							<td>
								<button class="btn btn-sm btn-outline-primary"
									data-bs-toggle="modal" data-bs-target="#postModal"
									onclick="openPostModal('faq', 'edit')">수정</button>
								<button class="btn btn-sm btn-outline-danger">삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</main>

	<!-- 공지사항/FAQ 작성 및 수정 모달 -->
	<div class="modal fade" id="postModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="postModalLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="postForm">
						<div class="mb-3" id="faqCategoryGroup" style="display: none;">
							<label class="form-label">카테고리</label> <select
								class="form-select" name="category">
								<option value="주문/결제">주문/결제</option>
								<option value="배송">배송</option>
								<option value="회원정보">회원정보</option>
							</select>
						</div>
						<div class="mb-3">
							<label class="form-label">제목</label> <input type="text"
								class="form-control" name="title" required>
						</div>
						<div class="mb-3">
							<label class="form-label">내용</label>
							<textarea class="form-control" name="content" rows="10" required></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="submit" form="postForm" class="btn"
						style="background-color: var(--admin-primary-color); color: white;">저장하기</button>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// 공지사항/FAQ 모달 열기 함수
		function openPostModal(type, mode) {
			const modalLabel = document.getElementById('postModalLabel');
			const postForm = document.getElementById('postForm');
			const faqCategoryGroup = document
					.getElementById('faqCategoryGroup');

			postForm.reset(); // 폼 초기화

			if (type === 'notice') {
				faqCategoryGroup.style.display = 'none';
				modalLabel.textContent = mode === 'new' ? '새 공지사항 작성'
						: '공지사항 수정';
			} else if (type === 'faq') {
				faqCategoryGroup.style.display = 'block';
				modalLabel.textContent = mode === 'new' ? '새 FAQ 작성' : 'FAQ 수정';
			}

			if (mode === 'edit') {
				// 수정 시, 실제로는 DB에서 가져온 데이터로 폼을 채워야 합니다.
				// 예시 데이터
				document.querySelector('#postForm [name="title"]').value = '7월 배송 휴무 안내';
				document.querySelector('#postForm [name="content"]').value = '7월 15일부터 17일까지 배송 휴무입니다.';
			}
		}
		function submitAnswer(inquiryNo) {
			// 1. 답변 내용 가져오기
			const textarea = document.getElementById('answer-textarea-'+inquiryNo);
			const answerText = textarea.value.trim();
			const ctx = '${pageContext.request.contextPath}'

			// 2. 입력값 검증
			if (answerText === "") {
				alert("답변 내용을 입력해주세요.");
				textarea.focus();
				return;
			}

			// 3. 서버로 전송할 데이터 준비
			const data = {
				no: inquiryNo,      // cs보드의 식별자
				answer: answerText  // 등록할 답변 내용
			};

			// 4. Fetch API를 사용하여 서버에 비동기 POST 요청 전송
			fetch(ctx+'/admin/cs/registerAnswer', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(data)
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('서버 응답에 실패했습니다. 상태: ' + response.status);
				}
				return response.json(); // 서버의 JSON 응답을 파싱
			})
			.then(result => {
				// 서버에서 { "success": true } 와 같은 응답을 보냈다고 가정
				if (result.success) {
					alert("답변이 성공적으로 등록되었습니다.");
					location.reload();
					/*
					// --- 실시간 UI 업데이트 ---
					const accordionItem = document.getElementById('inquiry-item-'+inquiryNo);

					// 상태 배지 '답변완료'로 변경
					
					const statusBadge = accordionItem.querySelector('.status-badge');
					statusBadge.classList.remove('pending');
					statusBadge.classList.add('complete');
					statusBadge.textContent = '답변완료';
					
					// 답변 입력 폼 숨기기
					document.getElementById('answer-form-'+inquiryNo).style.display = 'none';

					// 등록된 답변 영역 보이기 및 내용 채우기
					const answeredSection = document.getElementById('answered-section-'+inquiryNo);
					document.getElementById('answer-content-'+inquiryNo).textContent = answerText;
					answeredSection.style.display = 'block';
					*/
				} else {
					alert("답변 등록에 실패했습니다: " + (result.message || "알 수 없는 오류입니다."));
				}
			})
			.catch(error => {
				console.error('답변 등록 중 오류 발생:', error);
				alert(error);
			});
		}
	</script>
</body>
</html>