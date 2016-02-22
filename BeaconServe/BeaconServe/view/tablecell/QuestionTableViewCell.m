//
//  QuestionTableViewCell.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "QuestionTableViewCell.h"

@implementation QuestionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.titleLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
