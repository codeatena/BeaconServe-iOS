//
//  ProjectsViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "ProjectsViewController.h"
#import "ProjectCollectionViewCell.h"

@interface ProjectsViewController () <ProjectCollectionViewCellDelegate>

@property (nonatomic ,strong) NSMutableArray *projectArr;

@end

@implementation ProjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer.width = 10; // for example shift right bar button to the right
//    self.navigationItem.leftBarButtonItems = @[spacer , _avatarItem];
    self.navigationItem.leftBarButtonItems = @[_avatarItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _projectArr = [[NSMutableArray alloc] initWithArray:[[CoredataManager sharedManager] getArrayProjects]];
    [_collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _projectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectCollectionViewCell *cell = (ProjectCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"projectCell" forIndexPath:indexPath];
    cell.cellDelegate = self;
    
    ProjectEntity *entity = [_projectArr objectAtIndex:indexPath.row];
    [cell setEntity:entity];
    
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
    ProjectEntity *entity = [_projectArr objectAtIndex:indexPath.row];
    [[CoredataManager sharedManager] setCurrentProject:entity];
    [self performSegueWithIdentifier:@"directionSegue" sender:nil];
}

- (void)doDelete:(ProjectCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    ProjectEntity *entity = [_projectArr objectAtIndex:indexPath.row];
    [[CoredataManager sharedManager] deleteProject:entity];
    
    [_projectArr removeAllObjects];
    [_projectArr addObjectsFromArray:[[CoredataManager sharedManager] getArrayProjects]];
    [_collectionView reloadData];
}

@end
