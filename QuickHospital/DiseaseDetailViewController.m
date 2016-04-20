//
//  DiseaseDetailViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/22.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DiseaseDetailViewController.h"
#import "DiseaseDetail.h"
#import "DiseaseDetailViewModel.h"
#import "IFSRefreshView.h"

@interface DiseaseDetailViewController () <IFSRefreshViewDelegate>

@property (nonatomic, weak) IFSRefreshView *header;
@property (nonatomic, weak) IFSRefreshView *footer;

@property (nonatomic, strong) NSArray *details;

@end

@implementation DiseaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefreshView];
    [self loadDetails];
}

- (void)dealloc {
    [self.header free];
    [self.footer free];
}

- (void)setupTableView {
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)setupRefreshView {
    IFSRefreshView *header = [IFSRefreshView refreshViewWithType:IFSHeader];
    self.header = header;
    self.header.scrollView = self.tableView;
    self.header.delegate = self;
    
    IFSRefreshView *footer = [IFSRefreshView refreshViewWithType:IFSFooter];
    self.footer = footer;
    self.footer.scrollView = self.tableView;
    self.footer.delegate = self;
}

- (void)loadDetails {
    [DiseaseDetailViewModel getDiseaseDetailWithCi1Id:self.ci1Id page:1 completionHandler:^(NSArray *diseaseDetails) {
        if (diseaseDetails.count < 1) {
            return;
        }
        
        self.details = diseaseDetails;
        [self.tableView reloadData];
    }];
}

- (void)loadNewDetails {
    [DiseaseDetailViewModel getDiseaseDetailWithCi1Id:self.ci1Id page:1 completionHandler:^(NSArray *diseaseDetails) {
        [self.header endRefreshing];
        if (diseaseDetails.count < 1) {
            return;
        }
        
        DiseaseDetail *firstDetail = self.details.firstObject;
        NSMutableArray *arrM = [NSMutableArray array];
        for (DiseaseDetail *detail in diseaseDetails) {
            if (detail.ci2_id >= firstDetail.ci2_id) {
                break;
            }
            [arrM addObject:detail];
        }
        
        [arrM addObjectsFromArray:self.details];
        self.details = arrM;
        [self.tableView reloadData];
    }];
}

- (void)loadMoreDetails {
    if (self.details.count % DiseaseDetailPageSize) {
        [self.footer endRefreshing];
        return;
    }
    
    NSInteger page = self.details.count / DiseaseDetailPageSize + 1;
    [DiseaseDetailViewModel getDiseaseDetailWithCi1Id:self.ci1Id page:page completionHandler:^(NSArray *diseaseDetails) {
        [self.footer endRefreshing];
        if (diseaseDetails.count < 1) {
            return;
        }
        
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.details];
        DiseaseDetail *lastDetail = self.details.lastObject;
        for (DiseaseDetail *detail in diseaseDetails) {
            if (detail.ci2_id <= lastDetail.ci2_id) {
                continue;
            }
            [arrM addObject:detail];
        }
        
        self.details = arrM;
        [self.tableView reloadData];
    }];
}

- (void)refreshViewDidBeginRefreshing:(IFSRefreshView *)refreshView {
    if (refreshView.type == IFSHeader) {
        [self loadNewDetails];
    }
    
    if (refreshView.type == IFSFooter) {
        [self loadMoreDetails];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.details.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"detail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DiseaseDetail *detail = self.details[indexPath.row];
    cell.textLabel.text = detail.ci3_name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
    DiseaseDetail *detail = self.details[indexPath.row];
    if (self.chooseDetail) {
        self.chooseDetail(detail.ci3_name, detail.ci2_id, detail.ci3_id);
    }
}

@end