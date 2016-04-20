//
//  LeftView.h
//  QuickHospital
//
//  Created by zmx on 16/3/29.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftView;

@protocol LeftViewDelegate <NSObject>

- (void)leftViewWillLogin:(LeftView *)leftView;
- (void)leftViewWillRegister:(LeftView *)leftView;

@end

@interface LeftView : UIView

@property (nonatomic, weak) id<LeftViewDelegate> delegate;

@end