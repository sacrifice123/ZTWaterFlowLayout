//
//  ZTDecorationReusableView.h
//  ZTLayout
//
//  Created by zhangtao on 2018/2/24.
//  Copyright © 2018年 zhangtao. All rights reserved.
//

#import "ZTDecorationReusableView.h"
#import "ZTDecorationAttributes.h"

@implementation ZTDecorationReusableView
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[ZTDecorationAttributes class]]) {
        ZTDecorationAttributes *attr = (ZTDecorationAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;//分组背景色
    }
}
@end
