//
//  Constants.h
//  ZenParent
//
//  Created by Soumya Ranjan on 22/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#ifndef ZenParent_Constants_h
#define ZenParent_Constants_h


//mint bug tracking tool


#import "CDActivityIndicatorView.h"
#import "GAITrackedViewController.h"

#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)


#endif

// Uncomment This For Logs


#ifndef NDEBUG
#define NSLog(...);
#endif