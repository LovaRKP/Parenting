//
//  selectedSettigs2ViewController.h
//  ZenParent
//
//  Created by Soumya Ranjan on 07/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface selectedSettigs2ViewController : GAITrackedViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *selected2;

@property(strong, nonatomic) NSMutableArray *tableData;
@property(strong, nonatomic) UITableView *table;
@property (strong, nonatomic)NSMutableDictionary *userDataForUse;


@end
