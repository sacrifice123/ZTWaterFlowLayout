//
//  ZTWaterFlowLayout.h
//  ZTLayout
//
//  Created by zhangtao on 2018/2/24.
//  Copyright © 2018年 zhangtao. All rights reserved.
//

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#import <UIKit/UIKit.h>

@class ZTWaterFlowLayout;

@protocol ZTWaterFlowLayoutDelegate <NSObject>
@required
/*每个item的高度*/
- (CGFloat)waterflowLayout:(ZTWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional
/*列数*/
- (CGFloat)columnCountInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;
/*列间距*/
- (CGFloat)columnMarginInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;
/*行间距*/
- (CGFloat)rowMarginInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;
/*边缘间距*/
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;
/*头视图高度*/
- (CGFloat)headerHeightInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;
/*尾视图高度*/
- (CGFloat)footerHeightInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;
/*分组列表背景色*/
- (UIColor *)sectionBackgroundColorInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;

@end

@interface ZTWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<ZTWaterFlowLayoutDelegate> delegate;
@end
