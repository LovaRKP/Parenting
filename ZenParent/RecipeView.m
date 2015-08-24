//
//  RecipeView.m
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "RecipeView.h"
#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "RecipeCell.h"

#import <Social/Social.h>

#import "DetailRecipeNew.h"
#import "TostView.h"
#import "ViewController.h"



#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface RecipeView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate ,UIDocumentInteractionControllerDelegate>

{
    
    NSString *type;
    NSMutableArray *myArray;
    NSMutableArray *onlyEvents;
    NSString *articalid;
    NSString *urlShare;
    CDActivityIndicatorView * activityIndicatorView ;
    NSMutableArray *unSelectBook;
    NSMutableArray *unSelectedLike;
   
}

@end

@implementation RecipeView
@synthesize myCollection ,myArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.screenName = @"Recipes Screen";
   
    arSelectedRows = [[NSMutableArray alloc] init];
    arSelectedLike = [[NSMutableArray alloc]init];
    
    
    unSelectBook = [[NSMutableArray alloc]init];
    unSelectedLike = [[NSMutableArray alloc]init];
    
    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
    
    activityIndicatorView.center = self.view.center;
    
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
  
    
    
    [self retriveDataFromServer];
  
    
    // Do any additional setup after loading the view.
    
    
    
}

-(NSArray *)getSelections {
    
    NSMutableArray *selections = [[NSMutableArray alloc] init];
    
    for(NSIndexPath *indexPath in arSelectedRows) {
        
        [selections addObject:[myArray objectAtIndex:indexPath.row]];
        
    }
    
    return selections;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
        
        
        [self.navigationController.navigationBar.topItem setTitle:@"RECIPES"];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
    }else {
        
        [self.navigationController.navigationBar.topItem setTitle:@"व्यंजनों"];
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
    
    static NSString *CellIdentifier = @"recipes";
    
    RecipeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 10;
    
    cell.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.layer.cornerRadius] CGPath];
    
   
    
    cell.recipeTitle.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    
   
    
   // cell.recipeTitle.text = @"rama krishna";
    NSDictionary *mydicvalue = [[NSDictionary alloc]init];
    mydicvalue = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];

    cell.coockingTime.text = [NSString stringWithFormat:@"%@ min",[mydicvalue objectForKey:@"cooking_time"]];
    cell.preptime.text = [NSString stringWithFormat:@"%@ min",[mydicvalue objectForKey:@"preparing_time"]];
    //cell.coockingTime.text = [mydicvalue objectForKey:@"preparing_time"];
    [cell.snackLabel setTitle:[mydicvalue objectForKey:@"type"]forState:UIControlStateNormal];
    [cell.snackLabel.titleLabel setFont:[UIFont systemFontOfSize:9]];
    
    
    
    NSString *vegstrang = [mydicvalue objectForKey:@"is_veg"];
    
    if ([vegstrang isEqualToString:@"0" ] ) {
        
        [cell.lastobjimage setImage:[UIImage imageNamed:@"nonvig.png"] forState:UIControlStateNormal];
      
        
    }else {
        
        [cell.lastobjimage setImage:[UIImage imageNamed:@"vig.png"] forState:UIControlStateNormal];
   
    }
    
    cell.snackLabel.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.snackLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [cell.snackLabel setTitle:[mydicvalue objectForKey:@"type"]forState:UIControlStateNormal];
    [cell.snackLabel.titleLabel setFont:[UIFont systemFontOfSize:9]];
    
    
    
    NSString *imageurl = [[myArray objectAtIndex:indexPath.row]objectForKey:@"image"];
    // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]
                             
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                             
                                         timeoutInterval:60];
    [cell.recipeImage setImageWithURLRequest:request
                            placeholderImage:nil
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                         
                                         
                                         cell.recipeImage.image = image;
                                         
                                         // mycell3.easyImage.contentMode = UIViewContentModeScaleAspectFit;
                                         // [mycell setNeedsLayout];
                                     } failure:nil];
    
    
    cell.bodderdPrepTime1.layer.borderColor = [UIColor grayColor].CGColor;
    cell.boderCoockTime1.layer.borderColor = [UIColor grayColor].CGColor;
    cell.snackLabel.layer.borderColor = [UIColor grayColor].CGColor;
    cell.vegOrNonVeg.layer.borderColor = [UIColor grayColor].CGColor;
    cell.bodderdPrepTime1.layer.borderWidth = 1.0;
    cell.boderCoockTime1.layer.borderWidth = 1.0;
    cell.snackLabel.layer.borderWidth = 1.0;
    cell.vegOrNonVeg.layer.borderWidth = 1.0;
    cell.bodderdPrepTime1.layer.cornerRadius = 5;
    cell.boderCoockTime1.layer.cornerRadius = 5;
    cell.snackLabel.layer.cornerRadius = 5;
    cell.vegOrNonVeg.layer.cornerRadius = 5;
    
    articalid = [mydicvalue objectForKey:@"article_id"];
    
    NSLog(@"Articalid ===  %@",articalid);
    
    NSInteger bookTag = [articalid integerValue];
    
    [cell.boockMarkedPressed setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
    
    [cell.boockMarkedPressed setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
    
    [cell.likeButtonPressed setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
    
    [cell.likeButtonPressed setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
    
    NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
    
    NSLog(@"bookmark %@",myBookMark);
    
    int valuebook = [myBookMark intValue];
    
    if (valuebook == 0) {
        
        BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
        
        if(isTheObjectThere) {
            
            [cell.boockMarkedPressed setSelected:YES];
            
        }else {
            
            [cell.boockMarkedPressed setSelected:NO];
            
        }
        
        
    }else {
        
        
        [cell.boockMarkedPressed setSelected:YES];
        

    }
    
    
    BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
    
    if(isTheObjectThereInUnSelected) {
        
        [cell.boockMarkedPressed setSelected:NO];
        
    }
    
  
    
    //Liked
    
    
    
    NSInteger likeTag = [articalid integerValue];
    
    NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
    
    NSLog(@"LikedPressed %@",mylikeTab);
    
    int valueLike = [mylikeTab intValue];

    if (valueLike == 0) {
        
        BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
        
        if(isTheObjectThere) {
            
            [cell.likeButtonPressed setSelected:YES];
            
        }else {
            
            [cell.likeButtonPressed setSelected:NO];
            
        }
        
    }else {
        
        [cell.likeButtonPressed  setSelected:YES];
        
        
        
    }
    
    
    BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
    
    if(isTheObjectThereInUnSelectedLike) {
        
        [cell.likeButtonPressed setSelected:NO];
        
    }
    
    
    [cell.boockMarkedPressed addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell.boockMarkedPressed.tag = bookTag;

    NSLog(@"value === %ld",(long)bookTag);

    cell.shareButtonPressed.tag = indexPath.row;

    [cell.shareButtonPressed addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];

    [cell.likeButtonPressed addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
    
     cell.likeButtonPressed.tag = likeTag;
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize  = CGSizeMake(300, 381);
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 568)
        {
            // iPhone Classic
            CGSize mElementSize  = CGSizeMake(300, 361);
            return mElementSize;
        }
        if(result.height == 667)
        {
            // iPhone 5
            CGSize mElementSize  = CGSizeMake(350, 381);
            return mElementSize;
            
        } else if(result.height == 736)
        {
            CGSize mElementSize  = CGSizeMake(380, 381);
            return mElementSize;
        }
    }
    
    if (IS_IPAD)
    {
        CGSize mElementSize  = CGSizeMake(700, 500);
        return mElementSize;
        
    }
    
    return mElementSize;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSLog(@"working");
       NSString *ScreenNama = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
  
    if (IS_IPAD)
    {
        DetailRecipeNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                               
                               instantiateViewControllerWithIdentifier:@"DetailRecipeNew"];
        
        NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        NSLog(@"ArticalId========%@",foodId);
        
        //wc.IdValue = foodId;
        
        wc.articalID = foodId;
          wc.screenValue = ScreenNama;
        
        [self.navigationController pushViewController:wc animated:YES];
        
    } else {

    
    DetailRecipeNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                             
                             instantiateViewControllerWithIdentifier:@"DetailRecipeNew"];
    
    NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
    
    NSLog(@"ArticalId========%@",foodId);
    
    //wc.IdValue = foodId;
    
    wc.articalID = foodId;
        wc.screenValue = ScreenNama;
    
    [self.navigationController pushViewController:wc animated:YES];
    }

}



-(void)retriveDataFromServer

{
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
      NSString *langeVarble = [[NSUserDefaults standardUserDefaults]stringForKey:@"LanguageDefalt"];
    
    NSDictionary *parameters = @{@"user_id" : UserId ,
                                 
                                 @"token" : userToken ,
                                 
                                 @"type" : @"recipes" ,
                                 
                                 @"language_preference" : langeVarble
                                 
                                 
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://zenparent.in/api/articles"
     
      parameters:parameters
     
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSLog(@"JSON: %@", responseObject);
             
             myArray = [responseObject objectForKey: @"result"];
             
             NSLog(@"arrayCount======%lu",(unsigned long)myArray.count);
             
             int i =0;
              NSMutableArray *required = [[NSMutableArray alloc]init];
             
             for (i = 0; i< myArray.count ; i++ ) {
                 
                 //              articalIDS = [[newArray objectAtIndex:i]objectForKey:@"id"];
                 //              bookMarkIDS = [[newArray objectAtIndex:i]objectForKey:@"bookmarked"];
                 //
                 //                 NSLog(@"value == %@", articalIDS);
                 //                 NSLog(@"key === %@", bookMarkIDS);
                 //                [required setObject:articalIDS forKey:bookMarkIDS];
                 
                 
                 NSDictionary *dict123 = @{@"articalIDS" :[[myArray objectAtIndex:i]objectForKey:@"id"],
                                           @"bookMarkIDS"   : [[myArray objectAtIndex:i]objectForKey:@"liked"]                                        };
                 
                 [required addObject: dict123];
                 
             }
              NSLog(@"requiredValues =====%@",required);
             
             dispatch_async(dispatch_get_main_queue(), ^
                            
                            {
                                
                                [self.myCollection reloadData];
                                
                                 [activityIndicatorView stopAnimating];
                                
                                
                                
                            });
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             
             
             NSLog(@"Error: %@", error);
             
               [activityIndicatorView stopAnimating];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:ok];
             [self presentViewController:alertController animated:YES completion:nil];
             
             
         }];
    
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
    
  //  NSIndexPath *path = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
    
   // NSLog(@"Path=====%@",path);
    
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
    
   // NSIndexPath *path = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
    
   // NSLog(@"Path=====%@",path);
    
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
           // [tweet setInitialText:@"Please look into this article!"];
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
            //[tweet setInitialText:@"Please look into this article!"];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
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

