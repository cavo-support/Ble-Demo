package com.wosmart.sdkdemo.util.v7_gt7d.utils.ota;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.RectF;
import android.graphics.Shader;
import android.text.TextUtils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

public class BitmapUtils {

    /**
     * 将bitmap压缩为指定大小
     */
    public static Bitmap transImage(Bitmap bitmap, int width, int height) {
        return Bitmap.createScaledBitmap(bitmap, width, height, true);
    }

    /**
     * 压缩图片到指定大小
     *
     * @param image
     * @param rqsW
     * @param rqsH
     * @return
     */
    public static Bitmap compressBitmap565(Bitmap image, int rqsW, int rqsH) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        image.compress(Bitmap.CompressFormat.JPEG, 100, out);
        ByteArrayInputStream isBm = new ByteArrayInputStream(out.toByteArray());

        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inSampleSize = computeSampleSize(options, rqsW, rqsW * rqsH);
        options.inPreferredConfig = Bitmap.Config.RGB_565;

        return BitmapFactory.decodeStream(isBm, null, options);
    }

    public static int computeSampleSize(BitmapFactory.Options options, int minSideLength, int maxNumOfPixels) {
        int initialSize = computeInitialSampleSize(options, minSideLength, maxNumOfPixels);
        int roundedSize;
        if (initialSize <= 8) {
            roundedSize = 1;
            while (roundedSize < initialSize) {
                roundedSize <<= 1;
            }
        } else {
            roundedSize = (initialSize + 7) / 8 * 8;
        }
        return roundedSize;
    }

    private static int computeInitialSampleSize(BitmapFactory.Options options, int minSideLength, int maxNumOfPixels) {
        double w = options.outWidth;
        double h = options.outHeight;
        int lowerBound = (maxNumOfPixels == -1) ? 1 : (int) Math.ceil(Math.sqrt(w * h / maxNumOfPixels));
        int upperBound = (minSideLength == -1) ? 128 : (int) Math.min(Math.floor(w / minSideLength), Math.floor(h / minSideLength));
        if (upperBound < lowerBound) {
            // return the larger one when there is no overlapping zone.
            return lowerBound;
        }
        if ((maxNumOfPixels == -1) && (minSideLength == -1)) {
            return 1;
        } else if (minSideLength == -1) {
            return lowerBound;
        } else {
            return upperBound;
        }
    }

    /**
     * 每像素 大端转小端
     *
     * @param origin
     * @return
     */
    public static byte[] reverse(byte[] origin) {
        int len = origin.length / 2;
        byte[] data = new byte[len * 2];
        for (int i = 0; i < len; i++) {
            byte temp = origin[i * 2];
            data[i * 2] = origin[i * 2 + 1];
            data[i * 2 + 1] = temp;
        }
        return data;
    }

    /**
     * 通过BitmapShader实现圆形边框
     *
     * @param bitmap
     * @param outWidth  输出的图片宽度
     * @param outHeight 输出的图片高度
     * @param radius    圆角大小
     * @param boarder   边框宽度
     */
    public static Bitmap getRoundBitmapByShader(Bitmap bitmap, int outWidth, int outHeight, int radius, int boarder, String color) {
        if (bitmap == null) {
            return null;
        }
        int height = bitmap.getHeight();
        int width = bitmap.getWidth();

        float widthScale = outWidth * 1f / width;
        float heightScale = outHeight * 1f / height;

        Matrix matrix = new Matrix();
        matrix.setScale(widthScale, heightScale);
        //创建输出的bitmap
        Bitmap desBitmap = Bitmap.createBitmap(outWidth, outHeight, Bitmap.Config.RGB_565);
        //创建canvas并传入desBitmap，这样绘制的内容都会在desBitmap上
        Canvas canvas = new Canvas(desBitmap);
        Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        //创建着色器
        BitmapShader bitmapShader = new BitmapShader(bitmap, Shader.TileMode.CLAMP, Shader.TileMode.CLAMP);
        //给着色器配置matrix
        bitmapShader.setLocalMatrix(matrix);
        paint.setShader(bitmapShader);
        //创建矩形区域并且预留出border
        RectF rect = new RectF(boarder, boarder, outWidth - boarder, outHeight - boarder);
        //把传入的bitmap绘制到圆角矩形区域内
        canvas.drawRoundRect(rect, radius, radius, paint);

        if (boarder > 0) {
            //绘制boarder
            if(TextUtils.isEmpty(color)){
                color = "#08d3ff";
            }
            Paint boarderPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
            boarderPaint.setColor(Color.parseColor(color));
            boarderPaint.setStyle(Paint.Style.STROKE);
            boarderPaint.setStrokeWidth(boarder);
            canvas.drawRoundRect(rect, radius, radius, boarderPaint);
        }
        return desBitmap;
    }

}
