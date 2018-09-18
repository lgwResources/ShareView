//
//  RBShareItemCell.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/30.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBShareItemCell.h"

@interface RBShareItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation RBShareItemCell

- (void)setShareItem:(RBShareItem *)shareItem {
    _shareItem = shareItem;
    self.iconImageView.image = [UIImage imageNamed:shareItem.icon];
    self.titleLabel.text     = shareItem.title;
}
@end
