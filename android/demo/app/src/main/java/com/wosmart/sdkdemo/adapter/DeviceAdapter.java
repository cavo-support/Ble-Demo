package com.wosmart.sdkdemo.adapter;

import android.annotation.SuppressLint;
import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.model.SearchResult;

import java.util.List;

public class DeviceAdapter extends RecyclerView.Adapter {

    private Context context;
    private List<SearchResult> devices;
    private onItemClickListener listener;

    public DeviceAdapter(Context context, List<SearchResult> devices) {
        this.context = context;
        this.devices = devices;
    }

    public void setListener(onItemClickListener listener) {
        this.listener = listener;
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        return new DeviceHolder(LayoutInflater.from(context).inflate(R.layout.view_device_item, null));
    }

    @Override
    public void onBindViewHolder(@NonNull final RecyclerView.ViewHolder viewHolder, @SuppressLint("RecyclerView") final int i) {
        SearchResult device = devices.get(i);
        ((DeviceHolder) viewHolder).tv_name.setText(device.getName());
        ((DeviceHolder) viewHolder).tv_mac.setText(device.getAddress());
        ((DeviceHolder) viewHolder).tv_rrsi.setText(device.rssi + "");
        ((DeviceHolder) viewHolder).rl_device.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (null != listener) {
                    listener.onItemClick(i);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return null == devices ? 0 : devices.size();
    }

    private class DeviceHolder extends RecyclerView.ViewHolder {
        private RelativeLayout rl_device;
        private TextView tv_name;
        private TextView tv_mac;
        private TextView tv_rrsi;

        public DeviceHolder(@NonNull View itemView) {
            super(itemView);
            rl_device = itemView.findViewById(R.id.rl_device);
            tv_name = itemView.findViewById(R.id.tv_name);
            tv_mac = itemView.findViewById(R.id.tv_mac);
            tv_rrsi = itemView.findViewById(R.id.tv_rrsi);
        }
    }

    public interface onItemClickListener {
        void onItemClick(int pos);
    }
}
