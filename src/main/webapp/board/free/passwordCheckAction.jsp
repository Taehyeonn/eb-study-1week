<%@ page import="com.study.dao.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("utf-8");

    BoardDAO dao = new BoardDAO();

    String id = request.getParameter("id");
    String userPassword = request.getParameter("password");
    String pageNum = request.getParameter("pageNum");
    String type = request.getParameter("type");



    System.out.println("id = " + id);
    System.out.println("password = " + userPassword);

    boolean isPasswordValid = dao.checkPassword(id, userPassword);

    System.out.println("isPasswordValid = " + isPasswordValid);

//    if (isPasswordValid) {
//        dao.deleteBoard(id);
//        response.sendRedirect("list.jsp?pageNum"+pageNum);
//        return;
//    }
//
//    response.sendRedirect("passwordCheck.jsp?id="+id+"pageNum"+pageNum+"&status=fail");

    if (isPasswordValid && type.equals("delete")) {
        dao.deleteBoard(id);
        response.sendRedirect("list.jsp?pageNum="+pageNum);
        return;
    }

    if (isPasswordValid && type.equals("modify")) {
        response.sendRedirect("modify.jsp?id="+id+"&pageNum="+pageNum+"&status=success");
        return;
    }


    response.sendRedirect("passwordCheck.jsp?id="+id+"&pageNum="+pageNum+"&status=fail"+"&type="+type);

%>