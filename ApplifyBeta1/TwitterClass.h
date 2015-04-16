//
//  TwitterClass.h
//  ApplifyBeta1
//
//  Created by Michael Sevy on 4/11/15.
//  Copyright (c) 2015 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterClass : NSObject
@property NSArray *twitterArray;


@property (nonatomic, strong) NSString *name;

//@property (nonatomic, strong) NSString *twitterName;
//@property (nonatomic, strong) NSString *RSVPCount;
//@property (nonatomic, strong) NSString *hostedBy;
//@property (nonatomic, strong) NSString *eventDescription;
//@property (nonatomic, strong) NSString *address;
//@property (nonatomic, strong) NSURL *eventURL;
//@property (nonatomic, strong) NSURL *photoURL;
//@property (nonatomic, strong) NSArray *commentsArray;


- (void)performSearchWithKeyword:(NSString *)incomingString;
- (instancetype)initWithDictionary:(NSString *)name;
//+ (NSArray *)tweetsFromArray:(NSArray *)incomingArray;
//+ (void)performSearchWithKeyword:(NSString *)incomingString withCompletion:(void (^)(NSArray *events))complete;

@end
