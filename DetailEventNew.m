//
//  DetailEventNew.m
//  ZenParent
//
//  Created by Soumya Ranjan on 15/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "DetailEventNew.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "TostView.h"

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"

//#define DebugLog


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#ifdef NDEBUG
#define NSLog(...) /* suppress NSLog when in release mode */
#endif

@interface DetailEventNew ()< MKMapViewDelegate,  CLLocationManagerDelegate ,UITabBarDelegate>

{
    
    
    
    NSMutableDictionary *myArray;
    CGSize Hight;
    NSString *shareUrl;
    CDActivityIndicatorView * activityIndicatorView ;
    
    CGFloat height123;
    
    UIButton *homeBtn ;
    UIButton *settingsBtn;
    NSString *venuglob;
    CLLocationManager *locationManager;
    
    NSString *Latitude;
    NSString *Longitude;
    
    NSString *longitudeLabel;
    NSString *latitudeLabel;
    
    NSString *venuDetails;
    NSString *screenname;
   
    
}

@end

@implementation DetailEventNew

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screenName = _screenValue;
    
    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
    
    activityIndicatorView.center = self.view.center;
    
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    [self setTabBarItemImages];

    
    NSLog(@"areticalid =====%@",_articalID);

      if (_articalID == (id)[NSNull null] )
    {
        // Logic handling

        
        // fill the screen with json data which we get from the varun...
        NSLog( @"WORKing.......");
        
        myArray = _articalDeepArray;
 
        NSString *imageUrl = [myArray objectForKey:@"image"];
        
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]
                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                  timeoutInterval:60];
        
        [_DetailImage setImageWithURLRequest:imageRequest
                            placeholderImage:[UIImage imageNamed:@"placeholder"]
                                     success:nil
                                     failure:nil];
        
        
        // Dates
        
        
        NSString *title = [myArray objectForKey:@"title"];
        
        NSString *date = [myArray objectForKey:@"start_date"];
        //  NSString *enddate = [myArray objectForKey:@"updated_at"];
        
        NSLog(@"Date====%@",date);
        
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        NSString *currentDateString = date;
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
        NSLog(@"CurrentDate:%@", currentDate);
        NSDateFormatter *currentDTFormatter = [[NSDateFormatter alloc] init];
        [currentDTFormatter setDateFormat:@"dd"];
        
        NSString *eventDateStr = [currentDTFormatter stringFromDate:currentDate];
        NSLog(@"Date===%@", eventDateStr);
        [currentDTFormatter setDateFormat:@"MMM"];
        NSString *eventDateStr1 = [currentDTFormatter stringFromDate:currentDate];
        NSLog(@"month===%@", eventDateStr1);
        
        //   NSString *time = [myArray objectForKey:@"updated_at"];
        
        NSString *ageGroup = [myArray objectForKey:@"age_group"];
        
        NSLog(@"myAge ===%@",ageGroup);
        
        NSString *notAva = [myArray objectForKey:@"cost"];
        NSString *PriceOfEvent = [myArray objectForKey:@"cost"];
        if ([notAva isEqualToString:@"Not Available"]) {
            
            PriceOfEvent = @"0";
            
        }else {
            
            PriceOfEvent = [myArray objectForKey:@"cost"];
            
        }
        
        _bodderAgeGroups.layer.cornerRadius = 8;
        _bodderAgeGroups.layer.borderWidth = 1;
        _bodderAgeGroups.layer.borderColor = [UIColor blackColor].CGColor;
        
        _bodderLeabelFordate.layer.cornerRadius = 8;
        _bodderLeabelFordate.layer.borderWidth = 1;
        _bodderLeabelFordate.layer.borderColor = [UIColor blackColor].CGColor;
        
        _bodderOnWords.layer.cornerRadius = 8;
        _bodderOnWords.layer.borderWidth = 1;
        _bodderOnWords.layer.borderColor = [UIColor blackColor].CGColor;
        
        _bodderPriceLabel.layer.cornerRadius = 8;
        _bodderPriceLabel.layer.borderWidth = 1;
        _bodderPriceLabel.layer.borderColor = [UIColor blackColor].CGColor;
        
        
        
        _titleTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleTextLabel.numberOfLines = 0;
        _titleTextLabel.text = title;
        
        
        _dateLeabel.text = eventDateStr;
        _monthInWOrdsLeabel.text = eventDateStr1;
        // cell2.timeLeabel.text = time;
        
        _ageGroups.text = ageGroup;
        _priceOfEventLeabel.text = [NSString stringWithFormat:@"Rs. %@",PriceOfEvent];
        _ageLeablelNew.text = ageGroup;
        
        
        
        // Dates cell
        
        NSString *dateStart = [myArray objectForKey:@"start_date"];
        NSString *dateOfend = [myArray objectForKey:@"end_date"];
        
        // NSString *timeOfevents = [myArray objectForKey:@"cost"];
        
        NSLog(@"dateStart====%@",dateStart);
        NSLog(@"dateEnd====%@",dateOfend);
        
        NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc]init];
        
        NSString *currentDateString1 = dateStart;
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *currentDate1 = [dateFormatter dateFromString:currentDateString1];
        NSLog(@"CurrentDate:%@", currentDate1);
        NSDateFormatter *currentDTFormatter2 = [[NSDateFormatter alloc] init];
        [currentDTFormatter2 setDateFormat:@"dd"];
        NSString *eventDateStr2 = [currentDTFormatter2 stringFromDate:currentDate];
        NSLog(@"Date===%@", eventDateStr2);
        
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate2 = [dateFormatter dateFromString:currentDateString];
        dateFormatter.dateFormat = @"HH:mm";
        NSLog(@"ooooooo     ====%@",[dateFormatter stringFromDate:yourDate2]);
        NSString *startingTime = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:yourDate2]];
        
        NSString *myString1 = dateOfend;
        
        NSLog(@"value ==== %@",myString1);
        
        
        NSDateFormatter* dateFormatter2 = [[NSDateFormatter alloc] init];
        dateFormatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter2 dateFromString:myString1];
        dateFormatter2.dateFormat = @"dd-MMM-yyyy";
        
        NSString *endibgDate = [dateFormatter2 stringFromDate:yourDate];
        NSLog(@"%@",[dateFormatter2 stringFromDate:yourDate]);
        
        dateFormatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate1 = [dateFormatter1 dateFromString:myString1];
        dateFormatter.dateFormat = @"HH:mm";
        
        NSLog(@"hdshjshdj     ====%@",[dateFormatter stringFromDate:yourDate1]);
        
        NSString *endingTime = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:yourDate1]];
        
        
        
        
        NSLog(@"gjshgdjg ==    %@-%@",eventDateStr,endibgDate);
        
        
        NSString *finalDate = [NSString stringWithFormat:@"%@ - %@",eventDateStr,endibgDate];
        
        _dateOfEvents.text = finalDate;
        
        _timeOfEvents.text = [NSString stringWithFormat:@"%@ - %@",startingTime,endingTime];
        
        
        _timeLeabel.text = [NSString stringWithFormat:@"%@",startingTime];
        NSString *Price = [myArray objectForKey:@"cost"];
        _priceOfEventsWIthDate.text = [NSString stringWithFormat:@"Rs.%@",Price];
        
        
        NSLog(@"%@",Price);
        
        
        // Phone NO clicked
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnLink:)];
        // if labelView is not set userInteractionEnabled, you must do so
        [_phoneNotextField setUserInteractionEnabled:YES];
        [_phoneNotextField addGestureRecognizer:gesture];
        
        _phoneNotextField.text = [myArray objectForKey:@"contact2"];
        
        _phoneNotextField.textColor = [UIColor blueColor];
        
        if ([[myArray objectForKey:@"contact2"] isEqualToString:@""]) {
            
            _phoneNotextField.text = @"Not Mentioned.";
            
        }
        
        // About
        
        
        NSString *abouttext = [myArray objectForKey:@"article_content"];
        
        NSString *htmlString = abouttext;
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        _textView.attributedText = attributedString;
        
        
        if (IS_IPAD)
        {
            _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
            _textView.textContainerInset = UIEdgeInsetsMake(0, 40, 0, 40);
            
        } else {
            
            _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
            _textView.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
            
            
        }
        
        
        
        _textView.editable = NO;
        
        
        
        //MapView
        
        venuDetails = [myArray objectForKey:@"venue"];
        
        _venuOrLocation.text = venuDetails;
        
        
        Latitude = [myArray objectForKey:@"latitude"];
        NSLog(@"distination latitude  %@",Latitude);
        
        Longitude = [myArray objectForKey:@"longitude"];
        NSLog(@"distination longitude  %@",Longitude);
        
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            [self->locationManager requestWhenInUseAuthorization];
        
        [locationManager startUpdatingLocation];
        
        
        
        
        // [self bookMatkstates];
        
        NSString * myBookMark = [myArray objectForKey:@"bookmarked"];
        
        NSLog(@"bookmark %@",myBookMark);
        
        int valuebook = [myBookMark intValue];
        
        if (valuebook == 0) {
            
            [homeBtn setSelected:NO];
            
        }else {
            
            [homeBtn setSelected:YES];
            
        }
        
        NSString *myLiked = [myArray objectForKey:@"liked"];
        
        NSLog(@"bookmark %@",myLiked);
        
        int valueLiked = [myLiked intValue];
        
        if (valueLiked == 0) {
            
            [settingsBtn setSelected:NO];
            
            
        }else {
            
            [settingsBtn setSelected:YES];
            
        }
        shareUrl = [myArray objectForKey:@"share_link"];
        NSLog(@"ShareLink === %@",shareUrl);
        
        [activityIndicatorView stopAnimating];

     
      
    }else{
    
        NSLog(@"not working.....");
        
         [self retriveDataFromServer];
    
    }
    
    // Do any additional setup after loading the view.
    
    
    NSLog(@"Artical ID =====%@", _articalID);
    
    shareUrl = [myArray objectForKey:@"share_link"];
    
    homeBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setImage:[UIImage imageNamed:@"bookmark@2x.png"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(BookMarkWithId:) forControlEvents:UIControlEventTouchUpInside];
    [homeBtn setFrame:CGRectMake(0, 0, 32, 32)];
    
    [homeBtn setImage:[UIImage imageNamed:@"bookmark_selected@2x.png"] forState:UIControlStateSelected];
    
    settingsBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [settingsBtn setImage:[UIImage imageNamed:@"like@2x.png"] forState:UIControlStateNormal];
    [settingsBtn addTarget:self action:@selector(LikedWithId:) forControlEvents:UIControlEventTouchUpInside];
    [settingsBtn setFrame:CGRectMake(44, 0, 32, 32)];
    
    [settingsBtn setImage:[UIImage imageNamed:@"like_selected@2x.png"] forState:UIControlStateSelected];
    
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76, 32)];
    [rightBarButtonItems addSubview:homeBtn];
    [rightBarButtonItems addSubview:settingsBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
}


