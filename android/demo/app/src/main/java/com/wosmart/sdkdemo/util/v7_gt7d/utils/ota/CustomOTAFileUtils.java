package com.wosmart.sdkdemo.util.v7_gt7d.utils.ota;

import android.content.Context;
import android.graphics.Bitmap;
import android.os.Build;
import android.util.Log;


import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;

public class CustomOTAFileUtils {

    private static final String TAG = "";


    /**
     * @param context               上下文
     * @param bgBitmap              背景 bitmap
     * @param previewBitmap         预览图 bitmap
     * @param isRound               是否为圆形表盘
     * @param deviceChipType        设备芯片类型 0:C(正常芯片) 1:D(VD版本)
     * @param deviceWidth           设备实际宽度
     * @param deviceHeight          设备实际高度
     * @param previewImgWidth       预览图宽度
     * @param previewImgHeight      预览图高度
     * @param previewImgRadius      预览图圆角
     * @param previewImgBorderWidth 预览图边框宽度
     * @param previewImgBorderColor 预览图边框颜色
     */
    public static String createOTAFile(Context context, Bitmap bgBitmap, Bitmap previewBitmap,
                                       boolean isRound, int deviceChipType, int deviceWidth, int deviceHeight,
                                       int previewImgWidth, int previewImgHeight, int previewImgRadius, int previewImgBorderWidth, String previewImgBorderColor) {
        if (context == null || bgBitmap == null || previewBitmap == null) {
            return null;
        }
        if (isRound) {
            bgBitmap = BitmapUtils.createCircleBitmap(bgBitmap);
            previewBitmap = BitmapUtils.createCircleBitmap(previewBitmap);
        }
        Bitmap bitmap565 = BitmapUtils.transImage(bgBitmap, deviceWidth, deviceHeight);
        bitmap565 = BitmapUtils.compressBitmap565(bitmap565, deviceWidth, deviceHeight);
        int bytes = bitmap565.getByteCount();
        int c = bytes / 4;
        int d = bytes % 4;
        if (d > 0) {
            bytes = (c + 1) * 4;
        }
        ByteBuffer buf = ByteBuffer.allocate(bytes);
        bitmap565.copyPixelsToBuffer(buf);
        byte[] byteArray = buf.array();
        byteArray = BitmapUtils.reverse(byteArray);

        Bitmap preview565 = BitmapUtils.transImage(previewBitmap, previewImgWidth, previewImgHeight);
        preview565 = BitmapUtils.compressBitmap565(preview565, previewImgWidth, previewImgHeight);

        preview565 = BitmapUtils.getRoundBitmapByShader(preview565, previewImgWidth, previewImgHeight, previewImgRadius,
                previewImgBorderWidth, previewImgBorderColor);
        int preViewBytes = preview565.getByteCount();
        int c2 = preViewBytes / 4;
        int d2 = preViewBytes % 4;
        if (d2 > 0) {
            preViewBytes = (c2 + 1) * 4;
        }
        Log.i(TAG, "物理尺寸：width=" + deviceWidth + ", height=" + deviceHeight);

        ByteBuffer preBuf = ByteBuffer.allocate(preViewBytes);
        preview565.copyPixelsToBuffer(preBuf);
        byte[] previewArray = preBuf.array();
        previewArray = BitmapUtils.reverse(previewArray);

        int originLen = byteArray.length;
        int previewLen = previewArray.length;
        Log.i(TAG, "预览图尺寸：width=" + previewImgWidth + ", height = " + previewImgHeight);
        int picLen = originLen + previewLen;
        byte[] picArray = new byte[picLen];
        System.arraycopy(byteArray, 0, picArray, 0, originLen);
        System.arraycopy(previewArray, 0, picArray, originLen, previewLen);
        byte[] imgHeader;
        byte[] mpHeader;
        Log.d(TAG, "deviceChipType=" + deviceChipType);
        if (deviceChipType == 1) {
            imgHeader = ImgHeadUtil.getImgHeaderToVD(picArray);
            mpHeader = ImgHeadUtil.getMpHeaderToVD(picArray);
        } else {
            imgHeader = ImgHeadUtil.getImgHeader(picArray);
            mpHeader = ImgHeadUtil.getMpHeader(picArray);
        }
        int imgLen = imgHeader.length;
        int mpLen = mpHeader.length;

        int len = mpLen + imgLen + picLen;
        int c3 = len / 4;
        int d3 = len % 4;
        if (d3 > 0) {
            len = (c3 + 1) * 4;
        }
        byte[] merge = new byte[len];
        System.arraycopy(mpHeader, 0, merge, 0, mpLen);
        System.arraycopy(imgHeader, 0, merge, mpLen, imgLen);
        System.arraycopy(picArray, 0, merge, mpLen + imgLen, picLen);

        String binFilePath = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            try {
                String fileDir = FileUtils.createRootPath(context);
                File file = new File(fileDir + "/" + System.currentTimeMillis() + "-merge.bin");
                binFilePath = FileUtils.createFile(file);
                Log.d(TAG, "filePath=" + binFilePath);
                FileUtils.saveFile(merge, file);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            try {
                binFilePath = FileUtils.getWoFitCacheFilePath(context) + "merge.bin";
                File file = new File(binFilePath);
                if (file.exists()) {
                    file.delete();
                }
                file.createNewFile();
                FileUtils.saveFile(merge, file);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return binFilePath;
    }


}
