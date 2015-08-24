//
//  DetailEasyTipsNew.h
//  ZenParent
//
//  Created by Soumya Ranjan on 15/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTextView.h"
#import "Constants.h"

@interface DetailEasyTipsNew : GAITrackedViewController<UITabBarDelegate>

@property (weak, nonatomic)  NSString *articalID;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NCTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITabBar *myTabBar;

@property (weak, nonatomic)  NSString *screenValue;

@property (weak, nonatomic) NSMutableDictionary *articalDeepArray;

@end
