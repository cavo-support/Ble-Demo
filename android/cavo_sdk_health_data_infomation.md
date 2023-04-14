## Android

健康数据有以下十种类型

1. 步数运动数据 

    ```java
    onStepDataReceiveIndication(ApplicationLayerStepPacket packet)
    ```

    ApplicationLayerStepPacket 描述：

    |    Year    |    Month   |     Day    |    ItemCount   |   StepsItems  |
    |   :---:    |   :----:   |   :-----:  |     :----:     |     :----:    |
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 当天步数数据项总和 | 步数详情集合 |

    ApplicationLayerStepItemPacket 描述:

    |  StepCount  |   Calory  |   Distance  |    Offset   |   Mode  |  ActiveTime  |
    |   :---:     |   :----:  |   :-----:   |    :----:   |  :----: |   :----:     |
    |    步数     |   卡路里  |     距离    | 从每天0点开始，每15分钟偏移 +1 | |  |

2. 其它运动数据 

    ```java
    onSportDataReceiveIndication(ApplicationLayerSportPacket packet)
    ```

    ApplicationLayerSportPacket 描述：

    |    Year    |    Month   |     Day    |    ItemCount   |   SportItems  |
    |   :---:    |   :----:   |   :-----:  |     :----:     |     :----:    |
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 当天运动数据项总和 | 运动详情集合 |
   
    ApplicationLayerSportItemPacket 描述：

    |  minutes    | seconds | sportModel | sportMinute | sportSecond | pauseCount | pauseMinute | pauseSecond | steps | distance | calories | respirationRate | respirationRateMinute| rateHigh | rateAvg | rateLow |
    |  :-------:  |  :----: |  :-----:   |    :----:   |    :----:   |   :----:   |    :----:   |    :----:   | :---: |  :----:  |  :----:  |       :----:    |        :----:        |  :----:  |  :----  |  :----: |
    | 运动开始分钟  | 运动开始秒数  | 运动模式 | 运动分钟 | 运动秒数 | 暂停次数 | 暂停分钟 | 暂停秒数 | 步数 | 距离 | 卡路里 | 呼吸心率(仅呼吸训练)  | 呼吸分钟(仅呼吸训练) | 最高心率 | 平均心率 | 最低心率 | 

    sportModel 运动模式描述：

    | value |   定义    |  中文  |
    | :---: |   :--:    |  :--:  |
    | 0x00  | run       |  跑步  |
    | 0x01  | climb     |  登山  |
    | 0x02  | football  |  足球  |
    | 0x03  | cycle     |  骑行  |
    | 0x04  | rope      |  跳绳  |
    | 0x05  | RunOutDoor| 户外跑步 |
    | 0x06  |RideOutDoor| 户外骑车 |
    | 0x07  |WalkOutDoor| 户外徒步 |
    | 0x08  | RunInDoor | 室内跑步 |
    | 0x09  |   HIIT    | 自由训练 |
    | 0x0A  |   plank   | 平板支撑 |
    | 0x0B  |  walk     |  健走    |
    | 0x0C  | pranayama | 呼吸训练 |
    | 0x0D  |   yoga    | 瑜伽 |
    | 0x0E  |  hiking   | 徒步 |
    | 0x0F  |  spinning | 动感单车 |
    | 0x10  |  rowing   | 划船机 |
    | 0x11  |  stepper  | 踏步机 |
    | 0x12  | elliptical| 椭圆机 |
    | 0x13  | basketball| 篮球 |
    | 0x14  |  tennis   | 网球 |
    | 0x15  | badminton | 羽毛球 |
    | 0x16  | baseball  | 棒球 |
    | 0x17  |   rugby   | 橄榄球 |

3. 睡眠数据 

    ```java
    onSleepDataReceiveIndication(ApplicationLayerSleepPacket packet)
    ```

    ApplicationLayerSleepPacket 描述：

    |    Year    |    Month   |     Day    |    ItemCount   |   SleepItems  |
    |   :---:    |   :----:   |   :-----:  |     :----:     |     :----:    |
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 当天睡眠数据项总和 | 睡眠详情集合 |
   
    ApplicationLayerSleepItemPacket 描述：

    |    Minutes    |    Mode   |
    |     :---:     |   :----:  | 
    | 从当天的0点开始的分钟数<br>如1440，即为当天的24点 | 睡眠模式 <br> 0x01:浅睡 <br> 0x02:深睡 <br>0x03:退出睡眠 |

