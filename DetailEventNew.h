//
//  DetailEventNew.h
//  ZenParent
//
//  Created by Soumya Ranjan on 15/06/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTextView.h"
#import "Constants.h"

@interface DetailEventNew : GAITrackedViewController


@property (weak, nonatomic)  NSString *articalID;

@property (weak, nonatomic) IBOutlet UITabBar *myTabBar;

@property (weak, nonatomic) IBOutlet NCTextView *textView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *DetailImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *ageLeablelNew;

//cell
//@property (weak, nonatomic) IBOutlet UIImageView *DetailImage;

@property (weak, nonatomic) IBOutlet UILabel *dateLeabel;
@property (weak, nonatomic) IBOutlet UILabel *monthInWOrdsLeabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeabel;
@property (weak, nonatomic) IBOutlet UILabel *ageGroups;
@property (weak, nonatomic) IBOutlet UILabel *priceOfEventLeabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfEvents;
@property (weak, nonatomic) IBOutlet UILabel *timeOfEvents;
@property (weak, nonatomic) IBOutlet UILabel *priceOfEventsWIthDate;

@property (weak, nonatomic) IBOutlet UILabel *venuOrLocation;


//@property (weak, nonatomic) IBOutlet NCTextView *about;


//@property (strong, nonatomic) IBOutlet MKMapView *LocationMap;

//@property(nonatomic, retain) IBOutlet MKMapView *mapView;
//@property(nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *bodderLeabelFordate;

@property (weak, nonatomic) IBOutlet UIButton *bodderOnWords;

@property (weak, nonatomic) IBOutlet UIButton *bodderAgeGroups;

@property (weak, nonatomic) IBOutlet UIButton *bodderPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *getDirectionsPressed;

@property (weak, nonatomic)  NSString *screenValue;
@property (weak, nonatomic) IBOutlet UILabel *phoneNotextField;

@property (weak, nonatomic) NSMutableDictionary *articalDeepArray;



@end
