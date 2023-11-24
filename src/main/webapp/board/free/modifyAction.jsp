<%@ page import="com.study.dao.BoardDAO" %>
<%@ page import="com.study.dto.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
        request.setCharacterEncoding("utf-8");

        //dao dto 선언
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = new BoardDTO();

        //전송된 데이터 받아오기
        String id = request.getParameter("id");
        String pageNum = request.getParameter("pageNum");

        String writer = request.getParameter("writer");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        //유효성검사

        //dto에 넣기
        dto.setBoard_writer(writer);
        dto.setBoard_title(title);
        dto.setBoard_content(content);

        //update 메서드 호출
        dao.modifyBoard(id, dto);

        //content.jsp로 이동 (content는 num를 필요로 한다)
        response.sendRedirect("view.jsp?id="+id+"&pageNum="+pageNum);

%>
