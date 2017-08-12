//
//  MF_ModelSqliteKit.m
//  MFSqliteKit
//
//  Created by patpat on 2017/8/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "MF_ModelSqlite.h"
#ifdef SQLITE_HAS_CODEC
#import "sqlite3.h"
#else
#import <sqlite3.h>
#endif


static sqlite3 * mf_database;//数据库句柄

@interface MF_ModelSqlite()
@property (nonatomic,strong) dispatch_semaphore_t signal;//信号量,确保线程安全
@property (nonatomic, assign) BOOL check_update; //版本更新

@end

@implementation MF_ModelSqlite

- (MF_ModelSqlite*)init
{
    self = [super init];
    if (self) {
        self.signal = dispatch_semaphore_create(1);//批量存储数据需要用到
        self.check_update = YES;
    }
    return self;
}

+ (MF_ModelSqlite*)shareInstance
{
    static MF_ModelSqlite* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MF_ModelSqlite new];
    });
    return instance;
}

+ (BOOL)insert:(id)model_object
{
    if (model_object) {
        return [self inserts:@[model_object]];
    }
    return NO;
}

+ (BOOL)inserts:(NSArray*)model_array
{
    __block BOOL result = YES;
    dispatch_semaphore_wait([self shareInstance].signal, DISPATCH_TIME_FOREVER);//当前信号量-1，如果返回的值为0就需要等待，否则可以执行。
    @autoreleasepool {
        if (model_array !=nil && model_array.count>0) {
         //open database first and begin transtion
            if ([self openTable:[model_array.firstObject class]]) {
                
        
                
            }
         }
    }
    dispatch_semaphore_signal([self shareInstance].signal);//处理完一条数据就+1表示可以接受下一个处理
    return result;
}

+ (BOOL)openTable:(Class)model_class
{
    NSString* cache_directory = [self handleOldSqlite:model_class];
    SEL VERSION = @selector(mf_SqliteVersion);
    NSString* version = @"1.0";
    if ([model_class respondsToSelector:VERSION]) {
        version = [self exceSelector:VERSION modelClass:model_class];
        if (!version || version.length == 0) {version = @"1.0";}
        if ([self shareInstance].check_update) {
            NSString* local_model_name = [self localModelName:model_class];
            
        }
        [self shareInstance].check_update = YES;
        NSString * database_cache_path = [NSString stringWithFormat:@"%@%@_v%@.sqlite",cache_directory,NSStringFromClass(model_class),version];
        if (sqlite3_open([database_cache_path UTF8String], &mf_database) == SQLITE_OK) {
            NSLog(@"ok");
            
        
            
        }
    }
    return NO;
}

#pragma mark private method

+ (NSString*)getDataBaseCachePath
{
    return [NSString stringWithFormat:@"%@/Library/Caches/MFSqlite/",NSHomeDirectory()];
}

+ (void)createFloder:(NSString*)path
{
    BOOL is_directory = YES;
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path isDirectory:&is_directory]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (NSString*)exceSelector:(SEL)selector modelClass:(Class)model_class
{
    if ([model_class respondsToSelector:selector]) {
        IMP sqlite_func = [model_class methodForSelector:selector];//函数IMP指针
        NSString * (*func)(id, SEL) = (void *)sqlite_func;
        return func(model_class,selector);
    }
    return nil;
}

+ (NSString*)getSqlitePath:(Class)model_class
{
    SEL selector = @selector(mf_OtherSqlitePath);
    if ([model_class respondsToSelector:selector]) {
        NSString * sqlite_path = [self exceSelector:selector modelClass:model_class];
        if (sqlite_path && sqlite_path.length > 0) {
            return sqlite_path;
        }
    }
    return nil;
}

+ (NSString*)handleOldSqlite:(Class)model_class
{
    NSString* cachePath = [self getDataBaseCachePath];
    [self createFloder:cachePath];
    NSString* sqlitePath = [self getSqlitePath:model_class];
    if (sqlitePath && sqlitePath.length>0) {
    //拷贝数据库路径，兼容老版本
    BOOL is_directory = NO;
        NSString* version = [self exceSelector:@selector(mf_SqliteVersion) modelClass:model_class];
        if (!version && version.length ==0) {
              version = @"1.0";
        }
        NSString* mf_sqlitePath = [NSString stringWithFormat:@"%@%@_v%@.sqlite",cachePath,NSStringFromClass(model_class),version];
        NSLog(@"path = %@",mf_sqlitePath);
        NSFileManager* manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:sqlitePath isDirectory:&is_directory] &&
            [manager fileExistsAtPath:mf_sqlitePath isDirectory:&is_directory]) {
            [manager copyItemAtPath:sqlitePath toPath:mf_sqlitePath error:nil];
        }
    }
    return cachePath;
}

+ (NSString*)localModelName:(Class)model_class
{
  return @"";
    
    

}






@end



