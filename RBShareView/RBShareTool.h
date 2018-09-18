//
//  RBShareTool.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/30.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBShareTool : NSObject

+ (instancetype)sharedManager;

/**0:新浪 1:微信聊天 2:微信朋友圈 4:QQ聊天页面 5:qq空间*/
- (void)shareV:(NSString *)title description:(NSString *)description image:(NSString *)image shareUrl:(NSString *)shareUrl;

@end
