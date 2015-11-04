//
//  TSZClothes.h
//  UICollection瀑布流
//
//  Created by Tsz on 15/11/3.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSZClothes : NSObject
// 宽度
@property (nonatomic, assign) CGFloat w;
// 高度
@property (nonatomic, assign) CGFloat h;
// 图片
@property (nonatomic, copy) NSString *img;
// 价格
@property (nonatomic, copy) NSString *price;

@end
