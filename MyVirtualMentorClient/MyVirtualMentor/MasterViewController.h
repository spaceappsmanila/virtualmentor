//
//  MasterViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/17/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>
#import "LoginViewController.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, LoginViewControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
