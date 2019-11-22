//
//  SCNTabMenuViewController.m
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import "SCNTabMenuViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import <JXCategoryView/JXCategoryIndicatorLineView.h>

@interface SCNTabMenuViewController () <JXCategoryViewDelegate>

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@end

@implementation SCNTabMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.categoryView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    
    [self.categoryView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.categoryView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.categoryView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.categoryView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.indexDidChangeBlock(index);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.indexDidChangeBlock(index);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    self.indexDidChangeBlock(index);
}

#pragma mark - Public Methods
- (void)scrollToSelectedIndex:(NSInteger)selectedIndex {
    if (self.categoryView.selectedIndex != selectedIndex) {
        [self.categoryView selectItemAtIndex:selectedIndex];
    }
}

#pragma mark - Getters & Setters

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"推荐", @"附近", @"菜谱", @"视频", @"美食"];
    }
    return _titles;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor redColor];
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        _categoryView = [[JXCategoryTitleView alloc] init];
        _categoryView.translatesAutoresizingMaskIntoConstraints = NO;
        _categoryView.delegate = self;
        _categoryView.titles = self.titles;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}

@end
