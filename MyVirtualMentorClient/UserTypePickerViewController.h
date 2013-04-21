//
//  UserTypePickerViewController.h
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>


@class UserTypePickerViewController;

@protocol UserTypePickerViewControllerDelegate
- (void)choseUserType:(UserTypePickerViewController *)controller withType:(NSString*)userType;
@end

@interface UserTypePickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id <UserTypePickerViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerview_userType;

- (IBAction)done:(id)sender;
- (IBAction)dismiss:(id)sender;
@end
