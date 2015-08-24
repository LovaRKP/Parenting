//
//  ViewController.h
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "Constants.h"


@class GIDSignInButton;

@interface ViewController : GAITrackedViewController <FBLoginViewDelegate ,GPPSignInDelegate,UIScrollViewDelegate >
@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;
@property (strong, nonatomic)  NSMutableDictionary *userdata;
@property (strong, nonatomic) NSString *userurl;


// Google

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;


@end

