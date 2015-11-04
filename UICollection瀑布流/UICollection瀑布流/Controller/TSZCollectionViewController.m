//
//  ViewController.m
//  UICollection瀑布流
//
//  Created by Tsz on 15/11/2.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "TSZCollectionViewController.h"
#import "TSZWaterFallLayout.h"

@interface TSZCollectionViewController ()

@end

@implementation TSZCollectionViewController

//定义一个 ID
static NSString * const ID = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //切换布局
    self.collectionView.collectionViewLayout = [[TSZWaterFallLayout alloc]init];

}

#pragma mark: 实现collection的 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  20;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    return  cell;
}

@end
