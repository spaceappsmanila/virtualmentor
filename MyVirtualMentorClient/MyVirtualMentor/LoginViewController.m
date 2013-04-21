//
//  LoginViewController.m
//  MyVirtualMentor
//
//  Created by Pope Abella on 4/18/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "CoreDataAccess.h"
#import "Member.h"
#import "WebViewController.h"

@interface LoginViewController ()

@end

NSArray *users;

@implementation LoginViewController

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
    
//    CoreDataAccess *cda = [[CoreDataAccess alloc]init];
//    users = [cda getAllUsers];    
//    NSLog(@"Ilan nakareg dito %d", users.count);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender
{
    //TODO: (UI/UX) remove just for dev
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)successfulRegistration:(RegisterViewController *)controller
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"loggedin"];    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];    
}


- (IBAction)login:(id)sender
{
    //TODO: (TESTING) UNCOMMENT ME
    /*
    for (Member *member in users) {
        if (([member.username isEqualToString:self.txtfld_username.text]) && ([member.password isEqualToString:self.txtfld_password.text]) ) {
            NSLog(@"PASOK");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"loggedin"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];               
            CoreDataAccess *getUser = [[CoreDataAccess alloc]init];
            appDelegate.thisUser = [getUser getUser:member.username];
                        
            
        }
        else
        {
            NSLog(@"This user is not registered");
        }
    }
     */
    
    
    
    NSString *param = [NSString stringWithFormat:@"login[email]=%@&login[password]=%@", self.txtfld_username.text, self.txtfld_password.text];
    
    NSData *data=[param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength=[NSString stringWithFormat:@"%d",[data length]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@index.php/login",kURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    
    
    
    //TODO: DELETE MEEEEEE

    /*
    [defaults setObject: @"1" forKey:@"userID"];
    [defaults setObject:@"John Paul" forKey:@"firstName"];
    [defaults setObject:@"Abella" forKey:@"lastName"];
    [defaults setObject:@"j@j.com" forKey:@"email"];
    [defaults setObject:@"2" forKey:@"membership"];
    */
    
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
   
    
    
    
    //will retrun the ID of the user
    //need to check if valid and save the character here in core or app delegate
    
}

//FOR DEVELOPMENT PURPOSES
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSString *response=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"response %@",response);
    
    NSString *cleanResponse = [response stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    int userid = [cleanResponse intValue];
    
    if (userid !=0)
    {
        NSData *userData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/%@", kURL, cleanResponse]]];
        
        NSError *error;
        NSArray *userArray = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"%@", userArray);
        
        NSDictionary *userDict = [userArray objectAtIndex:0];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
       
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        
        Member *loggedUser = (Member *)[NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:delegate.managedObjectContext];
        
        loggedUser.userID =  [NSNumber numberWithInteger:[[userDict objectForKey:@"id"]integerValue]];
        loggedUser.firstName = [userDict objectForKey:@"firstname"];
        loggedUser.lastName = [userDict objectForKey:@"lastname"];
        loggedUser.email = [userDict objectForKey:@"email"];
        
        
        loggedUser.memberType = [NSNumber numberWithInt:[[userDict objectForKey:@"membership"] intValue]];
        
        NSLog(@"MEMBERSHIP TYPE 1: %@", loggedUser.memberType);
        
        
        
        [defaults setObject:loggedUser.userID forKey:@"userID"];
        [defaults setObject:loggedUser.firstName forKey:@"firstName"];
        [defaults setObject:loggedUser.lastName forKey:@"lastName"];
        [defaults setObject:loggedUser.email forKey:@"email"];
        [defaults setObject:loggedUser.memberType forKey:@"membership"];
        
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        //to check if logged in
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"loggedin"];
        [self.delegate successfulLogin:self];
    }
    else
    {
        NSLog(@"Ndi nakapasok sa login: %@",response);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
    
    
    
}

- (IBAction)homeSite:(id)sender
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
//    WebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
//    
//    vc.siteType = @"home";
//    [self.view addSubview:vc.view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showRegistrationForm"])
    {
        //[[segue destinationViewController] setDelegate:self];
        RegisterViewController *rvc = [segue destinationViewController];
        rvc.delegate =self;

        
    }
}





@end
