<%@ page import="com.study.dto.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<%
    String status = "";
    if (request.getParameter("status") != null) {
        status = request.getParameter("status");
    }

    String boardId = request.getParameter("id");
    String pageNum = request.getParameter("pageNum");
    String type = request.getParameter("type");

    String message = "비밀번호 확인";

    if (status.equals("fail")) {
        message = "비밀번호가 다릅니다";
    }

    BoardDTO dto = new BoardDTO();
%>
<body>
<h2><%= message %></h2>
<form action="passwordCheckAction.jsp?id=<%= boardId %>&pageNum=<%= pageNum %>&type=<%= type %>" method="post">
    <label for="password">비밀번호:</label>
    <input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요.">
    <input type="submit" value="확인">
</form>
</body>
</html>
