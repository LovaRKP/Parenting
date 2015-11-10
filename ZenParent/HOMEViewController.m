//
//  HOMEViewController.m
//  ZenParent
//
//  Created by Soumya Ranjan on 29/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "HOMEViewController.h"

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "HomeContantView.h"
#import "YourEventsView.h"
#import "ReviewsViewViewController.h"
#import "RecipeView.h"
#import "ParentingView.h"
#import "DinnerConversationView.h"
#import "EasyTipsView.h"
#import "BookMarksView.h"
#import "SetingsView.h"
#import "AFHTTPRequestOperationManager.h"
#import "ViewController.h"
#import "SampleDetail.h"
#import "SignUpView.h"

#import "WebViewController.h"
#import "Web2ViewController.h"

#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface HOMEViewController () <NKJPagerViewDataSource,NKJPagerViewDelegate,UIActionSheetDelegate,UIWebViewDelegate>

@end

@implementation HOMEViewController

- (void)viewDidLoad {
    
    
    // Do any additional setup after loading the view.
    // APP Deligate

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    self.dataSource = self;
    self.delegate = self;
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:116.0f/255.0f
                                                                             green:79.0f/255.0f
                                                                              blue:141.0f/255.0f
                                                                             alpha:1.0f]];
    
    
    [self.navigationController.navigationBar  setTranslucent:YES];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    
    UIButton *rightItem  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(ShowSettings:)forControlEvents:UIControlEventTouchUpInside];
    [rightItem setFrame:CGRectMake(44, 0, 32, 32)];
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76, 32)];
    [rightBarButtonItems addSubview:rightItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
        
        NSLog(@"English");

    
    self.navigationItem.title = @"HOME";
        
    }else {
    
    self.navigationItem.title = @"होम";
    
    }
    
        
        
    self.navigationItem.hidesBackButton = YES;
    
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    
}


- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)ShowSettings:(id)sender{
    
    [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setTintColor:[UIColor colorWithRed:116.0f/255.0f  green:79.0f/255.0f blue:141.0f/255.0f alpha:1.0f]];
    
//    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
//                            
//                            stringForKey:@"PartiallyRegistered"];
//    
//    NSLog(@"savedValue == %@",savedValue);
//    
//    NSLog(@"savedValue ==now......%@",savedValue);
    
    
   // Chicking Language
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
        
        NSLog(@"English");

    
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"PARlogged_in"])
        
    {
        NSLog(@"Taking to NonLogIn User data......");
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Please LogIn:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"LogIn",
                                
                                nil];

        popup.tag = 1;
        
        
        if (IS_IPAD)
        {
            [popup showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
            
        } else {
            
            [popup showInView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    }else {

        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select The Action:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"Settings",
                                @"ZenParent Website",
                                @"About US",
                                @"Logout",
                                
                                nil];

        popup.tag = 1;
  
        if (IS_IPAD)
        {
            [popup showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
            
        } else {
            
            [popup showInView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    }
        
    }
    //else for language
    else
    {

        if([[NSUserDefaults standardUserDefaults] boolForKey:@"PARlogged_in"])
            
        {
            NSLog(@"Taking to NonLogIn User data......");
            
            UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"कृपया लॉगिन करें:" delegate:self cancelButtonTitle:@"रद्द" destructiveButtonTitle:nil otherButtonTitles:
                                    @"लॉग इन करें",
                                    
                                    nil];
            
            popup.tag = 1;

            if (IS_IPAD)
            {
                [popup showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
                
            } else {
                
                [popup showInView:[UIApplication sharedApplication].keyWindow];
                
            }

        }else {

            UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"कार्रवाई चुनें:" delegate:self cancelButtonTitle:@"रद्द" destructiveButtonTitle:nil otherButtonTitles:
                                    @"सेटिंग",
                                    @"ZenParent वेबसाइट",
                                    @"हमारे बारे में",
                                    @"लॉग आउट",
                                    
                                    nil];

            popup.tag = 1;
            
            
            if (IS_IPAD)
            {
                [popup showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
                
            } else {
                
                [popup showInView:[UIApplication sharedApplication].keyWindow];
                
            }
            
        }

    }
 
}


- (NSUInteger)numberOfTabView
{
    return 8;
}

- (UIView *)viewPager:(NKJPagerViewController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    
    
    UILabel *label = [[UILabel alloc] init];
    if (IS_IPAD) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 60)];
        
    }else {
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    }
    
    
    UIColor *color = [UIColor blackColor];
    label.backgroundColor = color;
    
    if (IS_IPAD) {
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    }else {
    
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    }

    switch (index) {
        case 0:
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
                
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                label.text = [NSString stringWithFormat:@"DINNER CONVERSATION" ];
               
            } else {
                 NSLog(@"Hindi");
                
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.numberOfLines = 0;
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"डिनर बातचीत";
                [self boldFontForLabel:label];
                
            }

            break;
            
        case 1:
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
                
                
              label.text = [NSString stringWithFormat:@"EASY TIPS" ];
                
            } else {
                NSLog(@"Hindi");
                
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"आसान नुस्खे";
                [self boldFontForLabel:label];

                
            }
         
            
            break;
            
        case 2:
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
                
                
                   label.text = [NSString stringWithFormat:@"BOOKMARKS" ];
                
            } else {
                NSLog(@"Hindi");
                
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"बुकमार्क्स";
                [self boldFontForLabel:label];
                
                
            }
        
            break;
            
        case 3:
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
                
                
             label.text = [NSString stringWithFormat:@"HOME" ];
                
            } else {
                NSLog(@"Hindi");
                
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"होम";
                [self boldFontForLabel:label];
                
                
            }
           
            
            break;
        case 4:
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
                
                
                
                label.text = [NSString stringWithFormat:@"EVENTS" ];
                
            } else {
                NSLog(@"Hindi");
                
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"घटना";
                [self boldFontForLabel:label];
                
                
            }
            
            break;
        case 5:
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
                
                
       label.text = [NSString stringWithFormat:@"RECIPES" ];
                
            } else {
                NSLog(@"Hindi");
                
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"व्यंजनों";
                [self boldFontForLabel:label];
                
                
            }
            
            
            break;
        case 6:
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
          label.text = [NSString stringWithFormat:@"REVIEWS" ];
                
            } else {
                NSLog(@"Hindi");
                
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"समीक्षा";
                [self boldFontForLabel:label];
                
                
            }
     
            break;
        case 7:
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
                
                NSLog(@"English");
        
                label.text = [NSString stringWithFormat:@"PARENTING" ];
                
            } else {
                NSLog(@"Hindi");
                
                UIFont *font = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
                label.font = font;
                label.text = @"पेरेंटिंग";
                [self boldFontForLabel:label];
                
                
            }
        
            
            break;
            
        default:
            break;
            
            
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    return label;
}



