/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Arrays;
import java.util.List;

/**
 *
 * @author LAPTOP
 */
public class WordFilter {
    private static final List<String> FILTER_WORDS = Arrays.asList("fuck", "shit", "damn", "bitch");

    // Phương thức để lấy danh sách từ cấm
    public static List<String> getBadWords() {
        return FILTER_WORDS ;
    }

//    public static String filterWords(String text) {
//        String filteredText = text;
//        for (String word : FILTER_WORDS ) {
//            String replacement = "*".repeat(word.length());
//            filteredText = filteredText.replaceAll("(?i)\\b" + word + "\\b", replacement); // Không phân biệt hoa/thường
//        }
//        return filteredText;
//    }
}
