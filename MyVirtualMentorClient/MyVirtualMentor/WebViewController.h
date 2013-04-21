//
//  WebViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/19/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *siteType;


@end
