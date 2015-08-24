//
//  YourEventsView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 01/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"


@interface YourEventsView : GAITrackedViewController

{
    NSMutableArray *arSelectedRows;
    
    NSMutableArray *arSelectedLike;

}


@property (weak, nonatomic) IBOutlet UICollectionView *cpllection;
@property (copy, nonatomic)  NSMutableArray *myArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActiveIndicater;


@end
