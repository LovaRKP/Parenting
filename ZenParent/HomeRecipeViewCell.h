//
//  HomeRecipeViewCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 14/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRecipeViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *RecipeTitel;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UILabel *recipieTitle;
@property (weak, nonatomic) IBOutlet UILabel *boderCoockTime;
@property (weak, nonatomic) IBOutlet UILabel *bodderdPrepTime;
@property (weak, nonatomic) IBOutlet UIButton *snackButton;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *coockTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *boockMarkedButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *likecountButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *vegImageDot;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@end
