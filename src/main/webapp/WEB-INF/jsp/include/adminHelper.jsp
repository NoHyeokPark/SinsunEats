<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 알림 영역 (왼쪽 하단, "맨 위로" 버튼 위) -->
<div id="stock-alert-container"></div>

<!-- 맨 위로 버튼 (하단 고정) -->
<div class="bottom-sticky-menu">
    <button class="to-top-btn" onclick="window.scrollTo(0, 0)">▲ 맨 위로</button>
</div>

<style>
/* 하단 고정 맨 위로 버튼 */
.bottom-sticky-menu {
    position: fixed;
    left: 20px;
    bottom: 30px;
    z-index: 1000;
}

/* 푸시 알림 영역: "맨 위로" 버튼 위에 고정 */
#stock-alert-container {
    position: fixed;
    left: 20px;
    bottom: 90px; /* "맨 위로" 버튼 위에 위치하도록 조정 */
    z-index: 2000;
    display: flex;
    flex-direction: column; /* 새 알림이 아래에 쌓임 */
    align-items: flex-start;
    min-width: 120px;
    pointer-events: none; /* 알림 외 영역 클릭 방지 */
}

/* 알림 스타일 */
.stock-alert {
    background: #323232;
    color: #fff;
    padding: 16px 28px 16px 18px;
    border-radius: 10px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.18);
    margin-top: 10px;
    font-size: 0.8em;
    display: flex;
    align-items: center;
    min-width: 100px;
    max-width: 350px;
    pointer-events: auto;
    animation: slideUp 0.4s;
    position: relative;
    opacity: 0.96;
    transition: margin 0.2s, opacity 0.2s;
}
@keyframes slideUp {
    from { opacity: 0; transform: translateY(40px);}
    to   { opacity: 0.96; transform: translateY(0);}
}
.stock-alert .close-btn {
    background: none;
    border: none;
    color: #fff;
    font-size: 1.3em;
    font-weight: bold;
    margin-left: auto;
    cursor: pointer;
    padding: 0 8px;
    line-height: 1;
    transition: color 0.2s;
}
.stock-alert .close-btn:hover {
    color: #ff5252;
}
/* 하단 고정 맨 위로 버튼 */
.bottom-sticky-menu {
    position: fixed;
    left: 20px;
    bottom: 30px;
    z-index: 1000;
}
.to-top-btn {
    display: block;
    width: 120px;
    padding: 12px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1em;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    transition: background-color 0.3s;
}
.to-top-btn:hover {
    background-color: #0056b3;
}
</style>

<script>
const STORAGE_KEY = "stockAlerts";
function saveAlertToStorage(message) {
    let alerts = JSON.parse(sessionStorage.getItem(STORAGE_KEY) || "[]");
    alerts.unshift(message); // 최신 알림이 맨 앞에
    sessionStorage.setItem(STORAGE_KEY, JSON.stringify(alerts));
}
function removeAlertFromStorage(message) {
    let alerts = JSON.parse(sessionStorage.getItem(STORAGE_KEY) || "[]");
    alerts = alerts.filter(m => m !== message);
    sessionStorage.setItem(STORAGE_KEY, JSON.stringify(alerts));
}

if (window.eventSource == null) {
    window.eventSource = new EventSource('${pageContext.request.contextPath}/sse/stock');
    window.eventSource.addEventListener("stock-alert", function (event) {
    	const data = JSON.parse(event.data);
    	showStockAlert(event.data);
    });
    window.eventSource.onerror = function () {
        console.error("SSE 연결 끊김");
    };
}

// 알림 메시지 표시 함수
function showStockAlert(data) {
    const container = document.getElementById('stock-alert-container');
    // 알림 DOM 생성
    const alertDiv = document.createElement('div');
    // JSON 데이터 파싱
    //const data1 = JSON.parse(data);
    data = JSON.parse(data);
    
    // 내용물 추출
    const food = data.food;      // 음식 이름
    const stock = data.stock;    // 재고 수량
    const message = data.message; // 메시지
    const code = data.code;
    alertDiv.className = 'stock-alert';
    alertDiv.innerHTML = '<a href=${pageContext.request.contextPath}/admin/goods?code='+ code +'>'+"이슈 : [" + food + "] " + message + " 현재 " + stock + "개"+'</a> <button class="close-btn" onclick="closeStockAlert(this)">×</button>' ;
    // 새 알림을 container의 맨 아래(실제로는 column-reverse라 아래가 최신)로 추가
    container.prepend(alertDiv);
    if (!fromStorage) saveAlertToStorage(message);

}

// 알림 닫기 함수
function closeStockAlert(closeBtn) {
    const alertDiv = closeBtn.closest('.stock-alert');
    //const message = decodeURIComponent(encodedMessage);
    if (alertDiv) {
        // 부드럽게 사라지게 처리
        if (alertDiv._autoRemoveTimeout) clearTimeout(alertDiv._autoRemoveTimeout);
        alertDiv.style.opacity = '0';
        alertDiv.style.marginTop = '0';
        setTimeout(() => {
            if (alertDiv.parentElement) {
                alertDiv.parentElement.removeChild(alertDiv);
            }
        }, 200);
        //removeAlertFromStorage(message);
    }
}

window.addEventListener('DOMContentLoaded', () => {
    let alerts = JSON.parse(sessionStorage.getItem(STORAGE_KEY) || "[]");
    alerts.forEach(message => showStockAlert(message, true));
});
</script>
