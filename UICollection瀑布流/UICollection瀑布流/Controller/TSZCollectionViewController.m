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
#import <MJRefresh.h>
@interface TSZCollectionViewController () <TSZWaterFallLayoutDelegate>

@property (nonatomic ,strong)NSMutableArray *clothesArray;

@property (nonatomic ,strong)NSArray *tempArray;

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
    
    TSZWaterFallLayout *layout = [[TSZWaterFallLayout alloc]init];
    layout.delegate = self;
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //发送请求给服务器
    NSArray *tempArray = [TSZClothes objectArrayWithFilename:@"clothes.plist"];
    self.tempArray = tempArray;
    [self.clothesArray addObjectsFromArray:tempArray];
    
//    //上拉刷新
    [self upRefrash];
//
//    //下啦刷新
    [self downRefrash];

}

#pragma mark: 刷新数据 --> 下啦刷新
- (void)downRefrash{
    
    __weak typeof(self) weakSelf = self;
    
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //加载数据
        [weakSelf.clothesArray insertObjects:self.tempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tempArray.count)]];
        [weakSelf.collectionView reloadData];
        
        //结束刷新
        [weakSelf.collectionView.header endRefreshing];
    }];
    
}

#pragma mark: 刷新数据 --> 上啦刷新
- (void)upRefrash{
    
    __weak typeof(self) weakSelf = self;
    
    self.collectionView.footer = [MJRefreshAutoFooter   footerWithRefreshingBlock:^{
        
        //加载数据
        [weakSelf.clothesArray addObjectsFromArray:self.tempArray];
        
        [weakSelf.collectionView reloadData];
        
        //结束刷新
        [weakSelf.collectionView.footer endRefreshing];
    }];
    
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

#pragma mark :TSZWaterFallLayoutDelegate协议的实现

- (CGFloat)waterfallFlowLayout:(TSZWaterFallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width{
    TSZClothes *clothes = self.clothesArray[indexPath.item];
    
    return clothes.h *width / clothes.w;
}

- (NSUInteger)columnCountInWaterfallFlowLayout:(TSZWaterFallLayout *)layout{
    return  4;
}





@end
