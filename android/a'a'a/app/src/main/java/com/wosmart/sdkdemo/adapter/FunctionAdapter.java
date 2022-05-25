package com.wosmart.sdkdemo.adapter;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.model.Function;

import java.util.List;

public class FunctionAdapter extends RecyclerView.Adapter {

    private Context context;
    private List<Function> functions;
    private onItemClickListener listener;

    public FunctionAdapter(Context context, List<Function> functions) {
        this.context = context;
        this.functions = functions;
    }

    public void setListener(onItemClickListener listener) {
        this.listener = listener;
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        return new FunctionHolder(LayoutInflater.from(context).inflate(R.layout.view_function_item, null));
    }

    @Override
    public void onBindViewHolder(@NonNull final RecyclerView.ViewHolder viewHolder, int i) {
        final Function function = functions.get(i);
        ((FunctionHolder) viewHolder).tv_function.setText(function.getFunctionStr());
        ((FunctionHolder) viewHolder).rl_function.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (null != listener) {
                    listener.onItemClick(function.getId());
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return null == functions ? 0 : functions.size();
    }

    private class FunctionHolder extends RecyclerView.ViewHolder {
        private RelativeLayout rl_function;
        private TextView tv_function;

        public FunctionHolder(@NonNull View itemView) {
            super(itemView);
            rl_function = itemView.findViewById(R.id.rl_function);
            tv_function = itemView.findViewById(R.id.tv_function);
        }
    }

    public interface onItemClickListener {
        void onItemClick(int pos);
    }
}
