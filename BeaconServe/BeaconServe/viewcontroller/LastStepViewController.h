//
//  LastStepViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/18/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastStepViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UILabel *titltLbl;
@property (nonatomic ,assign) IBOutlet UILabel *descriptionLbl;
@property (nonatomic ,assign) IBOutlet UIImageView *projectImageView;

- (IBAction)onTakePhoto:(id)sender;

@end
