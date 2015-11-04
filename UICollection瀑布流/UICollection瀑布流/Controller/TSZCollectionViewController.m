//
//  ViewController.m
//  UICollection瀑布流
//
//  Created by Tsz on 15/11/2.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "TSZCollectionViewController.h"
#import "TSZWaterFallLayout.h"
#import "TSZClothes.h"
#import "TSZClothesCell.h"
#import <MJExtension.h>
@interface TSZCollectionViewController ()

@property (nonatomic ,strong)NSMutableArray *clothesArray;
@end

@implementation TSZCollectionViewController

-(NSMutableArray *)clothesArray{
    if (_clothesArray == nil) {
        _clothesArray = [NSMutableArray array];
    }
    return  _clothesArray;
}

//定义一个 ID
static NSString * const ID = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //切换布局
    self.collectionView.collectionViewLayout = [[TSZWaterFallLayout alloc]init];
    
    //发送请求给服务器
    NSArray *tempArray = [TSZClothes objectArrayWithFilename:@"clothes.plist"];
    
    [self.clothesArray addObjectsFromArray:tempArray];
}

#pragma mark: 实现collection的 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.clothesArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TSZClothesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.clothes = self.clothesArray[indexPath.item];
//    cell.backgroundColor = [UIColor redColor];
    return  cell;
}

@end
