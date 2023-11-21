<%@ page import="com.study.connection.ConnectionTest" %>
<%@ page import="com.study.connection.MysqlConnection" %>
<%@ page import="com.study.board.BoardDAO" %>
<%@ page import="com.study.board.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>

<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<h2><a href="/board/free/list.jsp">리스트로 이동</a></h2>
<button type="button" class="btn" onclick="location.href='/board/free/list.jsp'">이동</button>
</body>
</html>
