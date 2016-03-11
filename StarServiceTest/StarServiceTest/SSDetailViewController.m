//
//  SSDetailViewController.m
//  StarServiceTest
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import "SSDetailViewController.h"

@interface SSDetailViewController ()

@end

@implementation SSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.albumView.image = [UIImage imageNamed:@"Placeholder.jpg"];
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.albumView];
    self.albumView.imageURL = [NSURL URLWithString:self.albumUrl];
    self.titleLabel.text = self.albumTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
