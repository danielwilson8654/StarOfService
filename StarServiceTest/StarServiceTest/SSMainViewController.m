//
//  ViewController.m
//  StarServiceTest
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import "SSMainViewController.h"
#import "SSPageScrollView.h"
#import "SSPageView.h"
#import "SSiTunesSearch.h"
#import "AsyncImageView.h"
#import "SSDetailViewController.h"

@interface SSMainViewController ()<SSPageScrollViewDataSource,SSPageScrollViewDelegate>

@end

@implementation SSMainViewController{
    NSMutableArray *albums;
    SSPageView *PScrollView;
    UILabel *descriptionLabel;
    NSInteger selectedIndex;
    UIButton *nextpageButton;
    UIActivityIndicatorView *spinner;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateScroll) name:AlbumUpdated object:nil];
    [[SSiTunesSearch sharedInstance] update];
    
    
    PScrollView = [[SSPageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height*0.6)];
    PScrollView.pageScrollView.dataSource = self;
    PScrollView.pageScrollView.delegate = self;
    PScrollView.pageScrollView.padding = 50;
    PScrollView.pageScrollView.leftRightOffset = 0;
    PScrollView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -150)/2, 60, 150, 100);
    PScrollView.pageScrollView.center = CGPointMake(PScrollView.bounds.size.width/2.0, PScrollView.bounds.size.height/2.0);
    PScrollView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:79.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    [self.view addSubview:PScrollView];
    
    
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, PScrollView.frame.size.height, [[UIScreen mainScreen] bounds].size.width, 50)];
    descriptionLabel.backgroundColor = [UIColor greenColor];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.textColor = [UIColor blackColor];
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:descriptionLabel];
    
    
    nextpageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    nextpageButton.center = CGPointMake(descriptionLabel.center.x, descriptionLabel.center.y + 100);
    [nextpageButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextpageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextpageButton addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextpageButton];
    
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = PScrollView.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
 
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (NSInteger)numberOfPageInPageScrollView:(SSPageScrollView*)pageScrollView{
    return [albums count];
}


- (UIView*)pageScrollView:(SSPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    cell.backgroundColor = [UIColor whiteColor];
    
    AsyncImageView *albumView = [[AsyncImageView alloc] initWithFrame:cell.bounds];
    albumView.image = [UIImage imageNamed:@"Placeholder.jpg"];
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:albumView];
    albumView.imageURL = [NSURL URLWithString:albums[index][@"album"]];
    [cell addSubview:albumView];
    
    return cell;
}


- (CGSize)sizeCellForPageScrollView:(SSPageScrollView*)pageScrollView
{
    return CGSizeMake(100, 100);
}


- (void)pageScrollView:(SSPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"click cell at %ld",(long)index);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    selectedIndex = index;
    descriptionLabel.text = albums[index][@"description"];
}


- (void)updateScroll{
    albums = [[SSiTunesSearch sharedInstance] albumArray];
    [spinner stopAnimating];
    [PScrollView.pageScrollView reloadData];
}


- (void)nextPage{
    [self performSegueWithIdentifier:@"go2detail" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"go2detail"]) {
        SSDetailViewController *destViewController = segue.destinationViewController;
        destViewController.albumUrl = albums[selectedIndex][@"album"];
        destViewController.albumTitle = albums[selectedIndex][@"description"];
    }
}

@end
