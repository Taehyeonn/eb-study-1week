<%@ page import="com.study.board.BoardDAO" %>
<%@ page import="com.study.board.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
        request.setCharacterEncoding("utf-8");

        System.out.println("writeAction");
        //dao dto 선언
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = new BoardDTO();

        //전송된 데이터 받아오기
        String category = request.getParameter("category");
        String writer = request.getParameter("writer");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
//        String content = request.getParameter("content"); // 파일

        System.out.println("category = " +category);
        System.out.println("writer = " +writer);
        System.out.println("password = " +password);

        //dto에 넣기
        dto.setBoard_category(category);
        dto.setBoard_writer(writer);
        dto.setBoard_password(password);
        dto.setBoard_title(title);
        dto.setBoard_content(content);

        //insert 메서드 호출
        dao.insertBoard(dto);

        //list.jsp로 이동
        response.sendRedirect("list.jsp");
%>