package com.study.board;

import com.study.connection.MysqlConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

    MysqlConnection mysqlConnection = new MysqlConnection();

    // 게시글 목록 조회 메서드
    public List<BoardDTO> getBoardList() {

        List<BoardDTO> list = new ArrayList<>();
        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM board";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
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
                System.out.println("getBoardList 성공");
            }

        } catch (SQLException e) {
            System.out.println("getBoardList 에러 = " + e.getMessage());
        } finally {
            mysqlConnection.dbClose(rs, pstmt, conn);
            System.out.println("getBoardList 종료 성공");
        }

        return list;
    }

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
            //바인딩
            pstmt.setString(1, boardId);
            //실행
            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto.setBoard_id(rs.getInt("board_id"));
                dto.setBoard_category(rs.getString("board_category"));
                dto.setBoard_title(rs.getString("board_title"));
                dto.setBoard_writer(rs.getString("board_writer"));
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
        BoardDTO dto = new BoardDTO();
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
}
