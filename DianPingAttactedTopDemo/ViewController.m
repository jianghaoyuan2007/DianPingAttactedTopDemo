//
//  ViewController.m
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import "ViewController.h"
#import "SCNScrollView.h"
#import "SCNTopViewController.h"
#import "SCNTabMenuViewController.h"
#import "SCNTabsViewController.h"
#import "SCNScrollView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SCNScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *tabMenuView;

@property(nonatomic) BOOL allowsScrolling;

@property (nonatomic, strong) SCNTabMenuViewController *tabMenu;
@property (nonatomic, strong) SCNTabsViewController *tabs;
@property (nonatomic, readonly) SCNTabsViewController *container;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.allowsScrolling = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(tabsViewControllerScrollDidTopNotification:)
               name:SCNTabsViewControllerScrollDidTopNotification
             object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [NSNotificationCenter.defaultCenter removeObserver:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SCNTabMenuViewController"]) {
        self.tabMenu = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"SCNTabsViewController"]) {
        self.tabs = segue.destinationViewController;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat fixedMaximumOffsetY = CGRectGetMinY(self.tabMenuView.frame);
    if (scrollView.contentOffset.y >= fixedMaximumOffsetY) {
        scrollView.contentOffset = CGPointMake(0, fixedMaximumOffsetY);
        if (self.allowsScrolling) {
            self.allowsScrolling = NO;
            // All view controllers allows scrolling.
            self.container.allowsScrolling = YES;
        }
    } else if (!self.allowsScrolling) {
        scrollView.contentOffset = CGPointMake(0, fixedMaximumOffsetY);
    }
    scrollView.showsVerticalScrollIndicator = self.allowsScrolling;
}

#pragma mark - Responding Events
- (void)tabsViewControllerScrollDidTopNotification:(NSNotification *)notification {
    self.allowsScrolling = YES;
    self.container.allowsScrolling = NO;
}

#pragma mark - Getters & Setters

- (void)setTabMenu:(SCNTabMenuViewController *)tabMenu {
    _tabMenu = tabMenu;
    __weak typeof(self) weakSelf = self;
    _tabMenu.indexDidChangeBlock = ^(NSInteger index) {
        [weakSelf.tabs scrollToViewControllerAtPageIndex:index animated:YES];
    };
}

- (void)setTabs:(SCNTabsViewController *)tabs {
    _tabs = tabs;
    __weak typeof(self) weakSelf = self;
    _tabs.selectedPageIndexDidChangeBlock = ^(NSInteger selectedPageIndex) {
        [weakSelf.tabMenu scrollToSelectedIndex:selectedPageIndex];
    };
}

- (SCNTabsViewController *)container {
    return self.tabs;
}

@end
