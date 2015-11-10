//
//  YourEventsView.m
//  ZenParent
//
//  Created by Soumya Ranjan on 01/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "YourEventsView.h"
#import "YourEventCellCollectionViewCell.h"
#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "SampleDetail.h"
#import "YourEventCellCollectionViewCell.h"
#import "ViewController.h"

#import <Social/Social.h>
#import "DetailEventNew.h"
#import "TostView.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPHONE_6 [[UIScreen mainScreen]nativeBounds].size.width == 750.0 ? true : false

#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)


@interface YourEventsView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate>

{

    NSString *type;
    NSMutableArray *myArray;
    NSMutableArray *onlyEvents;
    NSString *articalid;
    NSString *urlShare;
    CDActivityIndicatorView * activityIndicatorView ;
    UIView *overlayView;
    NSMutableArray *unSelectBook;
    NSMutableArray *unSelectedLike;
}

@end

@implementation YourEventsView

@synthesize cpllection , myArray ;


- (void)viewDidLoad {
    
        [super viewDidLoad];
    
   self.screenName = @"Events Screen";
    // Do any additional setup after loading the view.
    
    arSelectedRows = [[NSMutableArray alloc] init];
    arSelectedLike = [[NSMutableArray alloc]init];
    
    unSelectBook = [[NSMutableArray alloc]init];
    unSelectedLike = [[NSMutableArray alloc]init];
    

    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
   

    activityIndicatorView.center = self.view.center;
 
    [self.view addSubview:activityIndicatorView];
   
    [activityIndicatorView startAnimating];
   
    
    [self retriveDataFromServer];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)getSelections {
    
    NSMutableArray *selections = [[NSMutableArray alloc] init];
    
    for(NSIndexPath *indexPath in arSelectedRows) {
        
        [selections addObject:[myArray objectAtIndex:indexPath.row]];
        
    }
    
    return selections;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
        
        
        [self.navigationController.navigationBar.topItem setTitle:@"EVENTS"];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
    }else {
        
        [self.navigationController.navigationBar.topItem setTitle:@"घटना"];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return myArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"events";
    
    YourEventCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    cell.layer.cornerRadius = 10;
    
    cell.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.layer.cornerRadius] CGPath];
    
    // events cell
    NSDictionary *mydicvalue = [[NSDictionary alloc]init];
    mydicvalue = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];
    
    
    
    cell.tatielLeabel.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    
    
    NSString *date = [mydicvalue objectForKey:@"start_date"];
    NSLog(@"Date====%@",date);
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    NSString *currentDateString = date;
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
    NSLog(@"CurrentDate:%@", currentDate);
    NSDateFormatter *currentDTFormatter = [[NSDateFormatter alloc] init];
    [currentDTFormatter setDateFormat:@"dd"];
    
    NSString *eventDateStr = [currentDTFormatter stringFromDate:currentDate];
    NSLog(@"Date===%@", eventDateStr);
    [currentDTFormatter setDateFormat:@"MMM"];
    NSString *eventDateStr1 = [currentDTFormatter stringFromDate:currentDate];
    NSLog(@"month===%@", eventDateStr1);
    
    cell.dateLeabel.text = eventDateStr;
    cell.monthLeabel.text = eventDateStr1;
    cell.pleaceLeabel.text = [mydicvalue objectForKey:@"venue"];
    
    cell.pleaceLeabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.pleaceLeabel.numberOfLines = 0;
    
    if (IS_IPAD)
    {
        cell.pleaceLeabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        
    }else{
        
        cell.pleaceLeabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
        
    }
    
    
    
    // button action
    
    
    
    
    articalid = [mydicvalue objectForKey:@"article_id"];
    
    NSLog(@"Articalid ===  %@",articalid);
    
    NSInteger bookTag = [articalid integerValue];
    
    [cell.boockmarkButton setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
    
    [cell.boockmarkButton setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
    
    [cell.likeButton setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
    
    [cell.likeButton setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
    
    NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
    
    NSLog(@"bookmark %@",myBookMark);
    
    int valuebook = [myBookMark intValue];
    
    if (valuebook == 0) {
        
        BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
        
        if(isTheObjectThere) {
            
            [cell.boockmarkButton setSelected:YES];
            
        }else {
            
            [cell.boockmarkButton setSelected:NO];
            
        }
        
        
    }else {
        
        
        
        [cell.boockmarkButton setSelected:YES];

        
    }
    
    BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
    
    if(isTheObjectThereInUnSelected) {
        
        [cell.boockmarkButton setSelected:NO];
        
    }
    
    NSInteger likeTag = [articalid integerValue];
    
    NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
    
    NSLog(@"LikedPressed %@",mylikeTab);
    
    int valueLike = [mylikeTab intValue];
    
    if (valueLike == 0) {
        
        BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
        
        if(isTheObjectThere) {
            
            [cell.likeButton setSelected:YES];
            
        }else {
            
            [cell.likeButton setSelected:NO];
            
        }
        
    }else {
        
        [cell.likeButton  setSelected:YES];
        
    }
    
    
    
    BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
    
    if(isTheObjectThereInUnSelectedLike) {
        
        [cell.likeButton setSelected:NO];
        
    }
    

    
    
    [cell.boockmarkButton addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell.boockmarkButton.tag = bookTag;
    
    NSLog(@"value === %ld",(long)bookTag);
    
    cell.shareButton.tag = indexPath.row;
    
    [cell.shareButton addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.likeButton addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.likeButton.tag = likeTag;
    return cell;
    //return mycell;
    
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize  = CGSizeMake(300, 198);
    CGSize mElementSize1 = CGSizeMake(350, 198);
    CGSize mElementSize2 = CGSizeMake(380, 198);
    CGSize mElementSize3 = CGSizeMake(700, 240);
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //its iPhone. Find out which one?
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            return mElementSize;
        }
        else if(result.height == 568)
        {
            return mElementSize;
        }
        else if(result.height == 667)
        {
            return mElementSize1;
        }
        else if(result.height == 736)
        {
            return mElementSize2;
        }
    }
    if (IS_IPAD)
    {
        return mElementSize3;
        
    }

    
    
    return mElementSize;
    
}
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"working");
    
      NSString *ScreenNama = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    
 
    
    
    if (IS_IPAD)
    {
        DetailEventNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                              instantiateViewControllerWithIdentifier:@"DetailEventnw"];
        
        NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
        NSLog(@"ArticalId========%@",foodId);
        
        //wc.IdValue = foodId;
        
        wc.articalID = foodId;
        wc.screenValue = ScreenNama;
        
        [self.navigationController pushViewController:wc animated:YES];
        
        
    }else {

    
    DetailEventNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                          instantiateViewControllerWithIdentifier:@"DetailEventnw"];
    
    NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
    NSLog(@"ArticalId========%@",foodId);
    
    //wc.IdValue = foodId;
    
    wc.articalID = foodId;
    wc.screenValue = ScreenNama;
    
    [self.navigationController pushViewController:wc animated:YES];
        
    }
    
    
    //    SampleDetail *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
    //                                        instantiateViewControllerWithIdentifier:@"Sample"];
    //
    //    NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
    //       NSLog(@"ArticalId========%@",foodId);
    //
    //        wc.articalID = foodId;
    //
    //    [self.navigationController pushViewController:wc animated:YES];
    
}



