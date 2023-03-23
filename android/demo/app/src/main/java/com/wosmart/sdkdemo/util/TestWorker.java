package com.wosmart.sdkdemo.util;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import com.wosmart.ukprotocollibary.WristbandManager;


public class TestWorker extends Worker {

    private Context mContext;

    public TestWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
        this.mContext = context;
    }

    @NonNull
    @Override
    public Result doWork() {
        Log.d("TestWorker","thread 1 id = "+Thread.currentThread().getId() + ", isConnect = " +WristbandManager.getInstance(mContext).isConnect());
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Log.d("TestWorker","thread 2 id = "+Thread.currentThread().getId() + ", isConnect = " +WristbandManager.getInstance(mContext).isConnect());
        return Result.success();
    }


}
