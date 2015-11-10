//
//  UserDetailViewViewController.m
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "UserDetailViewViewController.h"
#import "SetingsView.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "AFHTTPRequestOperationManager.h"
#import <QuartzCore/QuartzCore.h>
#import "selectedSettigs2ViewController.h"
#import "HOMEViewController.h"


@interface UserDetailViewViewController () <FBLoginViewDelegate ,UITextFieldDelegate >
{
    
    NSString *loginDeviceId;
    NSString *loginTocken;
    NSString *registerDeviceId;
    NSString *registerTocken;
    NSString *reguserId;
    
    
}
@property (strong, nonatomic)NSString *diviceToken;


@end

@implementation UserDetailViewViewController

- (void)viewDidLoad {
    
    self.screenName = @"User Details Screen";
    
    [super viewDidLoad];
    [_phoneNoTf setDelegate:self];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:116.0f/255.0f
                                                                             green:79.0f/255.0f
                                                                              blue:141.0f/255.0f
                                                                             alpha:1.0f]];
    [self.navigationController.navigationBar  setTranslucent:YES];
    self.navigationItem.hidesBackButton = YES;
    
    
    // NSLog(@"userData ==== %@",_myDIc);
    _userEmail.text = [_myDIc objectForKey:@"email"];
    _lastName.text = [_myDIc objectForKey:@"last_name"];
    _userName.text  = [_myDIc objectForKey:@"name"];
    
    
    _profilePic.layer.cornerRadius = _profilePic.frame.size.height /2;
    _profilePic.layer.masksToBounds = YES;
    _profilePic.layer.borderWidth = 0;
    _profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_userurl1]]];
    
    
    _registerButton.layer.cornerRadius = 10; // this value vary as per your desire
    _registerButton.clipsToBounds = YES;
    
    
    if (_googleData == nil) {
        
        NSLog(@"LODING FACEBOOK DATA...................");
        _fbID = [_myDIc objectForKey:@"id"];
        
        NSLog(@"social ID === %@",_fbID);
        
        
    }else {
        _userEmail.text = [_googleData objectForKey:@"email"];
        _lastName.text = [_googleData objectForKey:@"family_name"];
        _userName.text  = [_googleData objectForKey:@"name"];
        _profilePic.layer.cornerRadius = _profilePic.frame.size.height /2;
        _profilePic.layer.masksToBounds = YES;
        _profilePic.layer.borderWidth = 0;
        _fbID = [_googleData objectForKey:@"id"];
        
        NSLog(@"url:   %@",[_googleData objectForKey:@"picture"]);
        
        _profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_googleData objectForKey:@"picture"]]]];
        
        _userurl1 = [_googleData objectForKey:@"picture"];
        
    }
    
    
    
    NSLog(@"login by ========%@",_logINBy);
    
    
}

-(void)LoginApi{
    
    
    // LogIn Api
    NSString *diviceTokenOr = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
    
    NSLog(@"LOGINUSERID USERDEtail  =====%@",diviceTokenOr);
    
#if TARGET_IPHONE_SIMULATOR
    
    //Simulator
    diviceTokenOr = @"bfdhsglhjsg/ldshlhdjsgh4ou7982urejhfy4hhbdkhfjkdshfjhw89jdfbjkdshfuew";
    
    
#else
    
    // Device
    
#endif
    
    NSLog(@"loginby....................%@",_logINBy);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"email": _userEmail.text,
                             
                             @"device_token": diviceTokenOr
                             ,
                             @"device_type": @"ios"
                             ,
                             @"login_by": _logINBy
                             ,
                             @"social_unique_id":_fbID
                             
                             };
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
    [manager POST:@"http://zenparent.in/api/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"my Value :%@", responseObject);
        
        NSDictionary *dict = [[NSDictionary alloc]init];
        
        dict = [responseObject objectForKey:@"users"];
        NSLog(@"my value dic =%@",dict);
        
        
        registerDeviceId = [dict objectForKey:@"device_token"];
        
        NSLog(@"registerDeviceId====%@",registerDeviceId);
        
        registerTocken = [dict objectForKey:@"token"];
        
        NSLog(@"registerTocken====%@",registerTocken);
        
        reguserId = [dict objectForKey:@"id"];
        
        NSLog(@"reguserId====%@",reguserId);
        
        
        [[NSUserDefaults standardUserDefaults] setObject:registerTocken forKey:@"REG_TOKEN"];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:reguserId forKey:@"REG_userId"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"English" forKey:@"LanguageDefalt"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"REG_TOKEN"]);
        
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PARlogged_in"];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"PartiallyRegistered"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        //        HOMEViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
        //                                  instantiateViewControllerWithIdentifier:@"HOMEIOS"];
        //
        //        [self.navigationController pushViewController:wc animated:YES];
        
        //        SetingsView *wc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
        //                            instantiateViewControllerWithIdentifier:@"SETT"];
        //
        //          [self.navigationController pushViewController:wc1 animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
    }];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    _loginButton.delegate = nil;
    
    // register for keyboard notifications
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _loginButton.delegate = nil;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)nextPressed:(id)sender {
    
    
    [self registerTheUser];
    
}

