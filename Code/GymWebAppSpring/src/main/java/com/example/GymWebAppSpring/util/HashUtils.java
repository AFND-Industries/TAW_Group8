package com.example.GymWebAppSpring.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

/**
 * @author tonib
 */
public class HashUtils {
    /**
     * Hash a string using the SHA-256 algorithm
     * @param s String to be digested
     * @return Digested byte array in a hexadecimal format
     * */
    public static String hashString(String s) {
        byte[] byteArray = s.getBytes(StandardCharsets.UTF_8);
        try{
            byteArray = MessageDigest.getInstance("SHA256").digest(byteArray);
        } catch(Exception e){
            throw new RuntimeException("??? esta excepción no debería saltar");
        }
        String hex = "";

        // Iterating through each byte in the array
        for (byte i : byteArray) {
            hex += String.format("%02X", i);
        }

        return hex;
    }
}
