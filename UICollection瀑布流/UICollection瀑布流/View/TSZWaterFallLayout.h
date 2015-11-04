//
//  TSZWaterFallLayout.h
//  UICollection瀑布流
//
//  Created by Tsz on 15/11/3.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <UIKit/UIKit.h>

//为了更好的实现框架的效果和程序的健壮性

@class TSZWaterFallLayout;

/**
 * 使用协议实现信息的传递
 */

@protocol TSZWaterFallLayoutDelegate <NSObject>

@required
/**
 *  返回indexPath位置cell的高度 , 外界可以传入的高度
 */
- (CGFloat)waterfallFlowLayout:(TSZWaterFallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width;

@optional
/**
 *  返回布局的行间距
 */
- (CGFloat)rowSpacingInWaterfallFlowLayout:(TSZWaterFallLayout *)layout;

/**
 *  返回布局的列间距
 */
- (CGFloat)columnSpacingInWaterfallFlowLayout:(TSZWaterFallLayout *)layout;

/**
 *  返回布局的边距
 */
- (UIEdgeInsets)edgeInsetsInWaterfallFlowLayout:(TSZWaterFallLayout *)layout;

/**
 *  返回布局的列数
 */
- (NSUInteger)columnCountInWaterfallFlowLayout:(TSZWaterFallLayout *)layout;


@end

@interface TSZWaterFallLayout : UICollectionViewLayout

/**
 * 给出代理接口
 */

@property (nonatomic ,weak) id<TSZWaterFallLayoutDelegate> delegate;

@end
