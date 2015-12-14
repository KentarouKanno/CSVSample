//
//  CSVManager.h
//  CSVSample
//
//  Created by KentarOu on 2015/12/15.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVManager : NSObject

- (void)copyResourceBundleToDocument;
- (NSArray*)generateCSVDataFromDocument;

@end
