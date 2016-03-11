//
//  SSiTunesSearch.h
//  StarServiceTest
//
//  Created by Daniel Wilson on 3/11/16.
//  Copyright © 2016 Daniel Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AlbumUpdated @"UpdatedAlbums"
#define API_URL @"https://itunes.apple.com/"

@interface SSiTunesSearch : NSObject
+ (SSiTunesSearch *)sharedInstance;
- (NSMutableArray*)albumArray;
- (void)update;
@end
