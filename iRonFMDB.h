//
//  iRonFMDB.h
//  iRonFMDBDemo
//
//  Created by iRonCheng on 2017/10/13.
//  Copyright © 2017年 iRonCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iRonFMDB : NSObject

+ (BOOL)databaseWithDBName:(NSString *)dbName;

/* 创建表格 */
+ (BOOL)createTable:(NSString *)tableName withPrimaryKey:(NSString *)primaryKey;

/* 关闭数据库 */
+ (void)closeDatabase;

/* 选择所有 */
+ (id)selectAllFromTable:(NSString *)tableName withColumn:(NSString *)columnName;

/* 插入 */
+ (BOOL)insertIntoTable:(NSString *)tableName withParam:(NSDictionary *)dict;

/* 删除 */
+ (BOOL)delete:(NSString *)rowId fromTable:(NSString *)tableName;

@end
