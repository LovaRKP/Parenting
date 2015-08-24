//
//  SettingsView2Controller.h
//  ZenParent
//
//  Created by Soumya Ranjan on 07/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SettingsView2Controller : GAITrackedViewController <UITableViewDataSource,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *settings2View;

@property (weak, nonatomic) NSMutableArray *MiltiSelection;
@property (weak, nonatomic) IBOutlet UIButton *dobButton;

@end
