//
//  ViewController.m
//  CSVSample
//
//  Created by KentarOu on 2015/12/14.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import "ViewController.h"
#import "CSVManager.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CSVManager *manager = [CSVManager new];
    [manager copyResourceBundleToDocument];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
