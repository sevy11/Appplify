//
//  TwitterCustomTableViewCell.m
//  ApplifyBeta1
//
//  Created by Michael Sevy on 4/11/15.
//  Copyright (c) 2015 Michael Sevy. All rights reserved.
//

#import "TwitterCustomTableViewCell.h"

@implementation TwitterCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCell:(NSString *)labelOne andLabel:(NSString *)labelTwo andTextView:(UITextView *)textView{
    NSLog(@"setting cell");
}
@end
