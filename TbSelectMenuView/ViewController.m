//
//  ViewController.m
//  TbSelectMenuView
//
//  Created by Tb on 2017/8/19.
//  Copyright © 2017年 Tb. All rights reserved.
//

#import "ViewController.h"
#import "TbPopMenuView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"新建了一个dev分支");

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TbPopMenuView *popMenu = [[TbPopMenuView alloc] initWithTitle:@[@"标准视图",@"高级视图",@"传统视图"] imageName:@[@"standard",@"hight",@"trad"] clickRowComplete:^(NSString *selectRow, NSInteger row) {
        NSLog(@"name:%@,row:%zd",selectRow,row);
    }];
    [popMenu show];
}


@end
