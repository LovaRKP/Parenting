//
//  BookMarksView.m
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "BookMarksView.h"
#import "BookmarksCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "HomeRecipeViewCell.h"
#import "HomeReviewCell.h"
#import "HomeParientingViewCell.h"
#import "HomeEasyViewCell.h"
#import "HomeEventsViewCell.h"
#import "HomeDinnerViewCell.h"


#import <Social/Social.h>



//new
#import "DetailParentingViewNew.h"
#import "DetailRecipeNew.h"
#import "DetailReviewNew.h"
#import "DetailDinnerViewNew.h"
#import "DetailEventNew.h"
#import "DetailEasyTipsNew.h"
#import "TostView.h"
#import "ViewController.h"



#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface BookMarksView () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate>
{
    
    NSString *type;
    NSString *articalID;
    UIRefreshControl *refreshControl;
    NSString *articalid;
    NSString *urlShare;
    CDActivityIndicatorView * activityIndicatorView ;
    NSString *bookType;
    NSMutableArray *unSelectBook;
    NSMutableArray *unSelectedLike;
    
    
    
}

@end

@implementation BookMarksView
@synthesize myCollectionView;

@synthesize myArray;

static NSString *CellIdentifier = @"reviews";
static NSString *CellIdentifier1 = @"recipes";
static NSString *CellIdentifier2 = @"easy_tips";
static NSString *CellIdentifier3 = @"events";
static NSString *CellIdentifier4 = @"dinner_conversations";
static NSString *CellIdentifier5 = @"parenting";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.screenName = @"Bookmarks Screen";
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            
                            stringForKey:@"PartiallyRegistered"];
    
    NSLog(@"savedValue == %@",savedValue);
    
    if ([savedValue isEqualToString:@"1"])
        
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sign In" message:@"Please sign in for BOOKMARK the Article" preferredStyle:UIAlertControllerStyleAlert];
        
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
  
    
    
    arSelectedRows = [[NSMutableArray alloc] init];
    arSelectedLike = [[NSMutableArray alloc]init];
    
    unSelectBook = [[NSMutableArray alloc]init];
    unSelectedLike = [[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view.
    activityIndicatorView = [[CDActivityIndicatorView alloc] initWithImage:[UIImage imageNamed:@"indicater.png"]];
    
    activityIndicatorView.center = self.view.center;
    
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];

    myArray = [[NSMutableArray alloc]init];

    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(startRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.myCollectionView addSubview:refreshControl];
    self.myCollectionView.alwaysBounceVertical = YES;
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            
                            stringForKey:@"PartiallyRegistered"];
    
    NSLog(@"savedValue == %@",savedValue);
    
    if ([savedValue isEqualToString:@"1"])
        
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sign In" message:@"Please sign in for BOOKMARK the Article" preferredStyle:UIAlertControllerStyleAlert];
        
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
        NSLog(@"Sign In User...");
  
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
        [self FeatchData];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"LanguageSettings"]) {
        
        
        [self.navigationController.navigationBar.topItem setTitle:@"BOOKMARKS"];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
    }else {
        
        [self.navigationController.navigationBar.topItem setTitle:@"बुकमार्क्स"];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"myArray===%lu",(unsigned long)myArray.count);
    
    
    return myArray.count;
    
}

