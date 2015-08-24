//
//  HomeEasyViewCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 14/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeEasyViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;


@property (weak, nonatomic) IBOutlet UIImageView *easyImage;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *likeButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *likeCountButton;
@property (weak, nonatomic) IBOutlet UILabel *recipeTitle;
@property (weak, nonatomic) IBOutlet UILabel *diccription;
@property (weak, nonatomic) IBOutlet UIButton *bookMarkedButton;

@end
