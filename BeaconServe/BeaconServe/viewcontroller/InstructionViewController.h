//
//  InstructionViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstructionViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UIButton *continueBtn;

@property (nonatomic ,assign) IBOutlet UILabel *titleLbl;
@property (nonatomic ,assign) IBOutlet UILabel *instructionLbl;

- (IBAction)onContinue:(id)sender;

@end
