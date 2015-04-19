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

            //loop through JSON array
            for (NSArray *array in self.twitterArray) {
                NSDictionary *item = array[1];
                //pull elements out
                self.text = item[@"text"];

                //Screen Name
                NSDictionary *user = item[@"user"];
                self.screenName = user[@"screen_name"];
                //Name
                self.userName = user[@"name"];

                //date object
                NSString *createdAt = item[@"created_at"];
                NSDateFormatter *formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
                NSDate *tweetDate = [NSDate new];
                tweetDate = [formatter dateFromString:createdAt];
                NSDate *nowDate = [NSDate date];
                NSDateFormatter *format = [NSDateFormatter new];
                [format setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
                float timingDiff = [nowDate timeIntervalSinceDate:tweetDate];

                if (timingDiff < 1) {
                    self.timeDiff = [NSString stringWithFormat:@"Error"];
                } else if (timingDiff < 60){
                    self.timeDiff = [NSString stringWithFormat:@"%f ago", timingDiff];
                } else if (timingDiff < 3600){
                    int diffRound = round(timingDiff / 60);
                    self.timeDiff = [NSString stringWithFormat:@"%dm ago", diffRound];
                } else if (timingDiff < 86400){
                    int diffRound = round(timingDiff / 60 / 60);
                    self.timeDiff = [NSString stringWithFormat:@"%d hours's ago", diffRound];
                } else if (timingDiff < 2629743){
                    int diffRound = round(timingDiff / 60 / 60 / 24);
                    self.timeDiff = [NSString stringWithFormat:@"%d day's ago", diffRound];
                } else if (timingDiff < 18408201) {
                    int diffRound = round(timingDiff / 60 / 60 / 24 / 7);
                    self.timeDiff = [NSString stringWithFormat:@"%d, week's ago", diffRound];
                } else{
                    self.timeDiff = [NSString stringWithFormat:@"Over a week"];
                }

                //images
                NSString *userPicURL = user[@"profile_image_url_https"];
                NSURL *profileURL = [NSURL URLWithString:userPicURL];
                self.profileData = [NSData dataWithContentsOfURL:profileURL];

               // NSString *mainPicURL =


            }
        }
    }];

}

@end
