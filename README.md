(logo.png)

# 🥬 SinsunEats (신선 잇츠)

> 가장 신선한 순간을 당신의 식탁으로 전해드리는 온라인 식품몰

## 📋 프로젝트 개요

**SinsunEats**는 신선한 농산물과 식자재를 온라인으로 주문할 수 있는 Spring 기반의 웹 애플리케이션입니다. 
최상의 신선함과 편리한 온라인 쇼핑 경험을 제공합니다.

## 🛠️ 기술 스택

### Backend
- **Java** - 메인 개발 언어
- **Spring Framework** - 웹 애플리케이션 프레임워크
- **Spring MVC** - Model-View-Controller 패턴
- **MyBatis** - SQL 매핑 프레임워크
- **Oracle Database** - 데이터베이스
- **Apache Tomcat** - 웹 애플리케이션 서버

### Frontend
- **JSP (JavaServer Pages)** - 서버 사이드 렌더링
- **HTML5/CSS3** - 마크업 및 스타일링
- **JavaScript** - 클라이언트 사이드 로직
- **Bootstrap** - 반응형 UI 컴포넌트

### API Integration
- **Kakao API** - 소셜 로그인 및 지도 서비스

## 🏗️ 프로젝트 구조

```
src/
├── main/
│   ├── java/kr/ac/kopo/
│   │   ├── controller/          # 컨트롤러 클래스
│   │   │   ├── AdminController.java
│   │   │   ├── BoardController.java
│   │   │   ├── CartController.java
│   │   │   ├── CsController.java
│   │   │   ├── GoodsController.java
│   │   │   ├── KakaoController.java
│   │   │   ├── MemberController.java
│   │   │   └── SimpleLinkController.java
│   │   ├── service/             # 비즈니스 로직
│   │   │   ├── BoardService.java
│   │   │   ├── CartService.java
│   │   │   ├── CsService.java
│   │   │   ├── GoodsService.java
│   │   │   ├── KakaoService.java
│   │   │   ├── MemberService.java
│   │   │   └── PopupService.java
│   │   ├── vo/                  # Value Object
│   │   │   ├── BoardVO.java
│   │   │   ├── CartVO.java
│   │   │   ├── GoodsVO.java
│   │   │   ├── MemberVO.java
│   │   │   ├── OrderVO.java
│   │   │   └── PopupVO.java
│   │   └── board/dao/           # 데이터 접근 계층
│   │       ├── BoardDAO.java
│   │       ├── CartDAO.java
│   │       ├── GoodsDAO.java
│   │       ├── MemberDAO.java
│   │       └── OrderDAO.java
│   ├── resources/config/        # 설정 파일
│   └── webapp/WEB-INF/jsp/      # JSP 뷰 파일
│       ├── admin/               # 관리자 페이지
│       ├── cart/                # 장바구니 관련
│       ├── cs/                  # 고객 서비스
│       ├── goods/               # 상품 관련
│       ├── include/             # 공통 컴포넌트
│       ├── info/                # 회사 정보
│       ├── member/              # 회원 관리
│       └── home.jsp             # 메인 페이지
```

## ✨ 주요 기능

### 🛒 일반 사용자 기능
- **회원 관리**
  - 회원가입 및 로그인
  - 소셜 로그인 (Kakao API)
  - 마이페이지 및 개인정보 관리

- **상품 관리**
  - 상품 카테고리별 조회
  - 상품 상세 정보 및 리뷰
  - 상품 검색 및 필터링

- **주문 시스템**
  - 장바구니 기능
  - 주문 및 결제 처리
  - 주문 내역 조회

- **고객 서비스**
  - 1:1 문의 시스템
  - 자주 묻는 질문 (FAQ)
  - 고객센터 전화 상담 안내

### 🔧 관리자 기능
- **상품 관리**
  - 상품 등록/수정/삭제
  - 재고 관리
  - 프로모션 설정 (BEST, NEW)

- **주문 관리**
  - 주문 내역 조회
  - 배송 상태 관리
  - 취소/반품/교환 처리

- **회원 관리**
  - 회원 목록 조회
  - 회원 등급 관리
  - 활동 정지 처리

- **고객 서비스 관리**
  - 1:1 문의 답변
  - 공지사항 관리
  - FAQ 관리

- **사이트 관리**
  - 배너 및 팝업 관리
  - 매출 통계
  - 대시보드

## 🎨 화면 구성

### 메인 페이지
- 캐러셀 배너 (이벤트 및 프로모션)
- 이달의 특가 상품
- 카테고리별 상품 분류
- 팝업 공지사항

### 상품 페이지
- 상품 목록 (`list.jsp`)
- 상품 상세보기 (`detail.jsp`)

### 주문 시스템
- 장바구니 (`cart.jsp`)
- 주문서 작성 (`order.jsp`)
- 주문 처리 (`process.jsp`)
- 주문 내역 (`myOrder.jsp`)

### 고객 서비스
- 고객센터 메인 (`csMain.jsp`)
- 문의 목록 (`csList.jsp`)
- 문의 작성 (`write.jsp`)
- 문의 상세보기 (`view.jsp`)

### 회원 관리
- 로그인 (`loginForm.jsp`)
- 회원가입 (`join.jsp`)
- 마이페이지 (`myPage.jsp`)

## 🚀 설치 및 실행

### 필요 환경
- Java 11 이상
- Apache Tomcat 9.0 이상
- Oracle Database
- Maven 3.6 이상

### 실행 방법

1. **저장소 클론**
   ```bash
   git clone https://github.com/NoHyeokPark/SinsunEats.git
   cd SinsunEats
   ```

2. **의존성 설치**
   ```bash
   mvn clean install
   ```

3. **데이터베이스 설정**
   - Oracle Database 설치 및 설정
   - 데이터베이스 스키마 생성
   - `config/database.properties` 파일 설정

4. **서버 실행**
   - WAR 파일을 Tomcat 서버에 배포
   - 서버 시작 후 `http://localhost:8080/SinsunEats` 접속

## 📦 의존성 정보

주요 의존성 라이브러리:
- Spring WebMVC 6.2.7
- MyBatis 3.5.19
- Oracle JDBC Driver 19.27.0.0
- Jackson (JSON 처리) 2.19.0
- Lombok 1.18.38
- Apache Commons FileUpload 2.0.0
- OkHttp 4.12.0

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 학습 목적으로 제작되었습니다.

## 📞 연락처

프로젝트 문의: [GitHub Repository](https://github.com/NoHyeokPark/SinsunEats)

---

**SinsunEats** - *가장 신선한 순간을 당신의 식탁으로* 🌱
