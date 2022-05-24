//
//  JKBaseModel.h
//  JKBaseModel
//
//  Created by zx_04 on 15/6/27.
//  Copyright (c) 2015年 joker. All rights reserved.
//  github:https://github.com/Joker-King/JKDBModel

#import <Foundation/Foundation.h>

/**
 SQLite五种数据类型
 
 Five data types of SQLite
 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"
#define PrimaryKey  @"primary key"

#define primaryId   @"pk"

@interface JWBleDBModel : NSObject

/**
 主键 id
 
 Primary key id
 */
@property (nonatomic, assign)   int        pk;

/**
 列名
 
 Column name
 */
@property (retain, readonly, nonatomic) NSMutableArray         *columeNames;

/**
 列类型
 
 Column type
 */
@property (retain, readonly, nonatomic) NSMutableArray         *columeTypes;

/** 
 *
 *  获取该类的所有属性
 *
 *  Get all properties of this class
 *
 */
+ (NSDictionary *)getPropertys;

/**
 获取所有属性，包括主键
 
 Get all attributes, including primary key
 */
+ (NSDictionary *)getAllProperties;

/**

 数据库中是否存在表
 
 Whether the table exists in the database
 */
+ (BOOL)isExistInTable;

/**
 
 表中的字段
 
 Fields in the table
 */
+ (NSArray *)getColumns;

/**
 * 保存或更新
 * 如果不存在主键，保存，
 * 有主键，则更新
 *
 * Save or update
 * If there is no primary key, save it,
 * If there is a primary key, it will be updated
 */
- (BOOL)saveOrUpdate;
/**
 * 保存或更新
 * 如果根据特定的列数据可以获取记录，则更新，
 * 没有记录，则保存
 *
 * Save or update
 * If records can be obtained based on specific column data, update,
 * No record, save
 *
 */
- (BOOL)saveOrUpdateByColumnName:(NSString*)columnName AndColumnValue:(NSString*)columnValue;
/**
 保存单个数据
 
 Save a single data
 */
- (BOOL)save;
/**

 批量保存数据
 Save data in bulk
 */
+ (BOOL)saveObjects:(NSArray *)array;
/**
 
 更新单个数据
 Update single data
 */
- (BOOL)update;
/**
 批量更新数据
 Update data in bulk
 */
+ (BOOL)updateObjects:(NSArray *)array;
/**
 通过条件更新数据
 Update data by condition
 */
+ (BOOL)updateObjectsByCriteria:(NSString *)criteria;
/**

 删除单个数据
 Delete individual data
 */
- (BOOL)deleteObject;
/**
 批量删除数据
 Delete data in bulk
 */
+ (BOOL)deleteObjects:(NSArray *)array;
/**
 通过条件删除数据
 Delete data by condition
 */
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria;
/**
 通过条件删除 (多参数）--2
 Delete by condition (multiple parameters)-2
 */
+ (BOOL)deleteObjectsWithFormat:(NSString *)format, ...;
/**
 清空表
 Empty the table
 */
+ (BOOL)clearTable;

/**
 查询全部数据
 Query all data
 */
+ (NSArray *)findAll;

/**
 通过主键查询
 Query by primary key
 */
+ (instancetype)findByPK:(int)inPk;

+ (instancetype)findFirstWithFormat:(NSString *)format, ...;

/**
 查找某条数据
 Find a piece of data
 */
+ (instancetype)findFirstByCriteria:(NSString *)criteria;

+ (NSArray *)findWithFormat:(NSString *)format, ...;

/**
 * 通过条件查找数据
 * 这样可以进行分页查询 @" WHERE pk > 5 limit 10"
 *
 * Find data by condition
 * In this way, you can perform page query @" WHERE pk> 5 limit 10"
 */
+ (NSArray *)findByCriteria:(NSString *)criteria;
/**
 * 创建表
 * 如果已经创建，返回YES
 *
 * *Create table
 * If it has been created, return YES
 */
+ (BOOL)createTable;

#pragma mark - must be override method
/**
 如果子类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写
 
 If there are some properties in the subclass that do not need to create database fields, then this method must be rewritten in the subclass
 */
+ (NSArray *)transients;


@end
