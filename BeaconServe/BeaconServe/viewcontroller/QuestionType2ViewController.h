//
//  QuestionType2ViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionType2ViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UIButton *backBtn;
@property (nonatomic ,assign) IBOutlet UIButton *nextBtn;
@property (nonatomic ,assign) IBOutlet UILabel *topLbl;

@property(nonatomic ,strong) IBOutletCollection(UIButton) NSArray *buttons;

@property (nonatomic) NSInteger newIndex;
@property (nonatomic) NSInteger oldIndex;

@property (nonatomic ,assign) IBOutlet UILabel *titltLbl;
@property (nonatomic ,assign) IBOutlet UILabel *descriptionLbl;

@end
