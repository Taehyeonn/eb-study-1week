package com.study.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateUtils {

    //list.jsp의 date에 들어갈 날짜를 구한다
    public static String getStartDate() {
        LocalDate currentDate = LocalDate.now();
        LocalDate oneYearAgo = currentDate.minusYears(1);
        return oneYearAgo.format(DateTimeFormatter.ISO_LOCAL_DATE); //16:24:02.408
    }

    public static String getEndDate() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }
}