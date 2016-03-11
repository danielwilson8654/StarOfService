//
//  SSiTunesSearch.m
//  StarServiceTest
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import "SSiTunesSearch.h"


@implementation SSiTunesSearch{
    NSMutableArray *albumArray;
}

#pragma mark - Initialization

+ (SSiTunesSearch *)sharedInstance {
    static dispatch_once_t pred;
    static SSiTunesSearch *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        albumArray = [NSMutableArray array];
    }
    return self;
}

- (void)update{
    NSString *urlString = API_URL;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [albumArray removeAllObjects];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (!error) {
                                   NSError* parseError;
                                   id parse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
                                   NSLog(@"%@", parse);
                                   NSArray *results = [parse objectForKey:@"results"];
                                   if (results) {
                                       for (NSMutableDictionary *row in results) {
                                           NSMutableDictionary *album = [NSMutableDictionary dictionary];
                                           if (row[@"artworkUrl60"] && row[@"collectionName"]) {
                                               [album setObject:row[@"artworkUrl60"] forKey:@"album"];
                                               [album setObject:row[@"collectionName"] forKey:@"description"];
                                               [albumArray addObject:album];
                                           }
                                       }
                                   }
                                   [[NSNotificationCenter defaultCenter] postNotificationName:AlbumUpdated object:albumArray];
                               }
                           }];
}

- (NSMutableArray*)albumArray{
    return albumArray;
}
@end
