//
//  HomeContantView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 30/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Social/Social.h"
#import "Constants.h"





@interface HomeContantView : GAITrackedViewController


{
    
    NSMutableArray *arSelectedRows;
    
    NSMutableArray *arSelectedLike;
    
}


@property (weak, nonatomic) IBOutlet UICollectionView *cpllection;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionCell;
//@property (weak, nonatomic) IBOutlet UILabel *bodderOfRatting;
//
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActiveIndicater;
//
@property (copy, nonatomic)  NSMutableArray *myArray;
//
//@property (weak, nonatomic) IBOutlet UILabel *boderCoockTime;
//@property (weak, nonatomic) IBOutlet UILabel *bodderdPrepTime;

@end
