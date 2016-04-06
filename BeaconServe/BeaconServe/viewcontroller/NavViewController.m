//
//  NavViewController.m
//  BeaconServe
//
//  Created by AnCheng on 3/30/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "NavViewController.h"
#import "QuestionTypeViewController.h"
#import "LastStepViewController.h"
#import "StartProjectViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"exitbeaconfound" object:[BeaconManager sharedManager]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"questionbeacon1found" object:[BeaconManager sharedManager]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"questionbeacon2found" object:[BeaconManager sharedManager]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"exitbeaconfound" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"questionbeacon1found" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"questionbeacon2found" object:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"exitbeaconfound"])
    {
        // start last question

        [[Global sharedManager] setParam:@(1) forKey:kQuestionIndex];
        [[Global sharedManager] setParam:[NSMutableArray new] forKey:kAnswerArray];
        
        [[Global sharedManager] setParam:@(NO) forKey:kIsFromQuestion];
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionTypeViewController"];
        [self pushViewController:vc animated:YES];
        
    }
    else if ([notification.name isEqualToString:@"questionbeacon1found"])
    {
        // if question or last step view controller , ask if wants to stop and to start new question
        if ([self.topViewController isKindOfClass:[QuestionTypeViewController class]] || [self.topViewController isKindOfClass:[LastStepViewController class]])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"A new BeaconServe survey is available would you like to discard your current answers and start the new survey ?" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                [CATransaction begin];
                [CATransaction setCompletionBlock:^{
                    [self startQuestion:YES];
                }];
                
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[StartProjectViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
                
                [CATransaction commit];
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else
        {
            [self startQuestion:YES];
        }
    }
    else if ([notification.name isEqualToString:@"questionbeacon2found"])
    {
        // if question or last step view controller , ask if wants to stop and to start new question
        if ([self.topViewController isKindOfClass:[QuestionTypeViewController class]] || [self.topViewController isKindOfClass:[LastStepViewController class]])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"A new BeaconServe survey is available would you like to discard your current answers and start the new survey ?" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                [CATransaction begin];
                [CATransaction setCompletionBlock:^{
                    [self startQuestion:NO];
                }];
                
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[StartProjectViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
                
                [CATransaction commit];
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            [self startQuestion:NO];
        }
    }

}

- (void)startQuestion:(BOOL)isBeaconOneTwo
{
    if (isBeaconOneTwo)
        [[Global sharedManager] setParam:@"beacon1" forKey:@"beacon"];
    else
        [[Global sharedManager] setParam:@"beacon2" forKey:@"beacon"];

    [[Global sharedManager] setParam:@(1) forKey:kQuestionIndex];
    NSMutableArray *anwserArr = [NSMutableArray new];
    [[Global sharedManager] setParam:anwserArr forKey:kAnswerArray];
    
    [[Global sharedManager] setParam:@(YES) forKey:kIsFromQuestion];
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionTypeViewController"];
    [self pushViewController:vc animated:YES];
}

@end
