//
//  UserModelManager.m
//  test
//
//  Created by Smbat Tumasyan on 29.10.17.
//  Copyright © 2017 Smbat Tumasyan. All rights reserved.
//

#import "UserModelManager.h"
@implementation UserModelManager

+ (UserModelManager *)createInstance {
    UserModelManager *modelManager = [[UserModelManager alloc] init];
    return modelManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.coreDataManager = [[CoreDataManager alloc] init];
    }
    return self;
}

- (void)addUsers:(NSArray *)users {
    for (NSDictionary *user in users) {
        User *aUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.coreDataManager.persistentContainer.viewContext];
        aUser.name = [user valueForKey:@"name"];
        aUser.surName = [user valueForKey:@"surName"];
        aUser.userID = [[user valueForKey:@"userID"] integerValue];
    }
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request          = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userID" ascending: NO];
    [request setSortDescriptors:@[sortDescriptor]];
    _fetchedResultsController        = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                           managedObjectContext:self.coreDataManager.persistentContainer.viewContext
                                                                             sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    
    if( ! [_fetchedResultsController performFetch: &error] ) {
        NSLog( @"Error Description: %@", [error userInfo] );
    }
    return _fetchedResultsController;
}

@end
