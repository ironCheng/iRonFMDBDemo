//
//  iRonFMDB.m
//  iRonFMDBDemo
//
//  Created by iRonCheng on 2017/10/13.
//  Copyright © 2017年 iRonCheng. All rights reserved.
//

#import "iRonFMDB.h"
#import "FMDB.h"

static FMDatabase *dataBase = nil;

@implementation iRonFMDB

+ (BOOL)databaseWithDBName:(NSString *)dbName {
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径  xxx.sqlite
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",dbName]];
    
    // TODO: 每次都重新初始化数据库，根据情况修改
    dataBase = [FMDatabase databaseWithPath:filePath];
    
    if (![dataBase open]) {
        NSLog(@"open database failure.");
        return NO;
    }
    
    return YES;
}

// 创建数据表
+ (BOOL)createTable:(NSString *)tableName withPrimaryKey:(NSString *)primaryKey {
    
    // 初始化数据表 参数可自定义
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number'VARCHAR(255)) ",tableName,primaryKey];
    
    BOOL res = [dataBase executeUpdate:sql];
    
    if (!res) {
#if ENABLED_SQL_ERROR_LOG
        NSLog(@"DB CREATE TABLE %@(%@)", tableName, [database lastErrorMessage]);
#endif
    }
    
    return res;
}

+ (void)closeDatabase {
    
    if (dataBase) {
        [dataBase close];
        dataBase = nil;
    }
}


+ (id)selectAllFromTable:(NSString *)tableName withColumn:(NSString *)columnName
{
    FMResultSet *res = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ ",tableName]];
    NSMutableArray *array = [NSMutableArray array];
    
    while ([res next]) {
        /*
         stringForColumn
         doubleForColumn
         ...
         */
        NSString * string = [res stringForColumn:columnName];
        [array addObject:string];
    }
    
    return array;
}

+ (BOOL)insertIntoTable:(NSString *)tableName withParam:(NSDictionary *)dict
{
    BOOL res = [dataBase executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(person_id,person_name,person_age,person_number)VALUES(?,?,?,?)",tableName],dict[@"id"],dict[@"name"],dict[@"age"],dict[@"number"]];
    
    return res;
}

+ (BOOL)delete:(NSString *)rowId fromTable:(NSString *)tableName {
    
    BOOL res = [dataBase executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE id = ?",tableName],rowId];
    return res;
}


@end
