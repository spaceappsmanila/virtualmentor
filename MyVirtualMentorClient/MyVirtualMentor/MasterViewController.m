//
//  MasterViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/17/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "MasterViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "SecondTableViewController.h"
#import "ClassesViewController.h"
#import "Member.h"
#import "CoreDataAccess.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

NSArray *masterTableViewItems;

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.view = nil;
}

-(void)viewWillAppear:(BOOL)animated
{    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"loggedin"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        //TODO: (UI/UX) need to fix if starting in different orientation
        
        vc.delegate = self;
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int memberType = [[defaults objectForKey:@"membership"]intValue];    
    
  
    switch (memberType)
    {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            //if Mentor
            self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
            
            //TODO: (IMPT) Check kung mentor or mentee
            masterTableViewItems = @[@"Create a Course",
                                     @"Manage a Course",
                                     @"Active Classes",
                                     @"Finished Classes",
                                     @"Track Mentor Meetings",
                                     @"Group Mentoring",
                                     @"Important Dates",
                                     @"Media",
                                     @"Account Settings",
                                     @"Logout"
                                     ];
            
            [self.tableView reloadData];
        }
            break;
        case 3:
        {
            //if Mentee

            self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
            
            //TODO: (IMPT) Check kung mentor or mentee
            masterTableViewItems = @[@"Active Classes",
                                     @"Finished Classes",
                                     @"Join a Class",
                                     @"Track Mentor Meetings",
                                     @"Group Mentoring",
                                     @"Important Dates",
                                     @"Media",
                                     @"Account Settings",
                                     @"Logout"
                                     ];
            [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
        
}


-(void)successfulLogin:(LoginViewController *)controller
{
    [self viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
//    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    
//    // If appropriate, configure the new managed object.
//    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
//    
//    // Save the context.
//    NSError *error = nil;
//    if (![context save:&error]) {
//         // Replace this implementation with code to handle the error appropriately.
//         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: (IMPT) Check kung mentor or mentee
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    return [sectionInfo numberOfObjects];
    return masterTableViewItems.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        self.detailViewController.detailItem = object;
//    }
    
    //NSIndexPath *indexpath2=[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    Member *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:indexPath.section];
    NSLog(@"count %d", [sectionInfo numberOfObjects]);
    NSLog(@"my name is: %@", object.username);
     */
    
    //Will need to check if mentor or mentee
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    int memberType = [[defaults objectForKey:@"membership"]intValue];
    
    
    switch (memberType) {
        case 1:
        {
            
        }            
            break;
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    self.detailViewController.detailItem = @"createacourse";              
                    
                }
                    break;
                case 1:
                {
                    self.detailViewController.detailItem = @"createacourse";
                    
                }
                    break;
                    
                case 2:
                {    
                    
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
                    SecondTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondTableViewController"];
                    //send tayo ng string para un iload nya :D
                    vc.classType = @"Active";
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }
                    
                    break;
                case 3:
                {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
                    SecondTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondTableViewController"];
                    //send tayo ng string para un iload nya :D
                    vc.classType = @"Finished";
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }                    
                    break;
                case 4:
                {
                    self.detailViewController.detailItem = @"createacourse";
                    
                }
                    break;
                    
                case 5:
                {
                    self.detailViewController.detailItem = @"group";
                    
                }
                    
                    break;
                case 6:
                {
                    self.detailViewController.detailItem = @"dates";
                    
                }
                    
                    break;
                    
                case 7:
                {
                    self.detailViewController.detailItem = @"media";
                    
                }
                    
                    break;
                    
                case 8:
                {
                    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];                    
                    NSLog(@"This is %@ %@",appDelegate.thisUser.firstName, appDelegate.thisUser.lastName );
                }
                    
                    break;
                    
                case 9:
                {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setBool:NO forKey:@"loggedin"];
                    [self viewWillAppear:YES];
                }                    
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                    
                case 0:
                {
                    //lets go get that other table view then say what type
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
                    SecondTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondTableViewController"];
                    //send tayo ng string para un iload nya :D
                    vc.classType = @"Active";
                    [self.navigationController pushViewController:vc animated:YES];                    
                }
                    
                    break;
                case 1:
                {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
                    SecondTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondTableViewController"];
                    //send tayo ng string para un iload nya :D
                    vc.classType = @"Finished";
                    [self.navigationController pushViewController:vc animated:YES];                    
                }
                    
                    break;                    
                    
                case 2:
                {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
                    SecondTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SecondTableViewController"];
                    //send tayo ng string para un iload nya :D
                    vc.classType = @"Join";
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    
                    break;
                    
                case 3:
                {
                    //self.detailViewController.detailItem = @"group";
                    
                }
                    break;
                    
                case 4:
                {
                    self.detailViewController.detailItem = @"group";
                    
                }
                    
                    break;
                case 5:
                {
                    self.detailViewController.detailItem = @"dates";
                    
                }
                    
                    break;
                    
                case 6:
                {
                    self.detailViewController.detailItem = @"media";
                    
                }
                    
                    break;
                    
                case 7:
                {
                    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
                    
                    
                    NSLog(@"This is %@ %@",appDelegate.thisUser.firstName, appDelegate.thisUser.lastName );
                }
                    
                    break;
                    
                case 8:
                {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setBool:NO forKey:@"loggedin"];
                    [self viewWillAppear:YES];
                }
                    
                    break;
                    
                default:
                    break;
            }

        }
            break;
            
        default:
            break;
    }
    
    
        
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
    
    cell.textLabel.text = masterTableViewItems[indexPath.row];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //[[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    //Testing for members muna
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"email" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


#pragma mark - Instance Methods


@end
