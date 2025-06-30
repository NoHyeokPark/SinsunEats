<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문 및 배송 관리 | 신선 잇츠 관리자</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">
<style>
:root {
	--admin-primary-color: #34568B;
	--status-ready: #0d6efd; /* 출고준비 */
	--status-shipping: #fd7e14; /* 배송중 */
	--status-complete: #198754; /* 배송완료 */
	--status-cancel: #dc3545; /* 취소됨 */
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

/* 필터 및 검색 바 */
.filter-bar {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 30px;
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
	align-items: center;
}

/* 주문 목록 테이블 */
.order-table {
	width: 100%;
	background-color: #fff;
	border-collapse: collapse;
	font-size: 0.9em;
}

.order-table th, .order-table td {
	padding: 12px 10px;
	text-align: center;
	vertical-align: middle;
	border-bottom: 1px solid #dee2e6;
}

.order-table th {
	background-color: #f8f9fa;
	font-weight: 600;
}

/* 주문 상태 배지 */
.status-badge {
	display: inline-block;
	padding: .4em .7em;
	font-size: .8em;
	font-weight: 700;
	line-height: 1;
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-radius: .25rem;
	color: #fff;
}

.status-badge.ready {
	background-color: var(--status-ready);
}

.status-badge.shipping {
	background-color: var(--status-shipping);
}

.status-badge.complete {
	background-color: var(--status-complete);
}

.status-badge.cancel {
	background-color: var(--status-cancel);
}

/* 인라인 폼 컨트롤 스타일 */
.inline-form {
	display: flex;
	gap: 5px;
	align-items: center;
	justify-content: center;
}

.inline-form .form-control-sm, .inline-form .form-select-sm {
	flex: 1;
}

/* 모달 내부 스타일 */
.modal-body h5 {
	font-weight: bold;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 1px solid #dee2e6;
}

.detail-section dl {
	display: flex;
	margin-bottom: 8px;
}

.detail-section dt {
	width: 100px;
	color: #6c757d;
}

.detail-section dd {
	margin-left: 10px;
	font-weight: 500;
}

.ordered-item-list img {
	width: 40px;
	height: 40px;
	border-radius: 4px;
	object-fit: cover;
}
</style>
</head>
<body>

    <header class="admin-header">
    <jsp:include page="/WEB-INF/jsp/include/adminTop.jsp"></jsp:include>
    </header>

	<main class="main-container">
		<h2 class="h3 mb-4">주문 및 배송 관리</h2>

		<!-- 필터 및 검색 바 -->
		<form action="${pageContext.request.contextPath}/admin/order/search"
			method="post">
			<div class="filter-bar shadow-sm">
				<input type="date" name="startDate" value="${param.startDate}"
					class="form-control form-control-sm" style="width: auto;">
				<span>~</span> <input type="date" name="endDate"
					value="${param.endDate}" class="form-control form-control-sm"
					style="width: auto;"> <select name="status"
					class="form-select form-select-sm" style="width: 150px;">
					<option value="">전체 상태</option>
					<option value="출고준비" ${param.status == '출고준비' ? 'selected' : ''}>출고준비</option>
					<option value="배송중" ${param.status == '배송중' ? 'selected' : ''}>배송중</option>
					<option value="배송완료" ${param.status == '배송완료' ? 'selected' : ''}>배송완료</option>
					<option value="취소됨" ${param.status == '취소됨' ? 'selected' : ''}>취소됨</option>
				</select> <input type="text" name="keyword" value="${param.keyword}"
					class="form-control form-control-sm"
					placeholder="주문번호, 주문자, 수령인 검색">
				<button type="submit" class="btn btn-sm"
					style="background-color: var(--admin-primary-color); color: white;">검색</button>
			</div>
		</form>

		<!-- 주문 목록 테이블 -->
		<div class="table-responsive shadow-sm"
			style="border-radius: 8px; overflow: hidden;">
			<table class="order-table">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문일</th>
						<th>주문자ID</th>
						<th>수령인</th>
						<th>총 결제금액</th>
						<th>주문상태</th>
						<th>송장번호</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${not empty cs}">
						<tr>
							<td>${cs.deliveryId}</td>
							<td>${cs.orderDate}</td>
							<td>${cs.userId}</td>
							<td>${cs.recipientName}</td>
							<td><fmt:formatNumber value="${cs.totalPrice}"
									pattern="#,##0" />원</td>
							<td>			<select class="form-select form-select-sm"
									onchange="updateStatus('${cs.deliveryId}', this.value)">
									<option value="출고준비"
										<c:if test="${order.deliveryStatus == '출고준비'}">selected</c:if>>출고준비</option>
									<option value="배송중"
										<c:if test="${order.deliveryStatus == '배송중'}">selected</c:if>>배송중</option>
									<option value="배송완료"
										<c:if test="${order.deliveryStatus == '배송완료'}">selected</c:if>>배송완료</option>
									<option value="취소됨"
										<c:if test="${order.deliveryStatus == '취소됨'}">selected</c:if>>취소됨</option>
								</select></td>
							<td>
								<div class="inline-form">
									<input type="text" id="invoice_${cs.deliveryId}"
										class="form-control form-control-sm"
										value="${cs.invoiceNumber}" placeholder="송장번호 입력">
									<button class="btn btn-sm btn-outline-secondary"
										onclick="updateInvoice('${cs.deliveryId}')">저장</button>
								</div>
							</td>
							<td><button class="btn btn-sm btn-outline-primary"
									onclick="openOrderDetailModal('${cs.deliveryId}')">상세보기</button></td>
						</tr>
					</c:if>
					<c:forEach var="order" items="${orderList}">
						<tr>
							<td>${order.deliveryId}</td>
							<td>${order.orderDate}</td>
							<td>${order.userId}</td>
							<td>${order.recipientName}</td>
							<td><fmt:formatNumber value="${order.totalPrice}"
									pattern="#,##0" />원</td>
							<td>			<select class="form-select form-select-sm"
									onchange="updateStatus('${order.deliveryId}', this.value)">
									<option value="출고준비"
										<c:if test="${order.deliveryStatus == '출고준비'}">selected</c:if>>출고준비</option>
									<option value="배송중"
										<c:if test="${order.deliveryStatus == '배송중'}">selected</c:if>>배송중</option>
									<option value="배송완료"
										<c:if test="${order.deliveryStatus == '배송완료'}">selected</c:if>>배송완료</option>
									<option value="취소됨"
										<c:if test="${order.deliveryStatus == '취소됨'}">selected</c:if>>취소됨</option>
								</select></td>
							<td>
								<div class="inline-form">
									<input type="text" id="invoice_${order.deliveryId}"
										class="form-control form-control-sm"
										value="${order.invoiceNumber}" placeholder="송장번호 입력">
									<button class="btn btn-sm btn-outline-secondary"
										onclick="updateInvoice('${order.deliveryId}')">저장</button>
								</div>
							</td>
							<td><button class="btn btn-sm btn-outline-primary"
									onclick="openOrderDetailModal('${order.deliveryId}')">상세보기</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<%-- 페이지네이션 컴포넌트 위치 --%>
	</main>

	<!-- 주문 상세정보 모달 -->
	<div class="modal fade" id="orderDetailModal" tabindex="-1"
		aria-labelledby="orderDetailModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="orderDetailModalLabel">주문 상세 정보
						(주문번호: 20250624-001)</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="modalBodyContent">
					<div class="row">
						<!-- 왼쪽 컬럼 -->
						<div class="col-md-7">
							<div class="detail-section mb-4">
								<h5>주문 상품 정보</h5>
								<table class="table table-sm">
									<tbody>
										<%-- DELIVERY_ITEM 데이터 반복 --%>
										<tr>

											<td>고당도 파인애플 1통 (F0001)</td>
											<td>1개</td>
											<td>9,900원</td>
										</tr>
										<tr>

											<td>유기농 상추 200g (V0012)</td>
											<td>2개</td>
											<td>16,000원</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="detail-section">
								<h5>교환/환불 처리</h5>
								<p class="text-muted small">교환 또는 환불 요청 시 아래 버튼을 통해 상태를
									변경하세요.</p>
								<button class="btn btn-sm btn-outline-warning">교환 요청 처리</button>
								<button class="btn btn-sm btn-outline-danger">환불 요청 처리</button>
							</div>
						</div>
						<!-- 오른쪽 컬럼 -->
						<div class="col-md-5">
							<div class="detail-section bg-light p-3 rounded mb-4">
								<h5>주문 및 결제 정보</h5>
								<dl>
									<dt>주문자 ID</dt>
									<dd>user01</dd>
								</dl>
								<dl>
									<dt>주문 일시</dt>
									<dd>2025-06-24 10:30</dd>
								</dl>
								<dl>
									<dt>결제 수단</dt>
									<dd>신용카드</dd>
								</dl>
								<dl>
									<dt>결제 금액</dt>
									<dd>
										<strong>25,900원</strong>
									</dd>
								</dl>
							</div>
							<div class="detail-section bg-light p-3 rounded mb-4">
								<h5>배송지 정보</h5>
								<dl>
									<dt>수령인</dt>
									<dd>김신선</dd>
								</dl>
								<dl>
									<dt>연락처</dt>
									<dd>010-1234-5678</dd>
								</dl>
								<dl>
									<dt>우편번호</dt>
									<dd>12345</dd>
								</dl>
								<dl>
									<dt>배송지</dt>
									<dd>서울시 강남구 테헤란로 123, 래미안아파트 101동 202호</dd>
								</dl>
							</div>
							<div class="detail-section bg-light p-3 rounded">
								<h5>배송 상태 관리</h5>
								<select class="form-select form-select-sm"
									onchange="updateStatus('${order.deliveryId}', this.value)">
									<option value="출고준비"
										<c:if test="${order.deliveryStatus == '출고준비'}">selected</c:if>>출고준비</option>
									<option value="배송중"
										<c:if test="${order.deliveryStatus == '배송중'}">selected</c:if>>배송중</option>
									<option value="배송완료"
										<c:if test="${order.deliveryStatus == '배송완료'}">selected</c:if>>배송완료</option>
									<option value="취소됨"
										<c:if test="${order.deliveryStatus == '취소됨'}">selected</c:if>>취소됨</option>
								</select>
								<button class="btn btn-sm w-100"
									style="background-color: var(--admin-primary-color); color: white;">상태
									변경</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>
	<script>
    const contextPath = "${pageContext.request.contextPath}";

    // 주문 상태 변경
    function updateStatus(deliveryId, status) {
        if (!confirm('주문번호 ['+deliveryId+']의 상태를 '+status+'(으)로 변경하시겠습니까?')) {
            location.reload(); // 변경 취소 시 selectbox 원래대로 복원
            return;
        }
        fetch(contextPath+"/admin/orders/updateStatus", {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ deliveryId: deliveryId, deliveryStatus: status })
        })
        .then(response => response.json())
        .then(result => {
            if (result.success) {
                alert('상태가 성공적으로 변경되었습니다.');
                location.reload();
            } else {
                alert('상태 변경에 실패했습니다: ' + result.message);
            }
        })
        .catch(error => console.error('Error:', error));
    }

    // 송장번호 저장
    function updateInvoice(deliveryId) {
        const invoiceNumber = document.getElementById("invoice_"+deliveryId).value;
        if (invoiceNumber.trim() === "") {
            alert("송장번호를 입력해주세요.");
            return;
        }
        fetch(contextPath+"/admin/orders/updateInvoice", {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ deliveryId: deliveryId, invoiceNumber: invoiceNumber })
        })
        .then(response => response.json())
        .then(result => {
            if (result.success) {
                alert('송장번호가 저장되었습니다.');
            } else {
                alert('저장에 실패했습니다: ' + result.message);
            }
        });
    }

    // 주문 상세보기 모달 열기
    async function openOrderDetailModal(deliveryId) {
        try {
            const response = await fetch(contextPath+"/admin/orders/details?deliveryId="+deliveryId);
            const data = await response.json();

            if (!data.orderInfo) {
                alert("주문 정보를 불러오는데 실패했습니다.");
                return;
            }

            // 모달 내용 동적 생성
            const modalBody = document.getElementById('modalBodyContent');
            const order = data.orderInfo;
            const items = data.itemList;
      
            let itemsHtml = '';
            items.forEach(item => {
                itemsHtml += '<tr>' +
                                 '<td>' + item.foodName + ' (' + item.foodCode + ')</td>' +
                                 '<td>' + item.quantity + '개</td>' +
                                 '<td>' + item.price + '원</td>' +
                             '</tr>';
            });
            

            modalBody.innerHTML = 
                '<div class="row">' +
                    '<div class="col-md-7">' +
                        '<div class="detail-section mb-4">' +
                            '<h5>주문 상품 정보</h5>' +
                            '<table class="table table-sm"><tbody>' + itemsHtml + '</tbody></table>' +
                        '</div>' +
                        '<div class="detail-section">' +
                            '<h5>교환/환불 처리</h5>' +
                            '<p class="text-muted small">요청 처리 시, 주문 상태도 함께 변경해주세요.</p>' +
                            '<button id=refundApproveBtn class="btn btn-sm btn-outline-danger" data-user-id='+order.userId+
                            ' data-used-mileage='+ (order.usedMileage + order.totalPrice) +' >환불 승인</button>' +
                        '</div>' +
                    '</div>' +
                    '<div class="col-md-5">' +
                        '<div class="detail-section bg-light p-3 rounded mb-4">' +
                            '<h5>주문 및 결제 정보</h5>' +
                            '<dl><dt>주문자 ID</dt><dd>' + order.userId + '</dd></dl>' +
                            '<dl><dt>주문 일시</dt><dd>' + order.orderDate + '</dd></dl>' +
                            '<dl><dt>결제 수단</dt><dd>' + order.paymentMethod + '</dd></dl>' +
                            '<dl><dt>마일리지 사용</dt><dd>' + order.usedMileage + 'P</dd></dl>' +
                            '<dl><dt>결제 금액</dt><dd><strong>' + order.totalPrice + '원</strong></dd></dl>' +
                        '</div>' +
                        '<div class="detail-section bg-light p-3 rounded">' +
                            '<h5>배송지 정보</h5>' +
                            '<dl><dt>수령인</dt><dd>' + order.recipientName + '</dd></dl>' +
                            '<dl><dt>연락처</dt><dd>' + order.recipientPhone + '</dd></dl>' +
                            '<dl><dt>우편번호</dt><dd>' + order.postCode + '</dd></dl>' +
                            '<dl><dt>배송지</dt><dd>' + order.address + ' ' + order.addressDetail + '</dd></dl>' +
                        '</div>' +
                    '</div>' +
                '</div>';

                
            document.getElementById('refundApproveBtn').addEventListener('click', handleRefund);
            document.getElementById('orderDetailModalLabel').textContent = "주문 상세 정보 (주문번호: "+deliveryId+")";
            const orderModal = new bootstrap.Modal(document.getElementById('orderDetailModal'));
            orderModal.show();
            
        } catch (error) {
            alert("오류가 발생했습니다.");
        }
    }
    
    async function handleRefund(event) {
        // event.currentTarget에서 data 속성 값을 가져옴
        const button = event.currentTarget;
        const userId = button.dataset.userId;
        const usedMileage = parseInt(button.dataset.usedMileage, 10);

        if (!confirm('사용자('+userId+')에게 '+usedMileage.toLocaleString()+'P를 환불하시겠습니까?')) {
            return;
        }

        // 서버로 보낼 데이터 객체 생성
        const refundData = {
            userId: userId,
            usedMileage: usedMileage // 환불할 마일리지
        };

        try {
            const response = await fetch(contextPath+'/admin/refund', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(refundData)
            });

            const result = await response.json();

            if (response.ok) {
                // 예: "마일리지 환불 처리가 성공적으로 완료되었습니다."
                // 성공 시 모달 닫기
                alert('환불되었습니다.')
                const orderModal = bootstrap.Modal.getInstance(document.getElementById('orderDetailModal'));
                orderModal.hide();
            } else {
                // 서버에서 보낸 에러 메시지 표시
                alert('환불 처리 실패: '+result.message);
            }
        } catch (error) {
            console.error("Refund request failed:", error);
            alert("환불 처리 중 통신 오류가 발생했습니다.");
        }
    }
    </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>