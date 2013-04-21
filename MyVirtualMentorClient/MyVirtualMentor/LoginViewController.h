//
//  LoginViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"

@class LoginViewController;

@protocol LoginViewControllerDelegate
- (void)successfulLogin:(LoginViewController *)controller;
@end

@interface LoginViewController : UIViewController <RegisterViewControllerDelegate, NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtfld_username;
@property (weak, nonatomic) IBOutlet UITextField *txtfld_password;

@property (weak, nonatomic) id <LoginViewControllerDelegate> delegate;


//probably need to remove this
- (IBAction)dismiss:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)homeSite:(id)sender;

@end
