//
//  IFSRefreshView.m
//  Weibo
//
//  Created by zmx on 16/3/20.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSRefreshView.h"

#define viewH 64
#define kContentOffsetKey @"contentOffset"
typedef enum {
    IFSNormal = 0,
    IFSPullToRefresh = 1,
    IFSReleaseToRefresh = 2,
    IFSRefresh = 3
} IFSState;

@interface IFSRefreshView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign, readonly) CGFloat scrollW;
@property (nonatomic, assign, readonly) CGFloat scrollH;
@property (nonatomic, assign, readonly) CGFloat contentH;


@property (nonatomic, assign) IFSState state;

@end

@implementation IFSRefreshView

- (CGFloat)scrollW {
    return self.scrollView.frame.size.width;
}

- (CGFloat)scrollH {
    return self.scrollView.frame.size.height;
}

- (CGFloat)contentH {
    return self.scrollView.contentSize.height;
}

+ (instancetype)refreshViewWithType:(IFSRefreshType)type {
    IFSRefreshView *view = [[[NSBundle mainBundle] loadNibNamed:@"IFSRefreshView" owner:nil options:nil] firstObject];
    view.type = type;
    return view;
}

- (void)setState:(IFSState)state {
    _state = state;
    
    switch (state) {
        case IFSNormal: {
            self.titleLabel.text = nil;
            
            self.indicatorView.hidden = YES;
            if (self.indicatorView.isAnimating) {
                [self.indicatorView stopAnimating];
            }
            
            if (self.type == IFSHeader) {
                UIEdgeInsets edgeInsets = self.scrollView.contentInset;
                edgeInsets.top = 0;
                self.scrollView.contentInset = edgeInsets;
            } else if (self.type == IFSFooter) {
                UIEdgeInsets edgeInsets = self.scrollView.contentInset;
                edgeInsets.bottom = 0;
                self.scrollView.contentInset = edgeInsets;
            }
            
            break;
        }
            
        case IFSPullToRefresh: {
            self.indicatorView.hidden = YES;
            
            if (self.type == IFSHeader) {
                self.titleLabel.text = @"下拉刷新";
            } else if (self.type == IFSFooter) {
                self.titleLabel.text = @"上拉加载更多";
            }
            
            break;
        }
            
        case IFSReleaseToRefresh: {
            self.indicatorView.hidden = YES;
            
            if (self.type == IFSHeader) {
                self.titleLabel.text = @"松开手立刻刷新";
            } else if (self.type == IFSFooter) {
                self.titleLabel.text = @"松开手立刻加载";
            }
            
            break;
        }
            
        case IFSRefresh: {
            self.indicatorView.hidden = NO;
            if (!self.indicatorView.isAnimating) {
                [self.indicatorView startAnimating];
            }
            
            if (self.type == IFSHeader) {
                self.titleLabel.text = @"正在刷新...";
                
                UIEdgeInsets edgeInsets = self.scrollView.contentInset;
                edgeInsets.top = viewH;
                self.scrollView.contentInset = edgeInsets;
            } else if (self.type == IFSFooter) {
                self.titleLabel.text = @"正在加载...";
                
                UIEdgeInsets edgeInsets = self.scrollView.contentInset;
                edgeInsets.bottom = viewH;
                self.scrollView.contentInset = edgeInsets;
            }
            
            if ([self.delegate respondsToSelector:@selector(refreshViewDidBeginRefreshing:)]) {
                [self.delegate refreshViewDidBeginRefreshing:self];
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    [scrollView addSubview:self];
    [scrollView addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
}

- (void)free {
    [self.scrollView removeObserver:self forKeyPath:kContentOffsetKey];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.type == IFSHeader) {
        self.frame = CGRectMake(0, -viewH, self.scrollW, viewH);
    } else if (self.type == IFSFooter) {
        self.frame = CGRectMake(0, self.contentH >= self.scrollH ? self.contentH : self.scrollH, self.scrollW, viewH);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentOffsetKey]) {
        CGFloat contentOffsetY = self.scrollView.contentOffset.y;
        if (self.state != IFSRefresh) {
            if (self.type == IFSHeader) {
                if (self.scrollView.isDragging) {
                    if (contentOffsetY >= 0) {
                        self.state = IFSNormal;
                    } else if (contentOffsetY >= -viewH) {
                        self.state = IFSPullToRefresh;
                    } else {
                        self.state = IFSReleaseToRefresh;
                    }
                } else {
                    if (self.state == IFSReleaseToRefresh) {
                        self.state = IFSRefresh;
                    }
                }
            } else if (self.type == IFSFooter) {
                if (self.scrollView.isDragging) {
                    if (contentOffsetY <= self.contentH - self.scrollH) {
                        self.state = IFSNormal;
                    } else if (contentOffsetY <= self.contentH - self.scrollH + viewH) {
                        self.state = IFSPullToRefresh;
                    } else {
                        self.state = IFSReleaseToRefresh;
                    }
                } else {
                    if (self.state == IFSReleaseToRefresh) {
                        self.state = IFSRefresh;
                    }
                }
            }
        }
    }
}

- (void)beginRefreshing {
    if (self.state != IFSRefresh) {
        self.state = IFSRefresh;
    }
}

- (void)endRefreshing {
    if (self.state == IFSRefresh) {
        self.state = IFSNormal;
    }
}

@end
