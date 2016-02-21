//
//  AddProjectViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/22/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProjectViewController : UIViewController <UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

- (IBAction)onCamera:(id)sender;
- (IBAction)onDone:(id)sender;

@end
