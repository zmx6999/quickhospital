//
//  ViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/22.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "HomeViewController.h"
#import "DiseaseViewController.h"
#import "BannerData.h"
#import "BannerCell.h"
#import "BannerViewModel.h"
#import "ProvinceViewController.h"
#import "WeatherViewModel.h"
#import "WebViewController.h"
#import "LeftView.h"

#define identifier @"bannerData"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (weak, nonatomic) IBOutlet UIView *leadView;

@property (nonatomic, strong) NSArray *bannerDatas;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HomeViewController

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    ProvinceViewController *pvc = [[ProvinceViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
}

- (IBAction)toDisease:(UITapGestureRecognizer *)sender {
    DiseaseViewController *dvc = [[DiseaseViewController alloc] init];
    
    UIView *view = sender.view;
    dvc.ci1Id = view.tag;
    
    NSArray *diseases = @[@"肿瘤", @"血液科", @"心血管", @"神经科", @"骨科"];
    dvc.diseaseName = [diseases objectAtIndex:dvc.ci1Id - 1];
    
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupNav];
    
    [self setupDate];
    [self setupWeather];
    [self setupBanner];
    
    self.leadView.layer.cornerRadius = 4;
    self.leadView.layer.masksToBounds = YES;
    
    [self setupTimer];
    
    [NotificationCenter addObserver:self selector:@selector(didChooseCity:) name:DidChooseCityNotificationName object:nil];
}

- (void)setupNav {
    self.title = @"快医";
    
    UIButton *leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBarButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [leftBarButton addTarget:self.mainViewController action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
}

- (void)dealloc {
    [NotificationCenter removeObserver:self];
}

- (void)didChooseCity:(NSNotification *)noti {
    NSString *city = noti.userInfo[CityUserInfoKey];
    self.cityLabel.text = city;
    [self setupWeather];
}

- (void)setupDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    self.dateLabel.text = [formatter stringFromDate:[NSDate date]];
}

- (void)setupWeather {
    [WeatherViewModel getWeatherWithCityName:self.cityLabel.text responseHandler:^(NSString *cond, NSString *tmp) {
        if (!cond || !tmp) {
            return;
        }
        
        self.weatherLabel.text = cond;
        self.tmpLabel.text = [NSString stringWithFormat:@"温度：%@°C", tmp];
        
        if ([cond containsString:@"晴"]) {
            self.weatherView.image = [UIImage imageNamed:@"sun"];
        } else if ([cond containsString:@"多云"]) {
            self.weatherView.image = [UIImage imageNamed:@"cloudy"];
        } else if ([cond containsString:@"阴"]) {
            self.weatherView.image = [UIImage imageNamed:@"overcast"];
        } else if ([cond containsString:@"雨"]) {
            self.weatherView.image = [UIImage imageNamed:@"rain"];
        } else if ([cond containsString:@"雪"]) {
            self.weatherView.image = [UIImage imageNamed:@"snow"];
        }
    }];
}

- (void)setupBanner {
    [self.collectionView registerNib:[UINib nibWithNibName:@"BannerCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    self.layout.itemSize = CGSizeMake(ScreenW, ScreenW / 414 * 230);
    [BannerViewModel getBannerDataWithResponseHandler:^(NSArray *dataArr) {
        if (dataArr.count < 1) {
            return;
        }
        
        self.bannerDatas = dataArr;
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.pageControl.numberOfPages = self.bannerDatas.count;
    }];
}

- (void)setupTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTimer {
    CGPoint contentOffset = self.collectionView.contentOffset;
    contentOffset.x += ScreenW;
    [self.collectionView setContentOffset:contentOffset animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.bannerDatas.count < 1) {
        return 0;
    }
    
    if (section == 0 || section == 2) {
        return 1;
    } else {
        return self.bannerDatas.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    BannerData *data = self.bannerDatas[indexPath.item];
    if (indexPath.section == 0) {
        data = self.bannerDatas.lastObject;
    }
    cell.imgUrl = data.banner_img_url;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerData *data = self.bannerDatas[indexPath.item];
    WebViewController *wvc = [[WebViewController alloc] init];
    wvc.urlstr = data.banner_link;
    [self.navigationController pushViewController:wvc animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    [self setupTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.bannerDatas.count < 1) {
        return;
    }
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger page = contentOffsetX / ScreenW;
    
    if (page == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.bannerDatas.count - 1 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.pageControl.currentPage = self.bannerDatas.count - 1;
        return;
    }
    
    if (page == self.bannerDatas.count + 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.pageControl.currentPage = 0;
        return;
    }
    
    self.pageControl.currentPage = page - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

@end