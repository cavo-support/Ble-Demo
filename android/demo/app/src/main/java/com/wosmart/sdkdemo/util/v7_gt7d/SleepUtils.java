package com.wosmart.sdkdemo.util.v7_gt7d;

public class SleepUtils {

    /**
     * 睡眠质量计算, 方式一
     *
     * @param fall    第⼀段睡眠的时⻓
     * @param deep    深睡分钟数
     * @param all     总睡眠分钟数(深睡+浅睡)
     * @param wakeNum 苏醒次数
     * @return 睡眠质量分 (0 - 1 较差), (2 一般), (3 好), (4 很好), (5 完美)
     */
    public static int getSleepQuality(float fall, float deep, float all, int wakeNum) {
        if (all < 2 * 60) {
            return 0;
        } else {
            int quality = 5;
            if (fall > 60) {
                quality -= 1;
            }
            if (all < 4 * 60) {
                quality -= 1;
            }
            if (deep / all < 0.3f) {
                quality -= 1;
            }
            if (wakeNum > 2) {
                quality -= 1;
            }
            return quality;
        }
    }

    /**
     * 睡眠质量计算，方式二
     *
     * @param all      全部睡眠分钟数(深睡+浅睡)
     * @param deep     深睡分钟数
     * @param awakeNum 苏醒次数
     * @return 睡眠质量分 (0 - 1 较差), (2 一般), (3 好), (4 很好), (5 完美)
     */
    public static int getSleepQuality2(float all, float deep, int awakeNum) {
        float durationParams;
        float deepLowParams;
        float awakeParams;

        if (all >= 14 * 60f) {
            durationParams = 0.7f;
        } else if (all >= 13 * 60f) {
            durationParams = 0.8f;
        } else if (all >= 12 * 60f) {
            durationParams = 0.5f;
        } else if (all >= 11 * 60f) {
            durationParams = 0.9f;
        } else if (all >= 10 * 60f) {
            durationParams = 0.95f;
        } else if (all >= 7 * 60f) {
            durationParams = 1f;
        } else if (all >= 6 * 60f) {
            durationParams = 0.9f;
        } else if (all >= 5 * 60f) {
            durationParams = 0.7f;
        } else if (all >= 4 * 60f) {
            durationParams = 0.6f;
        } else if (all >= 3 * 60f) {
            durationParams = 0.5f;
        } else if (all >= 2 * 60f) {
            durationParams = 0.2f;
        } else {
            durationParams = 0f;
        }

        float deepPercent = deep / all;
        if (deepPercent >= 0.6f) {
            deepLowParams = 0.5f;
        } else if (deepPercent >= 0.5f) {
            deepLowParams = 0.9f;
        } else if (deepPercent >= 0.2f) {
            deepLowParams = 1f;
        } else if (deepPercent >= 0.1f) {
            deepLowParams = 0.7f;
        } else {
            deepLowParams = 0.5f;
        }

        if (awakeNum >= 10) {
            awakeParams = 0.1f;
        } else if (awakeNum >= 9) {
            awakeParams = 0.2f;
        } else if (awakeNum >= 8) {
            awakeParams = 0.3f;
        } else if (awakeNum >= 7) {
            awakeParams = 0.4f;
        } else if (awakeNum >= 6) {
            awakeParams = 0.5f;
        } else if (awakeNum >= 5) {
            awakeParams = 0.6f;
        } else if (awakeNum >= 4) {
            awakeParams = 0.7f;
        } else if (awakeNum >= 3) {
            awakeParams = 0.8f;
        } else {
            awakeParams = 1f;
        }

        return (int) (durationParams * deepLowParams * awakeParams * 5f);
    }

}
