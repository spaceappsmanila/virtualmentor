//
//  NASAGirlsHomeSiteViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/19/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "NASAGirlsHomeSiteViewController.h"

@interface NASAGirlsHomeSiteViewController ()

@end

@implementation NASAGirlsHomeSiteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.nasahomewebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://women.nasa.gov/nasagirls/"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
@end
