<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
 <script>
      // 1. 서버에서 넘겨준 값들을 안전하게 JavaScript 변수로 받습니다.
      const price = Number("${price}"); // 상품 가격
      const customerKey = "${ck}"; // 회원 식별 키 (비어있을 수 있음)
      const orderId = "${orderId}";
      const orderName = "${orderName}";
      const customerEmail = "${user.emailId}" && "${user.emailDomain}" ? "${user.emailId}@${user.emailDomain}" : "";
      const customerName = "${user.name}";
      const customerMobilePhone = "${user.tel1}" && "${user.tel2}" && "${user.tel3}" ? "${user.tel1}${user.tel2}${user.tel3}" : "";
      const contextPath = "${pageContext.request.contextPath}"; // 애플리케이션의 컨텍스트 경로
    </script>

    <!-- 결제 UI -->
    <div id="payment-method"></div>
    <!-- 이용약관 UI -->
    <div id="agreement"></div>
    <!-- 결제하기 버튼 -->
    <button class="button" id="payment-button" style="margin-top: 30px">결제하기</button>

    <script>
      main();

      async function main() {
        const button = document.getElementById("payment-button");
        const coupon = document.getElementById("coupon-box");
        // ------  결제위젯 초기화 ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // 회원 결제
        const customerKey = "DBqHodhXJ3l3JMlNiR_UA";
        const widgets = tossPayments.widgets({
          customerKey,
        });
        // 비회원 결제
        // const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

        // ------ 주문의 결제 금액 설정 ------
        await widgets.setAmount({
          currency: "KRW",
          value: price,
        });

        await Promise.all([
          // ------  결제 UI 렌더링 ------
          widgets.renderPaymentMethods({
            selector: "#payment-method",
            variantKey: "DEFAULT",
          }),
          // ------  이용약관 UI 렌더링 ------
          widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);

        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        button.addEventListener("click", async function () {
          await widgets.requestPayment({
            orderId: orderId,
            orderName: orderName,
            successUrl: window.location.origin + contextPath + "/cart/success",
            failUrl: window.location.origin + contextPath + "/cart/fail",
            customerEmail: customerEmail,
            customerName: customerName,
            customerMobilePhone: customerMobilePhone,
          });
        });
      }
    </script>
  </body>
</html>