//
//  LoginViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/16/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self addBottomBorder:_usernameTxtField];
    //[self addBottomBorder:_passwordTxtField];
    
    _acceptCheckbox.strokeColor = [UIColor whiteColor];
    _acceptCheckbox.checkColor = [UIColor whiteColor];
    _acceptCheckbox.tintColor = [UIColor clearColor];
    _acceptCheckbox.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _acceptCheckbox.titleLabel.textColor = [UIColor whiteColor];
    _acceptCheckbox.checkAlignment = M13CheckboxAlignmentLeft;
    _acceptCheckbox.checkHeight = 18.0f;
    _acceptCheckbox.radius = 0.0f;
    
    CALayer *btnLayer = [self.loginBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    btnLayer.borderColor = [UIColor whiteColor].CGColor;
    btnLayer.borderWidth = 1.5f;
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Terms & Conditions"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    _underlineLbl.attributedText = attributeString;
    
    [self setFont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLogin:(id)sender
{
    [self performSegueWithIdentifier:@"mainSegue" sender:nil];
}

- (void)setFont
{
    [self.usernameTxtField setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:16]];
    [self.passwordTxtField setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:16]];

    [_loginBtn.titleLabel setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    
    [self.acceptLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
    [self.underlineLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];

}

@end
