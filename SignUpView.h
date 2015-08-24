//
//  SignUpView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 17/07/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "Constants.h"

@class GIDSignInButton;


@interface SignUpView : GAITrackedViewController < UIScrollViewDelegate >

@property (strong, nonatomic)  NSMutableDictionary *userdata;
@property (strong, nonatomic) NSString *userurl;


@end