-(void)viewWillLayoutSubviews {
    
    CGSize sizeThatFits = [self.textView sizeThatFits:CGSizeMake(self.view.frame.size.width, MAXFLOAT)];
    self.textViewHeightConstraint.constant = ceilf(sizeThatFits.height) ;
    
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    CGSize sizeThatFits = [self.textView sizeThatFits:CGSizeMake(self.view.frame.size.width, MAXFLOAT)];
    self.textViewHeightConstraint.constant = ceilf(sizeThatFits.height );
    
}

-(void)bookMatkstates{
    
    NSString * myBookMark = [myArray objectForKey:@"bookmarked"];
    NSLog(@"bookmark %@",myBookMark);
    
    int valuebook = [myBookMark intValue];
    
    
    
    if (valuebook == 0) {
        [homeBtn setSelected:YES];
        
    }else {
        [homeBtn setSelected:NO];
        
    }
    
    NSString *myLiked = [myArray objectForKey:@"liked"];
    NSLog(@"bookmark %@",myLiked);
    
    int valueLiked = [myLiked intValue];
    
    if (valueLiked == 0) {
        [settingsBtn setSelected:YES];
        
    }else {
        [settingsBtn setSelected:NO];
        
    }
    
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

-(void)retriveDataFromServer
{
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSLog(@"userTocken ===%@",userToken);
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
    
    NSLog(@"userTocken ===%@",UserId);
    
    NSDictionary *parameters = @{@"user_id" : UserId ,
                                 @"token" : userToken ,
                                 @"article_id" : _articalID
                                 
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://zenparent.in/api/single_article"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             NSString *errorStringForSectionToken = [responseObject objectForKey:@"error_code"];
             
             int value = [errorStringForSectionToken intValue];
             
             if (value == 406) {
                 
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

                 
                 ViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                       instantiateViewControllerWithIdentifier:@"ViewContr"];
                 
                 [self.navigationController pushViewController:wc animated:YES];
                 
             }else {
             
             
             myArray = [responseObject objectForKey: @"result"];
             NSLog(@"arrayCount======%@",myArray);
             
             
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                
                                
                                NSString *imageUrl = [myArray objectForKey:@"image"];
                                
                                NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]
                                                                              cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                                          timeoutInterval:60];
                                
                                [_DetailImage setImageWithURLRequest:imageRequest
                                                    placeholderImage:[UIImage imageNamed:@"placeholder"]
                                                             success:nil
                                                             failure:nil];
                                
                                
                                // Dates
                                
                                
                                NSString *title = [myArray objectForKey:@"title"];
                                
                                NSString *date = [myArray objectForKey:@"start_date"];
                                //  NSString *enddate = [myArray objectForKey:@"updated_at"];
                                
                                NSLog(@"Date====%@",date);
                                
                                
                                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                                
                                NSString *currentDateString = date;
                                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
                                NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
                                NSLog(@"CurrentDate:%@", currentDate);
                                NSDateFormatter *currentDTFormatter = [[NSDateFormatter alloc] init];
                                [currentDTFormatter setDateFormat:@"dd"];
                                
                                NSString *eventDateStr = [currentDTFormatter stringFromDate:currentDate];
                                NSLog(@"Date===%@", eventDateStr);
                                [currentDTFormatter setDateFormat:@"MMM"];
                                NSString *eventDateStr1 = [currentDTFormatter stringFromDate:currentDate];
                                NSLog(@"month===%@", eventDateStr1);
                                
                                //   NSString *time = [myArray objectForKey:@"updated_at"];
                                
                                NSString *ageGroup = [myArray objectForKey:@"age_group"];
                                
                                NSLog(@"myAge ===%@",ageGroup);
                                
                                NSString *notAva = [myArray objectForKey:@"cost"];
                                NSString *PriceOfEvent = [myArray objectForKey:@"cost"];
                                if ([notAva isEqualToString:@"Not Available"]) {
                                    
                                    PriceOfEvent = @"0";
                                    
                                }else {
                                    
                                    PriceOfEvent = [myArray objectForKey:@"cost"];
                                    
                                }
                                
                                _bodderAgeGroups.layer.cornerRadius = 8;
                                _bodderAgeGroups.layer.borderWidth = 1;
                                _bodderAgeGroups.layer.borderColor = [UIColor blackColor].CGColor;
                                
                                _bodderLeabelFordate.layer.cornerRadius = 8;
                                _bodderLeabelFordate.layer.borderWidth = 1;
                                _bodderLeabelFordate.layer.borderColor = [UIColor blackColor].CGColor;
                                
                                _bodderOnWords.layer.cornerRadius = 8;
                                _bodderOnWords.layer.borderWidth = 1;
                                _bodderOnWords.layer.borderColor = [UIColor blackColor].CGColor;
                                
                                _bodderPriceLabel.layer.cornerRadius = 8;
                                _bodderPriceLabel.layer.borderWidth = 1;
                                _bodderPriceLabel.layer.borderColor = [UIColor blackColor].CGColor;
                                
                                
                                
                                _titleTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
                                _titleTextLabel.numberOfLines = 0;
                                _titleTextLabel.text = title;
                                
                                
                                _dateLeabel.text = eventDateStr;
                                _monthInWOrdsLeabel.text = eventDateStr1;
                                // cell2.timeLeabel.text = time;
                                
                                _ageGroups.text = ageGroup;
                                _priceOfEventLeabel.text = [NSString stringWithFormat:@"Rs. %@",PriceOfEvent];
                                _ageLeablelNew.text = ageGroup;
                                
                                
                                
                                // Dates cell
                                
                                NSString *dateStart = [myArray objectForKey:@"start_date"];
                                NSString *dateOfend = [myArray objectForKey:@"end_date"];
                                
                                // NSString *timeOfevents = [myArray objectForKey:@"cost"];
                                
                                NSLog(@"dateStart====%@",dateStart);
                                NSLog(@"dateEnd====%@",dateOfend);
                                
                                NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc]init];
                                
                                NSString *currentDateString1 = dateStart;
                                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
                                NSDate *currentDate1 = [dateFormatter dateFromString:currentDateString1];
                                NSLog(@"CurrentDate:%@", currentDate1);
                                NSDateFormatter *currentDTFormatter2 = [[NSDateFormatter alloc] init];
                                [currentDTFormatter2 setDateFormat:@"dd"];
                                NSString *eventDateStr2 = [currentDTFormatter2 stringFromDate:currentDate];
                                NSLog(@"Date===%@", eventDateStr2);
                                
                                dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                                NSDate *yourDate2 = [dateFormatter dateFromString:currentDateString];
                                dateFormatter.dateFormat = @"HH:mm";
                                NSLog(@"ooooooo     ====%@",[dateFormatter stringFromDate:yourDate2]);
                                NSString *startingTime = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:yourDate2]];
                                
                                NSString *myString1 = dateOfend;
                                
                                NSLog(@"value ==== %@",myString1);
                                
                                
                                NSDateFormatter* dateFormatter2 = [[NSDateFormatter alloc] init];
                                dateFormatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                                NSDate *yourDate = [dateFormatter2 dateFromString:myString1];
                                dateFormatter2.dateFormat = @"dd-MMM-yyyy";
                                
                                NSString *endibgDate = [dateFormatter2 stringFromDate:yourDate];
                                NSLog(@"%@",[dateFormatter2 stringFromDate:yourDate]);
                                
                                dateFormatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                                NSDate *yourDate1 = [dateFormatter1 dateFromString:myString1];
                                dateFormatter.dateFormat = @"HH:mm";
                                
                                NSLog(@"hdshjshdj     ====%@",[dateFormatter stringFromDate:yourDate1]);
                                
                                NSString *endingTime = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:yourDate1]];
                                
                                
                                
                                
                                NSLog(@"gjshgdjg ==    %@-%@",eventDateStr,endibgDate);
                                
                                
                                NSString *finalDate = [NSString stringWithFormat:@"%@ - %@",eventDateStr,endibgDate];
                                
                                _dateOfEvents.text = finalDate;
                                
                                _timeOfEvents.text = [NSString stringWithFormat:@"%@ - %@",startingTime,endingTime];
                                
                                
                                _timeLeabel.text = [NSString stringWithFormat:@"%@",startingTime];
                                NSString *Price = [myArray objectForKey:@"cost"];
                                _priceOfEventsWIthDate.text = [NSString stringWithFormat:@"Rs.%@",Price];
                                
                                
                                NSLog(@"%@",Price);
                                
                                
                                // Phone NO clicked
                                
                                UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnLink:)];
                                // if labelView is not set userInteractionEnabled, you must do so
                                [_phoneNotextField setUserInteractionEnabled:YES];
                                [_phoneNotextField addGestureRecognizer:gesture];
                                
                                _phoneNotextField.text = [myArray objectForKey:@"contact2"];
                                
                                _phoneNotextField.textColor = [UIColor blueColor];
                                
                                if ([[myArray objectForKey:@"contact2"] isEqualToString:@""]) {
                                    
                                    _phoneNotextField.text = @"Not Mentioned.";
                                    
                                }
                                
                                // About
                                
                                
                                NSString *abouttext = [myArray objectForKey:@"article_content"];
                                
                                NSString *htmlString = abouttext;
                                
                                NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                                _textView.attributedText = attributedString;
                                
                                
                                if (IS_IPAD)
                                {
                                    _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
                                    _textView.textContainerInset = UIEdgeInsetsMake(0, 40, 0, 40);
                                    
                                } else {
                                    
                                    _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
                                    _textView.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
                                    
                                    
                                }
                                
                                
                                
                                _textView.editable = NO;
                                
                                
                                
                                //MapView
                                
                                venuDetails = [myArray objectForKey:@"venue"];
                                
                                _venuOrLocation.text = venuDetails;
                                
                                
                                Latitude = [myArray objectForKey:@"latitude"];
                                NSLog(@"distination latitude  %@",Latitude);
                                
                                Longitude = [myArray objectForKey:@"longitude"];
                                NSLog(@"distination longitude  %@",Longitude);
                                
                                
                                locationManager = [[CLLocationManager alloc] init];
                                locationManager.delegate = self;
                                locationManager.distanceFilter = kCLDistanceFilterNone;
                                locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                                
                                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
                                    [self->locationManager requestWhenInUseAuthorization];
                                
                                [locationManager startUpdatingLocation];
                                
                                
                                
                                
                                // [self bookMatkstates];
                                
                                NSString * myBookMark = [myArray objectForKey:@"bookmarked"];
                                
                                NSLog(@"bookmark %@",myBookMark);
                                
                                int valuebook = [myBookMark intValue];
                                
                                if (valuebook == 0) {
                                    
                                    [homeBtn setSelected:NO];
                                    
                                }else {
                                    
                                    [homeBtn setSelected:YES];
                                    
                                }
                                
                                NSString *myLiked = [myArray objectForKey:@"liked"];
                                
                                NSLog(@"bookmark %@",myLiked);
                                
                                int valueLiked = [myLiked intValue];
                                
                                if (valueLiked == 0) {
                                    
                                    [settingsBtn setSelected:NO];
                                    
                                    
                                }else {
                                    
                                    [settingsBtn setSelected:YES];
                                    
                                }
                                shareUrl = [myArray objectForKey:@"share_link"];
                                NSLog(@"ShareLink === %@",shareUrl);
                                
                                [activityIndicatorView stopAnimating];
                                
                                
                            });
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error: %@", error);
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:ok];
             [self presentViewController:alertController animated:YES completion:nil];
             
             [activityIndicatorView stopAnimating];
         }];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // Do Stuff!
    if(item.tag == 0) {
        
        
        
        
        // Facebook
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            // [tweet setInitialText:@"Please look into this article!"];
            //[tweet addImage:postImage.image];
            [tweet addURL: [NSURL URLWithString:shareUrl]];
            [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 if (result == SLComposeViewControllerResultCancelled)
                 {
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                                     message:@"The user cancelled."
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     
                     [alert show];
                     NSLog(@"The user cancelled.");
                 }
                 else if (result == SLComposeViewControllerResultDone)
                 {
                     
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                                     message:@"The user sent the post."
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     
                     [alert show];
                     NSLog(@"The user sent the post.");
                 }
             }];
            [self presentViewController:tweet animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                            message:@"Facebook integration is not available.  Make sure you have setup your Facebook account on your device."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
        
        NSLog(@"working facebook");
        
    }else if (item.tag == 1){
        
        NSLog(@"working twitter");
        
        // Twitter
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            // [tweet setInitialText:@"Please look into this article!"];
            [tweet addURL: [NSURL URLWithString:shareUrl]];
            [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 if (result == SLComposeViewControllerResultCancelled)
                 {
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                                     message:@"The user cancelled."
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     
                     [alert show];
                     NSLog(@"The user cancelled.");
                 }
                 else if (result == SLComposeViewControllerResultDone)
                 {
                     
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                                     message:@"The user sent the tweet."
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     NSLog(@"The user sent the tweet");
                 }
             }];
            [self presentViewController:tweet animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                            message:@"Twitter integration is not available.  A Twitter account must be set up on your device."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
        }
        
        
    }else if (item.tag == 2){
        
        NSString * msg = [NSString stringWithFormat:@"%@",shareUrl];
        NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
        NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
            [[UIApplication sharedApplication] openURL: whatsappURL];
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        NSLog(@"working whatesup");
        
    }
    
    
}

