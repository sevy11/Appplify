//
//  ViewController.m
//  ApplifyBeta1
//
//  Created by Michael Sevy on 4/11/15.
//  Copyright (c) 2015 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import "TwitterClass.h"
#import "TwitterCustomTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *items;
@property NSArray *media;
@property float timingDiff;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.items = [NSMutableArray new];

    [self performSearchWithKeyword:@"timberlake"];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TwitterCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];

    TwitterClass *tweet = [self.items objectAtIndex:indexPath.row];

    cell.username.text = tweet.userName;
    cell.name.text = tweet.screenName;

    if (self.timingDiff < 1) {
        NSString *sec = [NSString stringWithFormat:@"Error"];
        cell.time.text = sec;
    } else if (self.timingDiff < 60){
        NSString *min = [NSString stringWithFormat:@"%f ago", self.timingDiff];
        cell.time.text = min;
    } else if (self.timingDiff < 3600){
        int diffRound = round(self.timingDiff / 60);
        NSString *hour = [NSString stringWithFormat:@"%dm ago", diffRound];
        cell.time.text = hour;
    } else if (self.timingDiff < 86400){
        int diffRound = round(self.timingDiff / 60 / 60);
        NSString *day = [NSString stringWithFormat:@"%d hours's ago", diffRound];
        cell.time.text = day;
    } else if (self.timingDiff < 2629743){
        int diffRound = round(self.timingDiff / 60 / 60 / 24);
        NSString *week = [NSString stringWithFormat:@"%d day's ago", diffRound];
        cell.time.text = week;
    } else if (self.timingDiff < 18408201) {
        int diffRound = round(self.timingDiff / 60 / 60 / 24 / 7);
        NSString *month = [NSString stringWithFormat:@"%d, week's ago", diffRound];
        NSLog(@"%@", month);
    } else{
        NSString *elseStatment = [NSString stringWithFormat:@"Over a week"];
        cell.time.text = elseStatment;
    }

    [cell.textView setText:tweet.text];
    cell.userImage.image = [UIImage imageWithData:tweet.profileData];
    cell.twitterLogo.image = [UIImage imageNamed:@"Twitter_logo_blue"];

//    if ([self.media isEqual:@""]) {
//        cell.tweetImage.backgroundColor = [UIColor grayColor];
//    } else {
//        cell.tweetImage.backgroundColor = [UIColor greenColor];
//
//    }
    cell.tweetImage.image = [UIImage imageWithData:tweet.mainImageData];

    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (void)performSearchWithKeyword:(NSString *)incomingString  {

     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://intutvp.herokuapp.com/intutv/api/v1.0/search/twitter/%@",incomingString]];

     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                                if (!connectionError) {
                                    NSArray *twitterArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

                                    //loop through JSON array
                                    for (NSArray *array in twitterArray) {
                                        TwitterClass *twitter = [TwitterClass new];

                                        NSDictionary *item = array[1];

                                        NSString *text = item[@"text"];
                                        twitter.text = text;

                                        NSDictionary *user = item[@"user"];
                                        NSString *screenName = user[@"screen_name"];
                                        twitter.screenName = screenName;

                                        NSString *name = user[@"name"];
                                        twitter.userName = name;
                                        NSLog(@"%@", screenName);

                                        ///......DATE......//
                                        NSString *createdAt = item[@"created_at"];
                                        NSDateFormatter *formatter = [NSDateFormatter new];
                                        [formatter setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
                                        NSDate *tweetDate = [NSDate new];
                                        tweetDate = [formatter dateFromString:createdAt];
                                        //now
                                        NSDate *nowDate = [NSDate date];
                                        NSDateFormatter *format = [NSDateFormatter new];
                                        [format setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
                                        self.timingDiff = [nowDate timeIntervalSinceDate:tweetDate];
                                        NSLog(@"%f", self.timingDiff);                                        

                                        //...PROFILE PIC...//
                                        NSString *userPicURL = user[@"profile_image_url_https"];
                                        NSURL *profileURL = [NSURL URLWithString:userPicURL];
                                        NSData *profileData = [NSData dataWithContentsOfURL:profileURL];
                                        twitter.profileData = profileData;

                                        //....MAIN PIC......//
                                        NSDictionary *entities = item[@"entities"];
                                        self.media = entities[@"media"];

                                        if (self.media != nil) {
                                        for (NSDictionary *mediaItem in self.media) {
                                            NSString *mediaURL = mediaItem[@"media_url_https"];
                                            NSLog(@"......Main Pic .......%@", mediaURL);

                                        NSURL *mainPicURL = [NSURL URLWithString:mediaURL];
                                        NSData *mainPicData = [NSData dataWithContentsOfURL:mainPicURL];
                                        twitter.mainImageData = mainPicData;
                                        }
                                        } else {
                                            NSLog(@"..........no main Pic...........%@", self.media);
                                        }

                                        [self.items addObject:twitter];
                                        [self.tableView reloadData];

                                }
                        }

        }];

}

@end