-(void)boldFontForLabel:(UILabel *)label{
    UIFont *currentFont = label.font;
    UIFont *newFont = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",currentFont.fontName] size:currentFont.pointSize];
    label.font = newFont;
}

- (UIViewController *)viewPager:(NKJPagerViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ContentViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Content"];
    
    if (IS_IPAD)
    {
        
        
        if (index == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            
            DinnerConversationView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"DINNER"];
            
            return vc3;
            
            
            
        }
        if (index == 1){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            
            EasyTipsView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"EasyTips"];
            
            return vc3;
        }
        else if (index == 2){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            
            BookMarksView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"BookMarks"];
            
            return vc3;
            
            
            
        }else if (index == 3){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            HomeContantView *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"HomeCon"];
            return vc2;
            
            
            
        }else if (index == 4){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            YourEventsView *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"YOU"];
            return vc2;
            
        }else if (index == 5){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            
            RecipeView*vc3 = [storyboard instantiateViewControllerWithIdentifier:@"RecipeView"];
            
            return vc3;
            
        }else if (index == 6){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            ReviewsViewViewController *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"Reviews"];
            return vc3;
            
        }else if (index == 7){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil];
            
            ParentingView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"Parenting"];
            
            return vc3;
            
            
            
        }
        
        
        
    }else {
        
        
        if (index == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DinnerConversationView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"DINNER"];
            
            return vc3;
            
            
            
        }
        if (index == 1){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            EasyTipsView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"EasyTips"];
            
            return vc3;
        }
        else if (index == 2){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            BookMarksView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"BookMarks"];
            
            return vc3;
            
            
            
        }else if (index == 3){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HomeContantView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"HomeCon"];
            return vc3;
            
            
            
        }else if (index == 4){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            YourEventsView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"YOU"];
            return vc3;
            
        }else if (index == 5){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            RecipeView*vc3 = [storyboard instantiateViewControllerWithIdentifier:@"RecipeView"];
            
            return vc3;
            
        }else if (index == 6){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ReviewsViewViewController *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"Reviews"];
            return vc3;
            
        }else if (index == 7){
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            ParentingView *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"Parenting"];
            
            return vc3;
            
        }
        
    }
    
    
    return vc;
}


