## Android

设置各种自动检测开关

1. 2.0 血压自动监测

    设置开关状态
    ```java
    setBp2Control(ApplicationLayerBp2ControlPacket packet)
    ```

    请求获取开关状态
    ```java
    setBpControlRequest()
    ```

    开关状态返回
    ```java
    onBp2Control(ApplicationLayerBp2ControlPacket packet)
    ```
    ApplicationLayerBp2ControlPacket 描述：

    |    open    |
    |   :---:    |
    |   是否开启  |

2. 3.0 血压自动监测

    ```java
    /**
     * 连续血压3.0采集设置
     * @param enable true-打开连续采集
     * @param interval 间隔，单位分钟
     */
    public boolean setBp3Continuous(boolean enable, int interval)
    ```

    ```java
    /**
     * 获取连续血压3.0采集设置
     */
    public boolean getBp3Continuous()
    ```

    ```java
    /**
     * 连续血压采集参数返回
     */
    public void onBp3Continuous(ApplicationLayerBp3ContinuousPacket bp3ContinuousPacket)
    ```

    ApplicationLayerBp3ContinuousPacket 描述：
    |    switchIsOpen |    time   |
    |     :---:      |     :----:    |
    |    是否开启      | 时间(单位 分钟) |

3. 血糖自动监测

   ```java
   /**
    * 连续血糖采集设置
    * @param enable 是否开启
    * @param interval 间隔，单位分钟
    */
   public boolean setGluContinuous(boolean enable, int interval)
   ```

   ```java
    /**
     * 获取血糖监测开关
     */
    public boolean getGluContinuous()
   ```

   ```java
   /**
    * 用于启用/禁用继续hrp设置
    * @param enable true-打开连续采集
    * @param interval 间隔，单位分钟
    */
   onGluContinueParamRsp(boolean enable, int interval)
   ```

4. 心率自动监测

    ```java
    /**
     * Use to enable/disable the continue hrp set
     * 用于启用/禁用继续hrp设置
     * @param enable true-打开连续采集
     * @param interval 间隔，单位分钟
     */
    public boolean setContinueHrp(boolean enable, int interval)
    ```

    ```java
    /**
     * use to request remote device support hrp param
     * 用于请求远程设备支持hrp参数
     *
     * @return the operate result
     */
    public boolean sendContinueHrpParamRequest()
    ```

    ```java
    /**
     * Use to enable/disable the continue hrp set
     * 用于启用/禁用继续hrp设置
     * @param enable true-打开连续采集
     * @param interval 间隔，单位分钟
     */
    onHrpContinueParamRsp(boolean enable, int interval)
    ```

5. 设置温度自动监测

    ```java
    /**
    * 设置温度监测参数
    *
    * @return the operate result
    */
    public boolean setTemperatureControl(ApplicationLayerTemperatureControlPacket packet)
    ```

    ```java
    /**
     * 用于请求远程设备支持温度设置
     *
     * @return the operate result
     */
    public boolean requestTemperatureSetting()
    ```

    ```java
    /**
     * 温度设置返回
     */
    public void onTemperatureMeasureSetting(ApplicationLayerTemperatureControlPacket packet)
    ```

    ApplicationLayerTemperatureControlPacket 描述：
    |    show |    adjust   | celsiusUnit |
    |   :---: |   :----:    |   :----:    |
    |  是否开  | 温度补偿开关  | 温度显示单位 |
