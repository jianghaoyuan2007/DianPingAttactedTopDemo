//
//  SCNScrollView.m
//  DianPingAttactedTopDemo
//
//  Created by Stephen Chiang on 2019/11/22.
//  Copyright © 2019 stephenchiang.net. All rights reserved.
//

#import "SCNScrollView.h"

@interface SCNScrollView () <UIGestureRecognizerDelegate>

@end

@implementation SCNScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
