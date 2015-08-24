//
//  DinnerConversationView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DinnerConversationView : GAITrackedViewController

{

    NSMutableArray *arSelectedRows;
    
    NSMutableArray *arSelectedLike;

}
@property (weak, nonatomic) IBOutlet UICollectionView *mycollectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActiveIndicaer;

@property (copy, nonatomic)  NSMutableArray *myArray;
@end
