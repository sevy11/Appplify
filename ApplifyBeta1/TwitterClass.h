//
//  TwitterClass.h
//  ApplifyBeta1
//
//  Created by Michael Sevy on 4/11/15.
//  Copyright (c) 2015 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface TwitterClass : NSObject

@property NSArray *twitterArray;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *timeDiff;
@property NSString *text;

@property NSArray *tweetArray;

@property (nonatomic, strong) UIImage *image;
@property NSData *profileData;

@property (nonatomic, strong) UIImage *mainImage;
@property NSData *mainImageData;

- (void)performSearchWithKeyword:(NSString *)incomingString;

@end
