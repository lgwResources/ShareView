//
//  RBShareItemCell.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/30.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBShareItem.h"
static NSString *shareItemCellId = @"RBShareItemCell";
@interface RBShareItemCell : UICollectionViewCell
@property (nonatomic, strong) RBShareItem *shareItem;
@end
