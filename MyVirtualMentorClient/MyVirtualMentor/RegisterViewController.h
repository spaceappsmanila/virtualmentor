//
//  RegisterViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTypePickerViewController.h"

@class RegisterViewController;

@protocol RegisterViewControllerDelegate
- (void)successfulRegistration:(RegisterViewController *)controller;
@end

@interface RegisterViewController : UIViewController <UserTypePickerViewControllerDelegate, NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtfld_firstName;

@property (weak, nonatomic) IBOutlet UITextField *txtfld_lastName;

@property (weak, nonatomic) IBOutlet UITextField *txtfld_username;
@property (weak, nonatomic) IBOutlet UITextField *txtfld_password;

@property (weak, nonatomic) IBOutlet UIButton *btn_type;



@property (weak, nonatomic) id <RegisterViewControllerDelegate> delegate;

- (IBAction)userType:(id)sender;
- (IBAction)pressedRegister:(id)sender;

- (IBAction)dismiss:(id)sender;
@end
