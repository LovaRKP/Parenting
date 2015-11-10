//
//  ViewController.m
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "ViewController.h"
#import "UserDetailViewViewController.h"
#import "ALScrollViewPaging.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <QuartzCore/QuartzCore.h>
#import "AFNetworkReachabilityManager.h"
#import "PrivacePolicy view.h"
#import "HOMEViewController.h"
#import "AFHTTPRequestOperationManager.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController () <GPPSignInDelegate ,UIWebViewDelegate>

{
    //FBLogin
    NSString *userEmailForFB;
    NSString *fbIdFb;
    
    
    //googleLogIn
    
    NSDictionary *googleUserInfermation;
    
    //Tokens
    NSString *loginDeviceId;
    NSString *loginTocken;
    NSString *registerDeviceId;
    NSString *registerTocken;
    NSString *reguserId;
    NSString *userImageURL;
    NSString *userLogInBy;
    NSString  *accessTocken;
    
    CDActivityIndicatorView * activityIndicatorView ;
    
}


@end

@implementation ViewController
@synthesize signInButton ;


// old one 202051062523-hjqmv3nb9sbfq6spdgf5rto6ohnt9s32.apps.googleusercontent.com

//  new id  579056634272-7lu3hclbl8fgnaprplug65jv6fop1bkb.apps.googleusercontent.com

static NSString * const kClientID = @"579056634272-7lu3hclbl8fgnaprplug65jv6fop1bkb.apps.googleusercontent.com";

- (void)viewDidLoad {
    
    self.screenName = @"LogIn Screen";
    
    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
    
    activityIndicatorView.center = self.view.center;
    
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    
    
    
    //self.navigationItem.hidesBackButton = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    //Leasen for notification
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMainMenu:)
                                                 name:@"loginComplete" object:nil];
    
    
    
    
    [FBLoginView class];
    
    
    [activityIndicatorView startAnimating];
    
    self.loginButton.delegate = self;
    
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    
    
    if (![UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"fb://"]])
    {
        self.loginButton.loginBehavior = FBLoginViewTooltipBehaviorDisable;
    }
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Connection Failed"  message:@"Check your Internet Connection"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
        
        
    }];
    
    
    // Google
    
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    // You previously set kClientID in the "Initialize the Google+ client" step
    signIn.clientID = kClientID;
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin,@"https://www.googleapis.com/auth/userinfo.email",nil];
    signIn.delegate = self;
    // BOOL alreadyLogin = [signIn trySilentAuthentication];
    
    if (signIn.hasAuthInKeychain == YES)
    {
        NSLog(@"user is Already login");
        
        [activityIndicatorView startAnimating];
        
    }
    else{
        
        
        [activityIndicatorView stopAnimating];
        
    }
    
    //
    [signIn trySilentAuthentication];
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:116.0f/255.0f
                                                                 green:79.0f/255.0f
                                                                  blue:141.0f/255.0f
                                                                 alpha:1.0f]];
    [[UIToolbar appearance] setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [super viewWillAppear:animated];
    _loginButton.delegate = self;
    
    
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _loginButton.delegate = nil;
    
    [activityIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    //self.lblLoginStatus.text = @"You are logged in.";
    
    //[self toggleHiddenState:NO];
    
    [activityIndicatorView startAnimating];
    
}




-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    // NSLog(@"%@", user);
    //    self.profilePicture.profileID = user.id;
    //    self.lblUsername.text = user.name;
    
    userEmailForFB = [user objectForKey:@"email"];
    
    fbIdFb = [user objectForKey:@"id"];
    [activityIndicatorView startAnimating];
    
    _userdata = (NSMutableDictionary *)user;
    _userurl = user.objectID;
    userLogInBy = @"facebook";
    
    accessTocken = [NSString stringWithFormat:@"%@",[[FBSession activeSession] accessTokenData]];
    
    NSLog(@"%@",[[FBSession activeSession] accessTokenData]);
    
    if (user == nil) {
        
        return;
        
    }else{
        
        [self loginApi];
        
        userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [user objectID]];
        NSLog(@"userimge===%@",userImageURL);
        
        
    }
}