- (NSInteger)widthOfTabView
{
    
    
    if (IS_IPAD)
    {
        
        return 250;
        
    }
    else
    {
        return  120;
        
    }
    
    
}
#pragma mark - NKJPagerViewDelegate

- (void)viewPager:(NKJPagerViewController *)viewPager didSwitchAtIndex:(NSInteger)index withTabs:(NSArray *)tabs
{
    [UIView animateWithDuration:0.01
                     animations:^{
                         for (UIView *view in self.tabs) {
                             if (index == view.tag) {
                                 view.alpha = 1.0;
                             } else {
                                 view.alpha = 0.7;
                             }
                         }
                     }
     
                     completion:^(BOOL finished){}];
    
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"PARlogged_in"])
        
    {

        NSLog(@"Taking to NonLogIn User data......");
        
        NSLog(@"Logged out of facebook");
        
        
        [FBSession.activeSession closeAndClearTokenInformation];
        
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            NSString* domainName = [cookie domain];
            NSRange domainRange = [domainName rangeOfString:@"facebook"];
            if(domainRange.length > 0)
            {
                [storage deleteCookie:cookie];
            }
        }
        
        
        FBSession* session = [FBSession activeSession];
        [session closeAndClearTokenInformation];
        [session close];
        [FBSession setActiveSession:nil];
        
        NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray* facebookCookies = [cookies cookiesForURL:[NSURL         URLWithString:@"https://facebook.com/"]];
        
        for (NSHTTPCookie* cookie in facebookCookies) {
            [cookies deleteCookie:cookie];
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"logged_in"];
        
        // [self signOut];
        
        [[GPPSignIn sharedInstance] signOut];

        
        
        
        ViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                          instantiateViewControllerWithIdentifier:@"ViewContr"];
        
        [self.navigationController pushViewController:wc animated:YES];
        
        
    }
    else {

    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:{
                    NSLog(@"Settings");
                    
                    SampleDetail *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                        instantiateViewControllerWithIdentifier:@"Sample"];
                    
                    [self.navigationController pushViewController:wc animated:YES];
                }
                    
                    break;
                case 1:
                {
                    NSLog(@"ZenParent WEbsite");
                    WebViewController *wcWeb = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                                instantiateViewControllerWithIdentifier:@"WeBView"];
                    
                    [self.navigationController pushViewController:wcWeb animated:YES];
                }

                    break;
                case 2:
                    NSLog(@"About US");
                {
                    
                    Web2ViewController *wcWeb = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                                 instantiateViewControllerWithIdentifier:@"Web2View"];
                    
                    [self.navigationController pushViewController:wcWeb animated:YES];
                }

                    break;
                case 3:
                    NSLog(@"Logout");
                    [self LOGOUTpressed];
                    
                    break;
                    
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    }
}

-(void)LOGOUTpressed{
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
    
    NSDictionary *parameters = @{
                                 @"user_id" : UserId,
                                 @"token" : userToken
                                 
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://zenparent.in/api/logout"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             
             // [self fbDidLogout];
             
             NSLog(@"Logged out of facebook");
             
             
             [FBSession.activeSession closeAndClearTokenInformation];
             
             NSHTTPCookie *cookie;
             NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
             for (cookie in [storage cookies])
             {
                 NSString* domainName = [cookie domain];
                 NSRange domainRange = [domainName rangeOfString:@"facebook"];
                 if(domainRange.length > 0)
                 {
                     [storage deleteCookie:cookie];
                 }
             }
             
             
             FBSession* session = [FBSession activeSession];
             [session closeAndClearTokenInformation];
             [session close];
             [FBSession setActiveSession:nil];
             
             NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
             NSArray* facebookCookies = [cookies cookiesForURL:[NSURL         URLWithString:@"https://facebook.com/"]];
             
             for (NSHTTPCookie* cookie in facebookCookies) {
                 [cookies deleteCookie:cookie];
             }
             
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"logged_in"];
             
             // [self signOut];
             
             [[GPPSignIn sharedInstance] signOut];
             
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PARlogged_in"];
             [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"PartiallyRegistered"];
             
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             SignUpView *ivc = [storyboard instantiateViewControllerWithIdentifier:@"SignUpView"];
             [self.navigationController pushViewController:ivc animated:YES];
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             
         }];
    
}


-(void)fbDidLogout
{
    NSLog(@"Logged out of facebook");
    
    
    [[FBSession activeSession] close];
    [[FBSession activeSession] closeAndClearTokenInformation];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
}


- (void)signOut {
    
    
    
}



@end
