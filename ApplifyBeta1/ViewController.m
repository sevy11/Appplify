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

@property NSArray *twitterArray;
@property NSDictionary *user;
@property NSString *text;
@property NSDictionary *screenName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSearchWithKeyword:@"timberlake"];
    
}

- (void)performSearchWithKeyword:(NSString *)incomingString  {

     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://intutvp.herokuapp.com/intutv/api/v1.0/search/twitter/%@",incomingString]];
 
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
 
                                if (!connectionError) {
                                    self.twitterArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];


                                    for (NSArray *array in self.twitterArray) {
                                        NSDictionary *item = array[1];
                                        self.text = item[@"text"];

                                        self.user = item[@"user"];
                                        self.screenName = self.user[@"screen_name"];
                                        NSLog(@"%@", self.screenName);

                                        NSDate *todaysDate = [NSDate date];
                                        NSLog(@"%@", todaysDate);

                                        [self.tableView reloadData];


                        }
                }
        }];

    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TwitterCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
    
    TwitterClass *twitterName = [self.twitterArray objectAtIndex:indexPath.row];//need to feed the cell here with an array


    NSString *texter = [NSString stringWithFormat:@"%@", self.text];
    [cell.text setText:texter];

    NSString *user = [NSString stringWithFormat:@"%@", self.screenName];
    cell.username.text = user;
    //set this cell.username.text = twitterClass name by putting the business logic in twitter class and then saying local variable twitterName.propery on the TwitterClass Class
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.twitterArray.count;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 420;
//}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.twitterArray.count;
//}
@end
