//
//  DetailRecipeNew.h
//  ZenParent
//
//  Created by Soumya Ranjan on 16/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTextView.h"
#import "constants.h"

@interface DetailRecipeNew : GAITrackedViewController


@property (weak, nonatomic) IBOutlet UIImageView *detailImageRecipe;
@property (weak, nonatomic) IBOutlet UILabel *bodderPripTime;
@property (weak, nonatomic) IBOutlet UILabel *bodderdSnack;

@property (weak, nonatomic) IBOutlet UILabel *bodderedCookTime;

@property (weak, nonatomic) IBOutlet UILabel *titleRecipe;
@property (weak, nonatomic) IBOutlet UILabel *cookTimeRecipe;
@property (weak, nonatomic) IBOutlet UILabel *prepareTimeRecipe;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsRecipe;
@property (weak, nonatomic) IBOutlet UIButton *vegOrNon;
@property (weak, nonatomic) IBOutlet UILabel *bodderButtonVeg;


@property (weak, nonatomic) IBOutlet UITextView *procedureRecipe;
@property (weak, nonatomic) IBOutlet UILabel *snackLabelRecepi;

@property (weak, nonatomic) IBOutlet NCTextView *textView;
@property (weak, nonatomic) IBOutlet NCTextView *textView1;



@property (weak, nonatomic) IBOutlet UITabBar *myTabBar;
@property (weak, nonatomic)  NSString *articalID;

//default

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint1;

@property (weak, nonatomic)  NSString *screenValue;

@property (weak, nonatomic) NSMutableDictionary *articalDeepArray;



@end
