//
//  HomeParientingViewCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 14/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeParientingViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageParenting;
@property (weak, nonatomic) IBOutlet UILabel *titleLeabel;
@property (weak, nonatomic) IBOutlet UILabel *discriptionleabel;
@property (weak, nonatomic) IBOutlet UIButton *bookMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
