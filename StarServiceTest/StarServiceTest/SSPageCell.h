//
//  SSPageCell.h
//  SSPageScrollView
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPageCell : UIView

@property (strong, nonatomic) UIView* contentView;
@property (strong, nonatomic) UIView* selectedBackgroundView;
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSString* identifiy;
@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithIdentifiy:(NSString*)identifiy;

@end
