//
//  QuestionType1ViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "QuestionType1ViewController.h"
#import "QuestionTableViewCell.h"

@interface QuestionType1ViewController () <UITableViewDataSource , UITableViewDelegate ,CHCSVParserDelegate>

@property (nonatomic ,strong) NSMutableArray *answerArr;

@property (nonatomic ,assign) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *currentRow;
@property (nonatomic ,strong) NSMutableDictionary *dict;

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
    
    [self setFont];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *fileURL = [bundle URLForResource:@"Question" withExtension:@"csv"];
    CHCSVParser *parser=[[CHCSVParser alloc] initWithContentsOfCSVURL:fileURL];
    parser.delegate=self;
    [parser parse];
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
    NSInteger index = [[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue];
    [[NSUserDefaults standardUserDefaults] setValue:@(index - 1) forKey:kQuestionIndex];

    //[self.navigationController popViewControllerAnimated:YES];

    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:4];
    [self.navigationController popToViewController:vc animated:YES];
}

- (IBAction)onNext:(id)sender
{
    NSInteger index = [[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue];
    
    [[NSUserDefaults standardUserDefaults] setValue:@(index + 1) forKey:kQuestionIndex];
    
    NSMutableArray *answerArr = [[[NSUserDefaults standardUserDefaults] arrayForKey:kAnswerArray] mutableCopy];
    [answerArr addObject:[NSString stringWithFormat:@"%d" ,_newIndex + 1]];
    [[NSUserDefaults standardUserDefaults] setObject:answerArr forKey:kAnswerArray];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (index < _currentRow.count - 1)
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionType1ViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
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
    
    if (_newIndex == indexPath.row)
    {
        cell.backgroundColor = [UIColor colorWithHexString:@"#0B334F"];
        cell.titleLbl.textColor = [UIColor whiteColor];
    }
    else{

        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLbl.textColor = [UIColor colorWithHexString:@"#0B334F"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _newIndex = indexPath.row;
    
    // make selected cell into green color
    QuestionTableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    cell1.backgroundColor = [UIColor colorWithHexString:@"#0B334F"];
    cell1.titleLbl.textColor = [UIColor whiteColor];
    
    // make old cell into white color
    if (_newIndex != _oldIndex)
    {
        QuestionTableViewCell *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_oldIndex inSection:indexPath.section]];
        cell1.backgroundColor = [UIColor whiteColor];
        cell1.titleLbl.textColor = [UIColor colorWithHexString:@"#0B334F"];
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

- (void)displayQuestion
{

    NSDictionary *dic = [_currentRow objectAtIndex:[[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue]];
    _descriptionLbl.text = dic[@"0"];
    _answerArr = [[NSMutableArray alloc] init];

    for (int i = 1 ; i < dic.allKeys.count ; i ++)
    {
        NSString *str = [dic objectForKey:[NSString stringWithFormat:@"%d" ,i]];
        if (str.length >  0)
            [_answerArr addObject:[dic objectForKey:[NSString stringWithFormat:@"%d" ,i]]];
    }
    
    _titltLbl.text = [NSString stringWithFormat:@"Question %d" , [[[NSUserDefaults standardUserDefaults] valueForKey:kQuestionIndex] integerValue]];
    _oldIndex = 0;_newIndex = 0;
    [_tableView reloadData];

}

#pragma mark - CHCSVParserDelegate
- (void)parserDidBeginDocument:(CHCSVParser *)parser;
{
     _currentRow = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(CHCSVParser *)parser;
{
    [self displayQuestion];
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber;
{
     _dict=[[NSMutableDictionary alloc]init];
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber;
{
    [_currentRow addObject:_dict];
    _dict=nil;
}

- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
     [_dict setObject:field forKey:[NSString stringWithFormat:@"%d",fieldIndex]];
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Parse failed : %@" ,error.localizedDescription);
}
    
@end
