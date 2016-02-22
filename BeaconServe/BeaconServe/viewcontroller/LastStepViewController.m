//
//  LastStepViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/18/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "LastStepViewController.h"

@interface LastStepViewController ()

@end

@implementation LastStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [[CoredataManager sharedManager] currentProject].projectname;
    [self setFont];
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
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)setFont
{
    [_titltLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    
    [self.descriptionLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
    
}

@end
