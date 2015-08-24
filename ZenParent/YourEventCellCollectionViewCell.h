//
//  YourEventCellCollectionViewCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 04/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourEventCellCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLeabel;

@property (weak, nonatomic) IBOutlet UILabel *monthLeabel;
@property (weak, nonatomic) IBOutlet UILabel *tatielLeabel;
@property (weak, nonatomic) IBOutlet UILabel *pleaceLeabel;
@property (weak, nonatomic) IBOutlet UIButton *boockmarkButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *likecountButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
