//
//  ParentingCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *parentingImage;


@property (weak, nonatomic) IBOutlet UILabel *parentingTitle;
@property (weak, nonatomic) IBOutlet UILabel *discriptionleabel;

@property (weak, nonatomic) IBOutlet UIButton *bookMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *LikeCountDisplayButton;

@end
