//
//  RBShareTool.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/30.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBShareTool.h"
#import "RBShareItem.h"
#import "RBShareView.h"

@implementation RBShareTool
RBOBJECT_SINGLETON_BOILERPLATE(RBShareTool, sharedManager)

#pragma mark -分享
- (void)shareV:(NSString *)title description:(NSString *)description image:(NSString *)image shareUrl:(NSString *)shareUrl{
    RB_WEAKSELF;
    RBShareItem *item1 = [RBShareItem itemWithTitle:@"微信好友" icon:@"share_wechatf" handler:^{
        [weakSelf wxShareToType:1 title:title.length?title:@"" description:description.length?description:@"" image:image.length?image:@"" shareUrl:shareUrl.length?shareUrl:@""];
    }];
    RBShareItem *item2 = [RBShareItem itemWithTitle:@"微信朋友圈" icon:@"share_wechatp" handler:^{
        [weakSelf wxShareToType:2 title:title.length?title:@"" description:description.length?description:@"" image:image.length?image:@"" shareUrl:shareUrl.length?shareUrl:@""];
    }];
    RBShareItem *item3 = [RBShareItem itemWithTitle:@"新浪微博" icon:@"share_sina" handler:^{
        [weakSelf wxShareToType:0 title:title.length?title:@"" description:description.length?description:@"" image:image.length?image:@"" shareUrl:shareUrl.length?shareUrl:@""];
    }];
    RBShareItem *item4 = [RBShareItem itemWithTitle:@"QQ好友" icon:@"share_qq" handler:^{
        [weakSelf wxShareToType:4 title:title.length?title:@"" description:description.length?description:@"" image:image.length?image:@"" shareUrl:shareUrl.length?shareUrl:@""];
    }];
    RBShareItem *item5 = [RBShareItem itemWithTitle:@"QQ空间" icon:@"share_qqroom" handler:^{
        [weakSelf wxShareToType:5 title:title.length?title:@"" description:description.length?description:@"" image:image.length?image:@"" shareUrl:shareUrl.length?shareUrl:@""];
    }];
    RBShareItem *item6 = [RBShareItem itemWithTitle:@"复制链接" icon:@"share_copy" handler:^{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = shareUrl.length?shareUrl:@"";
        [LCProgressHUD showMessage:@"已复制链接到剪贴板"];
    }];
    [RBShareView showShareViewWithData:@[item1,item2,item3,item4,item5,item6]];
}

- (void)wxShareToType:(int)type title:(NSString *)title description:(NSString *)description image:(NSString *)imageUrl shareUrl:(NSString *)shareUrl {
    
    /**创建分享消息对象*/
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    /**创建网页内容对象*/
    NSData *data = nil;
    if (imageUrl.length) {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    }else {
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
        UIImage *image = [UIImage imageNamed:icon];
        data = UIImagePNGRepresentation(image);
    }
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:description thumImage:[UIImage imageWithData:data]];
    /**设置网页地址*/
    shareObject.webpageUrl = shareUrl;
    /**分享消息对象设置分享内容对象*/
    messageObject.shareObject = shareObject;
    /**调用分享接口*/
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:[[AppDelegate sharedInstaceAppDelegate] currentViewController] completion:^(id data, NSError *error) {
        if (error) {
            [LCProgressHUD showMessage:@"分享失败"];
        }else{
            /**统计分享给好友成功后*/
            if ([shareUrl isEqualToString:appUrl]) {
                NSString *titleType = @"";
                switch (type) {
                    case 0:
                        titleType = @"新浪微博";
                        break;
                    case 1:
                        titleType = @"微信好友";
                        break;
                    case 2:
                        titleType = @"微信朋友圈";
                        break;
                    case 4:
                        titleType = @"QQ好友";
                        break;
                    case 5:
                        titleType = @"QQ空间";
                        break;
                        
                    default:
                        break;
                }
                [[RBAnalyticsManager sharedManager] eventShareToFriendWithType:titleType];
            }
            
            [LCProgressHUD showMessage:@"分享成功"];
        }
    }];
}
@end