// GETING more articals



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    
    if (bottomEdge >= scrollView.contentSize.height) {
        
        // we are at the end
        
        [activityIndicatorView startAnimating];
        [TostView showToastInParentView:self.view withText:@"Loading..." withDuaration:2.0];
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
                                         
                                         @"type" : @"recipes",
                                         
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
                                        [self.myCollection reloadData];
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
                                     
                                     
                                     
                                     @"type" : @"recipes"
                                     
                                     
                                     
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
                 
                 
                 int i =0;
                 NSMutableArray *required = [[NSMutableArray alloc]init];
                 
                 for (i = 0; i< myArray.count ; i++ ) {
                     
                     //              articalIDS = [[newArray objectAtIndex:i]objectForKey:@"id"];
                     //              bookMarkIDS = [[newArray objectAtIndex:i]objectForKey:@"bookmarked"];
                     //
                     //                 NSLog(@"value == %@", articalIDS);
                     //                 NSLog(@"key === %@", bookMarkIDS);
                     //                [required setObject:articalIDS forKey:bookMarkIDS];
                     
                     
                     NSDictionary *dict123 = @{@"articalIDS" :[[myArray objectAtIndex:i]objectForKey:@"id"],
                                               @"bookMarkIDS"   : [[myArray objectAtIndex:i]objectForKey:@"liked"]                                        };
                     
                     [required addObject: dict123];
                     
                 }

                 NSLog(@"requiredValues =====%@",required);
                 
                 
                 dispatch_async(dispatch_get_main_queue(), ^
                                
                                {
                                    
                                    [self.myCollection reloadData];
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
    





@end
