//
//  DetailViewController.m
//  CSVSample
//
//  Created by KentarOu on 2015/12/14.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate> 
@property (weak, nonatomic) IBOutlet UICollectionView *detailCollectionView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    NSInteger index = [_allDataArray indexOfObject:_data];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.detailCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _allDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionViewCell *cell = (DetailCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCell" forIndexPath:indexPath];
    DataModel *data  = self.allDataArray[indexPath.row];
    
    cell.detailLabel.text = [NSString stringWithFormat:@"%@ %@ %@",data.sectionTitle, data.eraText, data.eventText];
    cell.detailImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",data.imageName]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    CGSize cellSize = CGSizeMake(screenSize.size.width, 300);
    return cellSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
