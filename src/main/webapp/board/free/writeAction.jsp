<%@ page import="com.study.dao.BoardDAO" %>
<%@ page import="com.study.dto.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
        request.setCharacterEncoding("utf-8");

        System.out.println("writeAction");
        //dao dto 선언
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = new BoardDTO();

        //전송된 데이터 받아오기
        String pageNum = (request.getParameter("pageNum") != null) ? request.getParameter("pageNum") : "";

        String category = request.getParameter("category");
        String writer = request.getParameter("writer");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
//        String content = request.getParameter("content"); // 파일


        //유효성검사
        if (category == null || category.trim().isEmpty() ) {
                request.getSession().setAttribute("errorMessage", "카테고리를 선택해주세요.");
                response.sendRedirect("write.jsp?pageNum="+pageNum);
                return;
        }

        if (writer == null || writer.trim().isEmpty() || writer.length() < 3 || writer.length() >= 5) {
                request.getSession().setAttribute("errorMessage", "작성자는 3글자 이상 5글자 미만이어야 합니다.");
                response.sendRedirect("write.jsp?pageNum="+pageNum);
                return;
        }

        if (password == null || password.trim().isEmpty() || password.length() < 4 || password.length() >= 16 ||
                !password.matches("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@#$%^&+=]).*$") || !password.equals(confirmPassword)) {
                        request.getSession().setAttribute("errorMessage", "비밀번호는 4글자 이상 16글자 미만, 영문/숫자/특수문자(@#$%^&+=) 포함, 비밀번호 확인과 일치해야 합니다. ");
                        response.sendRedirect("write.jsp?pageNum="+pageNum);
                        return;
        }

        if (title == null || title.trim().isEmpty() || title.length() < 4 || title.length() >= 100) {
                request.getSession().setAttribute("errorMessage", "제목은 4글자 이상 100글자 미만이어야 합니다.");
                response.sendRedirect("write.jsp?pageNum="+pageNum);
                return;
        }

        if (content == null || content.trim().isEmpty() || content.length() < 4 || content.length() >= 2000) {
                request.getSession().setAttribute("errorMessage", "내용은 4글자 이상 2000글자 미만이어야 합니다.");
                response.sendRedirect("write.jsp?pageNum="+pageNum);
                return;
        }


        //dto에 넣기
        dto.setBoard_category(category);
        dto.setBoard_writer(writer);
        dto.setBoard_password(password);
        dto.setBoard_title(title);
        dto.setBoard_content(content);

        //insert 메서드 호출
        dao.insertBoard(dto);

        //list.jsp로 이동
        response.sendRedirect("list.jsp?pageNum="+pageNum);
%>