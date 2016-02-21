//
//  ProjectsViewController.h
//  BeaconServe
//
//  Created by AnCheng on 2/17/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectsViewController : UIViewController <UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic ,assign) IBOutlet UIBarButtonItem *avatarItem;
@property (nonatomic ,assign) IBOutlet UICollectionView *collectionView;

@end
