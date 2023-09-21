package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.model.db.JWHealthDataManager;
import com.wosmart.ukprotocollibary.model.sleep.filter.SleepFilter;
import com.wosmart.ukprotocollibary.model.sleep.filter.SleepInfo;
import com.wosmart.ukprotocollibary.v2.JWHealthDataSearchParams;
import com.wosmart.ukprotocollibary.v2.JWValueCallback;
import com.wosmart.ukprotocollibary.v2.entity.JWSleepInfo;
import com.wosmart.ukprotocollibary.v2.entity.JWStepInfo;

import java.util.List;

public class SleepAction extends BaseActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        // 睡眠自动计量，无需开启或关闭
        // 可从 SDK 数据库中获取指定时间数据，同步完成后数据为最完整状态

        // 指定日期
        JWHealthDataManager.getInstance().getHistorySleepListByDate(2023, 6, 16, new JWValueCallback<List<JWSleepInfo>>() {
            @Override
            public void onSuccess(List<JWSleepInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 指定条件
        // for example, if you want get data at 2022-03-04 07:00 - 2022-03-04 08:00
        // params.timeBegin = 1646348400000
        // params.timePeriod = 3600s * 1000
        JWHealthDataSearchParams searchParams = new JWHealthDataSearchParams();
        searchParams.setUserID("");
        searchParams.setTimeBegin(1646348400000L);
        searchParams.setTimePeriod(3600000);
        JWHealthDataManager.getInstance().getHistorySleepList(searchParams, new JWValueCallback<List<JWSleepInfo>>() {
            @Override
            public void onSuccess(List<JWSleepInfo> data) {

            }

            @Override
            public void onError(int code, String desc) {

            }
        });

        // 支持按年月日过滤无效睡眠数据
        // 建议使用这个，获取昨晚 8 点后到今早的睡眠数据，且会自动过滤无效苏醒类型的数据
        /**
         * 睡眠数据过滤机制
         * <ol>
         * Updated on 22/08/2017.
         * <li>在01:00点前出现清醒时间，且清醒时间（整体在01：00之前）大于等于20min，则删除之前的睡眠数据。(考虑到早睡情况，这条待确认，考虑目前的测试群体)</li>
         * <li>早上05:00点之后（整体在05：00之后），出现清醒时间超过30min，则之后的数据全部清除 </li>
         * <li>01:00之前最晚的一次清醒，如果之前只有清醒和浅睡，则删除该清醒状态以前的睡眠数据</li>
         * <li>05:00之后最早的一次清醒，如果之后只有清醒和浅睡，则删除该清醒状态以后的睡眠数据</li>
         * <li>01:00之前到05:00之后，为清醒状态，所有睡眠数据清除（核心区处于清醒状态）</li>
         *
         * <li>01:00点之前深睡超过1.5小时（整体在01：00之前），则之前的睡眠数据全部清除</li>
         * <li>05:00之后（整体在05：00之后），深睡超过1.5小时，则之后的睡眠数据全部清除</li>
         * <li>01:00和05:00之间(可包含1点或者5点)，深睡超过2.5小时，所有睡眠数据清除</li>
         *
         * <li>什么时候show UI，如何show:
         * ①当前阶段不show，show之前完整的阶段，并按照 1，2，3，4，5，6，7过滤；
         * ②总睡眠（清醒前后的 深睡 + 浅睡 ）时间小于2个小时不show；</li>
         * </ol>
         * Created by bingshanguxue on 22/08/2017.
         */
        SleepInfo sleepInfo = SleepFilter.filterByData(2023, 6, 16);
        // 如果感觉数据不正确，可以重置手表历史数据指标
        // 发送重置数据指令
        WristbandManager.getInstance().setFullSync();
        // 重置成功后，可以再次发起同步，即可拉取全量数据
        WristbandManager.getInstance().sendDataRequest();
    }
}
