//
//  CoredataManager.m
//  BeaconServe
//
//  Created by AnCheng on 2/22/16.
//  Copyright © 2016 Radu Vila. All rights reserved.
//

#import "CoredataManager.h"

@implementation CoredataManager

+ (id)sharedManager
{
    static CoredataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

- (id)init
{
    if (self = [super init])
    {
        _model = [[RSTCoreDataModel alloc] initWithName:@"BeaconServe"];
        
        // Initialize the stack
        _stack = [[RSTCoreDataStack alloc] initWithStoreURL:_model.storeURL
                                                  modelURL:_model.modelURL
                                                   options:nil
                                           concurrencyType:NSMainQueueConcurrencyType];

    }
    return self;
}

- (void)createProjet:(NSString *)name image1:(UIImage *)image1 image2:(UIImage *)image2
{
    ProjectEntity *entity = [ProjectEntity rst_insertNewObjectInManagedObjectContext:_stack.managedObjectContext];
    entity.projectname = name;
    entity.picture1 = UIImagePNGRepresentation(image1);
    entity.picture2 = UIImagePNGRepresentation(image2);

    [RSTCoreDataContextSaver save:_stack.managedObjectContext];

}

- (NSArray *) getArrayProjects {

    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"ProjectEntity"  inManagedObjectContext: _stack.managedObjectContext];
    [fetch setEntity:entityDescription];
    NSError * error = nil;
    NSArray *fetchedObjects = [_stack.managedObjectContext executeFetchRequest:fetch error:&error];
    NSLog(@"profile count: %lu", (unsigned long)[fetchedObjects count]);
    return fetchedObjects;
}

- (void)deleteProject:(ProjectEntity *)project
{
    [_stack.managedObjectContext deleteObject:project];
    [RSTCoreDataContextSaver saveAndWait:_stack.managedObjectContext];
    
}

@end
