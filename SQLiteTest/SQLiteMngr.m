//
//  SQLiteMngr.m
//  SQLiteTest
//
//  Created by Aizawa Takashi on 2014/04/16.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "SQLiteMngr.h"


@interface SQLiteMngr ()

@property (nonatomic, strong) FMDatabase* db;
@property (nonatomic, strong) NSString* tableName;
@end

@implementation SQLiteMngr

- (void)prepareDBWithDBName:(NSString*)dbFileName
{
    NSString* deFilePath = [self getDocumentDirectoryFilepath:dbFileName];
    NSLog(@"DB file: %@",deFilePath);
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = ([fileManager fileExistsAtPath:deFilePath isDirectory:&isDir] && !isDir);
    BOOL ret;
    NSError* error;
    if( fileExists == NO ){
        NSLog(@"File is not exist.");
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:dbFileName];
        ret = [fileManager copyItemAtPath:defaultDBPath toPath:deFilePath error:&error];
        if(!ret){
            // コピー失敗
            // 本当はエラー処理
        }
    }else{
        NSLog(@"File is exist.");
    }
    _db = [FMDatabase databaseWithPath:dbFileName];
    if( [_db open] == NO ){
        NSLog(@"DB open error");
    }
    [_db close];
}

- (BOOL)openDB
{
    BOOL error = NO;
    if( [_db open] == NO ){
        error = YES;
    }
    return error;
}

- (void)closeDB
{
    [_db close];
}

// [
//      {"name":"nameString", "type:"TEXT"}
//      {"name":"nameString", "type:"integer"}
//      {"name":"nameString", "type:"double"}
//      {"name":"nameString", "type:"TEXT"}
//      {"name":"nameString", "type:"TEXT"}
// ]
- (void)createTable:(NSString*)tableName columns:(NSArray*)params
{
    _tableName = tableName;
    NSMutableString* sql = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT ",tableName ];
    for( NSDictionary* param in params ){
        NSString* columnName = [param valueForKey:@"name"];
        NSString* type = [param valueForKey:@"type"];
        [sql appendFormat:@"%@ %@, ",columnName, type];
    }
    NSMutableString *str = [NSMutableString stringWithString:[sql substringToIndex:(sql.length-2)]];
    [str appendString:@")"];
    NSLog(@"sql = %@",str);
    [_db open];
    [_db executeUpdate:str];
    [_db close];
}

// [
//      [
//          {"name":"nameString", "type:"TEXT", "value":val}
//          {"name":"nameString", "type:"integer", "value":val}
//          {"name":"nameString", "type:"double", "value":val}
//      ]
//      [
//          {"name":"nameString", "type:"TEXT", "value":val}
//          {"name":"nameString", "type:"integer", "value":val}
//          {"name":"nameString", "type:"double", "value":val}
//      ]
// ]
- (void)insertDbWithObjects:(NSArray*)objects
{
    [_db open];
    [_db beginTransaction];
    for( NSArray* obj in objects ){
        NSMutableString* sql = [NSMutableString stringWithFormat:@"insert into %@ (",_tableName ];
        for( NSDictionary* column in obj ){
            [sql appendFormat:@"%@ ,", [column valueForKey:@"name"]];
        }
        NSMutableString *str = [NSMutableString stringWithString:[sql substringToIndex:(sql.length-2)]];
        [str appendString:@") values ("];
        for( int i = 0; i < obj.count; i ++ ){
            [str appendString:@"?,"];
        }
        NSMutableString* strSql =[NSMutableString stringWithString:[str substringToIndex:(str.length-1)]];
        [strSql appendString:@")"];
        NSLog(@"insert: sql = %@",strSql);
        switch (obj.count) {
            case 1:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ]];
                break;
            case 2:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ]];
                break;
            case 3:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ]];
                break;
            case 4:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ]];
                break;
            case 5:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ]];
                break;
            case 6:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ]];
                break;
            case 7:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ]];
                break;
            case 8:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ]];
                break;
            case 9:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ]];
                break;
            case 10:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ]];
                break;
            case 11:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ]];
                break;
            case 12:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ]];
                break;
            case 13:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ]];
                break;
            case 14:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ],[obj[13] valueForKey:@"value" ]];
                break;
            case 15:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ],[obj[13] valueForKey:@"value" ],[obj[14] valueForKey:@"value" ]];
                break;
            case 16:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ],[obj[13] valueForKey:@"value" ],[obj[14] valueForKey:@"value" ],[obj[15] valueForKey:@"value" ]];
                break;
            case 17:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ],[obj[13] valueForKey:@"value" ],[obj[14] valueForKey:@"value" ],[obj[15] valueForKey:@"value" ],[obj[16] valueForKey:@"value" ]];
                break;
            case 18:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ],[obj[13] valueForKey:@"value" ],[obj[14] valueForKey:@"value" ],[obj[15] valueForKey:@"value" ],[obj[16] valueForKey:@"value" ],[obj[17] valueForKey:@"value" ]];
                break;
            case 19:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ],[obj[13] valueForKey:@"value" ],[obj[14] valueForKey:@"value" ],[obj[15] valueForKey:@"value" ],[obj[16] valueForKey:@"value" ],[obj[17] valueForKey:@"value" ],[obj[18] valueForKey:@"value" ]];
                break;
            case 20:
                [_db executeUpdate:strSql,[obj[0] valueForKey:@"value" ],[obj[1] valueForKey:@"value" ],[obj[2] valueForKey:@"value" ],[obj[3] valueForKey:@"value" ],[obj[4] valueForKey:@"value" ],[obj[5] valueForKey:@"value" ],[obj[6] valueForKey:@"value" ],[obj[7] valueForKey:@"value" ],[obj[8] valueForKey:@"value" ],[obj[9] valueForKey:@"value" ],[obj[10] valueForKey:@"value" ],[obj[11] valueForKey:@"value" ],[obj[12] valueForKey:@"value" ],[obj[13] valueForKey:@"value" ],[obj[14] valueForKey:@"value" ],[obj[15] valueForKey:@"value" ],[obj[16] valueForKey:@"value" ],[obj[17] valueForKey:@"value" ],[obj[18] valueForKey:@"value" ],[obj[19] valueForKey:@"value" ]];
                break;
  
            default:
                break;
        }
    }
    [_db commit];
    [_db close];
}

- (FMResultSet*)selectBy:(NSString*)selectString
{
    FMResultSet* results = [_db executeQuery:selectString];
    return results;
}

- (NSString*)getDocumentDirectoryFilepath:(NSString*)fileName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    
    NSString* dbPath = paths[0];
    NSString* dbFilePath = [dbPath stringByAppendingPathComponent:fileName];
    return dbFilePath;
}

@end
