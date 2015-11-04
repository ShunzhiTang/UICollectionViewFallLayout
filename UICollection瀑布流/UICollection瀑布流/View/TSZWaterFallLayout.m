//
//  TSZWaterFallLayout.m
//  UICollection瀑布流
//
//  Created by Tsz on 15/11/3.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZWaterFallLayout.h"

@implementation TSZWaterFallLayout

//数组中是所有元素最终显示出来的 布局属性

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i =0 ; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [array addObject:attrs];
    }
    
    return array;
}

//说明indexPath 位置cell 的布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算 indexPath 位置cell的布局属性
    attrs.center = CGPointMake(100, 100);
    attrs.size = CGSizeMake(100, 100);
    return attrs;
}


@end
