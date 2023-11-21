<%@ page import="com.study.board.BoardDAO" %>
<%@ page import="com.study.board.BoardDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판 목록</title>
</head>
<body>
<%
    BoardDAO dao = BoardDAO.getInstance();
    List<BoardDTO> list = dao.selectBoardList();
%>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Date</th>
    </tr>
    <%
        for(BoardDTO dto : list) {
    %>
    <tr>
        <td><%= dto.getBoard_num() %></td>
        <td><%= dto.getBoard_title() %></td>
        <td><%= dto.getBoard_writer() %></td>
        <td><%= dto.getBoard_content() %></td>
    </tr>
    <%
        }
    %>
</table>

</body>
</html>