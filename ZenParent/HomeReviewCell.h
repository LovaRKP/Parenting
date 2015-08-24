//
//  HomeReviewCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 14/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface HomeReviewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameOfShow;
@property (weak, nonatomic) IBOutlet UILabel *diciptionOfShow;
@property (weak, nonatomic) IBOutlet UILabel *ageLeabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *tvShowReview;
@property (weak, nonatomic) IBOutlet UIButton *bookMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *likePressedButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *bodderRatting;
@property (weak, nonatomic) IBOutlet UILabel *bodderAgelab;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfRevews;
@property (weak, nonatomic) IBOutlet UILabel *reatingLeabelHifdden;
@property (weak, nonatomic) IBOutlet UILabel *titleForTv;

@property (weak, nonatomic) IBOutlet UIButton *likeCountButton;
@end