- (void)BookMarkWithId:(id)sender{
    
    
    
    
    // Sending to webservices for bookmarking
    
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params =@{@"user_id" : UserId ,
                            
                            @"token" : userToken,
                            
                            @"article_id" : _articalID
                            
                            };
    [manager POST:@"http://zenparent.in/api/bookmark"parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        
        
        if ([sender isSelected]) {
            [sender setImage:[UIImage imageNamed:@"bookmark@2x.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
        } else {
            [sender setImage:[UIImage imageNamed:@"bookmark_selected@2x.png"] forState:UIControlStateSelected];
            [sender setSelected:YES];
        }
        
        
        
        if ([sender isSelected]) {
            
            NSString *alertMessage = @"Article Bookmarked";
            
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
            
        }else{
            
            
            
            NSString *alertMessage = @"Article Diselected";
            
            
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
}


-(void)LikedWithId:(id)sender{
    
    // Sending to webservices for bookmarking
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
    NSLog(@"Articalid.  %@",_articalID);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params =@{@"user_id" : UserId,
                            
                            @"token" : userToken ,
                            
                            @"article_id" : _articalID
                            
                            };
    [manager POST:@"http://zenparent.in/api/like" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if ([sender isSelected]) {
            [sender setImage:[UIImage imageNamed:@"like@2x.png"] forState:UIControlStateNormal];
            [sender setSelected:NO];
        } else {
            [sender setImage:[UIImage imageNamed:@"like_selected@2x.png"] forState:UIControlStateSelected];
            [sender setSelected:YES];
        }
        
        if ([sender isSelected]) {
            
            NSString *alertMessage = @"Article Liked";
            
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
            
        }else{
            
            
            NSString *alertMessage = @"Article Diselected";
            
            
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
}
-(void)setTabBarItemImages

{
    
    UIImage *unselectedImage = [UIImage imageNamed:@"fb_icon"];
    
    UIImage *selectedImage = [UIImage imageNamed:@"fb_icon"];
    
    
    
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    [[self.myTabBar.items objectAtIndex:0] setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
    
    [[self.myTabBar.items objectAtIndex:0] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    
    
    
    unselectedImage = [UIImage imageNamed:@"twitter_icon"];
    
    selectedImage = [UIImage imageNamed:@"twitter_icon"];
    
    
    
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    [[self.myTabBar.items objectAtIndex:1] setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
    
    [[self.myTabBar.items objectAtIndex:1] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    
    
    
    unselectedImage = [UIImage imageNamed:@"whatsapp_icon"];
    
    selectedImage = [UIImage imageNamed:@"whatsapp_icon"];
    
    
    
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    [[self.myTabBar.items objectAtIndex:2] setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
    
    [[self.myTabBar.items objectAtIndex:2] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    
    
    longitudeLabel = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    latitudeLabel = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    
    
}

- (IBAction)getDirections:(id)sender {
    
    
    NSString *googleMapUrlString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%@,%@&daddr=%@,%@", latitudeLabel, longitudeLabel, Latitude, Longitude];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapUrlString]];
    
}

- (void)userTappedOnLink:(UIGestureRecognizer*)gestureRecognizer{
    
    NSLog(@"PhoneNO text ====%@",_phoneNotextField.text);
    
    NSString *cleanedString = [[_phoneNotextField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSString *escapedPhoneNumber = [cleanedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *phoneURLString = [NSString stringWithFormat:@"telprompt:%@", escapedPhoneNumber];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
        [[UIApplication sharedApplication] openURL:phoneURL];
    }else {
        
        if ([UIAlertController class])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Phone Call" message:@"Call facility is not available!!!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Phone Call" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
        
        
    }
    
}



@end
