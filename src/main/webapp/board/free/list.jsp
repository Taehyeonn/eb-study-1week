<%@ page import="com.study.board.BoardDTO" %>
<%@ page import="com.study.board.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.connection.MysqlConnection" %>
<%@ page import="com.study.board.CategoryDAO" %>
<%@ page import="com.study.board.CategoryDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="static com.study.utils.DateUtils.getStartDate" %>
<%@ page import="static com.study.utils.DateUtils.getEndDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>자유게시판 - 목록</title>
</head>

<%
  MysqlConnection conn = new MysqlConnection();

  //dao 선언
  BoardDAO dao = new BoardDAO();

  //게시글 목록
  List<BoardDTO> list = dao.getBoardList();

  //게시글 총 개수
  int totalCount = dao.getTotalCount();

  //카테고리 리스트
  CategoryDAO cateDAO = new CategoryDAO();
  List<CategoryDTO> cateList = cateDAO.getCategoryList();

  //날짜 출력 양식
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>

<body>
<div>
  <h2>자유게시판 - 목록</h2>
</div>
<div>
  <form action method="GET">
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
<table border="1">
  <tr>
    <th>카테고리</th>
    <th>1</th>
    <th>제목</th>
    <th>작성자</th>
    <th>조회수</th>
    <th>등록 일시</th>
    <th>수정 일시</th>
  </tr>

  <%
    for(BoardDTO dto : list) {
  %>
  <tr>
    <td><%= dto.getBoard_category() %></td>
    <td><%= dto.getBoard_id() %></td>
    <td><a href="view.jsp?id=<%= dto.getBoard_id() %>"><%= dto.getBoard_title() %></a></td>
    <td><%= dto.getBoard_writer() %></td>
    <td><%= dto.getBoard_view_count() %></td>
    <td><%= sdf.format(dto.getBoard_registration_date()) %></td>
    <td><%= dto.getBoard_modification_date() != null ? sdf.format(dto.getBoard_modification_date()) : "-" %></td>
  </tr>
  <%
    }
  %>
</table>

<button type="button" onclick="location.href='write.jsp'">등록</button>

</body>
</html>
