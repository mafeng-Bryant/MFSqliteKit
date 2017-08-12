//
//  Person.h
//  MFSqliteKit
//
//  Created by patpat on 2017/8/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animal.h"
#import "MF_ModelSqlite.h"

@interface Person : Animal<MF_ModelSqliteInfo>

@property(nonatomic,assign) NSInteger mfId; //主键
@property(nonatomic,assign) NSInteger _id; //主键
@property(nonatomic,strong) NSString* name;
@property (nonatomic, assign) long age;
@property (nonatomic, assign) float weight;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) BOOL isDeveloper;
@property (nonatomic, strong) NSString * xx;
@property (nonatomic, strong) NSString * yy;
@property (nonatomic, strong) NSString * ww;
@property (nonatomic, assign) char sex;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSNumber * zz;
@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSArray * carArray;
@property (nonatomic, strong) NSDictionary * dict;
@property (nonatomic, strong) NSDictionary * dictCar;

/// 下面是忽略属性
@property (nonatomic, strong) NSString * ignoreAttr1;
@property (nonatomic, strong) NSString * ignoreAttr2;
@property (nonatomic, strong) NSString * ignoreAttr3;

+ (NSString *)mf_SqliteVersion;
+ (NSArray *)mf_IgnorePropertys;

@end
