//
//  DetailReviewNew.m
//  ZenParent
//
//  Created by Soumya Ranjan on 16/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "DetailReviewNew.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import "TostView.h"
#import "constants.h"
#import "GAITrackedViewController.h"
#import "ViewController.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface DetailReviewNew ()<UITabBarDelegate>

{
    
    NSMutableDictionary *myArray;
    NSString *shareUrl;
    CDActivityIndicatorView * activityIndicatorView ;
    UIButton *homeBtn ;
    UIButton *settingsBtn ;
    NSString *screenname;
    
}

@end

@implementation DetailReviewNew
@synthesize myTabBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screenName = _screenValue;
    
    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
    
    activityIndicatorView.center = self.view.center;
    
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
    
    
    [self setTabBarItemImages];
    
    //DeepLinking
    
    NSLog(@"areticalid =====%@",_articalID);
    
    if (_articalID == (id)[NSNull null] || _articalID.length == 0 ){
        
          myArray = _articalDeepArray;
        
        NSLog(@"DATAVALUE =====%@",myArray);
        
        [_imageView setImageWithURL:[NSURL URLWithString:[myArray objectForKey:@"image"]]];
        
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[myArray objectForKey:@"image"]]
                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                  timeoutInterval:60];
        
        
        
        [_imageView setImageWithURLRequest:imageRequest
                          placeholderImage:[UIImage imageNamed:@"placeholder"]
                                   success:nil
                                   failure:nil];
        
        
        _titelDetailReview.text = [myArray objectForKey:@"title"];
        _titelDetailReview.lineBreakMode = NSLineBreakByWordWrapping;
        _titelDetailReview.numberOfLines = 0;
        
        
        
        
        NSString *EmptyAge = [myArray objectForKey:@"age_group"];
        
        
        
        
        
        _ageBoderLeabel.layer.borderColor = [UIColor blackColor].CGColor;
        _ageBoderLeabel.layer.borderWidth = 1.0;
        _ageBoderLeabel.layer.cornerRadius = 3;
        _ageLabel.text = [myArray objectForKey:@"age_group"];
        
        _ratingBoder.layer.borderColor = [UIColor blackColor].CGColor;
        _ratingBoder.layer.borderWidth = 1.0;
        _ratingBoder.layer.cornerRadius = 3;
        _reatingLeabel.text = [NSString stringWithFormat:@"%@/5",[myArray objectForKey:@"rating"]];
        _reatingLeabel.textAlignment = NSTextAlignmentCenter;
        
        
        if ([EmptyAge isEqualToString:@""]) {
            
            _ageLabel.text = @"All";
            
        }else{
            
            _ageLabel.text = [myArray objectForKey:@"age_group"];
            
        }
        NSString * violence = [myArray objectForKey:@"violence"];
        NSString * Sex = [myArray objectForKey:@"sex_nudity"];
        NSString * profanity = [myArray objectForKey:@"profanity"];
        NSString * drink = [myArray objectForKey:@"drink"];
        
        
        
        //Images
        
        UIImage *zeroImg = [UIImage imageNamed:@"zero_rating.png"];
        UIImage *oneImg = [UIImage imageNamed:@"1.png"];
        UIImage *twoImg = [UIImage imageNamed:@"2.png"];
        UIImage *threeImg = [UIImage imageNamed:@"3.png"];
        UIImage *fourImg = [UIImage imageNamed:@"4.png"];
        UIImage *fiveImg = [UIImage imageNamed:@"5.png"];
        
        
        if ([violence isEqualToString:@"0"]) {
            _violenceImage.image = zeroImg;
            
        }else if ([violence isEqualToString:@"1"]){
            
            _violenceImage.image = oneImg;
            
        }else if ([violence isEqualToString:@"2"]){
            
            _violenceImage.image = twoImg;
            
        }else if ([violence isEqualToString:@"3"]){
            _violenceImage.image = threeImg;
            
            
        }else if ([violence isEqualToString:@"4"]){
            
            _violenceImage.image = fourImg;
            
        }else if ([violence isEqualToString:@"5"]){
            
            _violenceImage.image = fiveImg;
            
        }
        
        //sex
        
        if ([Sex isEqualToString:@"0"]) {
            _sexNudeImage.image = zeroImg;
            
        }else if ([Sex isEqualToString:@"1"]){
            
            _sexNudeImage.image = oneImg;
            
        }else if ([Sex isEqualToString:@"2"]){
            
            _sexNudeImage.image = twoImg;
            
        }else if ([Sex isEqualToString:@"3"]){
            _sexNudeImage.image = threeImg;
            
            
        }else if ([Sex isEqualToString:@"4"]){
            
            _sexNudeImage.image = fourImg;
            
        }else if ([Sex isEqualToString:@"5"]){
            
            _sexNudeImage.image = fiveImg;
            
        }
        
        //profanity
        
        if ([profanity isEqualToString:@"0"]) {
            _profanityImage.image = zeroImg;
            
        }else if ([profanity isEqualToString:@"1"]){
            
            _profanityImage.image = oneImg;
            
        }else if ([profanity isEqualToString:@"2"]){
            
            _profanityImage.image = twoImg;
            
        }else if ([profanity isEqualToString:@"3"]){
            _profanityImage.image = threeImg;
            
            
        }else if ([profanity isEqualToString:@"4"]){
            
            _profanityImage.image = fourImg;
            
        }else if ([profanity isEqualToString:@"5"]){
            
            _profanityImage.image = fiveImg;
            
        }
        
        //smoking
        
        if ([drink isEqualToString:@"0"]) {
            _dreankingSmoking.image = zeroImg;
            
        }else if ([drink isEqualToString:@"1"]){
            
            _dreankingSmoking.image = oneImg;
            
        }else if ([drink isEqualToString:@"2"]){
            
            _dreankingSmoking.image = twoImg;
            
        }else if ([drink isEqualToString:@"3"]){
            _dreankingSmoking.image = threeImg;
            
            
        }else if ([drink isEqualToString:@"4"]){
            
            _dreankingSmoking.image = fourImg;
            
        }else if ([drink isEqualToString:@"5"]){
            
            _dreankingSmoking.image = fiveImg;
            
        }
        NSString *htmlString = [myArray objectForKey:@"article_content"];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        _textView.editable = NO;
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        
        if (IS_IPAD)
        {
            _textView.attributedText = attributedString;
            _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
            _textView.textContainerInset = UIEdgeInsetsMake(0, 40, 0, 40);
            
        }else {
            
            
            _textView.attributedText = attributedString;
            _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
            _textView.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
            
        }
        _textView.editable = NO;
        
        
        // BOOKMarked
        
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
        
        
        
        // [self bookMatkstates];
        [activityIndicatorView stopAnimating];
        
    
    }else{
    
    
     [self retriveDataFromServer];
    
    }
    
   
    
    
  
    // Do any additional setup after loading the view.
    
    
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
    
  
    
    
    NSLog(@"Artical ID =====%@", _articalID);
    
}

