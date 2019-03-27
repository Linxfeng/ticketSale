package com.linxf.common.utils;

import java.security.MessageDigest;

/**
 * MD5加密
 *
 * @author lintao
 * @date 2019/3/27
 */
public class MD5Util {

    public static final String KEY = "D3trAS"; // 密匙

    /**
     * MD5加密，返回32位：小写字母+数字组合
     * @param password
     * @return
     */
    public static String md5(String password) {
        password = password + KEY;
        MessageDigest md5;
        try {
            md5 = MessageDigest.getInstance("MD5");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        char[] charArray = password.toCharArray();
        byte[] byteArray = new byte[charArray.length];

        for (int i = 0; i < charArray.length; i++)
            byteArray[i] = (byte) charArray[i];
        byte[] md5Bytes = md5.digest(byteArray);
        StringBuffer hexValue = new StringBuffer();
        for (int i = 0; i < md5Bytes.length; i++) {
            int val = ((int) md5Bytes[i]) & 0xff;
            if (val < 16) {
                hexValue.append("0");
            }
            hexValue.append(Integer.toHexString(val));
        }
        return hexValue.toString();
    }

//    public static void main(String[] args) {
//        System.out.println(MD5Util.md5(".,.'.l.12!@#$%^&*("));
//    }

}
