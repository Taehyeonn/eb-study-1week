<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.study.dao.BoardDAO" %>
<%@ page import="com.study.dto.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 상세 페이지</title>
    <link href="../style.css" rel="stylesheet">
</head>
<%
    // 파라미터에서 id 받아오기
    String boardId = request.getParameter("id");
    String pageNum = request.getParameter("pageNum");

    //dao 선언
    BoardDAO dao = new BoardDAO();

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
<body>
<div class="container">
    <h1>게시글 상세 페이지</h1>
    <div class="view_title">
        <div>
            <span class="align-left"><%= boardDto.getBoard_writer() %></span>
            <span class="align-right">등록일시: <%= sdf.format(boardDto.getBoard_registration_date()) %></span>
            <span class="align-right">수정일시: <%= boardDto.getBoard_modification_date() != null ? sdf.format(boardDto.getBoard_modification_date()) : "-" %></span>
        </div>
        <div>
            <span>[<%= boardDto.getBoard_category() %>]</span>
            <span><%= boardDto.getBoard_title() %></span>
            <span class="align-right">조회수: <%= boardDto.getBoard_view_count() %></span>
        </div>
    </div>
    <div class="view_content">
        <p><%= boardDto.getBoard_content() %></p>
    </div >
    <div>
        <% for (String attachment : attachments) { %>
        <p><%= attachment %></p>
        <% } %>
    </div>
    <div class="view_comment">
        <div class="comment_list">
            <p>2020.22.22</p>
            <span>댓글내용</span>
        </div>
        <div class="comment_list">
            <p>2020.22.22</p>
            <span>댓글내용</span>
        </div>
        <div class="comment_input">
            <form action="CommentAction.jsp" method="get">
                <label><textarea rows="3" cols="112"></textarea></label>
                <input type="submit" value="등록">
            </form>
        </div>
    </div>
    <div class="view_buttons">
        <button type="button" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">목록</button>
        <button type="button" onclick="location.href='passwordCheck.jsp?id=<%= boardId %>&pageNum=<%= pageNum %>&type=modify'">수정</button>
        <button type="button" onclick="location.href='passwordCheck.jsp?id=<%= boardId %>&pageNum=<%= pageNum %>&type=delete'">삭제</button>
    </div>
</div>
</body>
</html>
