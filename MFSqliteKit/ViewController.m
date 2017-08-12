//
//  ViewController.m
//  MFSqliteKit
//
//  Created by patpat on 2017/8/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "MF_ModelSqlite.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /// 1.存储模型对象到数据库演示代码
    Person * person = [Person new];
    person.name = @"吴海超";
    person.age = 25;
    person.height = 180.0;
    person.weight = 140.0;
    person.isDeveloper = YES;
    person.sex = 'm';
    person.zz = @(100);
    person.type = @"android";

    [MF_ModelSqlite insert:person];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
