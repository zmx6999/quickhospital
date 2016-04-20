//
//  ComplicationViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ComplicationViewController.h"
#import "Complication.h"
#import "IFSRefreshView.h"
#import "DiseaseDetailViewModel.h"

@interface ComplicationViewController () <IFSRefreshViewDelegate>

@property (nonatomic, weak) IFSRefreshView *header;
@property (nonatomic, weak) IFSRefreshView *footer;

@property (nonatomic, strong) NSArray *complications;

@end

@implementation ComplicationViewController

- (void)choose {
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.choosedComplications sortUsingComparator:^NSComparisonResult(Complication *c1, Complication *c2) {
        return c1.complication_id > c2.complication_id;
    }];
    
    if (self.chooseComplication) {
        self.chooseComplication(self.choosedComplications);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(choose)];
    
    [self setupTableView];
    [self setupRefreshView];
    [self loadComplications];
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

- (void)reload {
    [self.tableView reloadData];
    
    NSInteger n = [self.tableView numberOfRowsInSection:0];
    for (int i = 0, j = 0; i < n; i++) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.accessoryView.hidden = YES;
        if (j < self.choosedComplications.count) {
            Complication *complication = self.choosedComplications[j];
            if ([cell.textLabel.text isEqualToString:complication.complication_name]) {
                cell.accessoryView.hidden = NO;
                j++;
            }
        }
    }
}

- (void)loadComplications {
    [DiseaseDetailViewModel getComplicationWithCi2Id:self.ci2Id page:1 completionHandler:^(NSArray *complications) {
        if (complications.count < 1) {
            return;
        }
        
        self.complications = complications;
        [self reload];
    }];
}

- (void)loadNewComplications {
    [DiseaseDetailViewModel getComplicationWithCi2Id:self.ci2Id page:1 completionHandler:^(NSArray *complications) {
        [self.header endRefreshing];
        if (complications.count < 1) {
            return;
        }
        
        Complication *firstComplication = self.complications.firstObject;
        NSMutableArray *arrM = [NSMutableArray array];
        for (Complication *complication in complications) {
            if (complication.complication_id >= firstComplication.complication_id) {
                break;
            }
            [arrM addObject:complication];
        }
        
        [arrM addObjectsFromArray:self.complications];
        self.complications = arrM;
        [self reload];
    }];
}

- (void)loadMoreComplications {
    if (self.complications.count % DiseaseDetailPageSize) {
        [self.footer endRefreshing];
        return;
    }
    
    NSInteger page = self.complications.count / DiseaseDetailPageSize + 1;
    [DiseaseDetailViewModel getComplicationWithCi2Id:self.ci2Id page:page completionHandler:^(NSArray *complications) {
        [self.footer endRefreshing];
        if (complications.count < 1) {
            return;
        }
        
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.complications];
        Complication *lastComplication = self.complications.lastObject;
        for (Complication *complication in complications) {
            if (complication.complication_id <= lastComplication.complication_id) {
                continue;
            }
            [arrM addObject:complication];
        }
        
        self.complications = arrM;
        [self reload];
    }];
}

- (void)refreshViewDidBeginRefreshing:(IFSRefreshView *)refreshView {
    if (refreshView.type == IFSHeader) {
        [self loadNewComplications];
    }
    
    if (refreshView.type == IFSFooter) {
        [self loadMoreComplications];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.complications.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"complication";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = [UIImage imageNamed:@"multiple_selected"];
        cell.accessoryView = imageView;
    }
    
    Complication *complication = self.complications[indexPath.row];
    NSString *complicationName = complication.complication_name;
    cell.textLabel.text = complicationName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView.hidden = !cell.accessoryView.hidden;
    
    if (cell.accessoryView.hidden) {
        for (Complication *complication in self.choosedComplications) {
            if ([complication.complication_name isEqualToString:cell.textLabel.text]) {
                [self.choosedComplications removeObject:complication];
                break;
            }
        }
    } else {
        [self.choosedComplications addObject:self.complications[indexPath.row]];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
