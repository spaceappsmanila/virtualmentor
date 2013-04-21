//
//  WebViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/19/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
	// Do any additional setup after loading the view.
    
    //RESIZE
    
    
    //TODO: grab text for dynamicism
    if ([self.siteType isEqualToString:@"group"])
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://women.nasa.gov/nasagirlsgroup/"]]];
    }
    
    else if ([self.siteType isEqualToString:@"dates"])
    {
        [  self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://women.nasa.gov/important-dates-for-nasa-girls/"]]];
    }
    else if ([self.siteType isEqualToString:@"media"])
    {
        [  self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://women.nasa.gov/media/"]]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
