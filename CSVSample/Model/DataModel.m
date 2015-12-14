//
//  DataModel.m
//  CSVSample
//
//  Created by KentarOu on 2015/12/14.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (void)setDataFromArray:(NSArray*)dataArray {
    self.sectionTitle = dataArray[0];
    self.eraText      = dataArray[1];
    self.eventText    = dataArray[2];
    self.imageName    = [dataArray[3] stringByReplacingOccurrencesOfString: @"\r" withString: @""];
}

@end
