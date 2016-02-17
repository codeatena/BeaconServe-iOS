//
//  LoginViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/16/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M13Checkbox.h"

@interface LoginViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UITextField *usernameTxtField;
@property (nonatomic ,assign) IBOutlet UITextField *passwordTxtField;
@property (nonatomic ,assign) IBOutlet M13Checkbox *acceptCheckbox;
@property (nonatomic ,assign) IBOutlet UIButton *loginBtn;
@property (nonatomic ,assign) IBOutlet UILabel *underlineLbl;

@end
