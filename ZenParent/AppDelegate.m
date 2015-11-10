//
//  AppDelegate.m
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "AppDelegate.h"
#import <GooglePlus/GooglePlus.h>
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserDetailViewViewController.h"
#import "ViewController.h"
#import "HOMEViewController.h"
#import <GoogleAppIndexing/GoogleAppIndexing.h>

// detailviews
#import "DetailDinnerViewNew.h"
#import "DetailEasyTipsNew.h"
#import "DetailEventNew.h"
#import "DetailParentingViewNew.h"
#import "DetailRecipeNew.h"
#import "DetailReviewNew.h"
#import "GAI.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


#import "SignUpView.h"
#import <GoogleAppIndexing/GoogleAppIndexing.h>


#define GA_TRACKING_ID @"UA-64993437-1"


#import "IMSdk.h"
#import "IMCommonConstants.h"
#import "IMSdk.h"
#import "IMNative.h"
#import "IMCustomNative.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"
#import "IMNativeDelegate.h"
#import "IMRequestStatus.h"


#import "HomeContantView.h"
#import "YourEventsView.h"
#import "ReviewsViewViewController.h"
#import "RecipeView.h"
#import "ParentingView.h"
#import "DinnerConversationView.h"
#import "EasyTipsView.h"



#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

@interface AppDelegate ()<UIActionSheetDelegate,UIAlertViewDelegate>

{
    NSString *articalIdNew;
    NSURL * myurl;
    NSString *articalidFromDeep;
    NSMutableDictionary *deepArray;
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Fabric with:@[CrashlyticsKit]];
    
    
    // 1
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // 2
    //  [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    
    
    [[GAI sharedInstance] setDispatchInterval:10.0];
    
    
    
    [[GAI sharedInstance] trackerWithTrackingId:GA_TRACKING_ID];
    
    // FBLoginView
    
    
    //Initialize InMobi SDK with your property-ID
    
   [IMSdk initWithAccountID:@"957c6e9e07384acba8f99d4fa35545fd"];   //957c6e9e07384acba8f99d4fa35545fd
    
  
    
    
    // Do your stuff.
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:116.0f/255.0f
                                                                 green:79.0f/255.0f
                                                                  blue:141.0f/255.0f
                                                                 alpha:1.0f]];
    
    
    //  [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UIToolbar appearance] setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
 

      //pushNotification
    
    [self connected];
    
  
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert |
         UIUserNotificationTypeBadge |
         UIUserNotificationTypeSound
                                          categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    else
    {
//        
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//         UIRemoteNotificationTypeAlert |
//         UIRemoteNotificationTypeBadge |
//         UIRemoteNotificationTypeSound];
//        
    }
    
    
    [FBLoginView class];
    [FBProfilePictureView class];
    
    // creating the catche.
    
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:20*1024*1024
                                                      diskCapacity:32*1024*1024
                                                          diskPath:@"app_cache"];
    
    // Set the shared cache to our new instance
    [NSURLCache setSharedURLCache:cache];
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
        
        
        [self displayLogin];
    } else {
        
        
        [self displayMainScreen];
    }
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"PARlogged_in"]) {
        
        [self displayMainScreen];
        
    }
    
    return YES;
}






// Autorotation ipad

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000