-(void)retriveDataFromServer
{
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
      NSString *langeVarble = [[NSUserDefaults standardUserDefaults]stringForKey:@"LanguageDefalt"];
    
    
    NSDictionary *parameters = @{
                                 @"user_id" : UserId,
                                 @"token" : userToken ,
                                 @"type" : @"events",
                                 
                                 @"language_preference" : langeVarble

                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://zenparent.in/api/articles"
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
             NSLog(@"arrayCount======%lu",(unsigned long)myArray.count);
             
             
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                [self.cpllection reloadData];
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

// GETING more articals

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        
        
           [activityIndicatorView startAnimating];
        [TostView showToastInParentView:self.view withText:@"Loading..." withDuaration:2.0];
        // we are at the end
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
   
        
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
        [myArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                
                                stringForKey:@"PartiallyRegistered"];
        
        NSLog(@"savedValue == %@",savedValue);
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"PARlogged_in"]) {
            
            savedValue = @"0";
            
        }
        
        
        
        if ([savedValue isEqualToString:@"1"])
            
        {
            
            
            if (myArray.count >= 10) {
                
                
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sign In" message:@"Please sign in first" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
                
                UIAlertAction *settings = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    ViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                          instantiateViewControllerWithIdentifier:@"ViewContr"];
                    
                    [self.navigationController pushViewController:wc animated:YES];
                    
                    
                    
                }];
                [alertController addAction:settings];
                [alertController addAction:cancel];
                
                [activityIndicatorView stopAnimating];
                
                [self presentViewController:alertController animated:YES completion:nil];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                
            } else {
                
        
        NSString *userToken = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"REG_TOKEN"];
        
        NSString *UserId = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"REG_userId"];
                
           NSString *langeVarble = [[NSUserDefaults standardUserDefaults]stringForKey:@"LanguageDefalt"];
        
        NSDictionary *parameters = @{@"user_id" : UserId,
                                     
                                     @"token" : userToken ,
                                     
                                     @"pagination_type" : @"down" ,
                                     
                                     @"article_id" : [[myArray objectAtIndex: [myArray count]-1]objectForKey:@"id"] ,
                                     
                                     @"type" : @"events",
                                     
                                     @"language_preference" : langeVarble
                                     
                                     };
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://zenparent.in/api/articles"
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 // NSLog(@"JSON: %@", responseObject);
                 
                 NSMutableArray *newArray = [[NSMutableArray alloc]init];
                 
                 newArray = [responseObject objectForKey:@"result"];
                 
                 NSLog(@"newArray====%@",newArray);
                 
                 NSLog(@"oldArray======%@",myArray);
                 
                 self.myArray = [[myArray arrayByAddingObjectsFromArray:newArray] mutableCopy];
                 
                 NSLog(@"ADDArray ====%@",myArray);
                 
                 dispatch_async(dispatch_get_main_queue(), ^
                                {
                                    [self.cpllection reloadData];
                                    if (newArray.count == 0) {
                                        
                                        [TostView showToastInParentView:self.view withText:@"END OF ARTICLES" withDuaration:2.0];
                                    }
                                    [activityIndicatorView stopAnimating];
                                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                    
                                });
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 NSLog(@"Error: %@", error);
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                 [alertController addAction:ok];
                 [self presentViewController:alertController animated:YES completion:nil];
                     [activityIndicatorView stopAnimating];
                     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                 
             }];
            }

        
        }else  {
        
        
            NSString *userToken = [[NSUserDefaults standardUserDefaults]
                                   stringForKey:@"REG_TOKEN"];
            
            NSString *UserId = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"REG_userId"];
            
            
            NSDictionary *parameters = @{@"user_id" : UserId,
                                         
                                         @"token" : userToken ,
                                         
                                         @"pagination_type" : @"down" ,
                                         
                                         @"article_id" : [[myArray objectAtIndex: [myArray count]-1]objectForKey:@"id"] ,
                                         
                                         @"type" : @"events"
                                         
                                         };
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:@"http://zenparent.in/api/articles"
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     // NSLog(@"JSON: %@", responseObject);
                     
                     NSMutableArray *newArray = [[NSMutableArray alloc]init];
                     
                     newArray = [responseObject objectForKey:@"result"];
                     
                     NSLog(@"newArray====%@",newArray);
                     
                     NSLog(@"oldArray======%@",myArray);
                     
                     self.myArray = [[myArray arrayByAddingObjectsFromArray:newArray] mutableCopy];
                     
                     NSLog(@"ADDArray ====%@",myArray);
                     
                     dispatch_async(dispatch_get_main_queue(), ^
                                    {
                                        [self.cpllection reloadData];
                                        if (newArray.count == 0) {
                                            
                                            [TostView showToastInParentView:self.view withText:@"END OF ARTICLES" withDuaration:2.0];
                                        }
                                        [activityIndicatorView stopAnimating];
                                        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                        
                                    });
                     
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     
                     NSLog(@"Error: %@", error);
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                     [alertController addAction:ok];
                     [self presentViewController:alertController animated:YES completion:nil];
                     [activityIndicatorView stopAnimating];
                     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                     
                 }];

        
        }
        
        }
    
}




