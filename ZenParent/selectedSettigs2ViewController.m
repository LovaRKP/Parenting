//
//  selectedSettigs2ViewController.m
//  ZenParent
//
//  Created by Soumya Ranjan on 07/05/15.
//  Copyright (c) 2015 Soumya Ranjan. All rights reserved.
//

#import "selectedSettigs2ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UserDetailViewViewController.h"

@interface selectedSettigs2ViewController ()

{

   NSMutableArray *selectedRows;
    NSMutableDictionary *selectedData;

}

@end

@implementation selectedSettigs2ViewController

- (void)viewDidLoad {
    
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenName = @"Settings View";
    
    selectedRows = [[NSMutableArray alloc] init];
  
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(donButonPressed)];
    self.navigationItem.rightBarButtonItem = anotherButton;
      [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableData.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
   // NSString *keyString = [NSString stringWithFormat:@"%d", indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
      //cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
     cell.textLabel.text = [[_tableData objectAtIndex:indexPath.row]objectForKey:@"tag"];
    
    cell.textLabel.textColor = [UIColor colorWithRed:116.0f/255.0f
                                               green:79.0f/255.0f
                                                blue:141.0f/255.0f
                                               alpha:1.0f];
    cell.detailTextLabel.text = [[_tableData objectAtIndex:indexPath.row]objectForKey:@"id"];
    
    cell.detailTextLabel.hidden = YES;
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
 
    // NSString *keyString = [NSString stringWithFormat:@"%d", indexPath.row];
     NSString *peerID = cell.detailTextLabel.text;
    if ( cell.accessoryType == UITableViewCellAccessoryNone ) {
    
        
           cell.accessoryType =  UITableViewCellAccessoryCheckmark;
        [selectedRows addObject:peerID];
        NSLog(@"Selected Row %@",selectedRows);
        
    }else if (cell.accessoryType ==  UITableViewCellAccessoryCheckmark){
    
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        //NSLog(@"not selected.......");
        [selectedRows removeLastObject];

    }
}

-(void)donButonPressed{
    


    NSLog(@"The selected rows are:");
    
        NSLog(@"%@", selectedRows);
    
    
    NSMutableArray *preverslySellected = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"preverslyIDS"] mutableCopy];
    
    
   // [preverslySellected addObjectsFromArray:selectedRows];
    
    NSArray *newArray=[preverslySellected arrayByAddingObjectsFromArray:selectedRows];
    
    NSLog(@"new array===%@",newArray);
    
    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"preverslyIDS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
       NSArray *newArray1=[preverslySellected arrayByAddingObjectsFromArray:selectedRows];
    NSLog(@"finalvalues=====%@",newArray1);
    
    [[NSUserDefaults standardUserDefaults] setObject:newArray1 forKey:@"preverslyIDS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    NSLog(@"serverValues %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"preverslyIDS"]) ;
    
    [self.navigationController popViewControllerAnimated:YES ];
    


}

@end
