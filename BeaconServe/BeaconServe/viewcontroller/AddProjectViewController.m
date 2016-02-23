//
//  AddProjectViewController.m
//  BeaconServe
//
//  Created by AnCheng on 2/22/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "AddProjectViewController.h"

@interface AddProjectViewController ()

@property (nonatomic ,assign) IBOutlet UIView *subView1;
@property (nonatomic ,assign) IBOutlet UIView *subView2;

@property (nonatomic ,assign) IBOutlet UIImageView *imageView1;
@property (nonatomic ,assign) IBOutlet UIImageView *imageView2;

@property (nonatomic ,assign) IBOutlet UIButton *button1;
@property (nonatomic ,assign) IBOutlet UIButton *button2;

@property (nonatomic ,strong) UIImageView *selectImageView;
@property (nonatomic ,assign) IBOutlet UITextField *nameTextField;

@end

@implementation AddProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setBorder:_subView1];
    [self setBorder:_subView2];
    
    _imageView1.layer.masksToBounds = YES;
    _imageView2.layer.masksToBounds = YES;
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

- (void)setBorder:(UIView *)view
{
    CALayer *btnLayer = [view layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    btnLayer.borderWidth = 1.0;
    btnLayer.borderColor = [UIColor colorWithHexString:@"#27b9de"].CGColor;
}

- (IBAction)onCamera:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1) _selectImageView = _imageView1;
    else _selectImageView = _imageView2;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // Distructive button tapped.
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id) self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // OK button tapped.
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id) self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

}

- (IBAction)onMenu:(id)sender
{
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:vc animated:YES];
}

- (IBAction)onDone:(id)sender
{
    if (_nameTextField.text.length == 0)
    {
        [self showAlert:@"Please type project name"];
        return;
    }
    
    if (_imageView1.image == nil)
    {
        [self showAlert:@"Please select picture1"];
        return;
    }
    
    if (_imageView2.image == nil)
    {
        [self showAlert:@"Please select picture2"];
        return;
    }
    
    [[CoredataManager sharedManager] createProjet:_nameTextField.text image1:_imageView1.image image2:_imageView2.image];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate ,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    _selectImageView.image = chosenImage;
    
    if (_selectImageView == _imageView1)
        _button1.hidden = YES;
    else
        _button2.hidden = YES;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)showAlert:(NSString *)alertMessage
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:alertMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
