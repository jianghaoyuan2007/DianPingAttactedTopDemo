//
//  SCNTabsViewController.m
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import "SCNTabsViewController.h"
#import "SCNTabContentViewController.h"

NSString *const SCNTabsViewControllerScrollDidTopNotification = @"SCNTabsViewControllerScrollDidTopNotification";

@interface SCNTabsViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation SCNTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index - 1 < 0) { return nil; }
    return self.viewControllers[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index + 1 > self.viewControllers.count - 1) { return nil; }
    return self.viewControllers[index + 1];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (!finished) { return; }
    self.selectedPageIndex = [self.viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
}

#pragma mark - Public Methods

- (void)scrollToViewControllerAtPageIndex:(NSInteger)pageIndex animated:(BOOL)animated {
    if (self.selectedPageIndex == pageIndex) { return; }
    if (self.viewControllers.count - 1 < pageIndex || pageIndex < 0) { return; }
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (self.selectedPageIndex > pageIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    UIViewController *viewController = self.viewControllers[pageIndex];
    __weak __typeof__(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[viewController]
                                      direction:direction
                                       animated:animated
                                     completion:^(BOOL finished) {
                                         __strong __typeof__(self) strongSelf = weakSelf;
                                         if (finished) { strongSelf.selectedPageIndex = pageIndex; }
                                     }];
}

#pragma mark - Private Methods

- (void)__updateAllowsScrollingOfChildViewControllers {
    for (UIViewController *viewController in self.viewControllers) {
        [viewController setValue:@(self.allowsScrolling) forKey:@"allowsScrolling"];
        if (!self.allowsScrolling) {
            UIScrollView *scrollView = [viewController valueForKey:@"scrollView"];
            scrollView.contentOffset = CGPointZero;
        }
    }
}

#pragma mark - Getters & Setters

- (void)setAllowsScrolling:(BOOL)allowsScrolling {
    _allowsScrolling = allowsScrolling;
    [self __updateAllowsScrollingOfChildViewControllers];
}

- (NSArray *)viewControllers {
    if (!_viewControllers) {
        NSMutableArray *controllers = [NSMutableArray new];
        [controllers addObject:SCNTabContentViewController.new];
        [controllers addObject:SCNTabContentViewController.new];
        [controllers addObject:SCNTabContentViewController.new];
        [controllers addObject:SCNTabContentViewController.new];
        [controllers addObject:SCNTabContentViewController.new];
        _viewControllers = [controllers copy];
    }
    return _viewControllers;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        self.pageViewController.dataSource = self;
        self.pageViewController.delegate = self;
        [self.pageViewController setViewControllers:@[self.viewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return _pageViewController;
}

- (void)setSelectedPageIndex:(NSInteger)selectedPageIndex {
    if (_selectedPageIndex != selectedPageIndex) {
        _selectedPageIndex = selectedPageIndex;
        self.selectedPageIndexDidChangeBlock(selectedPageIndex);
    }
}

@end
