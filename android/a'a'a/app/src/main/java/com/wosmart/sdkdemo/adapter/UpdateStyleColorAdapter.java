package com.wosmart.sdkdemo.adapter;

import android.annotation.SuppressLint;
import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wosmart.sdkdemo.R;
import com.wosmart.sdkdemo.model.Function;
import com.wosmart.sdkdemo.model.StyleColor;

import java.util.List;

public class UpdateStyleColorAdapter extends RecyclerView.Adapter {

    private Context context;
    private List<StyleColor> styleColors;
    private onItemClickListener listener;

    public UpdateStyleColorAdapter(Context context, List<StyleColor> styleColors) {
        this.context = context;
        this.styleColors = styleColors;
    }

    public void setListener(onItemClickListener listener) {
        this.listener = listener;
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        return new StyleColorHolder(LayoutInflater.from(context).inflate(R.layout.view_style_color_item, null));
    }

    @Override
    public void onBindViewHolder(@NonNull final RecyclerView.ViewHolder viewHolder, @SuppressLint("RecyclerView") final int i) {
        final StyleColor color = styleColors.get(i);
        ((StyleColorHolder) viewHolder).cb_select.setChecked(color.isSelected());
        ((StyleColorHolder) viewHolder).tv_color_num.setText(color.getColorStr());
        ((StyleColorHolder) viewHolder).rl_info.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(((StyleColorHolder) viewHolder).cb_select.isChecked()){

                }else{
                    for (int j = 0; j < styleColors.size(); j++) {
                        if(j == i){
                            color.setSelected(true);
                            styleColors.get(j).setSelected(true);
                            ((StyleColorHolder) viewHolder).cb_select.setChecked(true);
                        }else{
                            styleColors.get(j).setSelected(false);
                        }
                    }
                    notifyDataSetChanged();
                    if (null != listener) {
                        listener.onItemClick(color.getId());
                    }
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return null == styleColors ? 0 : styleColors.size();
    }

    private class StyleColorHolder extends RecyclerView.ViewHolder {
        private RelativeLayout rl_info;
        private CheckBox cb_select;
        private TextView tv_color_num;

        public StyleColorHolder(@NonNull View itemView) {
            super(itemView);
            rl_info = itemView.findViewById(R.id.rl_info);
            cb_select = itemView.findViewById(R.id.cb_select);
            tv_color_num = itemView.findViewById(R.id.tv_color_num);
        }
    }

    public interface onItemClickListener {
        void onItemClick(int pos);
    }
}
