<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
<link rel='stylesheet'
	href="${pageContext.request.contextPath}/reference/css/layout.css">

<style>
/* 장바구니 전용 스타일 */
.btn {
	background-color: #28a745;
	color: white;
	padding: 12px 25px;
	border-radius: 5px;
	font-weight: bold;
	transition: background-color 0.3s;
}

.cart-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.cart-header {
	border-bottom: 2px solid #e9ecef;
	padding-bottom: 20px;
	margin-bottom: 30px;
}

.cart-item {
	display: flex;
	align-items: center;
	padding: 20px;
	border-bottom: 1px solid #e9ecef;
	background-color: #ffffff;
	margin-bottom: 10px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.item-checkbox {
	margin-right: 20px;
}

.item-image {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 8px;
	margin-right: 20px;
}

.item-details {
	flex: 1;
	margin-right: 20px;
}

.item-name {
	font-size: 1.1em;
	font-weight: 500;
	margin-bottom: 10px;
	color: #333;
}

.item-code {
	font-size: 0.9em;
	color: #666;
	margin-bottom: 5px;
}

.item-date {
	font-size: 0.8em;
	color: #999;
}

.quantity-controls {
	display: flex;
	align-items: center;
	margin-right: 20px;
}

.quantity-btn {
	width: 30px;
	height: 30px;
	border: 1px solid #ddd;
	background-color: #f8f9fa;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}

.quantity-input {
	width: 50px;
	height: 30px;
	text-align: center;
	border: 1px solid #ddd;
	border-left: none;
	border-right: none;
}

.item-price {
	font-size: 1.2em;
	font-weight: bold;
	color: #28a745;
	margin-right: 20px;
}

.item-actions {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.cart-summary {
	position: sticky;
	top: 100px;
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.empty-cart {
	text-align: center;
	padding: 80px 20px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.empty-cart-icon {
	font-size: 4em;
	color: #dee2e6;
	margin-bottom: 20px;
}

.cart-layout {
	display: grid;
	grid-template-columns: 1fr 300px;
	gap: 30px;
}

@media ( max-width : 768px) {
	.cart-layout {
		grid-template-columns: 1fr;
	}
	.cart-item {
		flex-direction: column;
		align-items: flex-start;
	}
	.item-image {
		margin-bottom: 15px;
	}
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/jsp/include/topmenu.jsp"></jsp:include>
	</header>

	<div class="cart-container">
		<div class="cart-header">
			<h1 class="section-title">장바구니</h1>
		</div>

		<div class="cart-layout">
		
		
			<!-- 장바구니 아이템 영역 -->
			<div class="cart-items">


				<!-- 전체 선택 체크박스 -->
				<div class="cart-item"
					style="background-color: #f8f9fa; border: 1px solid #dee2e6;">
					<input type="checkbox" id="select-all" class="item-checkbox">
					<label for="select-all" style="font-weight: bold;">전체선택</label>
					<div style="margin-left: auto;">
						<button class="product-card add-to-cart-btn"
							onclick="deleteSelected()" type="button">선택삭제</button>
					</div>
				</div>
				
				
				<!-- 장바구니가 비어있을 때 -->
				<div class="empty-cart" id="empty-cart" style="display: none;">
					<div class="empty-cart-icon">🛒</div>
					<h2>장바구니에 담은 상품이 없습니다.</h2>
					<p>로그인을 하시면, 장바구니에 보관된 상품을 확인하실 수 있습니다.</p>
					<button class="btn"
						onclick="location.href='${pageContext.request.contextPath}/goods?no=1'">쇼핑
						계속하기</button>
				</div>
				
				
				<!-- 샘플 장바구니 아이템들 -->
				<c:forEach items="${carts}" var="i" varStatus="loop">
					<div class="cart-item" data-cart-id="${i.cartId}"
						data-price="${i.discountPrice}">
						<input type="checkbox" class="item-checkbox item-select" checked
							data-cart-id="${i.isSelected}"> <img
							src="https://images.unsplash.com/photo-1550258987-190a2d41a8ba?q=80&w=1974&auto=format&fit=crop"
							alt="음식 이미지" class="item-image">
						<div class="item-details">
							<div class="item-name">${i.foodName}</div>
							<div class="item-code">
								<span style="color: red;">${i.discountPercent}%!!</span> <span
									class="price">${i.discountPrice}원</span>
							</div>
							<div class="item-date">${i.addedAt}</div>
						</div>
						<div class="quantity-controls">
							<button class="quantity-btn"
								onclick="changeQuantity('${i.cartId}', -1)" type="button">-</button>
							<input type="number" name="quantity" class="quantity-input"
								value="${i.quantity}" min="1" readonly>
							<button class="quantity-btn"
								onclick="changeQuantity('${i.cartId}', 1)" type="button">+</button>
						</div>
						<div class="item-price">${i.discountPrice*i.quantity}원</div>
						<div class="item-actions">
							<button class="product-card add-to-cart-btn"
								onclick="removeItem(${i.cartId})" type="button">삭제</button>
						</div>
					</div>
				</c:forEach>

			</div>

			<!-- 주문 요약 영역 -->
			<div class="cart-summary">
				<h3 style="margin-top: 0;">주문 요약</h3>
				<div
					style="display: flex; justify-content: space-between; margin-bottom: 10px;">
					<span>선택 상품 수량:</span> <span id="selected-count">3333개</span>
				</div>
				<div
					style="display: flex; justify-content: space-between; margin-bottom: 10px;">
					<span>상품 금액:</span> <span id="total-price">105,500원</span>
				</div>
				<div
					style="display: flex; justify-content: space-between; margin-bottom: 10px;">
					<span>배송비:</span> <span>무료</span>
				</div>
				<hr>
				<div
					style="display: flex; justify-content: space-between; font-size: 1.2em; font-weight: bold; color: #28a745;">
					<span>총 결제 금액:</span> <span id="final-price">105,500원</span>
				</div>
				<button class="btn" style="width: 100%; margin-top: 20px;"
					onclick="proceedToOrder()" type="button">주문하기</button>
				<div style="margin-top: 15px; font-size: 0.9em; color: #666;">
					<p>🚚 로켓배송 상품은 다음날 새벽에 도착합니다</p>
					<p>💳 신선캐시 적립 가능</p>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<%@ include file="/WEB-INF/jsp/include/foot.jsp"%>
	</footer>

	<script>
	// 페이지 로드 시 초기 합계 계산
	document.addEventListener('DOMContentLoaded', function() {
		updateSummary();
	});

	// 전체 선택 체크박스
	const selectAllCheckbox = document.getElementById('select-all');
	// 개별 아이템 체크박스
	const itemCheckboxes = document.querySelectorAll('.item-select');

	// 전체 선택 체크박스 클릭 이벤트
	selectAllCheckbox.addEventListener('change', function() {
		itemCheckboxes.forEach(checkbox => {
			checkbox.checked = this.checked;
		});
		updateSummary();
	});

	// 개별 아이템 체크박스 클릭 이벤트
	itemCheckboxes.forEach(checkbox => {
		checkbox.addEventListener('change', function() {
			// 모든 아이템이 선택되었는지 확인
			if (!this.checked) {
				selectAllCheckbox.checked = false;
			} else {
				// 모든 개별 체크박스가 선택되었는지 확인하고 전체 선택 체크박스 상태 업데이트
				const allChecked = Array.from(itemCheckboxes).every(item => item.checked);
				selectAllCheckbox.checked = allChecked;
			}
			updateSummary();
		});
	});
	
	function saveCheckedFetch(cartId, checked){
		  fetch('/cart/checked', {
		    method : 'POST',
		    headers: { 'Content-Type': 'application/json' },
		    body   : JSON.stringify({ cartId, checked })
		  }).then(r => {
		      if (!r.ok) throw new Error('fail');
		  }).catch(console.error);
		}

	/**
	 * 주문 요약 정보를 업데이트하는 함수
	 */
	function updateSummary() {
		let selectedCount = 0;
		let totalPrice = 0;
		const cartItems = document.querySelectorAll('.cart-item:not([style*="background-color"])'); // 헤더 제외

		cartItems.forEach(item => {
			const checkbox = item.querySelector('.item-select');
			if (checkbox && checkbox.checked) {
				const quantityInput = item.querySelector('.quantity-input');
				const price = parseFloat(item.dataset.price);
				const quantity = parseInt(quantityInput.value);

				selectedCount += quantity;
				totalPrice += price * quantity;
			}
		});

		// 숫자를 한국 통화 형식으로 포맷
		const formatCurrency = (amount) => new Intl.NumberFormat('ko-KR').format(amount) + '원';
		
		//consol.log(selectedCount + ":::" + totalPrice)

		document.getElementById('selected-count').textContent = selectedCount + '개';
		document.getElementById('total-price').textContent = formatCurrency(totalPrice);
		document.getElementById('final-price').textContent = formatCurrency(totalPrice); // 배송비가 무료이므로 최종 금액도 동일하게 설정

		// 장바구니가 비어있는지 확인
		checkEmptyCart();
	}

	/**
	 * 상품 수량을 변경하는 함수
	 * @param {string} cartId - 카트 아이템의 고유 ID
	 * @param {number} delta - 변경할 수량 (-1 또는 1)
	 */
	function changeQuantity(cartNum, delta) {
	
		    const items = Array.from(document.querySelectorAll('.cart-item'));
		    const target = items.find(el => el.dataset.cartId === String(cartNum));

		    if (!target) {
		        console.warn(`cart-id=${cartNum}인 항목이 없습니다`);
		        return;
		    }

		    const input = target.querySelector('.quantity-input');
		    let newQuantity = parseInt(input.value) + delta;
		    if (newQuantity < 1) newQuantity = 1;
		    input.value = newQuantity;

			// 서버에 수량 변경을 알리는 AJAX 호출 (옵션)
			fetch('${pageContext.request.contextPath}/cart/updateQuantity', {
				method: 'POST',
				headers: {'Content-Type': 'application/json'},
				body: JSON.stringify({ cartId: cartNum, quantity: newQuantity })
			})
			.then(response => response.json())
			.then(data => {
				if(data.success) {
					console.log('수량이 성공적으로 변경되었습니다.');
					location.reload();
				}
			});
		 

			 
		// 수량 변경 시 해당 아이템의 총 가격 업데이트
		const price = parseFloat(item.dataset.price);
		const itemPriceElement = item.querySelector('.item-price');
		itemPriceElement.textContent = new Intl.NumberFormat('ko-KR').format(price * newQuantity) + '원';

		
	

		updateSummary();
		
	}

	/**
	 * 특정 아이템을 장바구니에서 삭제하는 함수
	 * @param {string} cartId - 삭제할 카트 아이템의 고유 ID
	 */
	function removeItem(cartNum) {
		if (confirm('선택하신 상품을 삭제하시겠습니까?')) {
			cartNum = cartNum.toString()
			/*
			//window.location.href = '${pageContext.request.contextPath}/cart/info?cartId='+cartId;
			
			let item = document.querySelector(`.cart-item[data-cart-id="${cartNum}"]`);
			alert(typeof cartNum + "" + item)
			item.remove();
			// 서버에 아이템 삭제를 알리는 AJAX 호출 (옵션)
			*/
			fetch('${pageContext.request.contextPath}/cart/delete', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        body: JSON.stringify({
		            cartId: cartNum,
		        })
		    })
				.then(response => response.json())
				.then(data => {
					if(data.success) {
						alert('아이템이 성공적으로 삭제되었습니다.');
						location.reload();
					}
				});
			

			updateSummary();
		}
	}

	/**
	 * 선택된 모든 아이템을 삭제하는 함수
	 */
	function deleteSelected() {
		const selectedItems = document.querySelectorAll('.item-select:checked');
		if (selectedItems.length === 0) {
			alert('삭제할 상품을 선택해주세요.');
			return;
		}

		if (confirm('선택하신 상품들을 모두 삭제하시겠습니까?')) {
			const cartIdsToDelete = [];
			selectedItems.forEach(checkbox => {
				const cartItem = checkbox.closest('.cart-item');
				cartIdsToDelete.push(cartItem.dataset.cartId);
				cartItem.remove();
			});

			// 서버에 선택된 아이템들 삭제를 알리는 AJAX 호출 (옵션)
			/*
			fetch('/cart/deleteSelected', {
				method: 'POST',
				headers: {'Content-Type': 'application/json'},
				body: JSON.stringify({ cartIds: cartIdsToDelete })
			})
			.then(response => response.json())
			.then(data => {
				if(data.success) {
					console.log('선택된 아이템들이 성공적으로 삭제되었습니다.');
				}
			});
			*/

			updateSummary();
		}
	}

	/**
	 * 장바구니가 비어있는지 확인하고 메시지를 표시하는 함수
	 */
	function checkEmptyCart() {
		const cartItems = document.querySelectorAll('.cart-item:not([style*="background-color"])');
		const emptyCartMessage = document.getElementById('empty-cart');
		if (cartItems.length === 0) {
			emptyCartMessage.style.display = 'block';
		} else {
			emptyCartMessage.style.display = 'none';
		}
	}
	
	


	/**
	 * 주문 페이지로 이동하는 함수
	 */
	function proceedToOrder() {
		const selectedItems = document.querySelectorAll('.item-select:checked');
		if (selectedItems.length === 0) {
			alert('주문할 상품을 선택해주세요.');
			return;
		}

	    const form = document.createElement('form');
	    form.method = 'post';
	    form.action = '${pageContext.request.contextPath}/cart/order';

	    selectedItems.forEach(checkbox => {
	        const cartItem = checkbox.closest('.cart-item');
	        const input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'cartId';
	        input.value = cartItem.dataset.cartId;
	        form.appendChild(input);
	    });

	    document.body.appendChild(form);
	    form.submit();
	}
</script>
</body>
</html>
