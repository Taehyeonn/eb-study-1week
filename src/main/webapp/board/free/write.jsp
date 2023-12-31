<%@ page import="com.study.dao.CategoryDAO" %>
<%@ page import="com.study.dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    //category 불러오기
    CategoryDAO cateDAO = new CategoryDAO();
    List<CategoryDTO> cateList = cateDAO.getCategoryList();

    String pageNum = (request.getParameter("pageNum") != null) ? request.getParameter("pageNum") : "1";
//    String status = "";
//    if (request.getParameter("status") != null) {
//        status = request.getParameter("status");
//    }
//    String errorMessage = (String) request.getAttribute("errorMessage");
//    String errorMessage = (String) request.getSession().getAttribute("errorMessage");

    String errorMessage = (String) session.getAttribute("errorMessage");
    System.out.println("errorMessage = " + errorMessage);




%>

<html>
<head>
    <title>Title</title>
    <script>
        function writeValidation() {
            let category = document.getElementById("category").value;
            let writer = document.getElementById("writer").value;
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;
            let title = document.getElementById("title").value;
            let content = document.getElementById("content").value;
            // let password = document.getElementById("password").value; 파일

            if (category === "" || writer === "" || password === "" || confirmPassword === "" || title === "" || content === "") {
                alert("필수 항목을 입력해주세요.");
                return false; // 폼 제출 중지
            }

            if (password !== confirmPassword) {
                alert("비밀번호가 다릅니다.");
                return false;
            }
        }

    </script>
</head>
<body>
<h1>게시글 추가</h1>

<%-- 유효성 검사 실패시 오류 메세지 --%>
<% if (errorMessage != null) { %>
<h2><%= errorMessage %></h2>
<% }
    session.removeAttribute("errorMessage"); %>

    <form action="writeAction.jsp?pageNum=<%= pageNum %>" method="post" onsubmit="return writeValidation()" >
        <label for="category">카테고리:</label>
        <select name="category" id="category">
            <option value="" disabled selected>카테고리 선택</option>
            <%
                for(CategoryDTO dto : cateList) {
            %>
            <option value="<%= dto.getCate_name() %>"><%= dto.getCate_name() %></option>
            <%
                }
            %>
        </select>
        <br>
        <label for="writer">작성자:</label>
        <input type="text" name="writer" id="writer">
        <br>
        <label for="password">비밀번호:</label>
        <input type="password" name="password" id="password" placeholder="비밀번호">
        <br>
        <label for="confirmPassword">비밀번호 확인:</label>
        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="비밀번호 확인">
        <br>
        <label for="title">제목:</label>
        <input type="text" name="title" id="title">
        <br>
        <label for="content">내용:</label>
        <textarea name="content" id="content" rows="5"></textarea>
        <br>
        <label for="file">파일 첨부:</label>
        <input type="file" name="file" id="file">
        <br>
        <button type="button" onclick="location.href='list.jsp?pageNum<%= pageNum %>'">취소</button>
        <input type="submit" id="submitButton" value="글쓰기">

    </form>
</body>
</html>