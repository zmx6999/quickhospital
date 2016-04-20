//
//  IFSRefreshView.h
//  Weibo
//
//  Created by zmx on 16/3/20.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    IFSHeader = 0,
    IFSFooter = 1
} IFSRefreshType;

@class IFSRefreshView;

@protocol IFSRefreshViewDelegate <NSObject>

- (void)refreshViewDidBeginRefreshing:(IFSRefreshView *)refreshView;

@end

@interface IFSRefreshView : UIView

@property (nonatomic, assign) IFSRefreshType type;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) id<IFSRefreshViewDelegate> delegate;

+ (instancetype)refreshViewWithType:(IFSRefreshType)type;

- (void)beginRefreshing;
- (void)endRefreshing;
- (void)free;

@end