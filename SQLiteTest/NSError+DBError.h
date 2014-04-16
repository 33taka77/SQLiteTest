//
//  NSError+DBError.h
//  SQLiteTest
//
//  Created by Aizawa Takashi on 2014/04/16.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    DB_ERROR_FILE_NOT_CREATED   = 301,
    DB_ERROR_DB_NOT_OPEND,
    DB_ERROR_DB_NOT_CLOSED
}DBError;

@interface NSError (DBError)

@end
