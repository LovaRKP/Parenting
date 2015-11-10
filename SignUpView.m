
//
//  SignUpView.m
//  ZenParent
//
//  Created by Soumya Ranjan on 17/07/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "SignUpView.h"

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


@interface SignUpView ()
{
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
    CDActivityIndicatorView * activityIndicatorView ;
    
}

@end

@implementation SignUpView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"LogIn Screen";
    
    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
    
    activityIndicatorView.center = self.view.center;
    
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    
    
    //
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:116.0f/255.0f
    //                                                                             green:79.0f/255.0f
    //                                                                              blue:141.0f/255.0f
    //                                                                             alpha:1.0f]];
    //    [self.navigationController.navigationBar  setTranslucent:NO];
    
    self.navigationItem.title = @"Sign In";
    
    
    if (IS_IPAD){
        
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 1024)
        {
            
            //create the scrollview with specific frame
            ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 750)];
            //array for views to add to the scrollview
            NSMutableArray *views = [[NSMutableArray alloc] init];
            //array for colors of views
            NSArray *colors = [[NSArray alloc] initWithObjects:@"image1.png",@"image2.png",@"image3.png",@"image4.png", nil];
            //cycle which creates views for the scrollview
            for (int i = 0; i < 4; i++) {
                UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 750)];
                
                NSLog(@"frame:  ====%@",view);
                
                view.image = [UIImage imageNamed:colors[i]];
                [views addObject:view];
                
                //add pages to scrollview
                [scrollView addPages:views];
                
                //add scrollview to the view
                [self.view addSubview:scrollView];
                
                [scrollView setHasPageControl:YES];
                [scrollView setPageControlCurrentPageColor:[UIColor redColor]];
                [scrollView setPageControlOtherPagesColor:[UIColor yellowColor]];
            }
            
        }
        
        
    }else {
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            //its iPhone. Find out which one?
            
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                
                //create the scrollview with specific frame
                ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 230)];
                //array for views to add to the scrollview
                NSMutableArray *views = [[NSMutableArray alloc] init];
                //array for colors of views
                NSArray *colors = [[NSArray alloc] initWithObjects:@"image1.png",@"image2.png",@"image3.png",@"image4.png", nil];
                //cycle which creates views for the scrollview
                for (int i = 0; i < 4; i++) {
                    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 230)];
                    
                    NSLog(@"frame:  ====%@",view);
                    
                    view.image = [UIImage imageNamed:colors[i]];
                    [views addObject:view];
                    
                    //add pages to scrollview
                    [scrollView addPages:views];
                    
                    //add scrollview to the view
                    [self.view addSubview:scrollView];
                    
                    [scrollView setHasPageControl:YES];
                    [scrollView setPageControlCurrentPageColor:[UIColor redColor]];
                    [scrollView setPageControlOtherPagesColor:[UIColor yellowColor]];
                }
                
                
            }
            else if(result.height == 568)
            {
                
                //create the scrollview with specific frame
                ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 300)];
                //array for views to add to the scrollview
                NSMutableArray *views = [[NSMutableArray alloc] init];
                //array for colors of views
                NSArray *colors = [[NSArray alloc] initWithObjects:@"image1.png",@"image2.png",@"image3.png",@"image4.png", nil];
                //cycle which creates views for the scrollview
                for (int i = 0; i < 4; i++) {
                    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 300)];
                    NSLog(@"frame:  ====%@",view);
                    view.image = [UIImage imageNamed:colors[i]];
                    [views addObject:view];
                    
                    
                    //add pages to scrollview
                    [scrollView addPages:views];
                    
                    //add scrollview to the view
                    [self.view addSubview:scrollView];
                    
                    [scrollView setHasPageControl:YES];
                    [scrollView setPageControlCurrentPageColor:[UIColor redColor]];
                    [scrollView setPageControlOtherPagesColor:[UIColor yellowColor]];
                    scrollView.showsVerticalScrollIndicator = NO;
                    scrollView.showsHorizontalScrollIndicator = NO;
                    
                }
                
            }
            else if(result.height == 667)
            {
                
                //create the scrollview with specific frame
                ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 400)];
                //array for views to add to the scrollview
                NSMutableArray *views = [[NSMutableArray alloc] init];
                //array for colors of views
                NSArray *colors = [[NSArray alloc] initWithObjects:@"image1.png",@"image2.png",@"image3.png",@"image4.png", nil];
                //cycle which creates views for the scrollview
                for (int i = 0; i < 4; i++) {
                    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 400)];
                    
                    NSLog(@"frame:  ====%@",view);
                    view.image = [UIImage imageNamed:colors[i]];
                    [views addObject:view];
                    
                    
                    //                [view addSubview:_myLeabel];
                    //                _myLeabel.backgroundColor = [UIColor clearColor];
                    //                _myLeabel.text = @"This app is designed to be your constant companion along the happy, thrilling and sometimes scary, rollercoaster that parenting is.";
                    //                _myLeabel.lineBreakMode = NSLineBreakByWordWrapping;
                    //                _myLeabel.numberOfLines = 0;
                    //                _myLeabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:26];
                    //                _logoImage.image = [UIImage imageNamed: @"logo-34.png"];
                    //                [ view addSubview:_logoImage ];
                    
                    
                    //add pages to scrollview
                    [scrollView addPages:views];
                    
                    //add scrollview to the view
                    
                    // view.contentMode = UIViewContentModeScaleAspectFit;
                    [self.view addSubview:scrollView];
                    
                    
                    
                    [scrollView setHasPageControl:YES];
                    [scrollView setPageControlCurrentPageColor:[UIColor redColor]];
                    [scrollView setPageControlOtherPagesColor:[UIColor yellowColor]];
                    
                    
                }
                
            }
            else if(result.height == 736)
            {
                
                //create the scrollview with specific frame
                ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 450)];
                //array for views to add to the scrollview
                NSMutableArray *views = [[NSMutableArray alloc] init];
                //array for colors of views
                NSArray *colors = [[NSArray alloc] initWithObjects:@"image1.png",@"image2.png",@"image3.png",@"image4.png", nil];
                //cycle which creates views for the scrollview
                for (int i = 0; i < 4; i++) {
                    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 450)];
                    view.image = [UIImage imageNamed:colors[i]];
                    [views addObject:view];
                    //add pages to scrollview
                    [scrollView addPages:views];
                    
                    //add scrollview to the view
                    [self.view addSubview:scrollView];
                    //                [self.view addSubview:_myLeabel];
                    //                _myLeabel.backgroundColor = [UIColor clearColor];
                    //                _myLeabel.text = @"This app is designed to be your constant companion along the happy, thrilling and sometimes scary, rollercoaster that parenting is.";
                    //                _myLeabel.lineBreakMode = NSLineBreakByWordWrapping;
                    //                _myLeabel.numberOfLines = 0;
                    //                _myLeabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
                    //                _logoImage.image = [UIImage imageNamed: @"logo-34.png"];
                    
                    [scrollView setHasPageControl:YES];
                    [scrollView setPageControlCurrentPageColor:[UIColor redColor]];
                    [scrollView setPageControlOtherPagesColor:[UIColor yellowColor]];
                }
                
            }
        }
    }
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:116.0f/255.0f
                                                                             green:79.0f/255.0f
                                                                              blue:141.0f/255.0f
                                                                             alpha:1.0f]];
    [self.navigationController.navigationBar  setTranslucent:YES];
    
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
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


