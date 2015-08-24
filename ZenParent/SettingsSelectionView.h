//
//  SettingsSelectionView.h
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SettingsSelectionView : GAITrackedViewController <UITableViewDataSource,UITabBarDelegate>

{

}
@property (weak, nonatomic) IBOutlet UITableView *settingsSelectedTV;
@property(strong, nonatomic) NSString *tittle;
@property(strong, nonatomic) NSMutableArray *tableData;
@property(strong, nonatomic) UITableView *table;



@end
