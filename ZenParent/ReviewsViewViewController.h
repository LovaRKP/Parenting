//
//  ReviewsViewViewController.h
//  ZenParent
//
//  Created by Soumya Ranjan on 04/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ReviewsViewViewController : GAITrackedViewController

{

    NSMutableArray *arSelectedRows;
    
    NSMutableArray *arSelectedLike;

}
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (copy, nonatomic)  NSMutableArray *myArray;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivieIndicater;

@end
