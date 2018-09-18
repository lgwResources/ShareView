//
//  RBShareItem.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/30.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBShareItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

/**点击后的事件处理*/
@property(nonatomic, copy) void (^selectionHandler)(void);

/**快速创建方法*/
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon handler:(void (^)(void))handler;

@end