-(NSArray *)getSelections {
    
    NSMutableArray *selections = [[NSMutableArray alloc] init];
    
    for(NSIndexPath *indexPath in arSelectedRows) {
        
        [selections addObject:[myArray objectAtIndex:indexPath.row]];
        
    }
    
    return selections;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    type = [[myArray objectAtIndex:indexPath.row]objectForKey:@"type"];
    
    UICollectionViewCell *mycell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath ];
    mycell.layer.cornerRadius = 10;
    mycell.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:mycell.bounds cornerRadius:mycell.layer.cornerRadius] CGPath];
    
    if ([type isEqualToString: CellIdentifier]) {
        
        HomeReviewCell *mycell1 = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath ];
        
        mycell1.layer.cornerRadius = 10;
        mycell1.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:mycell.bounds cornerRadius:mycell1.layer.cornerRadius] CGPath];
        
        
        //NSLog(@"First type %@", type);
        
        
        
        // FillUp review cell Here
        
        mycell1.nameOfShow.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        
        
        NSString *htmlString = [[myArray objectAtIndex:indexPath.row]objectForKey:@"article_content"];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        
        mycell1.diciptionOfShow.lineBreakMode = NSLineBreakByWordWrapping;
        mycell1.diciptionOfShow.numberOfLines = 0;
        
        mycell1.diciptionOfShow.attributedText = attributedString;
        if (IS_IPAD)
        {
            mycell1.diciptionOfShow.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
            
        }else {
            
            mycell1.diciptionOfShow.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
        }
        
        mycell1.diciptionOfShow.textColor = [UIColor whiteColor];
        
        
        NSDictionary *mydicvalue = [[NSDictionary alloc]init];
        mydicvalue = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];
        
        NSString *imageurl = [[myArray objectAtIndex:indexPath.row]objectForKey:@"image"];
        // NSLog(@"urlLink =====%@",imageurl);
        mycell1.bodderRatting.backgroundColor = [UIColor colorWithRed:116.0f/255.0f
                                                                green:79.0f/255.0f
                                                                 blue:141.0f/255.0f
                                                                alpha:1.0f];
        
        mycell1.bodderAgelab.layer.borderColor = [UIColor whiteColor].CGColor;
        mycell1.bodderRatting.layer.borderColor = [UIColor whiteColor].CGColor;
        
        mycell1.bodderAgelab.layer.borderWidth = 1.0;
        mycell1.bodderRatting.layer.borderWidth = 1.0;
        mycell1.bodderAgelab.layer.cornerRadius = 8;
        mycell1.bodderRatting.layer.cornerRadius = 8;
        
        
        mycell1.ageLeabel.text = [mydicvalue objectForKey:@"age_group"];
        mycell1.ratingLabel.text = [mydicvalue objectForKey:@"rating"];
        
        
        //  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:60];
        [mycell1.imageOfRevews setImageWithURLRequest:request
                                     placeholderImage:nil
                                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                  
                                                  
                                                  mycell1.imageOfRevews.image = image;
                                                  [mycell setNeedsLayout];
                                              } failure:nil];
        
        
        NSString *reviewwType = [mydicvalue objectForKey:@"review_type"];
        
        
        NSLog(@"value of review==== %@",reviewwType);
        
        if ([reviewwType isEqualToString:@"book"]) {
            mycell1.titleForTv.text = @"Book Review";
            
        }else if ([reviewwType isEqualToString:@"movie"]){
            mycell1.titleForTv.text = @"Movie Review";
            
            
        }else if ([reviewwType isEqualToString:@"tv"]){
            
            mycell1.titleForTv.text = @"TV Review";
            
            
        }else{
            mycell1.titleForTv.text = @"Reviews";
            
        }
        
        
        NSString *emptyAge = [mydicvalue objectForKey:@"age_group"];
        
        if ([emptyAge isEqualToString:@""]) {
            
            mycell1.ageLeabel.text = @"All";
            
        }else{
            mycell1.ageLeabel.text = [mydicvalue objectForKey:@"age_group"];
            
        }
        
        
        if([reviewwType isEqualToString:@"book"]) {
            
            mycell1.bodderRatting.hidden = YES;
            mycell1.ratingLabel.hidden = YES;
            mycell1.reatingLeabelHifdden.hidden = YES;
            
            
        }else {
            
            mycell1.bodderRatting.hidden = NO;
            mycell1.ratingLabel.hidden = NO;
            mycell1.reatingLeabelHifdden.hidden = NO;
            
        }
        
        // BookMarkedButton
        articalid = [mydicvalue objectForKey:@"article_id"];
        
        NSLog(@"Articalid ===  %@",articalid);
        
        NSInteger bookTag = [articalid integerValue];
        
        [mycell1.bookMarkButton setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell1.bookMarkButton setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        [mycell1.likePressedButton setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell1.likePressedButton setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
        
        NSLog(@"bookmark %@",myBookMark);
        
        int valuebook = [myBookMark intValue];
        
        if (valuebook == 0) {
            
            BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell1.bookMarkButton setSelected:YES];
                
            }else {
                
                [mycell1.bookMarkButton setSelected:NO];
                
            }
            
            
        }else {
            
            [mycell1.bookMarkButton setSelected:YES];
            
        }
        
        BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
        
        if(isTheObjectThereInUnSelected) {
            
            [mycell1.bookMarkButton setSelected:NO];
            
        }
        
        //Liked
        
        NSInteger likeTag = [articalid integerValue];
        
        NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
        
        NSLog(@"LikedPressed %@",mylikeTab);
        
        int valueLike = [mylikeTab intValue];
        
        if (valueLike == 0) {
            
            BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell1.likePressedButton setSelected:YES];
                
            }else {
                
                [mycell1.likePressedButton setSelected:NO];
                
            }
            
        }else {
            
            [mycell1.likePressedButton  setSelected:YES];
            
        }
        
        
        BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
        
        if(isTheObjectThereInUnSelectedLike) {
            
            [mycell1.likePressedButton setSelected:NO];
            
        }
        
        
        [mycell1.bookMarkButton addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        mycell1.bookMarkButton.tag = bookTag;
        
        NSLog(@"value === %ld",(long)bookTag);
        
        mycell1.shareButton.tag = indexPath.row;
        
        [mycell1.shareButton addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];
        
        [mycell1.likePressedButton addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        mycell1.likePressedButton.tag = likeTag;
        return mycell1;
        
        
        
    }else if ([type isEqualToString: CellIdentifier1]){
        
        
        HomeRecipeViewCell *mycell2 =  [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier1 forIndexPath:indexPath ];
        
        //  NSLog(@"second type %@", type);
        
        mycell2.layer.cornerRadius = 10;
        mycell2.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:mycell2.bounds cornerRadius:mycell2.layer.cornerRadius] CGPath];
        
        //Resipe cell details
        
        mycell2.recipieTitle.text= [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        
        NSString *imageurl = [[myArray objectAtIndex:indexPath.row]objectForKey:@"image"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:60];
        [mycell2.recipeImage setImageWithURLRequest:request
                                   placeholderImage:nil
                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                
                                                
                                                mycell2.recipeImage.image = image;
                                                [mycell setNeedsLayout];
                                            } failure:nil];
        
        
        mycell2.bodderdPrepTime.layer.borderColor = [UIColor grayColor].CGColor;
        mycell2.boderCoockTime.layer.borderColor = [UIColor grayColor].CGColor;
        mycell2.snackButton.layer.borderColor = [UIColor grayColor].CGColor;
        mycell2.playButton.layer.borderColor = [UIColor grayColor].CGColor;
        mycell2.bodderdPrepTime.layer.borderWidth = 1.0;
        mycell2.boderCoockTime.layer.borderWidth = 1.0;
        mycell2.snackButton.layer.borderWidth = 1.0;
        mycell2.playButton.layer.borderWidth = 1.0;
        mycell2.bodderdPrepTime.layer.cornerRadius = 8;
        mycell2.boderCoockTime.layer.cornerRadius = 8;
        mycell2.snackButton.layer.cornerRadius = 8;
        mycell2.playButton.layer.cornerRadius = 8;
        
        NSDictionary *mydicvalue = [[NSDictionary alloc]init];
        mydicvalue = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];
        
        
        mycell2.coockTimeLabel.text = [NSString stringWithFormat:@"%@ min",[mydicvalue objectForKey:@"cooking_time"]];
        mycell2.prepTimeLabel.text = [NSString stringWithFormat:@"%@ min",[mydicvalue objectForKey:@"preparing_time"]];
        
        NSString *vegstrang = [mydicvalue objectForKey:@"is_veg"];
        
        if ([vegstrang isEqualToString:@"0" ]) {
            
            [mycell2.vegImageDot setImage:[UIImage imageNamed:@"nonvig.png"] forState:UIControlStateNormal];
            
        }else {
            
            [mycell2.vegImageDot setImage:[UIImage imageNamed:@"vig.png"] forState:UIControlStateNormal];
            
        }
        
        mycell2.snackButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        mycell2.snackButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [mycell2.snackButton setTitle:[mydicvalue objectForKey:@"type"]forState:UIControlStateNormal];
        [mycell2.snackButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
        
        // BookMarkedButton
        articalid = [mydicvalue objectForKey:@"article_id"];
        
        NSLog(@"Articalid ===  %@",articalid);
        
        NSInteger bookTag = [articalid integerValue];
        
        [mycell2.boockMarkedButton setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell2.boockMarkedButton setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        [mycell2.likeButton setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell2.likeButton setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
        
        NSLog(@"bookmark %@",myBookMark);
        
        int valuebook = [myBookMark intValue];
        
        if (valuebook == 0) {
            
            BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell2.boockMarkedButton setSelected:YES];
                
            }else {
                
                [mycell2.boockMarkedButton setSelected:NO];
                
            }
            
            
        }else {
            
            [mycell2.boockMarkedButton setSelected:YES];
            
        }
        
        
        BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
        
        if(isTheObjectThereInUnSelected) {
            
            [mycell2.boockMarkedButton setSelected:NO];
            
        }
        
        //Liked
        
        
        
        NSInteger likeTag = [articalid integerValue];
        
        NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
        
        NSLog(@"LikedPressed %@",mylikeTab);
        
        int valueLike = [mylikeTab intValue];
        
        if (valueLike == 0) {
            
            BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell2.likeButton setSelected:YES];
                
            }else {
                
                [mycell2.likeButton setSelected:NO];
                
            }
            
        }else {
            
            [mycell2.likeButton  setSelected:YES];
            
        }
        
        BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
        
        if(isTheObjectThereInUnSelectedLike) {
            
            [mycell2.likeButton setSelected:NO];
            
        }
        
        
        [mycell2.boockMarkedButton addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        mycell2.boockMarkedButton.tag = bookTag;
        
        NSLog(@"value === %ld",(long)bookTag);
        
        mycell2.shareButton.tag = indexPath.row;
        
        [mycell2.shareButton addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];
        
        [mycell2.likeButton addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        mycell2.likeButton.tag = likeTag;
        
        return mycell2;
        
    }else if ([type isEqualToString: CellIdentifier2]){
        
        HomeEasyViewCell *mycell3  =  [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier2 forIndexPath:indexPath ];
        
        //  NSLog(@"third type %@", type);
        mycell3.layer.cornerRadius = 10;
        mycell3.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:mycell3.bounds cornerRadius:mycell3.layer.cornerRadius] CGPath];
        
        
        mycell3.recipeTitle.text= [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        
        NSString *htmlString = [[myArray objectAtIndex:indexPath.row]objectForKey:@"article_content"];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        
        mycell3.diccription.attributedText = attributedString;
        
        
        
        if (IS_IPAD)
        {
            mycell3.diccription.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
            
        }else {
            
            mycell3.diccription.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
        }
        
        NSString *imageurl = [[myArray objectAtIndex:indexPath.row]objectForKey:@"image"];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]
                                 
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                 
                                             timeoutInterval:60];
        [mycell3.easyImage setImageWithURLRequest:request
                                 placeholderImage:nil
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              
                                              
                                              mycell3.easyImage.image = image;
                                              
                                              //                                               mycell3.easyImage.contentMode = UIViewContentModeScaleAspectFit;
                                              [mycell setNeedsLayout];
                                          } failure:nil];
        
        // BookMarkedButton
        
        articalid = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        
        NSLog(@"Articalid ===  %@",articalid);
        
        NSInteger bookTag = [articalid integerValue];
        
        [mycell3.bookMarkedButton setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell3.bookMarkedButton setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        [mycell3.likeButtonPressed setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell3.likeButtonPressed setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
        
        NSLog(@"bookmark %@",myBookMark);
        
        int valuebook = [myBookMark intValue];
        
        if (valuebook == 0) {
            
            BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell3.bookMarkedButton setSelected:YES];
                
            }else {
                
                [mycell3.bookMarkedButton setSelected:NO];
                
            }
            
            
        }else {
            
            [mycell3.bookMarkedButton setSelected:YES];
            
        }
        
        BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
        
        if(isTheObjectThereInUnSelected) {
            
            [mycell3.bookMarkedButton  setSelected:NO];
            
        }
        
        //Liked
        
        NSInteger likeTag = [articalid integerValue];
        
        NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
        
        NSLog(@"LikedPressed %@",mylikeTab);
        
        int valueLike = [mylikeTab intValue];
        
        if (valueLike == 0) {
            
            BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell3.likeButtonPressed setSelected:YES];
                
            }else {
                
                [mycell3.likeButtonPressed setSelected:NO];
                
            }
            
        }else {
            
            [mycell3.likeButtonPressed  setSelected:YES];
            
        }
        
        
        BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
        
        if(isTheObjectThereInUnSelectedLike) {
            
            [mycell3.likeButtonPressed setSelected:NO];
            
        }
        
        
        [mycell3.bookMarkedButton addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        mycell3.bookMarkedButton.tag = bookTag;
        
        NSLog(@"value === %ld",(long)bookTag);
        
        mycell3.shareButton.tag = indexPath.row;
        
        [mycell3.shareButton addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];
        
        [mycell3.likeButtonPressed addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        mycell3.likeButtonPressed.tag = likeTag;
        
        
        return mycell3;
    }
    else if ([type isEqualToString: CellIdentifier3]){
        
        HomeEventsViewCell *mycell4  =  [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier3 forIndexPath:indexPath ];
        
        //  NSLog(@"fourth type %@", type);
        
        mycell4.layer.cornerRadius = 10;
        mycell4.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:mycell4.bounds cornerRadius:mycell4.layer.cornerRadius] CGPath];
        
        // events cell
        
        
        mycell4.titleLabel.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        
        NSMutableDictionary *mydicvalues = [[NSMutableDictionary alloc]init];
        
        mydicvalues = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];
        
        NSLog(@"mydicvalues === %@",mydicvalues);
        
        
        NSString *date = [mydicvalues objectForKey:@"start_date"];
        // NSLog(@"Date====%@",date);
        
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        
        NSString *currentDateString = date;
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
        //NSLog(@"CurrentDate:%@", currentDate);
        NSDateFormatter *currentDTFormatter = [[NSDateFormatter alloc] init];
        [currentDTFormatter setDateFormat:@"dd"];
        
        NSString *eventDateStr = [currentDTFormatter stringFromDate:currentDate];
        //NSLog(@"Date===%@", eventDateStr);
        [currentDTFormatter setDateFormat:@"MMM"];
        NSString *eventDateStr1 = [currentDTFormatter stringFromDate:currentDate];
        // NSLog(@"month===%@", eventDateStr1);
        
        mycell4.dateLabel.text = eventDateStr;
        mycell4.mounthLabel.text = eventDateStr1;
        
        NSDictionary *mydicvalue = [[NSDictionary alloc]init];
        mydicvalue = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];
        
        mycell4.placeLeabel.text = [mydicvalue objectForKey:@"venue"];
        
        
        
        articalid = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        NSLog(@"Articalid ===  %@",articalid);
        
        NSInteger bookTag = [articalid integerValue];
        
        [mycell4.boockMarkButton setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell4.boockMarkButton setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        [mycell4.likeButton setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell4.likeButton setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
        
        NSLog(@"bookmark %@",myBookMark);
        
        int valuebook = [myBookMark intValue];
        
        if (valuebook == 0) {
            
            BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell4.boockMarkButton setSelected:YES];
                
            }else {
                
                [mycell4.boockMarkButton setSelected:NO];
                
            }
            
            
        }else {
            
            [mycell4.boockMarkButton setSelected:YES];
            
        }
        
        
        BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
        
        if(isTheObjectThereInUnSelected) {
            
            [mycell4.boockMarkButton setSelected:NO];
            
        }
        
        
        //Liked
        
        
        NSInteger likeTag = [articalid integerValue];
        
        NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
        
        NSLog(@"LikedPressed %@",mylikeTab);
        
        int valueLike = [mylikeTab intValue];
        
        if (valueLike == 0) {
            
            BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell4.likeButton setSelected:YES];
                
            }else {
                
                [mycell4.likeButton setSelected:NO];
                
            }
            
        }else {
            
            [mycell4.likeButton  setSelected:YES];
            
        }
        
        BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
        
        if(isTheObjectThereInUnSelectedLike) {
            
            [mycell4.likeButton setSelected:NO];
            
        }
        
        
        
        [mycell4.boockMarkButton addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        mycell4.boockMarkButton.tag = bookTag;
        
        NSLog(@"value === %ld",(long)bookTag);
        
        mycell4.shareButton.tag = indexPath.row;
        
        [mycell4.shareButton addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];
        
        [mycell4.likeButton addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        mycell4.likeButton.tag = likeTag;
        
        
        return mycell4;
    }
    else if ([type isEqualToString: CellIdentifier4]){
        
        HomeDinnerViewCell *mycell5  = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier4 forIndexPath:indexPath ];
        
        // NSLog(@"fiveth type %@", type);
        
        mycell5.layer.cornerRadius = 10;
        mycell5.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:mycell5.bounds cornerRadius:mycell5.layer.cornerRadius] CGPath];
        
        mycell5.titleLeabel.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        NSLog(@"%@",mycell5.titleLeabel);
        
        
        NSString *htmlString = [[myArray objectAtIndex:indexPath.row]objectForKey:@"description"];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        
        mycell5.discriptionLeabel.attributedText = attributedString;
        
        if (IS_IPAD)
        {
            mycell5.discriptionLeabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
            
        }else {
            
            mycell5.discriptionLeabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
        }
        
        
        mycell5.discriptionLeabel.lineBreakMode = NSLineBreakByWordWrapping;
        mycell5.discriptionLeabel.numberOfLines = 0;
        
        
        mycell5.discriptionLeabel.textColor = [UIColor whiteColor];
        
        
        articalid = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        
        NSLog(@"Articalid ===  %@",articalid);
        
        NSInteger bookTag = [articalid integerValue];
        
        [mycell5.bookMarkedButton setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell5.bookMarkedButton setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        [mycell5.likedButton setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell5.likedButton setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
        
        NSLog(@"bookmark %@",myBookMark);
        
        int valuebook = [myBookMark intValue];
        
        if (valuebook == 0) {
            
            BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell5.bookMarkedButton setSelected:YES];
                
            }else {
                
                [mycell5.bookMarkedButton setSelected:NO];
                
            }
            
            
        }else {
            
            [mycell5.bookMarkedButton setSelected:YES];
            
        }
        
        BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
        
        if(isTheObjectThereInUnSelected) {
            
            [mycell5.bookMarkedButton setSelected:NO];
            
        }
        
        
        
        //Liked
        
        
        NSInteger likeTag = [articalid integerValue];
        
        NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
        
        NSLog(@"LikedPressed %@",mylikeTab);
        
        int valueLike = [mylikeTab intValue];
        
        if (valueLike == 0) {
            
            BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell5.likedButton setSelected:YES];
                
            }else {
                
                [mycell5.likedButton setSelected:NO];
                
            }
            
        }else {
            
            [mycell5.likedButton  setSelected:YES];
            
        }
        
        
        BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
        
        if(isTheObjectThereInUnSelectedLike) {
            
            [mycell5.likedButton  setSelected:NO];
            
        }
        
        
        [mycell5.bookMarkedButton addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        mycell5.bookMarkedButton.tag = bookTag;
        
        NSLog(@"value === %ld",(long)bookTag);
        
        mycell5.shareButton.tag = indexPath.row;
        
        [mycell5.shareButton addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];
        
        [mycell5.likedButton addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        mycell5.likedButton.tag = likeTag;
        
        
        return mycell5;
    }
    else if ([type isEqualToString: CellIdentifier5]){
        
        HomeParientingViewCell * mycell6  =  [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier5 forIndexPath:indexPath ];
        
        // NSLog(@"sixth type %@", type);
        
        mycell6.layer.cornerRadius = 10;
        mycell6.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:mycell6.bounds cornerRadius:mycell6.layer.cornerRadius] CGPath];
        mycell6.titleLeabel.text  = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        
        NSString *imageurl = [[myArray objectAtIndex:indexPath.row]objectForKey:@"image"];
        
        // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageurl]
                                 
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                 
                                             timeoutInterval:60];
        [mycell6.imageParenting setImageWithURLRequest:request
                                      placeholderImage:nil
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                   
                                                   
                                                   mycell6.imageParenting.image = image;
                                                   [mycell setNeedsLayout];
                                               } failure:nil];
        
        NSString *htmlString = [[myArray objectAtIndex:indexPath.row]objectForKey:@"description"];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        mycell6.discriptionleabel.attributedText  = attributedString;
        
        
        if (IS_IPAD)
        {
            mycell6.discriptionleabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
            
        }else {
            
            mycell6.discriptionleabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
        }
        
        
        articalid = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
        
        
        NSLog(@"Articalid ===  %@",articalid);
        
        NSInteger bookTag = [articalid integerValue];
        
        [mycell6.bookMarkButton setImage:[UIImage imageNamed:@"bookmarkNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell6.bookMarkButton setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        [mycell6.likeButton setImage:[UIImage imageNamed:@"likeNew@2x.png"] forState:UIControlStateNormal];
        
        [mycell6.likeButton setImage:[UIImage imageNamed:@"like_selectedNew@2x.png"] forState:UIControlStateSelected];
        
        NSString * myBookMark = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"bookmarked"];
        
        NSLog(@"bookmark %@",myBookMark);
        
        int valuebook = [myBookMark intValue];
        
        if (valuebook == 0) {
            
            BOOL isTheObjectThere = [arSelectedRows containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell6.bookMarkButton setSelected:YES];
                
            }else {
                
                [mycell6.bookMarkButton setSelected:NO];
                
            }
            
            
        }else {
            
            [mycell6.bookMarkButton setSelected:YES];
            
        }
        
        BOOL isTheObjectThereInUnSelected = [unSelectBook containsObject: articalid];
        
        if(isTheObjectThereInUnSelected) {
            
            [mycell6.bookMarkButton setSelected:NO];
            
        }
        
        //Liked
        
        NSInteger likeTag = [articalid integerValue];
        
        NSString * mylikeTab = [[myArray objectAtIndex:indexPath.row ] objectForKey:@"liked"];
        
        NSLog(@"LikedPressed %@",mylikeTab);
        
        int valueLike = [mylikeTab intValue];
        
        if (valueLike == 0) {
            
            BOOL isTheObjectThere = [arSelectedLike containsObject: articalid];
            
            if(isTheObjectThere) {
                
                [mycell6.likeButton setSelected:YES];
                
            }else {
                
                [mycell6.likeButton setSelected:NO];
                
            }
            
        }else {
            
            [mycell6.likeButton  setSelected:YES];
            
        }
        
        
        
        BOOL isTheObjectThereInUnSelectedLike = [unSelectedLike containsObject: articalid];
        
        if(isTheObjectThereInUnSelectedLike) {
            
            [mycell6.likeButton setSelected:NO];
            
        }
        
        
        
        [mycell6.bookMarkButton addTarget:self action:@selector(bookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        mycell6.bookMarkButton.tag = bookTag;
        
        NSLog(@"value === %ld",(long)bookTag);
        
        mycell6.shareButton.tag = indexPath.row;
        
        [mycell6.shareButton addTarget:self action:@selector(ShareWithId:) forControlEvents:UIControlEventTouchUpInside];
        
        [mycell6.likeButton addTarget:self action:@selector(LikeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        mycell6.likeButton.tag = likeTag;
        
        
        return mycell6;
    }
    
    
    
    return mycell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    CGSize pElementSize  = CGSizeMake(700, 403);
    
    CGSize pElementSize1 = CGSizeMake(700, 500);
    
    CGSize pElementSize2 = CGSizeMake(700, 530 );
    
    CGSize pElementSize3 = CGSizeMake(700, 239);
    
    CGSize pElementSize4 = CGSizeMake(700, 270);
    
    CGSize pElementSize5 = CGSizeMake(700, 541);
    
    
    
    
    CGSize rElementSize  = CGSizeMake(380, 283);
    
    CGSize rElementSize1 = CGSizeMake(380, 378);
    
    CGSize rElementSize2 = CGSizeMake(380, 400 );
    
    CGSize rElementSize3 = CGSizeMake(380, 178);
    
    CGSize rElementSize4 = CGSizeMake(380, 236);
    
    CGSize rElementSize5 = CGSizeMake(380, 387);
    
    
    
    
    CGSize mElementSize  = CGSizeMake(350, 283);
    
    CGSize mElementSize1 = CGSizeMake(350, 378);
    
    CGSize mElementSize2 = CGSizeMake(350, 400 );
    
    CGSize mElementSize3 = CGSizeMake(350, 178);
    
    CGSize mElementSize4 = CGSizeMake(350, 236);
    
    CGSize mElementSize5 = CGSizeMake(350, 387);
    
    
    // ios 6
    
    CGSize nElementSize  = CGSizeMake(300, 283);
    
    CGSize nElementSize1 = CGSizeMake(300, 378);
    
    CGSize nElementSize2 = CGSizeMake(300, 400 );
    
    CGSize nElementSize3 = CGSizeMake(300, 178);
    
    CGSize nElementSize4 = CGSizeMake(300, 236);
    
    CGSize nElementSize5 = CGSizeMake(300, 387);
    
    
    
    
    type = [[myArray objectAtIndex:indexPath.row]objectForKey:@"type"];
    
    if ([type isEqualToString: CellIdentifier]) {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 568)
            {
                return nElementSize;
            }
            if(result.height == 667)
            {
                
                return mElementSize;
                
            }if(result.height == 480)
            {
                
                return nElementSize;
                
            }else if(result.height == 736)
            {
                return rElementSize;
            }
        }
        if (IS_IPAD)
        {
            return pElementSize;
            
        }
        
        
        return mElementSize;
    }
    else if ([type isEqualToString:CellIdentifier1]){
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 568)
            {
                
                return nElementSize1;
            }
            if(result.height == 667)
            {
                
                return mElementSize1;
                
            }if(result.height == 480)
            {
                
                return nElementSize1;
                
            }else if(result.height == 736)
            {
                return rElementSize1;
            }
        }
        if (IS_IPAD)
        {
            return pElementSize1;
            
        }
        
        return mElementSize1;
    }
    else if ([type isEqualToString:CellIdentifier2]){
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 568)
            {
                
                return nElementSize2;
            }
            if(result.height == 667)
            {
                
                return mElementSize2;
                
            }if(result.height == 480)
            {
                
                return nElementSize2;
                
            }else if(result.height == 736)
            {
                return rElementSize2;
            }
        }
        if (IS_IPAD)
        {
            return pElementSize2;
            
        }
        
        return mElementSize2;
    }
    else if ([type isEqualToString:CellIdentifier3]){
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 568)
            {
                
                return nElementSize3;
            }
            if(result.height == 667)
            {
                
                return mElementSize3;
                
            }if(result.height == 480)
            {
                
                return nElementSize3;
                
            }else if(result.height == 736)
            {
                return rElementSize3;
            }
        }
        if (IS_IPAD)
        {
            return pElementSize3;
            
        }
        
        
        return mElementSize3;
    }
    else if ([type isEqualToString:CellIdentifier4]){
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 568)
            {
                
                return nElementSize4;
            }
            if(result.height == 667)
            {
                
                return mElementSize4;
                
            }if(result.height == 480)
            {
                
                return nElementSize4;
                
            }else if(result.height == 736)
            {
                return rElementSize4;
            }
        }
        if (IS_IPAD)
        {
            return pElementSize4;
            
        }
        
        return mElementSize4;
    }
    else if ([type isEqualToString:CellIdentifier5]){
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 568)
            {
                
                return nElementSize5;
            }
            if(result.height == 667)
            {
                
                return mElementSize5;
                
            }if(result.height == 480)
            {
                
                return nElementSize5;
                
            }else if(result.height == 736)
            {
                return rElementSize5;
            }
        }
        if (IS_IPAD)
        {
            return pElementSize5;
            
        }
        
        
        return mElementSize5;
    }
    
    return mElementSize;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
      NSString *ScreenNama = [[myArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    
    if (IS_IPAD)
    {
        
        
        NSString *TypesOfCellSelected = [[myArray objectAtIndex:indexPath.row]objectForKey:@"type"];
        
        if ([TypesOfCellSelected isEqualToString:@"events"]) {
            
            
            DetailEventNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                  instantiateViewControllerWithIdentifier:@"DetailEventnw"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
            wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
        }else if ([TypesOfCellSelected isEqualToString:@"reviews"]){
            
            
            
            NSDictionary *mydicvalue = [[NSDictionary alloc]init];
            
            mydicvalue = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];
            
            
            bookType = [mydicvalue objectForKey:@"review_type"];
            
            NSLog(@"booktype======%@",bookType);
            
            
            if ([bookType isEqualToString:@"book"]) {
                
                DetailParentingViewNew  *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                               instantiateViewControllerWithIdentifier:@"DetailParentingViewNew"];
                
                NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
                
                NSLog(@"ArticalId========%@",foodId);
                
                //wc.IdValue = foodId;
                
                wc.articalID = foodId;
                  wc.screenValue = ScreenNama;
                
                [self.navigationController pushViewController:wc animated:YES];
                
                
                
                
            }else{
                
                
                
                DetailReviewNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                       
                                       instantiateViewControllerWithIdentifier:@"DetailReviewNew"];
                
                NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
                
                NSLog(@"ArticalId========%@",foodId);
                
                //wc.IdValue = foodId;
                
                wc.articalID = foodId;
                  wc.screenValue = ScreenNama;
                
                [self.navigationController pushViewController:wc animated:YES];
                
            }
            
            
            
            //
            //        DetailReviewNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
            //                               instantiateViewControllerWithIdentifier:@"DetailReviewNew"];
            //
            //        NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            //        NSLog(@"ArticalId========%@",foodId);
            //
            //        wc.articalID = foodId;
            //
            //        [self.navigationController pushViewController:wc animated:YES];
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"recipes"]){
            
            
            
            DetailReviewNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                   instantiateViewControllerWithIdentifier:@"DetailRecipeNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"easy_tips"]){
            
            
            
            DetailEasyTipsNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                     instantiateViewControllerWithIdentifier:@"DetailEasyTipsNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"dinner_conversations"]){
            
            
            DetailDinnerViewNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                       instantiateViewControllerWithIdentifier:@"DetailDinnerViewNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"parenting"]){
            
            
            DetailParentingViewNew *wc = [[UIStoryboard storyboardWithName:@"StoryboardiPad" bundle:nil]
                                          instantiateViewControllerWithIdentifier:@"DetailParentingViewNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
        }
        
        
    } else {
        
        
        
        NSString *TypesOfCellSelected = [[myArray objectAtIndex:indexPath.row]objectForKey:@"type"];
        
        if ([TypesOfCellSelected isEqualToString:@"events"]) {
            
            
            DetailEventNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                  instantiateViewControllerWithIdentifier:@"DetailEventnw"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
        }else if ([TypesOfCellSelected isEqualToString:@"reviews"]){
            
            
            
            NSDictionary *mydicvalue = [[NSDictionary alloc]init];
            
            mydicvalue = [[myArray objectAtIndex:indexPath.row]objectForKey:@"meta"];
            
            
            bookType = [mydicvalue objectForKey:@"review_type"];
            
            NSLog(@"booktype======%@",bookType);
            
            
            if ([bookType isEqualToString:@"book"]) {
                
                DetailParentingViewNew  *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                               instantiateViewControllerWithIdentifier:@"DetailParentingViewNew"];
                
                NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
                
                NSLog(@"ArticalId========%@",foodId);
                
                //wc.IdValue = foodId;
                
                wc.articalID = foodId;
                  wc.screenValue = ScreenNama;
                
                [self.navigationController pushViewController:wc animated:YES];
                
                
                
                
            }else{
                
                
                
                DetailReviewNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                       
                                       instantiateViewControllerWithIdentifier:@"DetailReviewNew"];
                
                NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
                
                NSLog(@"ArticalId========%@",foodId);
                
                //wc.IdValue = foodId;
                
                wc.articalID = foodId;
                  wc.screenValue = ScreenNama;
                
                [self.navigationController pushViewController:wc animated:YES];
                
            }
            
            
            
            //
            //        DetailReviewNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
            //                               instantiateViewControllerWithIdentifier:@"DetailReviewNew"];
            //
            //        NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            //        NSLog(@"ArticalId========%@",foodId);
            //
            //        wc.articalID = foodId;
            //
            //        [self.navigationController pushViewController:wc animated:YES];
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"recipes"]){
            
            
            
            DetailReviewNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                   instantiateViewControllerWithIdentifier:@"DetailRecipeNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"easy_tips"]){
            
            
            
            DetailEasyTipsNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                     instantiateViewControllerWithIdentifier:@"DetailEasyTipsNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"dinner_conversations"]){
            
            
            DetailDinnerViewNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                       instantiateViewControllerWithIdentifier:@"DetailDinnerViewNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            
            [self.navigationController pushViewController:wc animated:YES];
            
            
            
        }else if ([TypesOfCellSelected isEqualToString:@"parenting"]){
            
            
            DetailParentingViewNew *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                          instantiateViewControllerWithIdentifier:@"DetailParentingViewNew"];
            
            NSString *foodId = [[myArray objectAtIndex:indexPath.row]objectForKey:@"id"];
            NSLog(@"ArticalId========%@",foodId);
            
            wc.articalID = foodId;
              wc.screenValue = ScreenNama;
            [self.navigationController pushViewController:wc animated:YES];
            
            
        }
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
}

