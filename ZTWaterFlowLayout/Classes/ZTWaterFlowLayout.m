//
//  ZTWaterFlowLayout.m
//  ZTLayout
//
//  Created by zhangtao on 2018/2/24.
//  Copyright © 2018年 zhangtao. All rights reserved.
//

#import "ZTWaterFlowLayout.h"
#import "ZTDecorationReusableView.h"
#import "ZTDecorationAttributes.h"

/** 默认的列数 */
static const NSInteger ZTDefaultColumnCount = 2;
/** 每一列之间的间距 */
static const CGFloat ZTDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat ZTDefaultRowMargin = 10;
/** 头视图高度 */
static const CGFloat ZTDefaultHeaderHeight = 0;
/** 尾视图高度 */
static const CGFloat ZTDefaultFooterHeight = 0;

/** 边缘间距 */
static const UIEdgeInsets ZTDefaultEdgeInsets = {10, 10, 10, 10};
NSString *const ZTCollectionViewSectionBackground = @"ZTCollectionViewSectionBackground";
@interface ZTWaterFlowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (CGFloat)headerHeight;
- (CGFloat)footerHeight;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
@end

@implementation ZTWaterFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerClass:[ZTDecorationReusableView class] forDecorationViewOfKind:ZTCollectionViewSectionBackground];
    }
    return self;
}

#pragma mark - 常见数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return ZTDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return ZTDefaultColumnMargin;
    }
}

- (CGFloat)footerHeight{
    
    if ([self.delegate respondsToSelector:@selector(footerHeightInWaterflowLayout:)]) {
        return [self.delegate footerHeightInWaterflowLayout:self];
    } else {
        return ZTDefaultFooterHeight;
    }
    
}

- (CGFloat)headerHeight{
    
    if ([self.delegate respondsToSelector:@selector(headerHeightInWaterflowLayout:)]) {
        return [self.delegate headerHeightInWaterflowLayout:self];
    } else {
        return ZTDefaultHeaderHeight;
    }
    
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return ZTDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return ZTDefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    //添加头视图
    UICollectionViewLayoutAttributes *headerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    headerAttr.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.headerHeight);
    [self.attrsArray addObject:headerAttr];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
    UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    footerAttr.frame = CGRectMake(0, self.contentHeight+self.edgeInsets.bottom, SCREEN_WIDTH, self.footerHeight);
    [self.attrsArray addObject:footerAttr];
    
    if ([self.delegate respondsToSelector:@selector(sectionBackgroundColorInWaterflowLayout:)]) {
        ZTDecorationAttributes *DecorationAttr = [ZTDecorationAttributes layoutAttributesForDecorationViewOfKind:ZTCollectionViewSectionBackground withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        DecorationAttr.frame = CGRectMake(0, self.headerHeight+self.edgeInsets.top, SCREEN_WIDTH, SCREEN_HEIGHT-self.footerHeight-self.headerHeight-self.edgeInsets.top-self.edgeInsets.bottom);
        DecorationAttr.zIndex = -1;
        DecorationAttr.backgroundColor = [self.delegate sectionBackgroundColorInWaterflowLayout:self];//分组背景色
        [self.attrsArray addObject:DecorationAttr];
        
    }
    
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置布局属性的frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }

    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }else{
        y += self.headerHeight;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:ZTCollectionViewSectionBackground]) {
        return self.attrsArray.lastObject;
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end


