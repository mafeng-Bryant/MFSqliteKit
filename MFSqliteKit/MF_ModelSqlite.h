//
//  MF_ModelSqliteKit.h
//  MFSqliteKit
//
//  Created by patpat on 2017/8/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MF_Sqlite MF_ModelSqlite

@protocol MF_ModelSqliteInfo <NSObject>

@optional

+ (NSString *)mf_SqliteVersion;


+ (NSArray *)mf_IgnorePropertys;


+ (NSString *)mf_OtherSqlitePath;


@end


@interface MF_ModelSqlite : NSObject

/**
 * 说明: 存储模型数组到本地(事务方式)
 * @param model_array 模型数组对象(model_array 里对象类型要一致,不一致无法存储，后续会实现不同模型可以存储)
 */

+ (BOOL)inserts:(NSArray*)model_array;

/**
 * 说明: 存储模型到本地
 * @param model_object 模型对象
 */

+ (BOOL)insert:(id)model_object;




@end