4. 心率数据

    ```java
    onHrpDataReceiveIndication(ApplicationLayerHrpPacket packet);
    ```

    ApplicationLayerHrpPacket 描述：

    |    Year    |    Month   |     Day    |    ItemCount   |   HrpItems  |
    |   :---:    |   :----:   |   :-----:  |     :----:     |    :----:   |
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 当天心率数据项总和 | 心率详情集合 |
   
    ApplicationLayerHrpItemPacket 描述：

    |    Minutes    |    SequenceNum  | Value | Temperature | WearStatus | AdjustStatus |  AnimationStatus | TempOriginValue | 
    |     :---:     |      :----:     | :---: |    :---:    |   :---:    |    :---:     |       :---:      |       :---:     |
    | 从当天的0点开始的分钟数<br>如1440，即为当天的24点 | 序列号 | 心率值 | 温度值 | 佩戴状态，只与温度相关 | 补偿状态，只与温度相关 | 动画状态 | 原始值 |

5. 心率数据批量返回

    ```java
    onRateList(ApplicationLayerRateListPacket packet);
    ```

    ApplicationLayerRateListPacket 批量数据只包含心率详情集合
   
    ApplicationLayerRateItemPacket 描述：

    |    Year    |    Month   |     Day    |    ItemCount   |    Minutes    |    SequenceNum  | Value | Temperature | WearStatus | AdjustStatus |  AnimationStatus | TempOriginValue | 
    |   :---:    |   :----:   |   :-----:  |     :----:     |     :---:     |      :----:     | :---: |    :---:    |   :---:    |    :---:     |       :---:      |       :---:     |
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 当天心率数据项总和 | 从当天的0点开始的分钟数<br>如1440，即为当天的24点 | 序列号 | 心率值 | 温度值 | 佩戴状态，只与温度相关 | 补偿状态，只与温度相关 | 动画状态 | 原始值 |

6. 心率变异性数据

    ```java
    onRtkHrvDataRsp(ApplicationLayerRtkHrvPacket packet);
    ```

    ApplicationLayerRtkHrvPacket 描述：
    |    dateType   |    time   |   hrvValue  |
    |     :---:     |   :----:  |    :----:   | 
    | 数据类型：1为表示HRV | 从1970-01-01 00:00:00至今的时间戳 | HRV的值 | 

7. 血压数据 

    ```java
    onBpDataReceiveIndication(ApplicationLayerBpPacket packet)
    ```

    ApplicationLayerBpPacket 描述：

    |    Year    |    Month   |     Day    |    ItemCount   |   BpItems  |
    |   :---:    |   :----:   |   :-----:  |     :----:     |     :----:    |
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 当天血压数据项总和 | 血压详情集合 |
   
    ApplicationLayerBpItemPacket 描述：

    |    Minutes    |    SequenceNum  | Value | LowValue | HighValue | 
    |     :---:     |      :----:     | :---: |   :---:  |  :---:    | 
    | 从当天的0点开始的分钟数<br>如1440，即为当天的24点 | 序列号 | 心率值 | 最低血压 | 最高血压 |

8. 血压数据批量返回

    ```java
    onBpList(ApplicationLayerBpListPacket packet)
    ```

    ApplicationLayerBpListPacket 批量数据只包含血压详情集合
   
    ApplicationLayerBpListItemPacket 描述：

    |    Year    |    Month   |     Day    |    ItemCount   |    Minutes    |    SequenceNum  | LowValue | HighValue | 
    |   :---:    |   :----:   |   :-----:  |     :----:     |     :---:     |      :----:     |   :---:  |  :---:    |  
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 当天血压数据项总和 | 从当天的0点开始的分钟数<br>如1440，即为当天的24点 | 序列号 | 最低血压 | 最高血压 |

9. 血氧数据

    ```java
    onSpo2DataReceive(ApplicationLayerSpo2Packet packet);
    ```
   
    ApplicationLayerSpo2Packet 描述：

    |    Year    |    Month   |     Day    |    Minutes    |    SequenceNum  | CurValue | HighValue | LowValue |
    |   :---:    |   :----:   |   :-----:  |     :---:     |      :----:     |   :---:  |   :---:   |   :---:  |
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 从当天的0点开始的分钟数<br>如1440，即为当天的24点 | 序列号 | 当前血氧值 | 最高血氧值 | 最低血氧值 |

10. 血糖数据

    ```java
    onGluDataRes(ApplicationLayerGLUPacket packet);
    ```
   
    ApplicationLayerGLUPacket 描述：

    |    Year    |    Month   |     Day    |    Minutes    |    Second  | GluValue | Others |
    |   :---:    |   :----:   |   :-----:  |     :---:     |    :----:  |   :---:  |  :---: | 
    |有效值 0-63 从2000年开始，13表示2013年|有效值 1~12 |有效值 1~31 | 从当天的0点开始的分钟数<br>如1440，即为当天的24点 | 秒数 | 血糖值 | 其它 |