//
//  SetingsView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SetingsView : GAITrackedViewController <UITableViewDelegate, UITableViewDataSource>{


}
@property (weak, nonatomic) IBOutlet UITableView *mytable;

@property (weak, nonatomic)  UITableView *selectTV;

@property(strong, nonatomic) NSString *sectings;
@property(strong, nonatomic) NSString *userID;
@property(strong, nonatomic) NSString *userToken;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIToolbar *PickerToolBar;

@property (weak, nonatomic) IBOutlet UIDatePicker *DatePickerView;

@end
