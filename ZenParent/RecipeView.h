//
//  RecipeView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 21/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface RecipeView : GAITrackedViewController

{

 NSMutableArray *arSelectedRows;
    
    NSMutableArray *arSelectedLike;

}


@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;
@property (copy, nonatomic)  NSMutableArray *myArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActiveIndicater;

@property (retain) UIDocumentInteractionController * documentInteractionController;

@end
