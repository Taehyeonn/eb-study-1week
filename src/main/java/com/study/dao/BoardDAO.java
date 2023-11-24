package com.study.dao;

import com.study.connection.MysqlConnection;
import com.study.dto.BoardDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

    MysqlConnection mysqlConnection = new MysqlConnection();

    //게시글 총 갯수
    public int getTotalCount() {

        int totalCount = 0;
        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select count(*) from board";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("getTotalCount 에러 = " + e.getMessage());
        } finally {
            mysqlConnection.dbClose(rs, pstmt, conn);
        }

        return totalCount;
    }

    //특정 게시글 내용 불러오기
    public BoardDTO getData(String boardId) {
        BoardDTO dto = new BoardDTO();
        String sql = "select * from board where board_id=?";

        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, boardId);
            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto.setBoard_id(rs.getInt("board_id"));
                dto.setBoard_category(rs.getString("board_category"));
                dto.setBoard_title(rs.getString("board_title"));
                dto.setBoard_writer(rs.getString("board_writer"));
                dto.setBoard_password(rs.getString("board_password"));
                dto.setBoard_content(rs.getString("board_content"));
                dto.setBoard_registration_date(rs.getTimestamp("board_registration_date"));
                dto.setBoard_modification_date(rs.getTimestamp("board_modification_date"));
                dto.setBoard_view_count(rs.getInt("board_view_count"));
            }
        } catch (SQLException e) {
            System.out.println("getData 오류"+e.getMessage());
        } finally {
            mysqlConnection.dbClose(rs, pstmt, conn);
        }
        return dto;
    }

    //조회수 증가
    public void increaseViewCount(String boardId) {
        String sql= "update board set board_view_count = board_view_count + 1 where board_id=?";

        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt = null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, boardId);
            pstmt.execute();
        } catch (SQLException e) {
            System.out.println("increaseViewCount 오류"+e.getMessage());
        } finally {
            mysqlConnection.dbClose(pstmt, conn);
        }
    }

    //글 작성
    public void insertBoard(BoardDTO dto) {
        String sql = "insert into board values(default, ?, ?, ?, ?, ?, default, default, default)";

        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt=null;

        try {
            pstmt = conn.prepareStatement(sql);

            //바인딩
            pstmt.setString(1, dto.getBoard_category());
            pstmt.setString(2, dto.getBoard_writer());
            pstmt.setString(3, dto.getBoard_password());
            pstmt.setString(4, dto.getBoard_title());
            pstmt.setString(5, dto.getBoard_content());
            pstmt.execute();

        } catch (SQLException e) {
            System.out.println("insertBoard 오류"+e.getMessage());
        } finally {
            mysqlConnection.dbClose(pstmt, conn);
        }
    }

    //삭제
    public void deleteBoard(String boardId) {

        String sql="delete from board where board_id=?";

        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt=null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, boardId);
            pstmt.execute();
            System.out.println("딜리트 완");
        } catch (SQLException e) {
            System.out.println("deleteBoard 오류"+e.getMessage());
        } finally {
            mysqlConnection.dbClose(pstmt, conn);
        }
    }

    public boolean checkPassword(String boardId, String userPassword) {

        System.out.println("BoardDAO.checkPassword");

        String sql="select board_password from board where board_id=?";

        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt=null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, boardId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String dbPassword = rs.getString("board_password");
                    return dbPassword.equals(userPassword);
                }
            }
        } catch (SQLException e) {
            System.out.println("checkPassword 오류"+e.getMessage());
        } finally {
            mysqlConnection.dbClose(pstmt, conn);
        }
        return false;
    }


    //수정
    public void modifyBoard(String BoardId, BoardDTO dto) {

        String sql="update board set board_writer=?, board_title=?, board_content=?, board_modification_date = now() where board_id=?";

        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt=null;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getBoard_writer());
            pstmt.setString(2, dto.getBoard_title());
            pstmt.setString(3, dto.getBoard_content());
            pstmt.setString(4, BoardId);

            pstmt.execute();
        } catch (SQLException e) {
            System.out.println("modifyBoard 오류"+e.getMessage());
        } finally {
            mysqlConnection.dbClose(pstmt, conn);
        }
    }

    //페이징
    public List<BoardDTO> selectList(int startRow, int listLimit, String text){

        List<BoardDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM board " +
                "WHERE board_title LIKE ? " +
                "ORDER BY board_registration_date DESC LIMIT ?, ?";

        Connection conn = mysqlConnection.getConnection(); // 연결
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try {
            pstmt = conn.prepareStatement(sql); // sql준비

            pstmt.setString(1, "%" + text + "%");
            pstmt.setInt(2, startRow);
            pstmt.setInt(3, listLimit);

            rs = pstmt.executeQuery(); // sql문 실행

            while(rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setBoard_id(rs.getInt("board_id"));
                dto.setBoard_category(rs.getString("board_category"));
                dto.setBoard_title(rs.getString("board_title"));
                dto.setBoard_writer(rs.getString("board_writer"));
                dto.setBoard_content(rs.getString("board_content"));
                dto.setBoard_registration_date(rs.getTimestamp("board_registration_date"));
                dto.setBoard_modification_date(rs.getTimestamp("board_modification_date"));
                dto.setBoard_view_count(rs.getInt("board_view_count"));
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("selectList 오류"+e.getMessage());
        } finally {
            mysqlConnection.dbClose(rs, pstmt, conn);
            System.out.println("db 종료 성공");
        }

        return list;
    }




    //검색 기능
//    public List<BoardDTO> searchList(String start, String end, String category, String text) {
//
//        List<BoardDTO> list = new ArrayList<>();
//        Connection conn = mysqlConnection.getConnection();
//        PreparedStatement pstmt = null;
//        ResultSet rs = null;
////        String sql = "SELECT * FROM board WHERE 등록일 >= ? AND 등록일 <= ? AND 카테고리 = ? AND 제목 LIKE ?";
//        String sql = "SELECT * FROM board"
//                + "WHERE "
//                + "    (board_registration_date >= ? AND board_registration_date <= ?)"
//                + "    AND board_category = ?"
//                + "    AND (board_title LIKE ? OR board_writer LIKE ? OR board_content LIKE ?)";
//
//        try {
//            pstmt = conn.prepareStatement(sql);
//
//            pstmt.setString(1, start);
//            pstmt.setString(2, end);
//            pstmt.setString(3, category);
//            pstmt.setString(4, "%" + text + "%");
//            pstmt.setString(5, "%" + text + "%");
//            pstmt.setString(6, "%" + text + "%");
//            pstmt.execute();
//
//            rs = pstmt.executeQuery();
//            while (rs.next()) {
//                BoardDTO dto = new BoardDTO();
//                dto.setBoard_id(rs.getInt("board_id"));
//                dto.setBoard_category(rs.getString("board_category"));
//                dto.setBoard_title(rs.getString("board_title"));
//                dto.setBoard_writer(rs.getString("board_writer"));
//                dto.setBoard_content(rs.getString("board_content"));
//                dto.setBoard_registration_date(rs.getTimestamp("board_registration_date"));
//                dto.setBoard_modification_date(rs.getTimestamp("board_modification_date"));
//                dto.setBoard_view_count(rs.getInt("board_view_count"));
//                list.add(dto);
//                System.out.println("searchList 성공");
//            }
//
//        } catch (SQLException e) {
//            System.out.println("searchList 에러 = " + e.getMessage());
//        } finally {
//            mysqlConnection.dbClose(rs, pstmt, conn);
//            System.out.println("searchList 종료 성공");
//        }
//
//        return list;
//    }





}
