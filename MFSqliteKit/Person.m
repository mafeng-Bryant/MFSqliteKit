//
//  Person.m
//  MFSqliteKit
//
//  Created by patpat on 2017/8/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSString *)mf_SqliteVersion
{
    return @"1.0";
}


+ (NSArray *)mf_IgnorePropertys
{
    return @[@"ignoreAttr1",@"ignoreAttr2",@"ignoreAttr3"];
}

+ (NSString *)mf_OtherSqlitePath
{
    return [NSString stringWithFormat:@"%@/Library/per.db",NSHomeDirectory()];
}

@end
