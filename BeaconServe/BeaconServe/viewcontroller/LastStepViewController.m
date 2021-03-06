//
//  LastStepViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/18/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "LastStepViewController.h"
#import <MessageUI/MessageUI.h>
#import "StartProjectViewController.h"

@interface LastStepViewController () <MFMailComposeViewControllerDelegate ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

@end

@implementation LastStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [[CoredataManager sharedManager] currentProject].projectname;

    NSString *beacon = [[Global sharedManager] getParam:@"beacon"];
    if ([beacon isEqualToString:@"beacon1"])
    {
        _projectImageView.image =  [UIImage imageWithData:[[CoredataManager sharedManager] currentProject].picture1];
        
    }
    else
    {
        _projectImageView.image =  [UIImage imageWithData:[[CoredataManager sharedManager] currentProject].picture2];
    }
    
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
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[StartProjectViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];

        }
    }
    
}

- (void)setFont
{
    [_titltLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Bold" size:18]];
    
    [self.descriptionLbl setFont:[UIFont fontWithName:@"RobotoCondensed-Regular" size:15]];
    
}

- (IBAction)onTakePhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id) self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MFMailComposeResultFailed:
            
            break;
        case MFMailComposeResultSent:
            
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate ,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^(void){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"response.csv"];
        
        CHCSVWriter *csvWriter=[[CHCSVWriter alloc] initForWritingToCSVFile:filePath];
        NSMutableArray *answerArr = [[[Global sharedManager] getParam:kAnswerArray] mutableCopy];
        [answerArr insertObject:@"answer" atIndex:0];
        [csvWriter writeLineOfFields:answerArr];

        NSMutableArray *locationArr = [[[Global sharedManager] getParam:kClosestBeaconArray] mutableCopy];
        if (locationArr.count > 0)
        {
            [locationArr insertObject:@"location" atIndex:0];
            [csvWriter writeLineOfFields:locationArr];
        }

        [csvWriter closeStream];
        
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [[controller navigationItem].rightBarButtonItem setTintColor:[UIColor blueColor]];
        if ([MFMailComposeViewController canSendMail])
        {
            [controller setSubject:@"Response"];
            
            NSData *noteData = [NSData dataWithContentsOfFile:filePath];
            NSArray * array = [[NSArray alloc] initWithObjects:@"matthew@virtusventures.com", nil];
            //NSArray * array = [[NSArray alloc] initWithObjects:@"acu11988@gmail.com", nil];
            [controller setToRecipients: array];
            [controller addAttachmentData:noteData mimeType:@"text/csv" fileName:@"response.csv"];
            [controller addAttachmentData:UIImagePNGRepresentation(chosenImage) mimeType:@"image/png" fileName:@"image.png"];
            controller.mailComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
    }];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
