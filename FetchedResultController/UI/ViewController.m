//
//  ViewController.m
//  test
//
//  Created by Smbat Tumasyan on 29.10.17.
//  Copyright © 2017 Smbat Tumasyan. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"
#import "UserModelManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) UserModelManager *userModelManager;
@property(strong, nonatomic) NSArray<User *> *userList;
@property(assign, nonatomic) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userModelManager = [[UserModelManager alloc] init];
    self.userModelManager.fetchedResultsController.delegate = self;
    NSLog(@"userrr: %lld", ((User *)self.userModelManager.fetchedResultsController.fetchedObjects.firstObject).userID);
    self.index =  ((User *)self.userModelManager.fetchedResultsController.fetchedObjects.firstObject).userID;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    User *aUser = [self.userModelManager.fetchedResultsController objectAtIndexPath:indexPath];
    cell.titleLabel.text = aUser.name;
    cell.borderView.layer.cornerRadius = 5;
    [self setShadowToView:cell.borderView];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userModelManager.fetchedResultsController.fetchedObjects.count;
}

#pragma Private Methods

//- (void)configureCell:

- (void)setShadowToView:(UIView *)view {
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blueColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    view.layer.shadowOpacity = 0.5f;
}

- (IBAction)addCellAction:(id)sender {
    self.index++;
    NSDictionary *user = @{@"name" : [NSString stringWithFormat:@"anun%li",self.index], @"surName" :@"azzganun", @"userID": @(self.index)};
        NSArray *userData = @[user];
        [self.userModelManager addUsers:userData];
        [self.userModelManager.coreDataManager saveContext];
    
}

#pragma NSFetchedResuldController Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate:
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath]
//                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


@end