// the function specified in the same class where we defined the addObserver
- (void)showMainMenu:(NSNotification *)note {
    
    NSLog(@"Received Notification - Someone seems to have logged in%@", note);
    
    // NSURL *googleUrl = note.object;
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 55, self.view.bounds.size.width,self.view.bounds.size.height-55)];
    // NSURL *pass = [[note userInfo] valueForKey:@"url"];
    // NSURL *nsurl=[NSURL URLWithString:url];
    NSURL *pass = note.object;
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:pass];
    webview.backgroundColor = [UIColor whiteColor];
    // webview.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [webview setDelegate:self];
    [webview loadRequest:nsrequest];
    [self.view addSubview:webview];
    
    [webview addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    webview.delegate = self;
    
}




-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    //self.lblLoginStatus.text = @"You are logged out";
    
    
    
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSString *alertMessage, *alertTitle;
    
    if ([FBErrorUtility shouldNotifyUserForError:error])
    {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
    {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
    }
    else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
    {
        NSLog(@"user cancelled login");
        
    }
    else
    {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage)
    {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

// google





- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error {
    
    
    if (error) {
        
        NSLog(@"ERROR ::: %@" ,[NSString stringWithFormat:@"Status: Authentication error: %@", error]);
        [activityIndicatorView stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    // getting the access token from auth
    
    
    //id_token = [NSString stringWithFormat:@"%@",[[[[GPPSignIn sharedInstance] authentication] parameters] objectForKey:@"id_token"]];
    
    [activityIndicatorView startAnimating];
    
    NSLog(@"id_token ========%@",accessTocken);
    
    accessTocken = [auth valueForKey:@"accessToken"]; // access tocken pass in .pch file
    
    NSLog(@"%@",accessTocken);
    
    NSString *str=[NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?access_token=%@",accessTocken];
    NSString *escapedUrl = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",escapedUrl]];
    NSString *jsonData = [[NSString alloc] initWithContentsOfURL:url usedEncoding:nil error:nil];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    
    userEmailForFB = [jsonDictionary objectForKey:@"email"];
    NSLog(@"userEmail gmail ====%@",userEmailForFB);
    
    fbIdFb = [jsonDictionary objectForKey:@"id"];
    
    NSLog(@"id for gmail ====%@",fbIdFb);
    
    googleUserInfermation = jsonDictionary;
    
    userLogInBy = @"google";
    
    NSLog(@"googleUserInfermation = %@",googleUserInfermation);
    
    
    // NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
    // NSString *userId=[jsonDictionary objectForKey:@"id"];
    // proDic=[jsonData JSONValue];
    // NSLog(@" user deata %@",jsonData);
    //NSLog(@"Received Access Token:%@",auth);
    // NSLog(@"user google user id  %@",signIn.userEmail); //logged in user's email id
    
    // [self reportAuthStatus];
    
    //    UserDetailViewViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
    //                                        instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
    //
    //    wc.googleData = jsonDictionary;
    //    NSLog(@"GoogleData: %@",jsonDictionary);
    //
    //    [self.navigationController pushViewController:wc animated:YES];
    
    // [[GPPSignIn sharedInstance] signOut];
    
    
    [self loginApi];
    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
    [activityIndicatorView stopAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [activityIndicatorView stopAnimating];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    if ([[[request URL] absoluteString] hasPrefix:@"in.zenparent:/oauth2callback"]) {
        [GPPURLHandler handleURL:request.URL sourceApplication:@"com.apple.mobilesafari" annotation:nil];
        // [self.navigationController popViewControllerAnimated:YES];
        
        [webView removeFromSuperview];
        // [activityIndicatorView startAnimating];
        
        return NO;
    }
    return YES;
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class implementation.
    // Usually calling super class implementation is done before self class implementation, but it's up to your application.
    
    [activityIndicatorView stopAnimating];
}



- (IBAction)privacePolicy:(id)sender {
    
    NSLog(@"working.......");
    
    
    PrivacePolicy_view *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                              instantiateViewControllerWithIdentifier:@"Privace"];
    
    [self.navigationController pushViewController:wc animated:YES];
    
}

-(void)loginApi
{
    
    // LogIn Api
    NSString *diviceTokenOr = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
    NSLog(@"LOGINUSERID  =====%@",diviceTokenOr);
    
    
    
#if TARGET_IPHONE_SIMULATOR
    
    diviceTokenOr = @"bfdhsglhjsg/ldshlhdjsgh4ou7982urejhfy4hhbdkhfjkdshfjhw89jdfbjkdshfuew";
    
#else
    
    // Device
    
#endif
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"email": userEmailForFB,
                             
                             @"device_token": diviceTokenOr
                             ,
                             @"device_type": @"ios"
                             ,
                             @"login_by": userLogInBy
                             ,
                             @"social_unique_id":fbIdFb,
                             
                             @"access_token": accessTocken
                             
                             };
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
    [manager POST:@"http://zenparent.in/api/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"my Value LOGINAt View :%@", responseObject);
        
        NSString *errorCode = [responseObject objectForKey:@"error_code"];
        
        int value = [errorCode intValue];
        
        if (value == 403) {
            
            [activityIndicatorView stopAnimating];
            
            
            if ([UIAlertController class])
            {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Logon Failed Due to Server Configuration with No Authentication" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            }
            else
            {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Logon Failed Due to Server Configuration with No Authentication" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
            return;
            
        }
        
        else if (value == 401) {
            
            if (IS_IPAD)
            {
                UserDetailViewViewController *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                                    instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
                wc.myDIc = _userdata;
                NSLog(@"facebookData:%@",_userdata);
                
                wc.userurl1 = userImageURL;
                wc.googleData = googleUserInfermation;
                wc.logINBy = userLogInBy;
                
                
                [self.navigationController pushViewController:wc animated:YES];
                
            }else {
                
                UserDetailViewViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                                    instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
                wc.myDIc = _userdata;
                NSLog(@"facebookData:%@",_userdata);
                
                wc.userurl1 = userImageURL;
                wc.googleData = googleUserInfermation;
                wc.logINBy = userLogInBy;
                
                
                [self.navigationController pushViewController:wc animated:YES];
                // [self presentViewController:wc animated:YES completion:nil];
                
            }
            
            
        }else{
            
            
            
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
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PARlogged_in"];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"PartiallyRegistered"];
            
            //Language settings
            
            
            [[NSUserDefaults standardUserDefaults] setObject:@"English" forKey:@"LanguageDefalt"];
            
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
                
                
                if (IS_IPAD)
                {
                    UserDetailViewViewController *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                                        instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
                    wc.myDIc = _userdata;
                    NSLog(@"facebookData:%@",_userdata);
                    
                    wc.userurl1 = userImageURL;
                    
                    wc.logINBy = userLogInBy;
                    
                    [self.navigationController pushViewController:wc animated:YES];
                    // [self presentViewController:wc animated:YES completion:nil];
                    
                }else {
                    
                    UserDetailViewViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                                        instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
                    wc.myDIc = _userdata;
                    NSLog(@"facebookData:%@",_userdata);
                    
                    wc.userurl1 = userImageURL;
                    
                    wc.logINBy = userLogInBy;
                    
                    [self.navigationController pushViewController:wc animated:YES];
                    // [self presentViewController:wc animated:YES completion:nil];
                    
                }
                
            } else {
                
                
                HOMEViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                          instantiateViewControllerWithIdentifier:@"HOMEIOS"];
                [self.navigationController pushViewController:wc animated:YES];
                
            }
            
        } //end of else
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
    }];
    
}


@end
