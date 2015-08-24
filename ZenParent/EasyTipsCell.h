//
//  EasyTipsCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyTipsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageEasy;

@property (weak, nonatomic) IBOutlet UILabel *titleEasy;
@property (weak, nonatomic) IBOutlet UILabel *discriptionEassy;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *bookMarkedButton;

@property (weak, nonatomic) IBOutlet UIButton *likeButtonPressed;
@end