-(void)FeatchData{
    
    /// afnetworking
    
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"REG_TOKEN"];
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults]
                        stringForKey:@"REG_userId"];
    
    NSString *langeVarble = [[NSUserDefaults standardUserDefaults]stringForKey:@"LanguageDefalt"];

    NSDictionary *parameters = @{@"user_id" : UserId ,
                                 @"token" :userToken ,
                                 
                                 @"language_preference" : langeVarble
                                 
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://zenparent.in/api/ret_bookmarks"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             // NSLog(@"JSON: %@", responseObject);
             NSMutableArray *newArray = [[NSMutableArray alloc]init];
             
             newArray = [responseObject objectForKey:@"result"];
             
             NSLog(@"newArray====%@",newArray);
             
             NSLog(@"oldArray======%@",myArray);
             
             self.myArray = [[myArray arrayByAddingObjectsFromArray:newArray] mutableCopy];
             
             
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                [self.myCollectionView reloadData];
                                [activityIndicatorView stopAnimating];
                                
                            });
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"Error: %@", error);
             
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:ok];
             [self presentViewController:alertController animated:YES completion:nil];
             
             [activityIndicatorView stopAnimating];
             
         }];
    
    
    
}

- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated{
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        // we are at the end
        
        [activityIndicatorView startAnimating];
        [TostView showToastInParentView:self.view withText:@"Loading..." withDuaration:2.0];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
        [myArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
        
        
        NSString *userToken = [[NSUserDefaults standardUserDefaults]
                               stringForKey:@"REG_TOKEN"];
        
        NSString *UserId = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"REG_userId"];
        NSString *langeVarble = [[NSUserDefaults standardUserDefaults]stringForKey:@"LanguageDefalt"];
        
        NSDictionary *parameters = @{@"user_id" : UserId ,
                                     
                                     @"token" : userToken ,
                                     
                                     @"pagination_type" : @"down" ,
                                     
                                     @"article_id" : [[myArray objectAtIndex: [myArray count]-1]objectForKey:@"id"],
                                     
                                     @"language_preference" : langeVarble
                                     
                                     };
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://zenparent.in/api/ret_bookmarks"
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
                                    [self.myCollectionView reloadData];
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
                 
                 [_myActivieIndicaer stopAnimating];
                 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                 
             }];
        
        
    }
}

-(void)startRefresh{
    
    
    //[self.myCollectionView reloadData];
    
 
    
    [ self->refreshControl endRefreshing];
    
}

-(void)LikeClick:(UIButton *)sender{
    
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
            
            NSLog(@"arSelectedRows === %@",arSelectedRows);
            
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
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    
}

-(void)bookCommentClick:(UIButton *)sender{
    
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
            
            if (IS_IPAD)
            {
                [sender setImage:[UIImage imageNamed:@"bookmark_selected@3x.png"] forState:UIControlStateSelected];
                
            }else {
                
                
                [sender setImage:[UIImage imageNamed:@"bookmark_selectedNew@2x.png"] forState:UIControlStateSelected];
            }
            
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
            //[tweet setInitialText:@"Please look into this article!"];
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



@end
