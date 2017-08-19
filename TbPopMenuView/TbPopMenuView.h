//
//  TbPopMenuVIew.h
//  AetosTrade
//
//  Created by mac on 16/12/1.
//  Copyright © 2016年 vst-Tb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TbPopMenuView : UIView

- (instancetype)initWithTitle:(NSArray *)title imageName:(NSArray *)imageName clickRowComplete:(void(^)(NSString *,NSInteger))clickRowComplete;

- (IBAction)cancel:(id)sender;
- (IBAction)ok:(id)sender;
- (void)show;
@end
