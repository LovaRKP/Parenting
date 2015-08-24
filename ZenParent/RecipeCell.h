//
//  RecipeCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UILabel *recipeTitle;

@property (weak, nonatomic) IBOutlet UILabel *coockingTime;
@property (weak, nonatomic) IBOutlet UILabel *preptime;

@property (weak, nonatomic) IBOutlet UIButton *snackLabel;
@property (weak, nonatomic) IBOutlet UIButton *boockMarkedPressed;

@property (weak, nonatomic) IBOutlet UIButton *likeButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *likeDisplayLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButtonPressed;

@property (weak, nonatomic) IBOutlet UILabel *boderCoockTime1;
@property (weak, nonatomic) IBOutlet UILabel *bodderdPrepTime1;
@property (weak, nonatomic) IBOutlet UIImageView *vigImage;
@property (weak, nonatomic) IBOutlet UIButton *lastobjimage;

@property (weak, nonatomic) IBOutlet UIButton *vegOrNonVeg;
@end
