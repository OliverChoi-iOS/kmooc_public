# 프로그래머스 과제관 (K-MOOC 강좌정보 서비스) 프로젝트

1. 과제 요구사항
    1. 강좌 목록 조회
        1. 표시 내용: 강좌 이미지, 강좌 이름, 운영기관 이름, 운영기간
        2. Pull To Refresh 구현
        3. Infinite Scroll 구현
    2. 강좌 상세 화면
        1. 표시 내용: 강좌 이미지(large), 강좌 번호, 분류, 운영기관, 교수정보, 운영기간, 추가 상세정보
        2. 추가 상세정보는 웹뷰로 구현
    3. 제한사항
        
        Apple 제공 framework 외에 pod/spm/carthago 등 외부 라이브러리 사용 불가
        
2. 환경
    
    
    | Xcode | 13.3 |
    | --- | --- |
    | 테스트 환경 | iPhone Simulator (iPhone 13) |
    | OS Target | iOS 15.4 |
3. 구현 내용
    1. Views
        1. Launch Screen 을 제외한 모든 화면을 SwiftUI View 로 구현
    2. 강좌 목록 조회
        1. 제공된 코드 중 **KmoocRepository** 의 list, next 메소드를 구현 (JSON String을 [String: Any] 로 디코딩하여 사용)
        2. 제공된 코드 중 **KmoocListViewModel** 을 **ObservableObject** 로 변경 구현
        3. SwiftUI의 **List** 를 사용하여 강좌 목록을 구현
        4. .refreshable 을 사용하여 Pull To Refresh 구현
    3. 강좌 상세 화면
        1. 제공된 코드 중 **KmoocRepository** 의 detail 메소드를 구현 (JSON String을 [String: Any] 로 디코딩하여 사용)
        2. 제공된 코드 중 **KmoocDetailViewModel** 을 **ObservableObject** 로 변경 구현
        3. SwiftUI의 **List** 를 사용하여 상세 화면을 구현 (Scrollable 한 화면을 구현하기 위해)
        4. 추가 상세정보를 웹뷰로 표현하기 위해 **WKWebView** 와 **UIViewRepresentable** 사용
        

### 과제관

[https://programmers.co.kr/skill_check_assignments/168](https://programmers.co.kr/skill_check_assignments/168)
