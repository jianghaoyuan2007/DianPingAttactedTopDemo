//
//  SCNTabMenuViewController.h
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SCNTabMenuViewControllerIndexDidChangeBlock)(NSInteger index);

@interface SCNTabMenuViewController : UIViewController

@property (nonatomic, copy) SCNTabMenuViewControllerIndexDidChangeBlock indexDidChangeBlock;

- (void)scrollToSelectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
