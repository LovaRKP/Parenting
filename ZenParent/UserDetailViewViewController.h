//
//  UserDetailViewViewController.h
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AFHTTPRequestOperation.h"
#import "constants.h"


@interface UserDetailViewViewController : GAITrackedViewController   {
    
    
}

@property (strong, nonatomic)NSMutableDictionary *myDIc;

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic)  FBLoginView *loginButton;


@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;

@property (weak, nonatomic) IBOutlet UILabel *userEmail;

@property (strong, nonatomic) NSString *userurl1;

@property (strong, nonatomic) NSString *fbID;
@property (strong, nonatomic) NSString *logINBy;



// Google

@property (strong, nonatomic) NSDictionary *googleData;


@property (weak, nonatomic) IBOutlet UITextField *phoneNoTf;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