- (IBAction)privacePolicePressedAction:(id)sender {
    
    NSLog(@"working.......");
    
    
    PrivacePolicy_view *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                              instantiateViewControllerWithIdentifier:@"Privace"];
    
    [self.navigationController pushViewController:wc animated:YES];
    
    
}
- (IBAction)continueAsGuestPressed:(id)sender {
    
    // DO the Guest Logic Here
    
    NSLog(@"working......");
    // Featch the device token and give to back end
    
    NSString *diviceTokenOr = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
    NSLog(@"LOGINUSERID  =====%@",diviceTokenOr);
    
    // Simulater detetction
    
#if TARGET_IPHONE_SIMULATOR
    
    //Simulator
    
    diviceTokenOr = @"bfdhsglhjsldshlhdjsgh4ou7982urejhfy4hhbdkhfjkdshfjhw89dsfsfdjdfbjkdshfuew";
    
    NSLog(@"device tocken don");
    
#else
    
    // Device
    
#endif
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{
                             
                             @"device_token":diviceTokenOr
                             
                             };
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
    [manager POST:@"http://zenparent.in/api/partial_register" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"my Value LOGINAt View :%@", responseObject);
        
        NSString * isPartiallyRegistered = [responseObject objectForKey:@"is_partially_registered"];
        
        NSString *parUserId = [responseObject objectForKey:@"id"];
        NSString *userTockenVlue = [responseObject objectForKey:@"token"];
        NSLog(@"is_partially_registered ====== %@",isPartiallyRegistered);
        
        [[NSUserDefaults standardUserDefaults] setObject:isPartiallyRegistered forKey:@"PartiallyRegistered"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([isPartiallyRegistered isEqualToString:@"1"]) {
            
            NSLog(@"isPartiallyRegistered .............");
            
            
            NSString *UserIdForParUser = parUserId;
            NSLog(@"value2 ====== %@",UserIdForParUser);
            
            if (userTockenVlue == (id)[NSNull null] || userTockenVlue.length == 0 ){
                
                userTockenVlue = @"dghlgfkhgdfkhgbjkadhdjkhkjhkf";
                
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:userTockenVlue forKey:@"REG_TOKEN"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:UserIdForParUser forKey:@"REG_userId"];
            
            NSLog(@"user id ===%@", [[NSUserDefaults standardUserDefaults ]objectForKey:@"REG_TOKEN"]);
            
            [[NSUserDefaults standardUserDefaults] setObject:@"English" forKey:@"LanguageDefalt"];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PARlogged_in"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            HOMEViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                      instantiateViewControllerWithIdentifier:@"HOMEIOS"];
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
        } else {
            
            NSLog(@"NormalUser .............");
            
            // collecting user id and tocken;
            
            NSString *parUserId = [responseObject objectForKey:@"id"];
            
            [[NSUserDefaults standardUserDefaults] setObject:userTockenVlue forKey:@"REG_TOKEN"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:parUserId forKey:@"REG_userId"];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"English" forKey:@"LanguageDefalt"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *valueToSave = @"0";
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"PartiallyRegistered"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *UserIdForParUser = parUserId;
            NSLog(@"value2 ====== %@",UserIdForParUser);
            
            HOMEViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                      instantiateViewControllerWithIdentifier:@"HOMEIOS"];
            
            [self.navigationController pushViewController:wc animated:YES];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
    }];
    
    
}



@end
