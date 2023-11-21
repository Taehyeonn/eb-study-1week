package com.study.board;

import com.study.connection.MysqlConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // 카테고리 목록 조회 메서드
    public List<CategoryDTO> getCategoryList() {
        MysqlConnection mysqlConnection = new MysqlConnection();
        List<CategoryDTO> cateList = new ArrayList<>();
        Connection conn = mysqlConnection.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM category";

        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CategoryDTO dto = new CategoryDTO();
                dto.setCate_name(rs.getString("cate_name"));
                cateList.add(dto);
                System.out.println("getCategoryList 성공");
            }

        } catch (SQLException e) {
            System.out.println("getCategoryList 에러 = " + e.getMessage());
        } finally {
            mysqlConnection.dbClose(rs, pstmt, conn);
            System.out.println("getCategoryList 종료 성공");
        }

        return cateList;
    }
}