- (NSInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
#else
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //    return [FBAppCall handleOpenURL:url
    //                 sourceApplication:sourceApplication];
    //
    //    return [GPPURLHandler handleURL:url
    //                  sourceApplication:sourceApplication
    //                         annotation:annotation];
    
    if ([GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation]) {
        return YES;
    }else if([FBAppCall handleOpenURL:url sourceApplication:sourceApplication]){
        return YES;
    }
    //host=zenparent.in
    //url = zenaparent.in/cartegory/post_name
    //url_with_pid = zenaparent.in/cartegory/post_name?pid=123
    //zenparent.in/api/single_article?params..?deep_link=1
    //respose = single_post_object ...post_id,post_type,post_title,pso
    
  

    
    
    
    NSLog( @"url for Api:===== %@",url);
    
    NSString *yourString = [url absoluteString];
    
    NSString * strNoURLScheme =
    [yourString stringByReplacingOccurrencesOfString:@"zenparent.ios://http//" withString:@"http://"];
    
    NSLog(@"URL without scheme: %@", strNoURLScheme);
    
    NSURL *myurlwithdeep = [NSURL URLWithString:strNoURLScheme];
    deepArray = [[NSMutableDictionary alloc]init];
    myurl = myurlwithdeep;
    [self deepLinkApi];
    
    
    
    // Note these methods take in the raw URL, not the sanitizedURL
    if ([GSDDeepLink isDeepLinkFromGoogleAppCrawler:url]) {
        
        NSLog(@"Working.....");
        // Don't count this traffic as part of organic app usage
    } else if ([GSDDeepLink isDeepLinkFromGoogleSearch:url]) {
        // Add analytics code below to track click from Google Search
        
        NSLog(@"Working.....");
    }
    
    
    return YES;
    
}





- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_AVAILABLE_IOS(8_0){
    [application registerForRemoteNotifications];
    
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSString *deviceToken = [[devToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"DeviceToken: content---%@", deviceToken);
    [[NSUserDefaults standardUserDefaults]setObject:deviceToken forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error  'this is a sumamulater': %@", err);
    
}

//Push Working

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ( application.applicationState == UIApplicationStateActive ){
        
        //Ipad code
        
        if (IS_IPAD) {
            
            // app was already in the foreground
            NSLog(@"app was already in the foreground");
            
            
            NSMutableDictionary *tempdic = [userInfo objectForKey:@"data"];
            NSLog(@"Dect  ====%@",tempdic);
            
            NSString *articalId = [tempdic objectForKey:@"article_id"];
            NSLog(@"articalidf====%@",articalId);
            
            NSString *articalType = [tempdic objectForKey:@"type"];
            NSLog(@"articalidf====%@",articalType);
            
            NSString *urlsite = [tempdic objectForKey:@"link"];
            NSLog(@"articalidf====%@",urlsite);
            
            
            // Remove Hardcoding link while testing........
            
            if (![[tempdic allKeys] containsObject:@"link"]){
                
                if ([articalType isEqualToString:@"reviews"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailReviewNew *controller = (DetailReviewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailReviewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"recipes"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailRecipeNew *controller = (DetailRecipeNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailRecipeNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                    
                }
                else if ([articalType isEqualToString:@"easy_tips"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailEasyTipsNew *controller = (DetailEasyTipsNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEasyTipsNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"events"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailEventNew *controller = (DetailEventNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEventnw"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"dinner_conversations"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailDinnerViewNew *controller = (DetailDinnerViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailDinnerViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"parenting"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailParentingViewNew *controller = (DetailParentingViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailParentingViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                
            }
            else{
                
                NSLog(@"Second Push.....");
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsite]];
                
            }
            
            
        }else {
            
            // app was already in the foreground
            NSLog(@"app was already in the foreground");
            
            
            NSMutableDictionary *tempdic = [userInfo objectForKey:@"data"];
            NSLog(@"Dect  ====%@",tempdic);
            
            NSString *articalId = [tempdic objectForKey:@"article_id"];
            NSLog(@"articalidf====%@",articalId);
            
            NSString *articalType = [tempdic objectForKey:@"type"];
            NSLog(@"articalidf====%@",articalType);
            
            NSString *urlsite = [tempdic objectForKey:@"link"];
            NSLog(@"articalidf====%@",urlsite);
            
            
            // Remove Hardcoding link while testing........
            
            //   if (IS_IPAD) {
            
            if (![[tempdic allKeys] containsObject:@"link"]){
                
                if ([articalType isEqualToString:@"reviews"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailReviewNew *controller = (DetailReviewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailReviewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"recipes"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailRecipeNew *controller = (DetailRecipeNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailRecipeNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                    
                }
                else if ([articalType isEqualToString:@"easy_tips"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailEasyTipsNew *controller = (DetailEasyTipsNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEasyTipsNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"events"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailEventNew *controller = (DetailEventNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEventnw"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"dinner_conversations"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailDinnerViewNew *controller = (DetailDinnerViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailDinnerViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"parenting"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailParentingViewNew *controller = (DetailParentingViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailParentingViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                
            }
            else{
                
                NSLog(@"Second Push.....");
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsite]];
                
            }
            
            
        }
        
        
    }
    
    else {
        
        if (IS_IPAD){
            
            // app was just brought from background to foreground
            NSLog(@"app was just brought from background to foreground");
            
            
            // sending push
            
            
            //   {"title":"Name of the article","id":"id of the article","type":"type of the article"}
            
            //  '{"aps":{"alert": "'.$message.'" ,"badge":1,"sound":"default"}}'
            
            NSMutableDictionary *tempdic = [userInfo objectForKey:@"data"];
            
            NSLog(@"Dect  ====%@",tempdic);
            
            
            
            NSString *articalId = [tempdic objectForKey:@"article_id"];
            NSLog(@"articalidf====%@",articalId);
            
            NSString *articalType = [tempdic objectForKey:@"type"];
            NSLog(@"articalidf====%@",articalType);
            
            
            NSString *urlsite = [tempdic objectForKey:@"link"];
            NSLog(@"articalidf====%@",urlsite);
            
            
            if (![[tempdic allKeys] containsObject:@"link"]){
                
                
                if ([articalType isEqualToString:@"reviews"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailReviewNew *controller = (DetailReviewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailReviewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"recipes"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailRecipeNew *controller = (DetailRecipeNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailRecipeNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                    
                }
                else if ([articalType isEqualToString:@"easy_tips"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailEasyTipsNew *controller = (DetailEasyTipsNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEasyTipsNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"events"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailEventNew *controller = (DetailEventNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEventnw"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"dinner_conversations"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailDinnerViewNew *controller = (DetailDinnerViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailDinnerViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"parenting"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardiPad" bundle: nil];
                    DetailParentingViewNew *controller = (DetailParentingViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailParentingViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                
            } //first if
            else{
                
                NSLog(@"Second Push.....");
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsite]];
                
                
            }
            
            
            
            
        }else{
            
            
            // app was just brought from background to foreground
            NSLog(@"app was just brought from background to foreground");
            
            
            // sending push
            
            
            //   {"title":"Name of the article","id":"id of the article","type":"type of the article"}
            
            //  '{"aps":{"alert": "'.$message.'" ,"badge":1,"sound":"default"}}'
            
            NSMutableDictionary *tempdic = [userInfo objectForKey:@"data"];
            
            NSLog(@"Dect  ====%@",tempdic);
            
            
            
            NSString *articalId = [tempdic objectForKey:@"article_id"];
            NSLog(@"articalidf====%@",articalId);
            
            NSString *articalType = [tempdic objectForKey:@"type"];
            NSLog(@"articalidf====%@",articalType);
            
            
            NSString *urlsite = [tempdic objectForKey:@"link"];
            NSLog(@"articalidf====%@",urlsite);
            
            
            if (![[tempdic allKeys] containsObject:@"link"]){
                
                
                if ([articalType isEqualToString:@"reviews"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailReviewNew *controller = (DetailReviewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailReviewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"recipes"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailRecipeNew *controller = (DetailRecipeNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailRecipeNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                    
                }
                else if ([articalType isEqualToString:@"easy_tips"])
                {
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailEasyTipsNew *controller = (DetailEasyTipsNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEasyTipsNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"events"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailEventNew *controller = (DetailEventNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEventnw"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"dinner_conversations"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailDinnerViewNew *controller = (DetailDinnerViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailDinnerViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                else if ([articalType isEqualToString:@"parenting"])
                {
                    
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    DetailParentingViewNew *controller = (DetailParentingViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailParentingViewNew"];
                    controller.articalID = articalId;
                    [navigationController pushViewController:controller animated:YES];
                    
                }
                
            } //first if
            else{
                
                NSLog(@"Second Push.....");
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsite]];
                
                
            }
            
        }
        
    }
    
}

// Connection Chick
-(BOOL)connected {
    
    __block BOOL reachable;
    
    // Setting block doesn't means you area running it right now
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"No Internet Connection");
                
                if ([UIAlertController class])
                {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please check the Network Status and try again" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:ok];
                    
                    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
                    
                    
                }
                else
                {
                    
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"please check the network status and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }
                reachable = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                
                reachable = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G");
                reachable = YES;
                break;
            default:
                NSLog(@"Unkown network status");
                reachable = NO;
                break;
                
        }
    }];
    // and now activate monitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return reachable;
    
}

-(void)displayLogin{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpView *ivc = [storyboard instantiateViewControllerWithIdentifier:@"SignUpView"];
    UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:ivc];
    self.window.rootViewController =nil;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    
}

-(void)displayMainScreen{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HOMEViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"HOMEIOS"];
    UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:ivc];
    self.window.rootViewController =nil;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    
}

-(void)deepLinkApi{
    
    NSDictionary *parameters = @{
                                 @"url" :myurl,
                                 
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://zenparent.in/api/deep_link"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON DEEPLINKING: %@", responseObject);
             
             //geting data from varun
             
             deepArray = [responseObject objectForKey: @"result"];
             
             NSString *beepPathString = [myurl path];
             NSLog(@"beepPathString   %@", beepPathString);
             
             
             NSURL *sanitizedURL = [GSDDeepLink handleDeepLink:myurl];
             
             NSLog(@"sanitizedURL ===%@",sanitizedURL);
             
             if (IS_IPAD) {
                 
                 
                 
                 if ([myurl.pathComponents[1] isEqualToString:@"reviews"]){
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailReviewNew *controller = (DetailReviewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailReviewNew"];
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"recipes"]){
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailRecipeNew *controller = (DetailRecipeNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailRecipeNew"];
                     
                     controller.articalDeepArray = deepArray;
                     
                     [navigationController pushViewController:controller animated:YES];
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"easy-tips"]){
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailEasyTipsNew *controller = (DetailEasyTipsNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEasyTipsNew"];
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1]  isEqualToString:@"events"]){
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailEventNew *controller = (DetailEventNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEventnw"];
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"dinner-conversations"]){
                     
                     
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailDinnerViewNew *controller = (DetailDinnerViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailDinnerViewNew"];
                     
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"parenting"]){
                     
                     NSLog(@"working............");
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailParentingViewNew *controller = (DetailParentingViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailParentingViewNew"];
                     
                     controller.articalDeepArray = deepArray;
                     
                     [navigationController pushViewController:controller animated:YES];
                     
                 }
                 
             }else {
                 
                 
                 
                 if ([myurl.pathComponents[1] isEqualToString:@"reviews"]){
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailReviewNew *controller = (DetailReviewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailReviewNew"];
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"recipes"]){
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailRecipeNew *controller = (DetailRecipeNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailRecipeNew"];
                     
                     controller.articalDeepArray = deepArray;
                     
                     [navigationController pushViewController:controller animated:YES];
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"easy-tips"]){
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailEasyTipsNew *controller = (DetailEasyTipsNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEasyTipsNew"];
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1]  isEqualToString:@"events"]){
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailEventNew *controller = (DetailEventNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailEventnw"];
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"dinner-conversations"]){
                     
                     
                     
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailDinnerViewNew *controller = (DetailDinnerViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailDinnerViewNew"];
                     
                     controller.articalDeepArray = deepArray;
                     [navigationController pushViewController:controller animated:YES];
                     
                     
                 }else if ([myurl.pathComponents[1] isEqualToString:@"parenting"]){
                     
                     NSLog(@"working............");
                     
                     UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                     DetailParentingViewNew *controller = (DetailParentingViewNew*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailParentingViewNew"];
                     
                     controller.articalDeepArray = deepArray;
                     
                     [navigationController pushViewController:controller animated:YES];
                     
                 }
                 
             }
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error: %@", error);
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:ok];
             [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
             
         }];
    
    
}
@end
