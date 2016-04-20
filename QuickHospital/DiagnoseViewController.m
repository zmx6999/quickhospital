//
//  DiagnoseViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DiagnoseViewController.h"
#import "Diagnose.h"
#import "DiseaseDetailViewModel.h"

@interface DiagnoseViewController ()

@property (nonatomic, strong) NSArray *diagnoses;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation DiagnoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self loadDiagnose];
}

- (void)setupTableView {
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)loadDiagnose {
    [DiseaseDetailViewModel getDiagnoseMethodWithCompletionHandler:^(NSArray *diagnoses) {
        if (diagnoses.count < 1) {
            return;
        }
        
        self.diagnoses = diagnoses;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.diagnoses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"diagnose";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = [UIImage imageNamed:@"multiple_selected"];
        cell.accessoryView = imageView;
    }
    
    Diagnose *diagnose = self.diagnoses[indexPath.row];
    NSString *diagnoseName = diagnose.diagnosis_type_name;
    cell.textLabel.text = diagnoseName;
    
    cell.accessoryView.hidden = ![diagnoseName isEqualToString:self.choosedDiagnose.diagnosis_type_name];
    if (!cell.accessoryView.hidden) {
        self.selectedIndexPath = indexPath;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
    selectedCell.accessoryView.hidden = YES;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView.hidden = NO;
    self.choosedDiagnose = self.diagnoses[indexPath.row];
    
    if (self.chooseDiagnose) {
        self.chooseDiagnose(self.choosedDiagnose);
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
