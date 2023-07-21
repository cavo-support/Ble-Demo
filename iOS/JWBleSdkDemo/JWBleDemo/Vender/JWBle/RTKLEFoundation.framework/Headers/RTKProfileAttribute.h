//
//  RTKProfileAttribute.h
//  RTKLEFoundation
//
//  Created by jerome_gu on 2019/1/7.
//  Copyright © 2019 Realtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTKProfileAttributeKey.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * RTKProfileAttribute在value发生变化时通过RTKProfileAttributeObservation声明的方法进行通知观察者，观察者使用-[RTKProfileAttribute addValueObserver:]注册自己，-[RTKProfileAttribute removeValueObserver:]取消监听
 */
@class RTKProfileAttribute;
@protocol RTKProfileAttributeObservation <NSObject>

- (void)attributeDidUpdateValue:(RTKProfileAttribute *)attr;

@end



@interface RTKProfileAttribute : NSObject {
    @protected
    NSObject *_value;
}
/**
 * Attribute的Key
 */
@property (nonatomic, readonly, nonnull) RTKProfileAttributeKey key;

/* Attribute值对象，实际的类型跟Key相关，详细参考RTKProfileAttributeKey定义 */
@property (nonatomic, readonly, nullable) NSObject *value;

/* Attribute值最后发生更新的时间 */
@property (readonly) NSDate *lastSyncTime;


- (instancetype)initWithAttributeKey:(RTKProfileAttributeKey)key attributeValue:(nullable id<NSCopying>)valueObj NS_DESIGNATED_INITIALIZER;

/* 添加和删除观察者 */
- (void)addValueObserver:(id<RTKProfileAttributeObservation>)observer;
- (void)removeValueObserver:(id<RTKProfileAttributeObservation>)observer;

/* 异步地同步Attribute值 */
- (void)syncWithFinishHandler:(void(^)(BOOL, NSError* _Nullable ))handler;

/* 主动修改Attribute值，只有特定的Attribute支持，详细参考RTKProfileAttributeKey定义 */
- (void)updateValueWithObj:(id)valueObj completion:(void(^)(BOOL, NSError* _Nullable))handler;

@end


@interface RTKProfileAttribute(Protect)

/* Protected method. 只能在子类中调用 */
- (void)internalUpdateValue:(nullable NSObject *)valueObj advertise:(BOOL)yesOrNo;

@end

NS_ASSUME_NONNULL_END
