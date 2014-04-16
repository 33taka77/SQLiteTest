//
//  ViewController.m
//  SQLiteTest
//
//  Created by Aizawa Takashi on 2014/04/16.
//  Copyright (c) 2014年 Aizawa Takashi. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteMngr.h"

@interface ViewController ()
@property (nonatomic, strong) SQLiteMngr* sqlMngr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _sqlMngr = [[SQLiteMngr alloc] init];
    [_sqlMngr prepareDBWithDBName:@"test.db"];

    NSArray *array = @[@{@"name":@"clm1", @"type":@"TEXT"},@{@"name":@"clm2",@"type":@"INTEGER"}];
    [_sqlMngr createTable:@"testTbl" columns:array];
    
    NSDictionary* param1 = @{@"name":@"clm1", @"type":@"TEXT", @"value":@"aizawa"};
    NSDictionary* param2 = @{@"name":@"clm2", @"type":@"integer", @"value":[NSNumber numberWithInt:5]};
    NSArray* params1 = @[param1,param2];
    
    NSDictionary* param3 = @{@"name":@"clm1", @"type":@"TEXT", @"value":@"sato"};
    NSDictionary* param4 = @{@"name":@"clm2", @"type":@"integer", @"value":[NSNumber numberWithInt:3]};
    NSArray* params2 = @[param3,param4];
    
    NSDictionary* param5 = @{@"name":@"clm1", @"type":@"TEXT", @"value":@"sato"};
    NSDictionary* param6 = @{@"name":@"clm2", @"type":@"integer", @"value":[NSNumber numberWithInt:3]};
    NSArray* params3 = @[param5,param6];

    NSArray* columns = @[params1,params2,params3];
    [_sqlMngr insertDbWithObjects:columns];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
