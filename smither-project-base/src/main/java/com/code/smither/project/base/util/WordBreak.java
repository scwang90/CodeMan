package com.code.smither.project.base.util;

import java.util.Collection;

public class WordBreak {
    /**
     * 4.单词拆分
     * @param s 非空字符串 s
     * @param wordDict  一个包含非空单词列表的字典 wordDict
     * @return s 是否可以被空格拆分为一个或多个在字典中出现的单词。
     * https://blog.csdn.net/microopithecus/article/details/88291095
     */
    public static boolean wordBreak(String s, Collection<String> wordDict) {
        int n = s.length();
        boolean[] dp = new boolean[n+1];
        dp[0] = true;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < i; j++) {
                if (dp[j] && wordDict.contains(s.substring(j, i))) {
                    dp[i] = true;
                    break;
                }
            }
        }
        return dp[n];

    }
}
