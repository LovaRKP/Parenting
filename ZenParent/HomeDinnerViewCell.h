//
//  HomeDinnerViewCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 14/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDinnerViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLeabel;

@property (weak, nonatomic) IBOutlet UILabel *discriptionLeabel;

@property (weak, nonatomic) IBOutlet UIButton *bookMarkedButton;

@property (weak, nonatomic) IBOutlet UIButton *likedButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@end
