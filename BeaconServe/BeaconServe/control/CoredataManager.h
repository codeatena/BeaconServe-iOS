//
//  CoredataManager.h
//  BeaconServe
//
//  Created by AnCheng on 2/22/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProjectEntity;

@interface CoredataManager : NSObject

@property (nonatomic, strong) RSTCoreDataModel *model;
@property (nonatomic, strong) RSTCoreDataStack *stack;

@property (nonatomic ,strong) ProjectEntity *currentProject;

+ (id)sharedManager;
- (void)createProjet:(NSString *)name image1:(UIImage *)image1 image2:(UIImage *)image2;
- (NSArray *) getArrayProjects;
- (void)deleteProject:(ProjectEntity *)project;

@end
