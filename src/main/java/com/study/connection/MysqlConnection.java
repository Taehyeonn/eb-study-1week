package com.study.connection;

import java.sql.*;

public class MysqlConnection {

    static final String MYSQL_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/ebrainsoft_study";
    static final String USER = "ebsoft";
    static final String PASS = "ebsoft";

    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(MYSQL_DRIVER);
            conn = DriverManager.getConnection(DB_URL,USER,PASS);
        } catch (ClassNotFoundException e) {
            System.out.println("mysql 드라이버 오류" + e.getMessage());
        } catch (SQLException e) {
            System.out.println("mysql 연결 실패" + e.getMessage());
        }
        return conn;
    }

    public void dbClose(Statement stmt, Connection conn) {
        try {
            stmt.close();
            conn.close();
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace();
        }
    }
    public void dbClose(ResultSet rs, Statement stmt, Connection conn) {
        try {
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace();
        }
    }

    public void dbClose(PreparedStatement pstmt, Connection conn) {
        try {
            pstmt.close();
            conn.close();
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace();
        }
    }
    public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try {
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace();
        }
    }
}
