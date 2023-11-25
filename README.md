
# 스터디 1주차 - JSP를 이용한 MODEL-1 게시판 만들기
사용기술: jsp, mysql


### 미구현 기능들
- 검색 </br>
list.jsp 접속시 실행되는 게시글 목록 조회와 날짜+카테고리+검색어 필터를 같은 getBoardList로 사용하려함</br>
-> 기본 필터값을 와일드카드로 하여 기본 조회와 검색을 같은 메서드로 사용하고 싶었으나 역량부족으로 실패.</br>
- 유효성검사(프론트) </br>
키값이 입력될때마다 유효성검사 함수를 불러서 검증하고 통과하면 O 표시. 전부 다 통과하면 등록 버튼 활성화를 구현했으나</br>
-> UXUI에 치중되는거 같아 삭제. 아직 할 때가 아니라 판단</br>
프론트에서 등록버튼을 눌렀을때 유효성검사함수를 불러오고 그 함수는 각각의 객체를 검사하는 함수 실행. 모두 통과시 이동. 실패시 원래 화면</br>
-> 첫번째 함수는 불러와지는데 함수의 함수가 안불러와져서 실패</br>
- 비밀번호 암호화</br>
-> 시간부족</br>
- 댓글</br>
-> 시간부족</br>
- 첨부파일</br>
-> 시간부족</br>
    

### 후기

- 시간관리의 중요성을 깨달았다. 작은 기능 하나에 꽂혀서 하루를 날렸더니 일정을 못맞춰버리는 일이 생겨버렸다. 우선순위를 정하고 안되는건 적당히 포기할줄도 알아야겠다.
- css 신경쓰지말고 기능 구현에만 집중해야겠다
</br></br>

페이징에 억지로 rownum 쓰려다가 코드도 길어지고 보기 안좋아서 mysql에서 사용하는 limit으로 변경했다.

```sql
String sql = "SELECT * FROM (SELECT *, (@rownum := @rownum + 1) AS rn FROM (SELECT * FROM board ORDER BY board_registration_date DESC) a, (SELECT @rownum := 0) r) b WHERE b.rn > ? AND b.rn <= ?";
```

```sql
String sql = "SELECT * FROM board WHERE board_title LIKE ? ORDER BY board_registration_date DESC LIMIT ?, ?";
```
---
### 피드백

- 통일성을 위해 컨벤션 지키기
- 메서드 단위마다 주석 필수로 작성하기(자세하면 좋지만 간단하게 목적과 의도만 적어도 괜찮다)
- 중복되는 작업은 함수로 빼기
- Class.forName()의 역할?

### 질문

Q 개발할수록 파라미터가 추가돼서 주소가 길어지는데 상관없을까요?

A 여기에 저장안하면 다른 곳에다가 저장해야 돼서 차라리 주소창에 물고 다니는 게 낫다.




# 사전 준비

## JDK 11 설치

## Docker Desktop 설치
https://www.docker.com/products/docker-desktop/

## Apache Tomcat 설치
https://tomcat.apache.org/download-90.cgi

## Docker Compose 실행 - MySql
``` 
cd help
docker-compose up -d
```
