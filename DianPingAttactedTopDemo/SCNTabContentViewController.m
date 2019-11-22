//
//  SCNTabContentViewController.m
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import "SCNTabContentViewController.h"
#import "SCNTabsViewController.h"

@interface SCNTabContentViewController ()

@end

@implementation SCNTabContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.allowsScrolling) { self.tableView.contentOffset = CGPointZero; }
    if (self.tableView.contentOffset.y < 0) {
        self.allowsScrolling = NO;
        self.tableView.contentOffset = CGPointZero;
        // Post a notifcation about outter scroll can scroll.
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:SCNTabsViewControllerScrollDidTopNotification object:nil];
    }
    self.tableView.showsVerticalScrollIndicator = self.allowsScrolling;
}

#pragma mark - Getters & Setters

- (UIScrollView *)scrollView { return self.tableView; }

@end
