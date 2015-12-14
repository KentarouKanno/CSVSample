//
//  DetailViewController.m
//  CSVSample
//
//  Created by KentarOu on 2015/12/14.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _data.eventText;
    _detailImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_data.imageName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
