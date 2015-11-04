//
//  TSZWaterFallLayout.m
//  UICollection瀑布流
//
//  Created by Tsz on 15/11/3.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "TSZWaterFallLayout.h"

#define TSZCollectionViewWidth self.collectionView.frame.size.width
// 默认行间距
static const CGFloat TSZDefaultRowSpacing = 10;
// 默认列间距
static const CGFloat TSZDefaultColumnSpacing = 20;
// 默认边距
static const UIEdgeInsets TSZDefaultEdgeInsets = {10, 10, 10, 10};
// 默认列数
static const NSUInteger TSZDefaultColumnCount = 3;

//Extension
@interface TSZWaterFallLayout()

// 每一列的最大y坐标
@property (nonatomic, strong) NSMutableArray *columnMaxYArray;

// 存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *attrsArray;

//声明get方法 ， 把数据声明出来
- (CGFloat)rowSpacing;
- (CGFloat)columnSpacing;
- (UIEdgeInsets)edgeInsets;
- (NSUInteger)columnCount;


@end


@implementation TSZWaterFallLayout

#pragma mark: 懒加载
- (NSMutableArray *)columnMaxYArray{
    if (!_columnMaxYArray) {
        _columnMaxYArray = [NSMutableArray array];
    }
    return _columnMaxYArray;
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

#pragma mark  实现内部方法

/**
 * 准备layout 的布局
 */
- (void)prepareLayout{
    [super prepareLayout];
    
    //重置每一列的最大的坐标
    [self.columnMaxYArray removeAllObjects];
    
    for (int i = 0  ; i < TSZDefaultColumnCount; i++) {
        [self.columnMaxYArray addObject:@(self.edgeInsets.top)];
    }
    
    //计算所有cell 的 布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView  numberOfItemsInSection:0];
    
    for (int i = 0; i< count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

// 决定collectionView 的ContentSize

- (CGSize)collectionViewContentSize{
    
    //找出最长的一列
    
    CGFloat destColumnMaxY = [self.columnMaxYArray[0] doubleValue];
    
    for (int i = 1; i < self.columnMaxYArray.count; i++) {
        CGFloat columnMaxY = [self.columnMaxYArray[i] doubleValue];
        
        if (columnMaxY > destColumnMaxY) {
            destColumnMaxY = columnMaxY;
        }
    }
    
    return  CGSizeMake(TSZCollectionViewWidth,destColumnMaxY + self.edgeInsets.bottom);
}

//数组中是所有元素最终显示出来的 布局属性

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0 ; i < self.attrsArray.count; i++) {
        
        UICollectionViewLayoutAttributes *attrs = self.attrsArray[i];
        
        if (CGRectIntersectsRect(rect, attrs.frame)) {
            [array addObject:attrs];
        }
    }
    return array;
}

//说明indexPath 位置cell 的布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //每一个cell 的 布局
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 计算indexPath位置cell 的布局属性 ， 找出最短的列号 和最大的y坐标
    CGFloat  destColumnMaxY = [self.columnMaxYArray[0] doubleValue];
    
    NSUInteger destColumnIndex = 0;
    
    for ( int i = 1;  i < self.columnMaxYArray.count; i++) {
        
        CGFloat columnMaxY = [self.columnMaxYArray[i] doubleValue];
        
        if (columnMaxY < destColumnMaxY) {
            destColumnMaxY = columnMaxY;
            
            destColumnIndex = i;
        }
    }
    
    CGFloat totalColumnSpacing = (self.columnCount -1) * self.columnSpacing;
    
    CGFloat width = (TSZCollectionViewWidth - self.edgeInsets.left - self.edgeInsets.right - totalColumnSpacing) / TSZDefaultColumnCount;
    
    CGFloat height = [self.delegate waterfallFlowLayout:self heightForItemAtIndexPath:indexPath withItemWidth:width];
    
    CGFloat x = self.edgeInsets.left + destColumnIndex * (width + self.columnSpacing);
    
    CGFloat y = destColumnMaxY;
    if (destColumnMaxY != self.edgeInsets.top) {
        y += self.rowSpacing;
    }
    
    attrs.frame  = CGRectMake(x, y, width, height);
    
    //更新最大的坐标
    self.columnMaxYArray[destColumnIndex] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}


#pragma mark 处理数据
- (CGFloat)rowSpacing{
    if ([self.delegate respondsToSelector:@selector(rowSpacingInWaterfallFlowLayout:)]) {
        return [self.delegate rowSpacingInWaterfallFlowLayout:self];
    }
    return TSZDefaultRowSpacing;
}

- (CGFloat)columnSpacing{
    if([self.delegate respondsToSelector:@selector(columnSpacingInWaterfallFlowLayout:)]){
        
        return [self.delegate columnSpacingInWaterfallFlowLayout:self];
    }
    return TSZDefaultColumnSpacing;
}

- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterfallFlowLayout:)]) {
        return [self.delegate edgeInsetsInWaterfallFlowLayout:self];
    }
    return TSZDefaultEdgeInsets;
}

- (NSUInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterfallFlowLayout:)]) {
        return [self.delegate columnCountInWaterfallFlowLayout:self];
    }
    return TSZDefaultColumnCount;
}

@end
