//
//  ProjectCollectionViewCell.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "ProjectCollectionViewCell.h"

@implementation ProjectCollectionViewCell

- (void)awakeFromNib
{
    _thumbImageView.layer.masksToBounds = YES;

    CALayer *btnLayer = [self.selectBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:2.0f];
    btnLayer.borderWidth = 1.0;
    btnLayer.borderColor = [UIColor clearColor].CGColor;
}

- (IBAction)onSelect:(id)sender
{
    [self.cellDelegate doSelect:self];
}

- (void)setEntity:(ProjectEntity *)entity
{
    _nameLbl.text = entity.projectname;
    _thumbImageView.image = [UIImage imageWithData:entity.picture1];
}

@end
