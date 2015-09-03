//
//  SettingsSelectionView.m
//  ZenParent
//
//  Created by Soumya Ranjan on 28/04/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "SettingsSelectionView.h"
#import "SetingsView.h"

@interface SettingsSelectionView ()
{
    
    NSMutableArray *idArray;
    
    
}

@end

@implementation SettingsSelectionView



- (void)viewDidLoad {
    
   self.screenName = @"Settings View";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:116.0f/255.0f
                                                                             green:79.0f/255.0f
                                                                              blue:141.0f/255.0f
                                                                             alpha:1.0f]];
    [self.navigationController.navigationBar  setTranslucent:YES];
      [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //[self.navigationItem setHidesBackButton:YES animated:YES];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableData.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    //  cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    
    cell.textLabel.text = [[_tableData objectAtIndex:indexPath.row]objectForKey:@"tag"];
    cell.detailTextLabel.text = [[_tableData objectAtIndex:indexPath.row]objectForKey:@"id"];
    cell.detailTextLabel.hidden = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType =  UITableViewCellAccessoryCheckmark;
    
    
    if (_table.indexPathForSelectedRow.row == 0){
        NSString *cellText = cell.textLabel.text;
        NSString *detailTextId = cell.detailTextLabel.text;
        
        [[NSUserDefaults standardUserDefaults] setObject:detailTextId forKey:@"IDstatus"];
        
        [[NSUserDefaults standardUserDefaults] setObject:cellText forKey:@"status"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        // NSLog(@"value is====%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"status"]);
        [self.navigationController popViewControllerAnimated:YES ];
        
    }else if (_table.indexPathForSelectedRow.row == 1){
        NSString *cellText = cell.textLabel.text;
        NSString *detailTextId = cell.detailTextLabel.text;
        
        
        [[NSUserDefaults standardUserDefaults] setObject:detailTextId forKey:@"IDstatus1"];
        [[NSUserDefaults standardUserDefaults] setObject:cellText forKey:@"status1"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popViewControllerAnimated:YES ];
        
    }
    else if (_table.indexPathForSelectedRow.row == 2){
        NSString *cellText = cell.textLabel.text;
        NSString *detailTextId = cell.detailTextLabel.text;
        [[NSUserDefaults standardUserDefaults] setObject:detailTextId forKey:@"IDstatus2"];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:cellText forKey:@"status2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popViewControllerAnimated:YES ];
        
    }
    else if (_table.indexPathForSelectedRow.row == 3){
        NSString *cellText = cell.textLabel.text;
        NSString *detailTextId = cell.detailTextLabel.text;
        [[NSUserDefaults standardUserDefaults] setObject:detailTextId forKey:@"IDstatus3"];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:cellText forKey:@"status3"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        NSLog(@"Cell Text ==== %@",cellText);
        
         NSLog(@"detailTextId ==== %@",detailTextId);
        
        
        [self.navigationController popViewControllerAnimated:YES ];
        
    }
    else if (_table.indexPathForSelectedRow.row == 4){
        NSString *cellText = cell.textLabel.text;
        NSString *detailTextId = cell.detailTextLabel.text;
        
        [[NSUserDefaults standardUserDefaults] setObject:detailTextId forKey:@"IDstatus4"];
        
        [[NSUserDefaults standardUserDefaults] setObject:cellText forKey:@"status4"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popViewControllerAnimated:YES ];
        
    }
    
    
}




@end
