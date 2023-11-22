<%@ page import="com.study.board.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("utf-8");

    BoardDAO dao = new BoardDAO();

    String id = request.getParameter("id");
    String userPassword = request.getParameter("password");

    System.out.println("id = " + id);
    System.out.println("password = " + userPassword);

    boolean isPassword = dao.checkPassword(id, userPassword);

    System.out.println("isPassword = " + isPassword);

    if (isPassword) {
        dao.deleteBoard(id);
        response.sendRedirect("list.jsp");
        return;
    }

    response.sendRedirect("delete.jsp?id="+id+"&status=fail");

%>