//
//  TostView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 18/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TostView : UIView



@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic, readonly) UILabel *textLabel;

+ (void)showToastInParentView: (UIView *)parentView withText:(NSString *)text withDuaration:(float)duration;

@end
