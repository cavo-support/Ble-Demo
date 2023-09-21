package com.wosmart.sdkdemo.util.v7_gt7d.action;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.wosmart.sdkdemo.App;
import com.wosmart.sdkdemo.common.BaseActivity;
import com.wosmart.ukprotocollibary.WristbandManager;
import com.wosmart.ukprotocollibary.WristbandManagerCallback;
import com.wosmart.ukprotocollibary.applicationlayer.ApplicationLayerAddressBookPacket;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class AddressBookAction extends BaseActivity {

    public static class Contact {

        public String name;
        public String phone;

        public Contact(String name, String phone) {
            this.name = name;
            this.phone = phone;
        }
    }

    private int sendIndex = 0;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        // 通讯录最多支持设置 10 个，因历史原因，设置，修改，删除需一起全部设置给设备
        // 例如要设置 8 个用户
        List<Contact> contactList = new ArrayList<>();
        for (int i = 0; i < 8; i++) {
            contactList.add(new Contact("name" + i, "phone" + i));
        }

        WristbandManager.getInstance().registerCallback(new WristbandManagerCallback() {

            @Override
            public void onAddressBookToDevice(int state) {
                super.onAddressBookToDevice(state);
                // 只需关注逐条发送的结果，开始和结束命令无需关注结果
                if (state == 2) {
                    // 逐条发送成功
                    if (sendIndex == contactList.size() - 1) {
                        // 全部发送完毕，发送结束命令
                        setAddressBookEnd(contactList.size());
                    } else {
                        // 上一个用户发送成功，现在发送下一个用户
                        sendIndex++;
                        setAddressBook(contactList.get(sendIndex));
                    }
                }
            }
        });

        // 发送开始发送通讯录命令
        setAddressBookStart(contactList.size());

        sendIndex = 0;
        // 紧接着发送用户，建议等返回发送状态后再发送下一个用户，也可直接 for 循环发送所有用户(可能发送速度过快，有失败风险)
        setAddressBook(contactList.get(sendIndex));
    }

    private void setAddressBookStart(int count) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 0：开始发送（要发送的通讯录数据条数）
                // 1：发送结束（要发送的通讯录数据条数）
                // 2：开始发送数据（逐条发送）
                ApplicationLayerAddressBookPacket packet = new ApplicationLayerAddressBookPacket();

                packet.setSendState(0);
                packet.setAddressLen(count);

                WristbandManager.getInstance().setAddressBookToDevice(packet);
            }
        }).start();

    }

    private void setAddressBook(Contact contact) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 0：开始发送（要发送的通讯录数据条数）
                // 1：发送结束（要发送的通讯录数据条数）
                // 2：开始发送数据（逐条发送）
                ApplicationLayerAddressBookPacket packet = new ApplicationLayerAddressBookPacket();
                packet.setSendState(2);

                packet.setAddressName(contact.name);
                packet.setAddressPhone(contact.phone);
                WristbandManager.getInstance().setAddressBookToDevice(packet);
            }
        }).start();

    }

    private void setAddressBookEnd(int count) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 0：开始发送（要发送的通讯录数据条数）
                // 1：发送结束（要发送的通讯录数据条数）
                // 2：开始发送数据（逐条发送）
                ApplicationLayerAddressBookPacket packet = new ApplicationLayerAddressBookPacket();

                packet.setSendState(1);
                packet.setAddressLen(count);

                WristbandManager.getInstance().setAddressBookToDevice(packet);
            }
        }).start();

    }
}
