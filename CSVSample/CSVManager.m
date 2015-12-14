//
//  CSVManager.m
//  CSVSample
//
//  Created by KentarOu on 2015/12/15.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import "CSVManager.h"
#import "DataModel.h"

@implementation CSVManager


- (void)copyResourceBundleToDocument {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"data.csv"];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        NSString *csvFile = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"csv"];
        NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
        [csvData writeToFile:filePath atomically:YES];
    }
}

- (NSArray*)generateCSVDataFromDocument {
    
    NSMutableArray *sectionData = [NSMutableArray array];
    NSMutableArray *sectionTitle = [NSMutableArray array];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *csvFile = [directory stringByAppendingPathComponent:@"data.csv"];

    
    // NSString *csvFile = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSShiftJISStringEncoding];
    NSArray *lines = [csv componentsSeparatedByString:@"\n"];
    
    
    NSMutableArray *listDataArray = [NSMutableArray array];
    NSString *title;
    
    for (NSString *row in lines) {
        
        NSArray *items = [row componentsSeparatedByString:@","];
        
        DataModel *data = [DataModel new];
        [data setDataFromArray:items];
        
        if (!title) {
            title = data.sectionTitle;
            [sectionTitle addObject:title];
        }
        
        if ([title isEqualToString:data.sectionTitle]) {
            [listDataArray addObject:data];
        } else {
            
            title = data.sectionTitle;
            [sectionTitle addObject:title];
            
            [sectionData addObject:listDataArray];
            
            listDataArray = [NSMutableArray array];
            [listDataArray addObject:data];
        }
    }
    [sectionData addObject:listDataArray];
    
    return @[sectionTitle, sectionData];
}

@end
