<%@ page import="com.study.dto.BoardDTO" %>
<%@ page import="com.study.dao.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.connection.MysqlConnection" %>
<%@ page import="com.study.dao.CategoryDAO" %>
<%@ page import="com.study.dto.CategoryDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="static com.study.utils.DateUtils.getStartDate" %>
<%@ page import="static com.study.utils.DateUtils.getEndDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>자유게시판 - 목록</title>
  <link href="../style.css" rel="stylesheet">
</head>

<%
  //날짜 출력 양식
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

  int pageNum = (request.getParameter("pageNum") != null) ? Integer.parseInt(request.getParameter("pageNum")) : 1;

  String searchText = (request.getParameter("searchText") != null) ? request.getParameter("searchText") : "%";
  String reg_start_date = (request.getParameter("reg_start_date") != null) ? request.getParameter("reg_start_date") : getStartDate();
  String reg_end_date = (request.getParameter("reg_end_date") != null) ? request.getParameter("reg_end_date") : getEndDate();
  String category = (request.getParameter("category") != null) ? request.getParameter("category") : "%";

  MysqlConnection conn = new MysqlConnection();

  //dao 선언
  BoardDAO dao = new BoardDAO();

  //게시글 총 개수
  int totalCount = dao.getTotalCount();

  //페이징
  int amount = 10; //한페이지에 보여줄 게시글 수
  int lastPage = (int) Math.ceil((double)totalCount / amount); // 총 페이지 수
  int pageListLimit = 10; // 최대 페이지 수 << < 1~10 > >>
  int startPage = (pageNum-1) / pageListLimit * pageListLimit + 1; // 인덱스의 시작 페이지
  int endPage = startPage + pageListLimit - 1; //인덱스의 마지막 페이지

  System.out.println("endPage = " + endPage);
  System.out.println("lastPage = " + lastPage);
  System.out.println("startPage = " + startPage);

  // 만약에 endPage가 lastPage보다 클 때는 endPage를 lastPage로 변경!
  if(endPage > lastPage) {
    endPage = lastPage;
  }
  System.out.println("endPage = " + endPage);

//게시글 조회 변수
  int startRow = (pageNum - 1) * amount; // 0 10 20

  //게시글 목록
//  List<BoardDTO> list = dao.getList(pageNum, amount);


  List<BoardDTO> list = dao.selectList(startRow, amount, searchText);
//  List<BoardDTO> list = dao.selectList(startRow, amount, searchText, category, reg_start_date, reg_end_date);

  //카테고리 리스트
  CategoryDAO cateDAO = new CategoryDAO();
  List<CategoryDTO> cateList = cateDAO.getCategoryList();
%>

<body>
  <div class="container">
    <div>
      <h2>자유게시판 - 목록</h2>
    </div>
    <div class="list_search">
      <form action="list.jsp?pageNum=<%= pageNum %>" method="GET">
          <span>등록일</span>
          <input type="date" name="reg_start_date" value="<%= getStartDate() %>">
          -
          <input type="date" name="reg_end_date" value="<%= getEndDate() %>">
        <select name="category">
          <option value="*">전체 카테고리</option>
          <%
            for(CategoryDTO dto : cateList) {
          %>
          <option value=<%= dto.getCate_name() %>><%= dto.getCate_name() %></option>
        <%
          }
        %>
        </select>
        <input type="text" name="search_text" placeholder="검색어를 입력해주세요. (제목 + 작성자 + 내용)">
        <input type="submit" value="검색" >
      </form>
    </div>
    <div>
      <p>총 <%=totalCount%>건</p>
    </div>
      <table class="list_table">
        <thead>
          <tr>
            <th>카테고리</th>
            <th></th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>등록 일시</th>
            <th>수정 일시</th>
          </tr>
        </thead>
        <%
          for(BoardDTO dto : list) {
        %>
        <tr>
          <td><%= dto.getBoard_category() %></td>
          <td></td> <%-- 첨부파일 유무 --%>
          <td><a href="view.jsp?id=<%= dto.getBoard_id() %>&pageNum=<%=pageNum%>"><%= dto.getBoard_title() %></a></td>
          <td><%= dto.getBoard_writer() %></td>
          <td><%= dto.getBoard_view_count() %></td>
          <td><%= sdf.format(dto.getBoard_registration_date()) %></td>
          <td><%= dto.getBoard_modification_date() != null ? sdf.format(dto.getBoard_modification_date()) : "-" %></td>
        </tr>
        <%
          }
        %>
      </table>

    <div class="list_page">
      <% if(pageNum > 1) {%>
      <a href="list.jsp?pageNum=<%=pageNum-1%>">Prev</a>
      <%}else {%>
      <a href="javascript:void(0)">Prev</a>

      <%}
        for(int i = startPage; i <= endPage; i++) {%>
      <% if(pageNum == i) {%>
      <a href="javascript:void(0)"><%=i%></a>
      <%}else {%>
      <a href="list.jsp?pageNum=<%=i%>"><%=i%></a>
      <%}
      }%>

      <% if(pageNum < lastPage) {%>
      <a href="list.jsp?pageNum=<%=pageNum+1%>">Next</a>
      <%}else {%>
      <a href="javascript:void(0)">Next</a>
      <%}%>
    </div>
    <div class="list_button">
      <button type="button" onclick="location.href='write.jsp?pageNum=<%= pageNum %>'">등록</button>
    </div>
  </div>
</body>
</html>
