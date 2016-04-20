//
//  ProvinceViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/24.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ProvinceViewController.h"
#import "Province.h"
#import "CityViewController.h"

@interface ProvinceViewController ()

@property (nonatomic, strong) NSArray *provinces;

@end

@implementation ProvinceViewController

- (NSArray *)provinces {
    if (_provinces == nil) {
        NSArray *provinces = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil]];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in provinces) {
            Province *province = [Province provinceWithDict:dict];
            [arrM addObject:province];
        }
        _provinces = arrM;
    }
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of sections
    return self.provinces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#warning Incomplete implementation, return the number of rows
    static NSString *identier = @"province";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Province *province = self.provinces[indexPath.row];
    cell.textLabel.text = province.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Province *province = self.provinces[indexPath.row];
    if (province.cities.count < 1) {
        [NotificationCenter postNotificationName:DidChooseCityNotificationName object:nil userInfo:@{CityUserInfoKey: province.name}];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    CityViewController *cvc = [[CityViewController alloc] init];
    cvc.cities = province.cities;
    [self.navigationController pushViewController:cvc animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
