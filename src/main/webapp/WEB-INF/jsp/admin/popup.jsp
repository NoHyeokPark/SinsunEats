<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>배너/팝업 관리 | 신선 잇츠 관리자</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
<style>
:root {
	--admin-primary-color: #34568B;
	--status-active: #198754; /* 진행중 */
	--status-scheduled: #0d6efd; /* 예정 */
	--status-ended: #6c757d; /* 종료 */
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

/* 관리 테이블 스타일 */
.management-table {
	width: 100%;
	background-color: #fff;
}

.management-table th, .management-table td {
	text-align: center;
	vertical-align: middle;
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

.status-badge.active {
	background-color: var(--status-active);
}

.status-badge.scheduled {
	background-color: var(--status-scheduled);
}

.status-badge.ended {
	background-color: var(--status-ended);
}

/* 부트스트랩 폼 스위치(토글) 커스텀 */
.form-switch .form-check-input {
	width: 3.5em;
	height: 1.8em;
	cursor: pointer;
}

.form-switch .form-check-input:checked {
	background-color: var(--admin-primary-color);
	border-color: var(--admin-primary-color);
}
</style>
</head>
<body>

	<header class="admin-header">
		<jsp:include page="/WEB-INF/jsp/include/adminTop.jsp"></jsp:include>
	</header>


	<main class="main-container">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="h3">배너 및 팝업 관리</h2>
			<button class="btn"
				style="background-color: var(--admin-primary-color);"
				data-bs-toggle="modal" data-bs-target="#popupModal"
				onclick="openPopupModal('new')">+ 새 공지 등록</button>
		</div>

		<div class="table-responsive shadow-sm"
			style="border-radius: 8px; overflow: hidden;">
			<table class="table table-hover management-table">
				<thead>
					<tr>
						<th style="width: 5%;">ID</th>
						<th style="width: 25%;">제목</th>
						<th>등록일</th>
						<th>게시 기간</th>
						<th>상태</th>
						<th>팝업 노출</th>
						<th style="width: 15%;">관리</th>
					</tr>
				</thead>
				<tbody id="popup-list-body">
					
					<c:forEach items="${ popupList}" var="pop" varStatus="loop">
						<tr>
							<td>${loop.count}</td>
							<td>${pop.title }</td>
							<td>${pop.regDate }</td>
							<td>${pop.startDate }~ ${pop.endDate }</td>
							<td><c:choose>
									<c:when test="${pop.processed == 0 }">
										<span class="status-badge scheduled">예정</span>
									</c:when>
									<c:when test="${pop.processed == 1 }">
										<span class="status-badge active">진행중</span>
									</c:when>
									<c:otherwise>
										<span class="status-badge ended">종료</span>
									</c:otherwise>
								</c:choose></td>
							<td>
								<div
									class="form-check form-switch d-flex justify-content-center">

									<input class="form-check-input popup-status-switch" type="checkbox" role="switch" data-id="${pop.id}"
										<c:if test="${pop.isPopup == 'Y'}">
								checked
								</c:if>>
								</div>
							</td>
							<td>
								<button class="btn btn-sm btn-outline-primary"
									data-bs-toggle="modal" data-bs-target="#popupModal"
									data-id="${pop.id}" data-title="<c:out value='${pop.title}'/>"
									data-content="<c:out value='${pop.content}'/>"
									data-startDate="${pop.startDate}"
									data-endDate="${pop.endDate}" data-isPopup="${pop.isPopup}"
									onclick="openPopupModal(this)">수정</button>
								 <button class="btn btn-sm btn-outline-danger btn-delete"
                        data-id="${pop.id}">삭제</button> 
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</main>

	<!-- 공지 등록/수정 모달 -->
	<div class="modal fade" id="popupModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="popupModalLabel">새 공지 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="popupForm" action="${pageContext.request.contextPath}/admin/popup/save" method="post">
						<input type="hidden" name="id">
						<div class="mb-3">
							<label class="form-label">제목*</label> <input type="text"
								class="form-control" name="title" required>
						</div>
						<div class="mb-3">
							<label class="form-label">내용</label>
							<textarea class="form-control" name="content" rows="8"
								placeholder="이미지 배너의 경우, 이미지 URL을 입력할 수 있습니다."></textarea>
						</div>
						<div class="row mb-3">
							<div class="col-md-6">
								<label class="form-label">게시 시작일*</label> <input type="date"
									class="form-control" name="startDate" required>
							</div>
							<div class="col-md-6">
								<label class="form-label">게시 종료일*</label> <input type="date"
									class="form-control" name="endDate" required>
							</div>
						</div>
						<div class="form-check form-switch mb-3">
							<input class="form-check-input" type="checkbox" role="switch"
								id="isPopupSwitch" name="isPopup" value="Y"> <label
								class="form-check-label" for="isPopupSwitch">메인 페이지에
								팝업으로 노출하기</label>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="submit" form="popupForm" class="btn"
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
		// 공지 모달 열기 함수
		function openPopupModal(button) {
			const modalLabel = document.getElementById('popupModalLabel');
	        const popupForm = document.getElementById('popupForm');
	        popupForm.reset(); // 폼 초기화

	        // 'button' 인자가 있으면 '수정' 모드, 없으면 '새 등록' 모드
	        if (button) { // '수정' 모드
	            modalLabel.textContent = '팝업 수정';

	            // 버튼의 data-* 속성에서 데이터 추출
	            const data = button.dataset;

	            // 추출한 데이터로 폼 채우기
	            document.querySelector('#popupForm [name="id"]').value = data.id;
	            document.querySelector('#popupForm [name="title"]').value = data.title;
	            document.querySelector('#popupForm [name="content"]').value = data.content;
	            
	            const startDateFormatted = formatDateToInput(data.startdate);
	            const endDateFormatted = formatDateToInput(data.enddate);
	            document.querySelector('#popupForm [name="startDate"]').value = startDateFormatted;
	            document.querySelector('#popupForm [name="endDate"]').value = endDateFormatted;
	            document.getElementById('isPopupSwitch').checked = (data.isPopup === 'Y');

	        } else { // '새 등록' 모드
	            modalLabel.textContent = '새 팝업 등록';
	            // id 필드는 비워두거나 0으로 설정 (새 등록이므로)
	            document.querySelector('#popupForm [name="id"]').value = ''; 
	        }
	    }
		
		 document.addEventListener('DOMContentLoaded', function () {
		        const popupForm = document.getElementById('popupForm');
		        const popupModalEl = document.getElementById('popupModal');
		        const popupModal = new bootstrap.Modal(popupModalEl);
		        const ctx = '${pageContext.request.contextPath}';

		        popupForm.addEventListener('submit', function (event) {
		            // 1. 기본 폼 전송(페이지 새로고침) 방지
		            event.preventDefault();

		            // 2. 폼 데이터 객체로 변환
		            const formData = new FormData(popupForm);
		            const data = {};
		            // FormData의 각 필드를 일반 객체로 변환 (JSON으로 보내기 위함)
		            formData.forEach((value, key) => {
		                data[key] = value;
		            });
		            
		            // 'isPopup' 체크박스 값 처리: 체크 안되면 'N'
		            if (!data.isPopup) {
		                data.isPopup = 'N';
		            }
		            
		            const popupId = data.id;
		            let method = '';
		            let url = '';

		            if (popupId) {
		                // ID가 있으면 '수정' (UPDATE)
		              
		                url = '/admin/popup/update'; 
		            } else {
		                // ID가 없으면 '등록' (INSERT)
		          
		                url = '/admin/popup/save'; 
		            }
		            
		            // 3. fetch API를 사용해 데이터 서버로 전송
		            fetch(ctx+url, {
		                method: 'POST',
		                headers: {
		                    'Content-Type': 'application/json',
		                },
		                body: JSON.stringify(data),
		            })
		            .then(response => {
		                if (!response.ok) {
		                    // 서버에서 4xx, 5xx 에러 응답을 보냈을 때
		                    throw new Error('서버 응답이 올바르지 않습니다.');
		                }
		                return response.json(); // 서버가 보낸 JSON 응답을 파싱
		            })
		            .then(result => {
		                // 4. 서버로부터 성공 응답을 받았을 때
		                if (result.success) {
		                    alert('성공적으로 저장되었습니다.');
		                    popupModal.hide(); // 모달 닫기
		                    location.reload(); // 목록을 새로고침하여 변경사항 확인
		                } else {
		                    alert('저장에 실패했습니다: ' + (result.message || ''));
		                }
		            })
		            .catch(error => {
		                // 5. 네트워크 오류나 처리 중 예외가 발생했을 때
		                alert('Error:'+ error);
		            });
		        });
		    });
		 
		 function formatDateToInput(dateStr) {
			  const date = new Date(dateStr);
			  if (isNaN(date)) return ''; // 유효하지 않은 날짜는 빈값
			  const yyyy = date.getFullYear();
			  const mm = String(date.getMonth() + 1).padStart(2, '0'); // 0~11 → 1~12
			  const dd = String(date.getDate()).padStart(2, '0');
			  return `${yyyy}-${mm}-${dd}`;
			}
		 
		 document.addEventListener('DOMContentLoaded', function () {
			 
			   const popupListBody = document.getElementById('popup-list-body');
		       const ctx = '${pageContext.request.contextPath}';
		        if (popupListBody) {
		            popupListBody.addEventListener('click', function (event) { // 'change'가 아닌 'click' 이벤트
		                // 클릭된 요소가 삭제 버튼인지 확인
		                if (event.target.matches('.btn-delete')) {
		                    event.preventDefault(); // 기본 동작 방지

		                    // 1. 사용자에게 삭제 여부 확인
		                    if (confirm('정말로 삭제하시겠습니까?')) {
		                        const deleteButton = event.target;
		                        const popupId = deleteButton.dataset.id;
		                        const row = deleteButton.closest('tr'); // 삭제할 테이블 행(<tr>)

		                        // 2. fetch API를 사용해 서버에 삭제 요청
		                        fetch(ctx+"/admin/popups/delete/"+popupId, {
		                            method: 'DELETE', // HTTP DELETE 메소드 사용
		                            headers: {
		                                // CSRF 토큰 등이 필요하면 여기에 추가
		                            }
		                        })
		                        .then(response => {
		                            if (response.ok) {
		                                // 서버가 성공(2xx) 응답을 보냈을 때
		                                return response.json();
		                            }
		                            // 서버가 실패(4xx, 5xx) 응답을 보냈을 때
		                            throw new Error('서버에서 삭제 처리에 실패했습니다.');
		                        })
		                        .then(result => {
		                            if (result.success) {
		                                // 3. 성공 시, 화면에서 해당 행 제거
		                                row.remove();
		                                alert('성공적으로 삭제되었습니다.');
		                            } else {
		                                alert('삭제에 실패했습니다: ' + (result.message || ''));
		                            }
		                        })
		                        .catch(error => {
		                            console.error('Error:', error);
		                            alert('삭제 중 오류가 발생했습니다.' + error);
		                        });
		                    }
		                }
		            });
		        }
			 
		 
		        // tbody에 이벤트 리스너를 설정 (이벤트 위임)
		        if (popupListBody) {
		            popupListBody.addEventListener('change', function (event) {
		                // 클릭된 요소가 상태 변경 스위치인지 확인
		                if (event.target.matches('.popup-status-switch')) {
		                    const switchElement = event.target;
		                    
		                    // 1. 업데이트할 데이터 준비
		                    const popupId = switchElement.dataset.id; // data-id 속성에서 ID 가져오기
		                    const newStatus = switchElement.checked ? 'Y' : 'N'; // 체크 여부로 Y/N 결정

		                    // 2. fetch API를 사용해 서버에 업데이트 요청
		                    fetch(ctx+'/admin/popup/update-status', { // 요청을 보낼 URL
		                        method: 'POST',
		                        headers: {
		                            'Content-Type': 'application/json',
		                            // Spring Security CSRF 토큰이 필요하다면 여기에 추가해야 합니다.
		                        },
		                        body: JSON.stringify({
		                            id: popupId,
		                            isPopup: newStatus
		                        })
		                    })
		                    .then(response => {
		                        if (response.ok) {
		                            return response.json();
		                        }
		                        // 서버 응답이 실패하면(4xx, 5xx), 스위치를 원래 상태로 되돌림
		                        throw new Error('서버 통신에 실패했습니다.');
		                    })
		                    .then(result => {
		                        if (result.success) {
		                            console.log(`팝업 ID: ${popupId}의 상태가 ${newStatus}(으)로 변경되었습니다.`);
		                            // 성공 시 특별히 할 작업은 없음 (UI는 이미 변경됨)
		                            // 원한다면 작은 성공 알림(toast)을 띄울 수 있습니다.
		                        } else {
		                            // 서버 로직 상 실패 시, 스위치를 원래 상태로 되돌림
		                            alert('상태 변경에 실패했습니다: ' + result.message);
		                            switchElement.checked = !switchElement.checked;
		                        }
		                    })
		                    .catch(error => {
		                        console.error('Error:', error);
		                        alert('상태 변경 중 오류가 발생했습니다.'+error);
		                        // 네트워크 에러 시, 스위치를 원래 상태로 되돌림
		                        switchElement.checked = !switchElement.checked;
		                    });
		                }
		            });
		        }
		    });
	</script>
</body>
</html>