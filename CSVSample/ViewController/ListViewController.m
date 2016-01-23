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
#import "CSVManager.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *sectionData;
    NSMutableArray *sectionTitle;
    NSMutableArray *allDataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CSVManager *manager = [CSVManager new];
    NSArray *array = [manager generateCSVDataFromDocument];
    sectionTitle = array[0];
    sectionData  = array[1];
    allDataArray = array[2];
}

- (void)viewDidAppear:(BOOL)animated {
    NSIndexPath *selectIndex = _listTableView.indexPathForSelectedRow;
    [_listTableView deselectRowAtIndexPath:selectIndex animated:YES];
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
    DataModel *cellData = [self selectDataFromIndexPath:indexPath];
    
    cell.textLabel.text = cellData.eraText;
    cell.detailTextLabel.text = cellData.eventText;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [self performSegueWithIdentifier:@"PushDetail" sender:[self selectDataFromIndexPath:indexPath]];
}

- (DataModel*)selectDataFromIndexPath:(NSIndexPath*)indexPath {
    NSMutableArray *rowDataArray = sectionData[indexPath.section];
    DataModel *cellData = rowDataArray[indexPath.row];
    return cellData;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [[segue identifier] isEqualToString:@"PushDetail"] ) {
        DetailViewController *detail = [segue destinationViewController];
        detail.allDataArray = allDataArray;
        detail.data = (DataModel*)sender;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
