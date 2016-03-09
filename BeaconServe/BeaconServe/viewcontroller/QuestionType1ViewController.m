//
//  QuestionType1ViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "QuestionType1ViewController.h"
#import "QuestionTableViewCell.h"

@interface QuestionType1ViewController () <UITableViewDataSource , UITableViewDelegate>

@property (nonatomic ,strong) NSArray *answerArr;
@property (nonatomic ,strong) NSArray *questionArr;

@property (nonatomic ,assign) IBOutlet UITableView *tableView;

@end

@implementation QuestionType1ViewController

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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    _questionArr = [NSArray arrayWithContentsOfFile:path];

    NSDictionary *dic = [_questionArr objectAtIndex:[[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue]];
    _answerArr = dic[@"answer"];
    _descriptionLbl.text = dic[@"question"];
    _titltLbl.text = [NSString stringWithFormat:@"Question %ld" , [[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue] + 1];
    
    _newIndex = _oldIndex = -1;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _answerArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionTableViewCell *cell = (QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    cell.titleLbl.text = [_answerArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _newIndex = indexPath.row;
    
    // make selected cell into green color
    QuestionTableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    cell1.backgroundColor = [UIColor colorWithHexString:@"#a6f178"];
    cell1.titleLbl.textColor = [UIColor whiteColor];
    
    // make old cell into white color
    if (_oldIndex != -1 && _newIndex != _oldIndex)
    {
        QuestionTableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_oldIndex inSection:indexPath.section]];
        cell1.backgroundColor = [UIColor whiteColor];
        cell1.titleLbl.textColor = [UIColor colorWithHexString:@"#a6f178"];
    }
    
    _oldIndex = _newIndex;
}

- (void)setFont
{
    [_backBtn.titleLabel setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    [_nextBtn.titleLabel setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];

    [_titltLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    
    [self.descriptionLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
}

@end
