//
//  TwitterClass.m
//  ApplifyBeta1
//
//  Created by Michael Sevy on 4/11/15.
//  Copyright (c) 2015 Michael Sevy. All rights reserved.
//

#import "TwitterClass.h"

@implementation TwitterClass

- (void)performSearchWithKeyword:(NSString *)incomingString  {

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://intutvp.herokuapp.com/intutv/api/v1.0/search/twitter/%@",incomingString]];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (!connectionError) {
            self.twitterArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

            for (NSArray *array in self.twitterArray) {
                NSDictionary *item = array[1];
                //NSDictionary *text = item[@"text"];

                NSDictionary *user = item[@"user"];
                NSLog(@"%@", user[@"screen_name"]);

//                NSDate *todaysDate = [NSDate date];
//                NSLog(@"%@", todaysDate);
//
//                TwitterClass *tweetName = [[TwitterClass alloc]initWithDictionary:self.user[@"screen_name"]];
//                NSLog(@"%@", tweetName);


            }
        }
    }];
}


//-(instancetype)initWithDictionary:(NSString *)name  {
//    self = [super init];
//    if (self) {
//        self.twitterName = name;
//    }
//    return self;
//}
//- (instancetype)initWithDictionary:(NSDictionary *)dictionary   {
//
//    self = [super init];
//    if (self) {
//        self.name = dictionary[@"name"];
//
//        self.eventID = dictionary[@"id"];
//        self.RSVPCount = [NSString stringWithFormat:@"%@",dictionary[@"yes_rsvp_count"]];//they give a NSNumber we change to a string
//        self.hostedBy = dictionary[@"group"][@"name"];
//        self.eventDescription = dictionary[@"description"];
//        self.address = dictionary[@"venue"][@"address"];
//        self.eventURL = [NSURL URLWithString:dictionary[@"event_url"]];
//        self.photoURL = [NSURL URLWithString:dictionary[@"photo_url"]];
//    }
//    return self;
//    }
//}




//+ (NSArray *)tweetsFromArray:(NSArray *)incomingArray
//{//this method arranges the JSON for you using the loop below
//    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:incomingArray.count];
//    //making a new array from the item array in the JSON file
//    for (NSDictionary *d in incomingArray) {
//        TwitterClass *t = [[TwitterClass alloc]initWithDictionary:d];
//        [newArray addObject:t];
//    }
//    return newArray;
//}

@end
