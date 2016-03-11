//
//  SSDetailViewController.h
//  StarServiceTest
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface SSDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet AsyncImageView *albumView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSString *albumUrl;
@property NSString *albumTitle;
@end
