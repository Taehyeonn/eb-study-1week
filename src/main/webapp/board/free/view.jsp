<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.study.board.BoardDAO" %>
<%@ page import="com.study.board.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 상세 페이지</title>
</head>
<body>
<h1>게시글 상세 페이지</h1>
<%
    // 파라미터에서 id 받아오기
    String boardId = request.getParameter("id");

    //dao 선언
    BoardDAO dao = new BoardDAO();
    BoardDTO dto = new BoardDTO();

    //조회수 증가
    dao.increaseViewCount(boardId);

    //id 해당하는 dto 얻기
    BoardDTO boardDto = dao.getData(boardId);

    //날짜 출력 양식
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    // 댓글, 첨부파일 임시 배열
    List<String> attachments = Arrays.asList("첨부파일1", "첨부파일2", "첨부파일3");
    List<String> comments = Arrays.asList("댓글1", "댓글2", "댓글3");
%>
<div>
    <span><%= boardDto.getBoard_writer() %></span>
    <span>등록일시: <%= sdf.format(boardDto.getBoard_registration_date()) %></span>
    <span>수정일시: <%= boardDto.getBoard_modification_date() != null ? sdf.format(boardDto.getBoard_modification_date()) : "-" %></span>
</div>
<div>
    <span><%= boardDto.getBoard_category() %></span>
    <span><%= boardDto.getBoard_title() %></span>
    <span>조회수: <%= boardDto.getBoard_view_count() %></span>
</div>
<div>
<p><%= boardDto.getBoard_content() %></p>
</div>
<div>
<% for (String attachment : attachments) { %>
<p><%= attachment %></p>
<% } %>
</div>
<div>
<% for (String comment : comments) { %>
<p><%= comment %></p>
<% } %>
</div>
<div>
    <button type="button" onclick="location.href='list.jsp'">목록</button>
    <button type="button" onclick="location.href='modify.jsp?id=<%= boardId %>'">수정</button>
    <button type="button" onclick="location.href='delete.jsp?id=<%= boardId %>&status='">삭제</button>
</div>
</body>
</html>
