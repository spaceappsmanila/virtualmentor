//
//  DetailViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/17/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "CreateACourseViewController.h"


@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
    if ([self.detailItem isEqualToString:@"dates"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];

        vc.siteType = @"dates";
        //[self.view addSubview:vc.view];
        [self presentViewController:vc animated:NO completion:nil];
    }
    else if ([self.detailItem isEqualToString:@"group"])
    {        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];

        vc.siteType = @"group";
        [self presentViewController:vc animated:NO completion:nil];
    }
    
    else if ([self.detailItem isEqualToString:@"media"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        
        vc.siteType = @"media";
        [self presentViewController:vc animated:NO completion:nil];
    }
    
    
    else if ([self.detailItem isEqualToString:@"createacourse"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        CreateACourseViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateACourseViewController"];
        //[self.view addSubview:vc.view];        
        [self presentViewController:vc animated:NO completion:nil];
    }
    
    
    
    
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize sizeOfView = self.view.bounds.size;
    
    NSLog(@"%f, %f",sizeOfView.height, sizeOfView.width);
    
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.view = nil;
}
@end
