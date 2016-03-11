//
//  SSPageScrollView.h
//  SSPageScrollView
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSPageScrollView;



@protocol SSPageScrollViewDelegate <UIScrollViewDelegate>

@required
- (NSInteger)numberOfPageInPageScrollView:(SSPageScrollView*)pageScrollView;
@optional
- (CGSize)sizeCellForPageScrollView:(SSPageScrollView*)pageScrollView;
- (void)pageScrollView:(SSPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index;
@end




@protocol SSPageScrollViewDataSource <UIScrollViewDelegate>

@required
- (UIView*)pageScrollView:(SSPageScrollView *)pageScrollView viewForRowAtIndex:(int)index;
@end



@interface SSPageScrollView : UIScrollView

@property (nonatomic, assign) CGSize  cellSize;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) float leftRightOffset;
@property (nonatomic, strong) UIImageView* backgroundView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray* visibleCell;
@property (nonatomic, strong) NSMutableSet* cacheCells;
@property (nonatomic, strong) NSMutableDictionary* visibleCellsMap;
@property (nonatomic, assign) CGFloat pageViewWith;

@property (nonatomic, weak) id<SSPageScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<SSPageScrollViewDelegate> delegate;

- (void)reloadData;
- (UIView*)viewForRowAtIndex:(NSInteger)index;

@end
