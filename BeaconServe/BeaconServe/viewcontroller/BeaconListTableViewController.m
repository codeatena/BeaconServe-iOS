//
//  BeaconListTableViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/25/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "BeaconListTableViewController.h"

@interface BeaconListTableViewController ()

@property (nonatomic ,strong) NSMutableArray *beaconArr;

@end

@implementation BeaconListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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

- (IBAction)onMenu:(id)sender
{
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _beaconArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beaconlistCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *dic = [_beaconArr objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.detailTextLabel.text = dic[@"uuid"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"beacon1" forKey:@"beacon"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"beacon2" forKey:@"beacon"];

    }
    [self performSegueWithIdentifier:@"startSegue" sender:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    
    if ([notification.name isEqualToString:@"beacon1found"])
    {
        NSLog(@"Beacon 1 Found");
        //[[NSUserDefaults standardUserDefaults] setValue:@"beacon1" forKey:@"beacon"];
        //[self performSegueWithIdentifier:@"beaconlistSegue" sender:nil];
        
        [_beaconArr addObject:notification.userInfo];
        [self.tableView reloadData];
    }
    else if ([notification.name isEqualToString:@"beacon2found"])
    {
        NSLog(@"Beacon 2 Found");
        //[[NSUserDefaults standardUserDefaults] setValue:@"beacon2" forKey:@"beacon"];
        //[self performSegueWithIdentifier:@"beaconlistSegue" sender:nil];
        
        [_beaconArr addObject:notification.userInfo];
        [self.tableView reloadData];

    }
}

@end
