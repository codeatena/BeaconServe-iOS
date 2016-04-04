//
//  BeaconViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/25/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "BeaconViewController.h"
#import "ProjectCollectionViewCell.h"

@interface BeaconViewController () <ProjectCollectionViewCellDelegate>

@property (nonatomic ,strong) NSMutableArray *beaconArr;

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _beaconArr = [NSMutableArray new];
    
    [[BeaconManager sharedManager] startItems];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"beacon1found" object:[BeaconManager sharedManager]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"beacon2found" object:[BeaconManager sharedManager]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"beacon1found"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"beacon2found"
                                                  object:nil];
    
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _beaconArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectCollectionViewCell *cell = (ProjectCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell" forIndexPath:indexPath];
    cell.cellDelegate = self;
    
    NSDictionary *dic = [_beaconArr objectAtIndex:indexPath.row];
    ProjectEntity *entity = dic[@"project"];
    [cell setEntity:entity identifier:dic[@"beacon"]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = (collectionView.bounds.size.width * 5) / 8;
    CGSize size = CGSizeMake((collectionView.bounds.size.width) / 2, height);
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(320, 0);
}

#pragma mark - ProjectCollectionViewCellDelegate
- (void)doSelect:(ProjectCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    NSDictionary *dic = [_beaconArr objectAtIndex:indexPath.row];
    [[Global sharedManager] setParam:dic[@"beacon"] forKey:@"beacon"];

    [self performSegueWithIdentifier:@"startSegue" sender:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    
    if ([notification.name isEqualToString:@"beacon1found"])
    {
        NSLog(@"Beacon 1 Found");
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"beacon1found"
                                                      object:nil];
        
        [_beaconArr addObject:@{@"project" : [[CoredataManager sharedManager] currentProject] ,@"beacon" : @"beacon1"}];
        [self.collectionView reloadData];
    }
    else if ([notification.name isEqualToString:@"beacon2found"])
    {
        NSLog(@"Beacon 2 Found");
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"beacon2found"
                                                      object:nil];
        
        [_beaconArr addObject:@{@"project" : [[CoredataManager sharedManager] currentProject] ,@"beacon" : @"beacon2"}];
        [self.collectionView reloadData];
        
    }
}

@end