-(void)LikeClick:(UIButton *)sender{
    
    
    
    // Chicking the user is login or partial user
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            
                            stringForKey:@"PartiallyRegistered"];
    
    NSLog(@"savedValue == %@",savedValue);
    
    if ([savedValue isEqualToString:@"1"])
        
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sign In" message:@"Please sign in for Like the Article" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
        
        UIAlertAction *settings = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            ViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                  instantiateViewControllerWithIdentifier:@"ViewContr"];
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
            
        }];
        [alertController addAction:settings];
        [alertController addAction:cancel];
        
        [activityIndicatorView stopAnimating];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    else {
        

    
    UIButton *senderButton = (UIButton *)sender;
    
    NSLog(@"current Row=%ld",(long)senderButton.tag);
    
 
    
    NSInteger i = [sender tag];
    
    NSString *bootagLikeServer = [NSString stringWithFormat:@"%ld", (long)i];
    
    NSLog(@"current Row  == %@",bootagLikeServer);

    // Sending to webservices for bookmarking
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        
                        stringForKey:@"REG_userId"];
    
    NSLog(@"ArticalId=====final     %@",bootagLikeServer);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params =@{@"user_id" : UserId ,
                            
                            @"token" : userToken ,
                            
                            @"article_id" : bootagLikeServer
                            
                            };
    
    [manager POST:@"http://zenparent.in/api/like" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        senderButton.selected = ![senderButton isSelected]; // Important line
        
        if (senderButton.selected)
            
        {
            
            NSLog(@"Selected");
            
            NSLog(@" button tag %li",(long)senderButton.tag);
            
            [sender setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
            
            NSString *alertMessage = @"Article Liked";
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
            
            [arSelectedLike addObject:bootagLikeServer];
            
            NSLog(@"arSelectedLike === %@",arSelectedLike);
            
        }
        
        else
            
        {
            
            NSLog(@"Un Selected");
            
            NSLog(@"%li",(long)senderButton.tag);
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:articalid];
            
            [sender setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
            
            NSString *alertMessage = @"Article Un Selected";
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
            
            [arSelectedLike removeObject:bootagLikeServer];
            
              [unSelectedLike addObject:bootagLikeServer];
            NSLog(@"arSelectedLike === %@",arSelectedLike);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
        
    }
    
}


-(void)bookCommentClick:(UIButton *)sender{
    
    
    
    // Chicking the user is login or partial user
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            
                            stringForKey:@"PartiallyRegistered"];
    
    NSLog(@"savedValue == %@",savedValue);
    
    if ([savedValue isEqualToString:@"1"])
        
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sign In" message:@"Please sign in for BookMark the Article" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
        
        UIAlertAction *settings = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            ViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                  instantiateViewControllerWithIdentifier:@"ViewContr"];
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
            
        }];
        [alertController addAction:settings];
        [alertController addAction:cancel];
        
        [activityIndicatorView stopAnimating];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    else {
        

    
    UIButton *senderButton = (UIButton *)sender;
    
    NSLog(@"current Row=%ld",(long)senderButton.tag);
    
    
    
    NSInteger i = [sender tag];
    
    NSString *bookTagValueSever = [NSString stringWithFormat:@"%ld", (long)i];
    
    NSLog(@"current Row  == %@",bookTagValueSever);
    
    
    
    // Sending to webservices for bookmarking
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        
                        stringForKey:@"REG_userId"];
    
    NSLog(@"ArticalId=====final     %@",bookTagValueSever);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params =@{@"user_id" : UserId ,
                            
                            @"token" : userToken ,
                            
                            @"article_id" : bookTagValueSever
                            
                            };
    
    [manager POST:@"http://zenparent.in/api/bookmark" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        senderButton.selected = ![senderButton isSelected]; // Important line
        
        if (senderButton.selected)
            
        {
            
            NSLog(@"Selected");
            
            NSLog(@" button tag %li",(long)senderButton.tag);
            
            [sender setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
            
            NSString *alertMessage = @"Article Bookmarked";
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
            
            [arSelectedRows addObject:bookTagValueSever];
            
            NSLog(@"arSelectedRows === %@",arSelectedRows);
            
        }
        
        else
            
        {
            
            NSLog(@"Un Selected");
            
            NSLog(@"%li",(long)senderButton.tag);
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:articalid];
            
            [sender setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
            
            NSString *alertMessage = @"Article Un Selected";
            
            [TostView showToastInParentView:self.view withText:alertMessage withDuaration:1.0];
            
            [arSelectedRows removeObject:bookTagValueSever];
            
            [unSelectBook addObject:bookTagValueSever];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    }
    
}

//Action

-(void)ShareWithId:(UIButton *)sender
{
    
    
     [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setTintColor:[UIColor colorWithRed:116.0f/255.0f  green:79.0f/255.0f blue:141.0f/255.0f alpha:1.0f]];
    
    
    
    NSInteger Id = [sender tag];
    
    urlShare  = [[myArray objectAtIndex:Id]objectForKey:@"share_link"];
    
    NSLog(@"shareUrl:%@",urlShare);
    
    UIActionSheet *sharingSheet = [[UIActionSheet alloc] initWithTitle:@"Share"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Share on Twitter", @"Share on Facebook",@"Share on whatesup", nil];
    [sharingSheet showInView:self.view];
    
    
    
}

#pragma mark UIActionSheet Delegate Methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // Twitter
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            // [tweet setInitialText:];
            [tweet addURL: [NSURL URLWithString:urlShare]];
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
        
    }
    else if (buttonIndex == 1)
    {
        // Facebook
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            // [tweet setInitialText:@"Please look into this article!"];
            //[tweet addImage:postImage.image];
            [tweet addURL: [NSURL URLWithString:urlShare]];
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
    }
    else if (buttonIndex == 2) {
        
        
        //WhatesUP Sharing
        
        NSString * msg = [NSString stringWithFormat:@"%@",urlShare];
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





@end







