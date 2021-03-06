//
//  StartProjectViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "StartProjectViewController.h"
#import "ProjectsViewController.h"

@interface StartProjectViewController ()
{
    BOOL startSuvey;
}

@end

@implementation StartProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = [[CoredataManager sharedManager] currentProject].projectname;
    _projectImageView.layer.masksToBounds = YES;
    
    NSString *beacon = [[Global sharedManager] getParam:@"beacon"];
    if ([beacon isEqualToString:@"beacon1"])
    {
        _projectImageView.image =  [UIImage imageWithData:[[CoredataManager sharedManager] currentProject].picture1];

    }
    else
    {
        _projectImageView.image =  [UIImage imageWithData:[[CoredataManager sharedManager] currentProject].picture2];
    }
    
    CALayer *btnLayer = [self.startBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    btnLayer.borderWidth = 1.0;
    btnLayer.borderColor = [UIColor clearColor].CGColor;

    [self setFont];
    
    startSuvey = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onMenu:(id)sender
{
    [[BeaconManager sharedManager] stopItems];
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[ProjectsViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            
        }
    }
}

- (IBAction)onSart:(id)sender
{
    //if ([[Global sharedManager] enteredStore]) return; // if already entered store , ignore that function
    
//    [[Global sharedManager] initParams];
//    [[Global sharedManager] setParam:[NSMutableArray new] forKey:kClosestBeaconArray];
//    [[Global sharedManager] removeParam:kClosestQuestionBeaconNumber];
    
    // start monitoring
    
    if (!startSuvey)
    {
        [[BeaconManager sharedManager] stopItems];
        [[BeaconManager sharedManager] startItems];
        
        startSuvey = YES;
    }

}

- (void)setFont
{
    [_startBtn.titleLabel setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    [_titltLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    [self.descriptionLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
}

@end
