//
//  SCNTabsViewController.h
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const SCNTabsViewControllerScrollDidTopNotification;

typedef void(^SCNTabsViewControllerSelectedPageIndexDidChangeBlock)(NSInteger);

@interface SCNTabsViewController : UIViewController

@property (nonatomic) NSInteger selectedPageIndex;

@property(nonatomic) BOOL allowsScrolling;

@property (nonatomic, copy) SCNTabsViewControllerSelectedPageIndexDidChangeBlock selectedPageIndexDidChangeBlock;

- (void)scrollToViewControllerAtPageIndex:(NSInteger)pageIndex animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
