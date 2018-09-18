//
//  RBShareView.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/30.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBShareView.h"
#import "RBShareItemCell.h"
@interface RBShareView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *shareViewBjView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareViewBjViewH;

@property (weak, nonatomic) IBOutlet UICollectionView *shareCollectionView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation RBShareView
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.shareCollectionView.dataSource = self;
    self.shareCollectionView.delegate   = self;
    [self.shareCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RBShareItemCell class]) bundle:nil] forCellWithReuseIdentifier:shareItemCellId];
    
}

+ (void)showShareViewWithData:(NSArray *)arrData {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    RBShareView *shareView = [RBShareView loadFromXib];
    shareView.frame = window.bounds;
    [window addSubview:shareView];
    shareView.dataArr = arrData;
    [shareView setUpViewFrame];
}

-(void)setUpViewFrame{
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.shareViewBjView.top = self.height;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self upAnimation];
}

#pragma mark -取消视图
- (IBAction)cancelBtnClick:(id)sender {
    [self downAnimation];
}

#pragma mark -点击背景手势
- (IBAction)onClickBG:(id)sender {
    [self downAnimation];
}

- (void)upAnimation{
    RB_WEAKSELF;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.shareViewBjView.bottom = self.height;
        weakSelf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }];
}

- (void)downAnimation{
    RB_WEAKSELF;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        weakSelf.shareViewBjView.top = self.height;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


#pragma mark -UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark -定义展示的Section的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

#pragma mark -定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((screenWidth-20)/3, 95);
}

#pragma mark -定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - 每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RBShareItemCell *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:shareItemCellId forIndexPath:indexPath];
    cell.shareItem          = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self downAnimation];
    RBShareItem *shareItem = self.dataArr[indexPath.row];
    if (shareItem.selectionHandler) {
        shareItem.selectionHandler();
    }
    
}

@end
