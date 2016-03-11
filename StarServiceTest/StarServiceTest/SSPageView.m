//
//  SSPageView.m
//  SSPageScrollView
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import "SSPageView.h"

@implementation SSPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageScrollView = [[SSPageScrollView alloc] init];
        [self.pageScrollView setPagingEnabled:YES];
        [self.pageScrollView setClipsToBounds:NO];
        self.pageScrollView.pageViewWith = self.frame.size.width;
        [self addSubview:self.pageScrollView];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!CGRectContainsPoint(self.pageScrollView.frame, point)) {
        return self.pageScrollView;
    }
    return [super hitTest:point withEvent:event];
}

@end