-(void)viewWillLayoutSubviews {
    
    CGSize sizeThatFits = [self.textView sizeThatFits:CGSizeMake(self.view.frame.size.width, MAXFLOAT)];
    self.textViewHeightConstraint.constant = ceilf(sizeThatFits.height);
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Automatic Screen View Analytics
    // Manual Screen View Analytics
   
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    CGSize sizeThatFits = [self.textView sizeThatFits:CGSizeMake(self.view.frame.size.width, MAXFLOAT)];
    self.textViewHeightConstraint.constant = ceilf(sizeThatFits.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    // update to server like and book mark
    
    
    
    
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
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
    NSDictionary *parameters = @{
                                 @"user_id" :UserId ,
                                 
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
             
             if (value == 406){
                 
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
             NSLog(@"arrayCount======%lu",(unsigned long)myArray.count);
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                
                                
                                [_imageView setImageWithURL:[NSURL URLWithString:[myArray objectForKey:@"image"]]];
                                
                                NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[myArray objectForKey:@"image"]]
                                                                              cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                                          timeoutInterval:60];
                                
                                
                                
                                [_imageView setImageWithURLRequest:imageRequest
                                                  placeholderImage:[UIImage imageNamed:@"placeholder"]
                                                           success:nil
                                                           failure:nil];
                                
                                
                                _titelDetailReview.text = [myArray objectForKey:@"title"];
                                _titelDetailReview.lineBreakMode = NSLineBreakByWordWrapping;
                                _titelDetailReview.numberOfLines = 0;
                           
                              
                               
                              
                                NSString *EmptyAge = [myArray objectForKey:@"age_group"];
                                
                         
                                
                                
                                
                                _ageBoderLeabel.layer.borderColor = [UIColor blackColor].CGColor;
                                _ageBoderLeabel.layer.borderWidth = 1.0;
                                _ageBoderLeabel.layer.cornerRadius = 3;
                                _ageLabel.text = [myArray objectForKey:@"age_group"];
                                
                                _ratingBoder.layer.borderColor = [UIColor blackColor].CGColor;
                                _ratingBoder.layer.borderWidth = 1.0;
                                _ratingBoder.layer.cornerRadius = 3;
                                _reatingLeabel.text = [NSString stringWithFormat:@"%@/5",[myArray objectForKey:@"rating"]];
                                _reatingLeabel.textAlignment = NSTextAlignmentCenter;
                                
                                
                                if ([EmptyAge isEqualToString:@""]) {
                                    
                                    _ageLabel.text = @"All";
                                    
                                }else{
                                    
                                    _ageLabel.text = [myArray objectForKey:@"age_group"];
                                    
                                }
                                NSString * violence = [myArray objectForKey:@"violence"];
                                NSString * Sex = [myArray objectForKey:@"sex_nudity"];
                                NSString * profanity = [myArray objectForKey:@"profanity"];
                                NSString * drink = [myArray objectForKey:@"drink"];
                                
                                
                                
                                //Images
                                
                                UIImage *zeroImg = [UIImage imageNamed:@"zero_rating.png"];
                                UIImage *oneImg = [UIImage imageNamed:@"1.png"];
                                UIImage *twoImg = [UIImage imageNamed:@"2.png"];
                                UIImage *threeImg = [UIImage imageNamed:@"3.png"];
                                UIImage *fourImg = [UIImage imageNamed:@"4.png"];
                                UIImage *fiveImg = [UIImage imageNamed:@"5.png"];
                                
                                
                                if ([violence isEqualToString:@"0"]) {
                                    _violenceImage.image = zeroImg;
                                    
                                }else if ([violence isEqualToString:@"1"]){
                                    
                                    _violenceImage.image = oneImg;
                                    
                                }else if ([violence isEqualToString:@"2"]){
                                    
                                    _violenceImage.image = twoImg;
                                    
                                }else if ([violence isEqualToString:@"3"]){
                                    _violenceImage.image = threeImg;
                                    
                                    
                                }else if ([violence isEqualToString:@"4"]){
                                    
                                    _violenceImage.image = fourImg;
                                    
                                }else if ([violence isEqualToString:@"5"]){
                                    
                                    _violenceImage.image = fiveImg;
                                    
                                }
                                
                                //sex
                                
                                if ([Sex isEqualToString:@"0"]) {
                                    _sexNudeImage.image = zeroImg;
                                    
                                }else if ([Sex isEqualToString:@"1"]){
                                    
                                    _sexNudeImage.image = oneImg;
                                    
                                }else if ([Sex isEqualToString:@"2"]){
                                    
                                    _sexNudeImage.image = twoImg;
                                    
                                }else if ([Sex isEqualToString:@"3"]){
                                    _sexNudeImage.image = threeImg;
                                    
                                    
                                }else if ([Sex isEqualToString:@"4"]){
                                    
                                    _sexNudeImage.image = fourImg;
                                    
                                }else if ([Sex isEqualToString:@"5"]){
                                    
                                    _sexNudeImage.image = fiveImg;
                                    
                                }
                                
                                //profanity
                                
                                if ([profanity isEqualToString:@"0"]) {
                                    _profanityImage.image = zeroImg;
                                    
                                }else if ([profanity isEqualToString:@"1"]){
                                    
                                    _profanityImage.image = oneImg;
                                    
                                }else if ([profanity isEqualToString:@"2"]){
                                    
                                    _profanityImage.image = twoImg;
                                    
                                }else if ([profanity isEqualToString:@"3"]){
                                    _profanityImage.image = threeImg;
                                    
                                    
                                }else if ([profanity isEqualToString:@"4"]){
                                    
                                    _profanityImage.image = fourImg;
                                    
                                }else if ([profanity isEqualToString:@"5"]){
                                    
                                    _profanityImage.image = fiveImg;
                                    
                                }
                                
                                //smoking
                                
                                if ([drink isEqualToString:@"0"]) {
                                    _dreankingSmoking.image = zeroImg;
                                    
                                }else if ([drink isEqualToString:@"1"]){
                                    
                                    _dreankingSmoking.image = oneImg;
                                    
                                }else if ([drink isEqualToString:@"2"]){
                                    
                                    _dreankingSmoking.image = twoImg;
                                    
                                }else if ([drink isEqualToString:@"3"]){
                                    _dreankingSmoking.image = threeImg;
                                    
                                    
                                }else if ([drink isEqualToString:@"4"]){
                                    
                                    _dreankingSmoking.image = fourImg;
                                    
                                }else if ([drink isEqualToString:@"5"]){
                                    
                                    _dreankingSmoking.image = fiveImg;
                                    
                                }
                                NSString *htmlString = [myArray objectForKey:@"article_content"];
                                NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                                
                                _textView.editable = NO;
                                _textView.layoutManager.allowsNonContiguousLayout = NO;
                                
                                if (IS_IPAD)
                                {
                                    _textView.attributedText = attributedString;
                                    _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
                                    _textView.textContainerInset = UIEdgeInsetsMake(0, 40, 0, 40);
                                    
                                }else {
                                    
                                    
                                    _textView.attributedText = attributedString;
                                    _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
                                    _textView.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
                                    
                                }
                                _textView.editable = NO;
                                
                                
                                // BOOKMarked
                                
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
                                
                                
                                
                                // [self bookMatkstates];
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
    
    
    shareUrl = [myArray objectForKey:@"share_link"];
    
    NSLog(@"shareurl === %@", shareUrl);
    // Do Stuff!
    if(item.tag == 0) {
        
        
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"fb_icon.png"];
        
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
            //[tweet setInitialText:@"Please look into this article!"];
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
    
    
    // Sample
    
    [[self.myTabBar.items objectAtIndex:0] setImage:unselectedImage];
    
    [[self.myTabBar.items objectAtIndex:0] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    unselectedImage = [UIImage imageNamed:@"twitter_icon"];
    
    selectedImage = [UIImage imageNamed:@"twitter_icon"];
    
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[self.myTabBar.items objectAtIndex:1] setImage:unselectedImage];
    
    [[self.myTabBar.items objectAtIndex:1] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    unselectedImage = [UIImage imageNamed:@"whatsapp_icon"];
    
    selectedImage = [UIImage imageNamed:@"whatsapp_icon"];
    
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[self.myTabBar.items objectAtIndex:2] setImage:unselectedImage];
    
    [[self.myTabBar.items objectAtIndex:2] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];

    
}


@end
