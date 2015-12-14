//
//  ListViewController.m
//  CSVSample
//
//  Created by KentarOu on 2015/12/14.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "DataModel.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *sectionData;
    NSMutableArray *sectionTitle;
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self generateCSVDataFromBundle];
}

- (void)viewDidAppear:(BOOL)animated {
    NSIndexPath *selectIndex = _listTableView.indexPathForSelectedRow;
    [_listTableView deselectRowAtIndexPath:selectIndex animated:YES];
}

- (void)generateCSVDataFromBundle {
    
    NSString *csvFile = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSShiftJISStringEncoding];
    NSArray *lines = [csv componentsSeparatedByString:@"\n"];
    
    sectionData = [NSMutableArray array];
    sectionTitle = [NSMutableArray array];
    
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
}

#pragma mark- TableView Delegate & DataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return sectionTitle[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *rowDataArray = sectionData[section];
    return rowDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    NSMutableArray *rowDataArray = sectionData[indexPath.section];
    DataModel *cellData = rowDataArray[indexPath.row];
    
    cell.textLabel.text = cellData.eraText;
    cell.detailTextLabel.text = cellData.eventText;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *rowDataArray = sectionData[indexPath.section];
    DataModel *cellData = rowDataArray[indexPath.row];
    
    [self performSegueWithIdentifier:@"PushDetail" sender:cellData];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [[segue identifier] isEqualToString:@"PushDetail"] ) {
        DetailViewController *detail = [segue destinationViewController];
        detail.data = (DataModel*)sender;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
