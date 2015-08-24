//
//  HomeEventsViewCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 14/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface HomeEventsViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleEvents;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *mounthLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLeabel;
@property (weak, nonatomic) IBOutlet UIButton *boockMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *likeCountbutton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;



@end
