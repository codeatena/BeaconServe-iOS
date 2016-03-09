//
//  QuestionType2ViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "QuestionType2ViewController.h"

@interface QuestionType2ViewController ()

@property (nonatomic ,strong) NSArray *answerArr;
@property (nonatomic ,strong) NSArray *questionArr;

@end

@implementation QuestionType2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [[CoredataManager sharedManager] currentProject].projectname;

    CALayer *btnLayer = [self.backBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    btnLayer.borderWidth = 1.0;
    btnLayer.borderColor = [UIColor clearColor].CGColor;
    
    btnLayer = [self.nextBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    btnLayer.borderWidth = 1.0;
    btnLayer.borderColor = [UIColor clearColor].CGColor;
    
    _newIndex = _oldIndex = -1;

    [self setFont];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    _questionArr = [NSArray arrayWithContentsOfFile:path];
    
    NSDictionary *dic = [_questionArr objectAtIndex:[[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue]];
    _answerArr = dic[@"answer"];
    _topLbl.text = dic[@"question"];
    _titltLbl.text = [NSString stringWithFormat:@"Question %ld" , [[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue] + 1];

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

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onNext:(id)sender
{
    NSInteger index = [[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue];
    if (index < _questionArr.count - 1)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@(index + 1) forKey:kQuestionIndex];
        
        NSDictionary *dic = [_questionArr objectAtIndex:index + 1];
        if ([dic[@"answer"] count] < 10)
        {
            //
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionType1ViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else
        {
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionType2ViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LastStepViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(IBAction) buttonPressed:(id)sender
{
    _newIndex = ((UIButton *)sender).tag;

    [_buttons enumerateObjectsUsingBlock:^(UIButton *aButton, NSUInteger idx, BOOL   *stop) {

        if (aButton.tag == _newIndex)
        {
            //aButton.tintColor = [UIColor whiteColor];
            [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            aButton.backgroundColor = [UIColor colorWithHexString:@"#a6f178"];
        }
        
        if (aButton.tag == _oldIndex && _newIndex != _oldIndex)
        {
            aButton.backgroundColor = [UIColor whiteColor];
            //aButton.tintColor = [UIColor colorWithHexString:@"#a6f178"];
            [aButton setTitleColor:[UIColor colorWithHexString:@"#a6f178"] forState:UIControlStateNormal];

        }
        
    }];
    
    _oldIndex = _newIndex;

}

- (void)setFont
{
    [_backBtn.titleLabel setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    [_nextBtn.titleLabel setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    
    [_titltLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    
    [self.descriptionLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
    [self.topLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
}

@end
