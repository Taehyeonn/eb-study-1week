<%@ page import="com.study.dao.BoardDAO" %>
<%@ page import="com.study.dto.BoardDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <script>
        function valid() {
            let id = document.getElementById("id").value;
            let password = document.getElementById("password").value;

            // 유효성 검사
            if (id === "" || password === "") {
                alert("ID와 비밀번호를 모두 입력해주세요.");
                return false; // 폼 제출 중지
            }

        }
    </script>
</head>
<%
    // 파라미터에서 id 받아오기
    String boardId = request.getParameter("id");
    String pageNum = request.getParameter("pageNum");

    String status = "";
    if (request.getParameter("status") != null) {
        status = request.getParameter("status");
    }

    if (status.isEmpty()) {
        System.out.println("비정상접근");
        response.sendRedirect("list.jsp?pageNum"+pageNum);
    }

    //dao 선언
    BoardDAO dao = new BoardDAO();

    //조회수 증가
    dao.increaseViewCount(boardId);

    //id 해당하는 dto 얻기
    BoardDTO boardDto = dao.getData(boardId);

    //날짜 출력 양식
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<body>
<h1>게시글 수정</h1>

<form action="modifyAction.jsp?id=<%= boardId %>&pageNum=<%= pageNum %>" method="post" onsubmit="return valid()" >
    <span>카테고리:</span>
    <span><%= boardDto.getBoard_category() %></span>
    <br>
    <span>등록일시:</span>
    <span><%= sdf.format(boardDto.getBoard_registration_date()) %></span>
    <br>
    <span>수정일시:</span>
    <span><%= boardDto.getBoard_modification_date() != null ? sdf.format(boardDto.getBoard_modification_date()) : "-" %></span>
    <br>
    <span>조회수:</span>
    <span><%= boardDto.getBoard_view_count() %></span>
    <br>
    <span>카테고리:</span>
    <span><%= boardDto.getBoard_category() %></span>
    <br>
    <label for="writer">작성자:</label>
    <input type="text" name="writer" id="writer" value="<%= boardDto.getBoard_writer() %>">
    <br>
    <label for="password">비밀번호:</label>
    <input type="password" name="password" id="password" placeholder="비밀번호">
    <br>
    <label for="title">제목:</label>
    <input type="text" name="title" id="title" value="<%= boardDto.getBoard_title() %>">
    <br>
    <label for="content">내용:</label>
    <textarea name="content" id="content" rows="5"><%= boardDto.getBoard_content() %></textarea>
    <br>
    <label for="file">파일 첨부:</label>
    <input type="file" name="file" id="file">
    <br>
    <button type="button" onclick="location.href='view.jsp?id=<%= boardId %>&pageNum=<%= pageNum %>'">취소</button>
    <input type="submit" id="submitButton" value="수정">
</form>
</body>
</html>
