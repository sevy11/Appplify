//
//  TwitterCustomTableViewCell.h
//  ApplifyBeta1
//
//  Created by Michael Sevy on 4/11/15.
//  Copyright (c) 2015 Michael Sevy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *twitterLogo;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;

- (void)textViewDidChange:(UITextView *)textView;


@end
