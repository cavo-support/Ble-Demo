package com.wosmart.sdkdemo.model;

import java.nio.channels.SelectableChannel;

public class StyleColor {

    /**
     * 功能编号
     */
    private int id;

    /**
     * 功能描述
     */
    private String colorStr;

    private boolean isSelected;

    public StyleColor() {
    }

    public StyleColor(int id, String colorStr,boolean isSelected) {
        this.id = id;
        this.colorStr = colorStr;
        this.isSelected = isSelected;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getColorStr() {
        return colorStr;
    }

    public void setColorStr(String colorStr) {
        this.colorStr = colorStr;
    }

    public boolean isSelected() {
        return isSelected;
    }

    public void setSelected(boolean selected) {
        isSelected = selected;
    }

    @Override
    public String toString() {
        return "StyleColor{" +
                "id=" + id +
                ", colorStr='" + colorStr + '\'' +
                '}';
    }
}
