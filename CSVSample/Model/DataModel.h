//
//  DataModel.h
//  CSVSample
//
//  Created by KentarOu on 2015/12/14.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property NSString *sectionTitle;
@property NSString *eraText;
@property NSString *eventText;
@property NSString *imageName;

- (void)setDataFromArray:(NSArray*)dataArray;

@end
