//
//  DoctorViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DoctorViewController.h"
#import "DoctorCell.h"
#import "IFSRefreshView.h"
#import "DoctorViewModel.h"
#import "Disease.h"
#import "Doctor.h"
#import "DoctorInfoViewController.h"

#define identifier @"doctor"

@interface DoctorViewController () <IFSRefreshViewDelegate>

@property (nonatomic, weak) IFSRefreshView *header;
@property (nonatomic, weak) IFSRefreshView *footer;

@property (nonatomic, strong) NSArray *doctors;

@end

@implementation DoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefreshView];
    [self loadDoctor];
}

- (void)setupTableView {
    self.tableView.rowHeight = 80;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"DoctorCell" bundle:nil] forCellReuseIdentifier:identifier];
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

- (void)dealloc {
    [self.header free];
    [self.footer free];
}

- (void)loadDoctor {
    self.disease.page = 1;
    [DoctorViewModel getDoctorWithDisease:self.disease completionHandler:^(NSArray *doctors) {
        if (doctors.count < 1) {
            return;
        }
        
        self.doctors = doctors;
        [self.tableView reloadData];
    }];
}

- (void)loadNewDoctor {
    self.disease.page = 1;
    [DoctorViewModel getDoctorWithDisease:self.disease completionHandler:^(NSArray *doctors) {
        [self.header endRefreshing];
        if (doctors.count < 1) {
            return;
        }
        
        NSMutableArray *arrM = [NSMutableArray array];
        Doctor *firstDoctor = self.doctors.firstObject;
        for (Doctor *doctor in doctors) {
            if (doctor.accuracy.intValue <= firstDoctor.accuracy.intValue) {
                break;
            }
            [arrM addObject:doctor];
        }
        [arrM addObjectsFromArray:self.doctors];
        self.doctors = arrM;
        [self.tableView reloadData];
    }];
}

- (void)loadMoreDoctor {
    if (self.doctors.count % self.disease.page_size) {
        return;
    }
    
    self.disease.page = self.doctors.count / self.disease.page_size + 1;
    [DoctorViewModel getDoctorWithDisease:self.disease completionHandler:^(NSArray *doctors) {
        [self.footer endRefreshing];
        if (doctors.count < 1) {
            return;
        }
        
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.doctors];
        Doctor *lastDoctor = self.doctors.lastObject;
        for (Doctor *doctor in doctors) {
            if (doctor.accuracy.intValue >= lastDoctor.accuracy.intValue) {
                break;
            }
            [arrM addObject:doctor];
        }
        self.doctors = arrM;
        [self.tableView reloadData];
    }];
}

- (void)refreshViewDidBeginRefreshing:(IFSRefreshView *)refreshView {
    if (refreshView.type == IFSHeader) {
        [self loadNewDoctor];
    }
    
    if (refreshView.type == IFSFooter) {
        [self loadMoreDoctor];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.doctors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.doctor = self.doctors[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Doctor *doctor = self.doctors[indexPath.row];
    DoctorInfoViewController *dvc = [[DoctorInfoViewController alloc] init];
    dvc.doctor = doctor;
    [self.navigationController pushViewController:dvc animated:YES];
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
