//
//  ProjectCollectionViewCell.h
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProjectCollectionViewCell;

@protocol ProjectCollectionViewCellDelegate <NSObject>

- (void)doSelect:(ProjectCollectionViewCell *)cell;

@end

@interface ProjectCollectionViewCell : UICollectionViewCell

@property (nonatomic ,assign) IBOutlet UIButton *selectBtn;
@property (nonatomic ,assign) IBOutlet UILabel *nameLbl;
@property (nonatomic ,assign) IBOutlet UIImageView *thumbImageView;

- (IBAction)onSelect:(id)sender;
- (void)setEntity:(ProjectEntity *)entity;
- (void)setEntity:(ProjectEntity *)entity identifier:(NSString *)identifier;

@property (nonatomic ,weak) id <ProjectCollectionViewCellDelegate> cellDelegate;

@end
