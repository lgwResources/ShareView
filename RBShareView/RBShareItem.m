//
//  RBShareItem.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/30.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBShareItem.h"

@implementation RBShareItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon handler:(void (^)(void))handler {
    RBShareItem *item   = [[RBShareItem alloc] init];
    item.title          = title;
    item.icon           = icon;
    item.selectionHandler = handler;
    return item;
}
@end
