package com.wosmart.sdkdemo.model;

public class Function {

    /**
     * 功能编号
     */
    private int id;

    /**
     * 功能描述
     */
    private String functionStr;

    public Function() {
    }

    public Function(int id, String functionStr) {
        this.id = id;
        this.functionStr = functionStr;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFunctionStr() {
        return functionStr;
    }

    public void setFunctionStr(String functionStr) {
        this.functionStr = functionStr;
    }

    @Override
    public String toString() {
        return "Function{" +
                "id=" + id +
                ", functionStr='" + functionStr + '\'' +
                '}';
    }
}
