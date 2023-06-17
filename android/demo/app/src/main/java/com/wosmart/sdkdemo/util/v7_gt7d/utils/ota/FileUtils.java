package com.wosmart.sdkdemo.util.v7_gt7d.utils.ota;

import android.content.Context;
import android.os.Build;
import android.os.Environment;
import android.util.Log;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileUtils {

    private static final String TAG = "FileUtils";

    /**
     * 递归创建文件夹
     *
     * @param file
     * @return 创建失败返回""
     */
    public static String createFile(File file) {
        try {
            if (file.getParentFile().exists()) {
                Log.i(TAG, "----- 创建文件" + file.getAbsolutePath());
                file.createNewFile();
                return file.getAbsolutePath();
            } else {
                createDir(file.getParentFile().getAbsolutePath());
                file.createNewFile();
                Log.i(TAG, "----- 创建文件" + file.getAbsolutePath());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 创建根缓存目录
     *
     * @return
     */
    public static String createRootPath(Context context) {
        String cacheRootPath = "";
        if (Build.VERSION.SDK_INT <= 28) {
            if (isSdCardAvailable()) {
                cacheRootPath = context.getExternalCacheDir().getPath();
            } else {
                cacheRootPath = context.getCacheDir().getPath();
            }
        } else {
            File[] medias = context.getExternalMediaDirs();
            if (medias != null && medias.length > 0) {
                cacheRootPath = medias[0].getPath();
            } else {
                cacheRootPath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).getPath() + "/WoFit/Image/";
            }
        }
//        cacheRootPath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).getPath()+"/WoFit/Image";
        createDir(cacheRootPath);
        return cacheRootPath;
    }

    /**
     * 递归创建文件夹
     *
     * @param dirPath
     * @return 创建失败返回""
     */
    public static String createDir(String dirPath) {
        try {
            File file = new File(dirPath);
            if (file.getParentFile().exists()) {
                Log.i(TAG, "----- 创建文件夹" + file.getAbsolutePath());
                file.mkdir();
                return file.getAbsolutePath();
            } else {
                createDir(file.getParentFile().getAbsolutePath());
                Log.i(TAG, "----- 创建文件夹" + file.getAbsolutePath());
                file.mkdir();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dirPath;
    }

    public static boolean isSdCardAvailable() {
        return Environment.MEDIA_MOUNTED.equals(Environment.getExternalStorageState());
    }

    public static String getWoFitCacheFilePath(Context context) {
        if (context == null) {
            return "";
        }
        String fileDir = context.getCacheDir().getAbsolutePath() + "/WoFit/File/";
        File file = new File(fileDir);
        if (!file.exists()) {
            file.mkdirs();
        }
        return fileDir;
    }

    public static void saveFile(byte[] data, File txtFile) {
        FileOutputStream foss = null;
        BufferedOutputStream fos = null;
        try {
            foss = new FileOutputStream(txtFile);
            fos = new BufferedOutputStream(foss);
            for (int i = 0; i < data.length - 1; i++) {
                // 替换掉盘符路径(E:) 以冒号作为判断改字节是否代表一个盘符
//                if (content[i] == bSource &amp;&amp; content[i + 1] == colon) {
//                    content[i] = bTarget;
//                }
                fos.write(data[i]);
            }

            fos.write(data[data.length - 1]); // 写入最后一个字节

            fos.flush();
//            return true;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != foss) {
                    foss.close();
                }
                if (null != fos) {
                    fos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


}
