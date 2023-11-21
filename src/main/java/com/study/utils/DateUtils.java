package com.study.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateUtils {
    public static String getStartDate() {
        LocalDate currentDate = LocalDate.now();
        LocalDate oneYearAgo = currentDate.minusYears(1);
        return oneYearAgo.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }

    public static String getEndDate() {
        LocalDate currentDate = LocalDate.now();
        return currentDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }
}