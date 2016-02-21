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
    
    _questionArr = @[@"Just starting" , @"One to three months" , @"Three to six months"];
    _newIndex = _oldIndex = -1;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionTableViewCell *cell = (QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    cell.titleLbl.text = [_questionArr objectAtIndex:indexPath.row];
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

@end
