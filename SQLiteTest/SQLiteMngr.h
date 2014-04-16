//
//  SQLiteMngr.h
//  SQLiteTest
//
//  Created by Aizawa Takashi on 2014/04/16.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SQLiteMngr : NSObject
- (void)prepareDBWithDBName:(NSString*)dbFileName;
- (BOOL)openDB;
- (void)closeDB;
- (void)createTable:(NSString*)tableName columns:(NSArray*)params;
- (void)insertDbWithObjects:(NSArray*)objects;
- (FMResultSet*)selectBy:(NSString*)selectString;
- (void)insert;

@end
