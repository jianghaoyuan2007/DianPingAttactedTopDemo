//
//  SCNTabContentViewController.h
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCNTabContentViewController : UITableViewController

@property(nonatomic) BOOL allowsScrolling;

- (UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
