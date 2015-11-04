//
//  TSZClothesCell.m
//  UICollection瀑布流
//
//  Created by Tsz on 15/11/3.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZClothesCell.h"
#include "TSZClothes.h"
#import <UIImageView+WebCache.h>

@interface TSZClothesCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end


@implementation TSZClothesCell

//set方法 赋值

- (void)setClothes:(TSZClothes *)clothes{
    _clothes = clothes;
//    //设置图片
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:clothes.img] placeholderImage:[UIImage imageNamed:@"loading.png"]];

    
    //设置价格
    self.priceLabel.text = clothes.price;
}

@end
