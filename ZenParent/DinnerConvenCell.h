//
//  DinnerConvenCell.h
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DinnerConvenCell : UICollectionViewCell

{

    NSMutableArray *arSelectedRows;
    
    NSMutableArray *arSelectedLike;

}
@property (weak, nonatomic) IBOutlet UILabel *dinnerTittel;
@property (weak, nonatomic) IBOutlet UILabel *tittle;
@property (weak, nonatomic) IBOutlet UIButton *bookMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end
