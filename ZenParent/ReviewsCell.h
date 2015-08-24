//
//  ReviewsCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 04/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *TitleReview;
@property (weak, nonatomic) IBOutlet UIButton *bookMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *discriptionReview;
@property (weak, nonatomic) IBOutlet UILabel *ageLeabel;
@property (weak, nonatomic) IBOutlet UILabel *reatingLeabel;
@property (weak, nonatomic) IBOutlet UIImageView *reviewImage;
@property (weak, nonatomic) IBOutlet UILabel *bodderdRating;
@property (weak, nonatomic) IBOutlet UILabel *bodderdAge;
@property (weak, nonatomic) IBOutlet UILabel *rattingLeabelHidden;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *hiddenLeabel;

@end
