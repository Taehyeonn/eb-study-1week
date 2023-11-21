package com.study.board;

import java.sql.Timestamp;

public class BoardDTO {

    private long board_id;
    private String board_category;
    private String board_writer;
    private int board_password;
    private String board_title;
    private String board_content;
    private long board_view_count;
    private Timestamp board_registration_date;
    private Timestamp board_modification_date;

    public long getBoard_id() {
        return board_id;
    }

    public void setBoard_id(long board_id) {
        this.board_id = board_id;
    }

    public String getBoard_category() {
        return board_category;
    }

    public void setBoard_category(String board_category) {
        this.board_category = board_category;
    }

    public String getBoard_writer() {
        return board_writer;
    }

    public void setBoard_writer(String board_writer) {
        this.board_writer = board_writer;
    }

    public int getBoard_password() {
        return board_password;
    }

    public void setBoard_password(int board_password) {
        this.board_password = board_password;
    }

    public String getBoard_title() {
        return board_title;
    }

    public void setBoard_title(String board_title) {
        this.board_title = board_title;
    }

    public String getBoard_content() {
        return board_content;
    }

    public void setBoard_content(String board_content) {
        this.board_content = board_content;
    }

    public long getBoard_view_count() {
        return board_view_count;
    }

    public void setBoard_view_count(long board_view_count) {
        this.board_view_count = board_view_count;
    }

    public Timestamp getBoard_registration_date() {
        return board_registration_date;
    }

    public void setBoard_registration_date(Timestamp board_registration_date) {
        this.board_registration_date = board_registration_date;
    }

    public Timestamp getBoard_modification_date() {
        return board_modification_date;
    }

    public void setBoard_modification_date(Timestamp board_modification_date) {
        this.board_modification_date = board_modification_date;
    }
}