-(void)registerTheUser{
    
    NSString *diviceTokenOr = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
    
    NSLog(@"REGISTERUSERID USERDEtail  =====%@",diviceTokenOr);
    
#if TARGET_IPHONE_SIMULATOR
    
    //Simulator
    diviceTokenOr = @"bfdhsglhjsg/ldshlhdjsgh4ou7982urejhfy4hhbdkhfjkdshfjhw89jdfbjkdshfuew";
    
#else
    
    // Device
    
#endif
    
    NSLog(@"loginby....................%@",_logINBy);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"first_name": _userName.text,
                                 @"last_name":_lastName.text,
                                 @"email": _userEmail.text,
                                 @"phone":  _phoneNoTf.text,
                                 @"device_token": diviceTokenOr,
                                 @"device_type": @"ios",
                                 @"social_unique_id": _fbID ,
                                 @"login_by":_logINBy,
                                 
                                 @"picture":_userurl1};
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
    [manager POST:@"http://zenparent.in/api/register" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"my REgisterValue :%@", responseObject);
        
        NSMutableDictionary *user =[[NSMutableDictionary alloc]init];
        user = [responseObject objectForKey:@"user"];
        
        NSString *errorCode = [responseObject objectForKey:@"error_code"];
        
        int value = [errorCode intValue];
        
        if (value == 401) {
            
            NSLog(@"The User is Already Login so alow him to Home Screen And featch details by calling login api");
            
            
            [self LoginApi];
            
            return ;
            
        }
        else {
            
            
            registerDeviceId = [user objectForKey:@"device_token"];
            
            NSLog(@"registerDeviceId====%@",registerDeviceId);
            
            registerTocken = [user objectForKey:@"token"];
            
            NSLog(@"registerTocken====%@",registerTocken);
            
            reguserId = [user objectForKey:@"id"];
            
            NSLog(@"reguserId====%@",reguserId);
            
            
            // Fetching user details
            
            // [[NSUserDefaults standardUserDefaults] setObject:registerDeviceId forKey:@"REG_DEVICEID"];
            
            [[NSUserDefaults standardUserDefaults] setObject:registerTocken forKey:@"REG_TOKEN"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:reguserId forKey:@"REG_userId"];
            [[NSUserDefaults standardUserDefaults] setObject:@"English" forKey:@"LanguageDefalt"];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PARlogged_in"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"PartiallyRegistered"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            //   GO TO NEXT SCREEN TABLE WITH 5 ITEMES
            
            SetingsView *wc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                instantiateViewControllerWithIdentifier:@"SETT"];
            
            
            wc1.userID = [responseObject objectForKey:@"id"];
            
            NSLog(@"USERID++++%@",wc1.userID);
            
            [self.navigationController pushViewController:wc1 animated:YES];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
        
        
    }];
    
    
}

//Textfield Methods.....

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -260; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}
@end
