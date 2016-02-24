//
//  InstructionViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "InstructionViewController.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;

    CALayer *btnLayer = [self.continueBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    btnLayer.borderWidth = 1.0;
    btnLayer.borderColor = [UIColor clearColor].CGColor;
    
    [self setFont];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"beacon1found" object:[BeaconManager sharedManager]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"beacon2found" object:[BeaconManager sharedManager]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"beacon1found"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"beacon2found"
                                                  object:nil];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"beacon1found"])
    {
        
    }
}

- (void)setFont
{
    [_continueBtn.titleLabel setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    [_titleLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];

    [self.instructionLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
}

- (IBAction)onContinue:(id)sender
{
    
    [[BeaconManager sharedManager] startItems];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    [[BeaconManager sharedManager] stopItems];
    
    if ([notification.name isEqualToString:@"beacon1found"])
    {
        NSLog(@"Beacon 1 Found");
        [[NSUserDefaults standardUserDefaults] setValue:@"beacon1" forKey:@"beacon"];
        
        [self performSegueWithIdentifier:@"startSegue" sender:nil];
    }
    else if ([notification.name isEqualToString:@"beacon2found"])
    {
        NSLog(@"Beacon 2 Found");
        [[NSUserDefaults standardUserDefaults] setValue:@"beacon2" forKey:@"beacon"];

        [self performSegueWithIdentifier:@"startSegue" sender:nil];

    }
}

@end
