//
//  ZTViewController.m
//  ZTWaterFlowLayout
//
//  Created by sacrifice123 on 01/30/2019.
//  Copyright (c) 2019 sacrifice123. All rights reserved.
//

#import "ZTViewController.h"
#import "ZTWaterFlowLayout.h"
#import "ZTDecorationReusableView.h"
#import "WaterFlowTestCell.h"
#import "WaterFlowHeadView.h"
#import "WaterFlowFootView.h"

@interface ZTViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ZTWaterFlowLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZTViewController
static  NSString *const cellId = @"WaterFlowTestCell";
static  NSString *const headerId = @"headerId";
static  NSString *const footerId = @"footerId";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}


- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        ZTWaterFlowLayout *flowLayout = [[ZTWaterFlowLayout alloc] init];
        flowLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowTestCell" bundle:nil] forCellWithReuseIdentifier:cellId];
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];

    }
    
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableview = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
        
    }else if (kind == UICollectionElementKindSectionFooter) {
        reusableview = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId forIndexPath:indexPath];
        
    }
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFlowTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%li个item",indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (CGFloat)waterflowLayout:(ZTWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    
    return 50 +  (arc4random() % 101);
}

- (CGFloat)rowMarginInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout{
    return 5;
}

- (CGFloat)columnMarginInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout{
    
    return 5;
}

- (CGFloat)headerHeightInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout{
    
    return 100;
}

- (CGFloat)footerHeightInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout{
    
    return 50;
    
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout{
    return UIEdgeInsetsMake(1, 0, 3, 0);
}

- (UIColor *)sectionBackgroundColorInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout{
    
    return [UIColor yellowColor];
}

@end
