//
//  DetailReviewNew.h
//  ZenParent
//
//  Created by Soumya Ranjan on 16/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTextView.h"
#import "constants.h"

@interface DetailReviewNew : GAITrackedViewController

@property (weak, nonatomic) IBOutlet UITabBar *myTabBar;
@property (weak, nonatomic)  NSString *articalID;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NCTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageDetailReview;
@property (weak, nonatomic) IBOutlet UILabel *titelDetailReview;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *reatingLeabel;
@property (weak, nonatomic) IBOutlet UIImageView *violenceImage;

@property (weak, nonatomic) IBOutlet UIImageView *sexNudeImage;
@property (weak, nonatomic) IBOutlet UIImageView *dreankingSmoking;

@property (weak, nonatomic) IBOutlet UIImageView *profanityImage;
@property (weak, nonatomic) IBOutlet UITextView *containtText;

@property (weak, nonatomic) IBOutlet UILabel *ageBoderLeabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingBoder;

@property (weak, nonatomic)  NSString *screenValue;

@property (weak, nonatomic) NSMutableDictionary *articalDeepArray;

@end
